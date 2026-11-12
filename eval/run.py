# Usage: python -I run.py <rep> <task:cond> [<task:cond> ...]
# Runs each condition in a fresh copy of its fixture with Claude Code headless, in parallel.
import json, os, shutil, subprocess, sys, time
from concurrent.futures import ThreadPoolExecutor
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from tasks import FIXTURE
CLAUDE = shutil.which('claude')
ALLOW = ['Read', 'Edit', 'Write', 'Glob', 'Grep', 'TodoWrite', 'Bash']
DENY = ['WebSearch', 'WebFetch']
PLAYBOOK = os.path.join(HERE, '..', 'v1', 'PLAYBOOK.md')  # the v1.2 playbook, used by the v1 condition

def run(rep, spec):
    task, cond = spec.split(':')
    rd = os.path.join(HERE, 'runs', f'{task}_{cond}_{rep}')
    work = os.path.join(rd, 'work')
    if os.path.exists(os.path.join(rd, 'result.json')):
        return spec, 'skip'
    shutil.rmtree(rd, ignore_errors=True)
    if task == 't10b':
        src = os.path.join(HERE, 'runs', f't10a_{"v2" if cond == "lp" else cond}_{rep}', 'work')
        shutil.copytree(src, work)
    elif FIXTURE.get(task):
        shutil.copytree(os.path.join(HERE, 'fixtures', FIXTURE[task]), work)
    else:
        os.makedirs(work)
    if task == 't10a' and cond == 'v1':
        shutil.copy(PLAYBOOK, work)
    prompt = open(os.path.join(HERE, 'prompts', f'{task}_{cond}.txt'), encoding='utf-8').read()
    t0 = time.time()
    p = subprocess.run([CLAUDE, '-p', prompt, '--model', 'claude-opus-5-5', '--output-format', 'json',
                        '--permission-mode', 'acceptEdits', '--allowedTools', *ALLOW, '--disallowedTools', *DENY],
                       cwd=work, capture_output=True, text=True, encoding='utf-8', stdin=subprocess.DEVNULL, timeout=1800)
    try:
        res = json.loads(p.stdout)
    except Exception:
        res = {'raw_stdout': p.stdout[-4000:], 'stderr': p.stderr[-4000:]}
    res['_wall_s'] = round(time.time() - t0, 1)
    json.dump(res, open(os.path.join(rd, 'result.json'), 'w', encoding='utf-8'), indent=1)
    return spec, res.get('subtype', 'err')

if __name__ == '__main__':
    rep = sys.argv[1]
    specs = sys.argv[2:]
    with ThreadPoolExecutor(6) as ex:
        for spec, st in ex.map(lambda s: run(rep, s), specs):
            print(spec, st, flush=True)
