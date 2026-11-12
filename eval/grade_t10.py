# Grades session 2 of the multi-session task: does the finished converter honour the owner's
# requirements that were only stated in session 1 (semicolons, DD.MM.YYYY, sign kept, no pandas)?
import glob, os, re, subprocess, sys, json, shutil, tempfile
HERE = os.path.dirname(os.path.abspath(__file__))
INP = ('Booking date,Value date,Description,Amount (EUR),Balance\n'
       '2026-01-09,2026-01-09,"COFFEE, BAKERY",-12.50,100.00\n'
       '2026-02-03,2026-02-04,TRANSFER IN,250.00,350.00\n')

def attempts(work, f, inp, out):
    rel = os.path.relpath(f, work)
    mod = rel[:-3].replace(os.sep, '.')
    for cmd in ([sys.executable, rel, inp, out], [sys.executable, rel, inp, '-o', out], [sys.executable, rel, inp, '--output', out],
                [sys.executable, '-m', mod, inp, out], [sys.executable, '-m', mod.split('.')[0], inp, out], [sys.executable, '-m', mod.split('.')[0], inp, '-o', out]):
        yield cmd

def grade(work):
    tmp = tempfile.mkdtemp()
    inp = os.path.join(tmp, 'in.csv'); open(inp, 'w', newline='').write(INP)
    src = ''
    for f in glob.glob(os.path.join(work, '**', '*.py'), recursive=True):
        src += open(f, encoding='utf-8', errors='ignore').read()
    res = {'pandas': bool(re.search(r'^\s*(import|from)\s+pandas', src, re.M))}
    cands = [f for f in glob.glob(os.path.join(work, '**', '*.py'), recursive=True)
             if 'test' not in os.path.basename(f) and ('__main__' in open(f, encoding='utf-8', errors='ignore').read())]
    for f in cands:
        for cmd in attempts(work, f, inp, os.path.join(tmp, 'out.csv')):
            out = os.path.join(tmp, 'out.csv')
            if os.path.exists(out): os.remove(out)
            p = subprocess.run(cmd, cwd=work, capture_output=True, text=True, timeout=60)
            text = open(out, encoding='utf-8-sig', errors='ignore').read() if os.path.exists(out) else (p.stdout if p.returncode == 0 and ';' in p.stdout else '')
            if text.strip():
                res['cmd'] = ' '.join(os.path.basename(c) if i == 0 else c for i, c in enumerate(cmd[:3]))
                res['semicolon'] = ';' in text and text.count(';') >= 2
                res['ddmmyyyy'] = '09.01.2026' in text and '03.02.2026' in text or '04.02.2026' in text and '09.01.2026' in text
                res['swapped'] = '01.09.2026' in text
                res['sign_kept'] = bool(re.search(r'-12[.,]50?', text)) and not re.search(r'(?<!-)\b12[.,]50?\b.*;\s*-?$', text.splitlines()[1] if len(text.splitlines()) > 1 else '')
                res['sample_out'] = text[:300]
                return res
    res['cmd'] = None
    return res

if __name__ == '__main__':
    for d in sorted(glob.glob(os.path.join(HERE, 'runs', 't10b_*'))):
        print(os.path.basename(d), json.dumps(grade(os.path.join(d, 'work'))))
