// Checks run locally (node tests/check.js) and in CI before anything deploys.
// 1. The page scripts parse. 2. Every combination of additions composes. 3. Generated text matches
// the reviewed snapshot (update with --update after reviewing the diff). 4. Known v1 contradictions
// and forbidden instructions cannot come back. 5. Version strings agree.
'use strict';
const fs = require('fs');
const path = require('path');
const vm = require('vm');
const root = path.join(__dirname, '..');
const read = (f) => fs.readFileSync(path.join(root, f), 'utf8');
let failures = 0;
const fail = (msg) => { failures++; console.error('FAIL ' + msg); };

// 1. syntax
for (const f of ['assets/compose.js', 'assets/page.js']) {
  try { new vm.Script(read(f), { filename: f }); } catch (e) { fail(f + ' does not parse: ' + e.message); }
}
const { compose } = require(path.join(root, 'assets/compose.js'));
const data = JSON.parse(read('additions.json'));

// 2. structure
const ids = data.additions.map((a) => a.id);
if (new Set(ids).size !== ids.length) fail('duplicate addition ids');
for (const a of data.additions) {
  for (const k of ['id', 'label', 'help', 'text', 'why']) if (!a[k] || typeof a[k] !== 'string') fail(a.id + ' missing ' + k);
  if (/<\/?script/i.test(JSON.stringify(a))) fail(a.id + ' contains a script tag');
}

// 3. every combination, snapshot
const req = 'Fix the export so it ignores empty rows.';
const combos = {};
for (let mask = 0; mask < 1 << ids.length; mask++) {
  const sel = ids.filter((_, i) => mask & (1 << i));
  const r = compose(data, req, sel);
  if (!r.text.startsWith(req)) fail('request not first for ' + sel.join('+'));
  if (sel.length === 0 && r.text !== req) fail('empty selection must return the request unchanged');
  for (const id of sel) if (!r.text.includes(data.additions.find((a) => a.id === id).text)) fail('missing ' + id);
  combos[sel.join('+') || '(none)'] = r.text;
}
if (compose(data, '   ', []).text !== '') fail('blank request should compose to empty text');
const snapFile = path.join(__dirname, 'snapshot.json');
if (process.argv.includes('--update')) {
  fs.writeFileSync(snapFile, JSON.stringify(combos, null, 1) + '\n');
  console.log('snapshot updated: ' + Object.keys(combos).length + ' combinations');
} else {
  const snap = JSON.parse(fs.readFileSync(snapFile, 'utf8'));
  for (const k of Object.keys(combos)) if (snap[k] !== combos[k]) fail('snapshot differs for ' + k + ' (review, then run with --update)');
  if (Object.keys(snap).length !== Object.keys(combos).length) fail('snapshot has a different number of combinations');
}

// 4. things v2 removed must not return in generated text
const all = Object.values(combos).join('\n');
const banned = [
  [/instructions come only from/i, 'v1 trust rule that contradicted project instruction files'],
  [/STATE\.md|DECISIONS\.md|PLAYBOOK\.md/, 'prescribed v1 project files'],
  [/\b(two|three|30|eight) (rounds|attempts|lines|strikes)\b/i, 'arbitrary numeric thresholds'],
  [/\boracle\b/i, 'v1 oracle terminology'],
  [/\b(opus|sonnet|haiku|fable|gpt-?\d|effort level)\b/i, 'model names or effort levels'],
];
for (const [re, why] of banned) if (re.test(all)) fail('generated text contains ' + why);

// 5. versions agree
const cfg = read('_config.yml').match(/^version:\s*"?([^"\n]+)"?/m);
if (!cfg || cfg[1].trim() !== data.version) fail('_config.yml version does not match additions.json');
const log = read('CHANGELOG.md').match(/^## (\S+)/m);
if (!log || log[1] !== data.version) fail('CHANGELOG.md top entry does not match additions.json version');

if (failures) { console.error(failures + ' check(s) failed'); process.exit(1); }
console.log('ok: ' + Object.keys(combos).length + ' combinations, version ' + data.version);
