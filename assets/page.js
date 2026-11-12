/* Page wiring for the composer. Data: additions.json. Logic: compose.js. */
(function () {
  'use strict';
  var $ = function (id) { return document.getElementById(id); };
  var data = null;

  function selected() {
    return Array.prototype.map.call(document.querySelectorAll('#adds input[data-kind=add]:checked'), function (i) { return i.value; });
  }

  function render() {
    if (!data) return;
    var r = window.APB.compose(data, $('req').value, selected());
    $('out').value = r.text;
    var v = $('verdict');
    if (r.empty && !r.added.length) {
      v.textContent = 'Write your request in step 1. The text to paste appears here.';
    } else if (!r.added.length) {
      v.textContent = 'Nothing to add. Your request is the whole prompt: paste it as it is.';
    } else {
      v.textContent = 'Adds ' + r.added.length + (r.added.length === 1 ? ' paragraph' : ' paragraphs') +
        ' (' + r.addedWords + ' words) to your request.' + (r.empty ? ' Write your request in step 1 first.' : '');
    }
    $('copy').disabled = !r.text;
    var adv = $('advice');
    adv.textContent = '';
    Array.prototype.forEach.call(document.querySelectorAll('#adds input[data-kind=advice]:checked'), function (i) {
      var a = data.advice.filter(function (x) { return x.id === i.value; })[0];
      var p = document.createElement('p');
      var b = document.createElement('b'); b.textContent = a.label + '. ';
      p.appendChild(b); p.appendChild(document.createTextNode(a.text));
      adv.appendChild(p);
    });
    adv.hidden = !adv.childNodes.length;
    $('copy-status').textContent = '';
  }

  function item(a, kind) {
    var wrap = document.createElement('div');
    wrap.className = 'add';
    var input = document.createElement('input');
    input.type = 'checkbox'; input.id = kind + '-' + a.id; input.value = a.id;
    input.setAttribute('data-kind', kind);
    input.setAttribute('aria-describedby', input.id + '-d');
    input.addEventListener('change', render);
    var label = document.createElement('label');
    label.htmlFor = input.id; label.textContent = a.label;
    wrap.appendChild(input); wrap.appendChild(label);
    if (kind === 'add') {
      var desc = document.createElement('p');
      desc.id = input.id + '-d'; desc.className = 'add-d'; desc.textContent = a.help;
      var more = document.createElement('details');
      var sum = document.createElement('summary'); sum.textContent = 'What it adds, and why';
      var q = document.createElement('blockquote'); q.textContent = a.text;
      var why = document.createElement('p'); why.textContent = a.why;
      more.appendChild(sum); more.appendChild(q); more.appendChild(why);
      wrap.appendChild(desc); wrap.appendChild(more);
    } else {
      var adv = document.createElement('p');
      adv.id = input.id + '-d'; adv.className = 'add-d';
      adv.textContent = 'Adds nothing to the prompt; shows advice for you.';
      wrap.appendChild(adv);
    }
    return wrap;
  }

  function build(d) {
    data = d;
    var box = $('adds');
    d.additions.forEach(function (a) { box.appendChild(item(a, 'add')); });
    (d.advice || []).forEach(function (a) { box.appendChild(item(a, 'advice')); });
    render();
  }

  function copied(ok) {
    $('copy-status').textContent = ok ? 'Copied.' : 'Could not copy automatically. The text is selected: press Ctrl+C (or Cmd+C on a Mac).';
  }

  $('copy').addEventListener('click', function () {
    var out = $('out');
    var fallback = function () {
      out.focus(); out.select();
      var ok = false;
      try { ok = document.execCommand('copy'); } catch (e) { ok = false; }
      copied(ok);
    };
    if (navigator.clipboard && window.isSecureContext) {
      navigator.clipboard.writeText(out.value).then(function () { copied(true); }, fallback);
    } else {
      fallback();
    }
  });
  $('req').addEventListener('input', render);

  fetch('additions.json', { cache: 'no-cache' })
    .then(function (r) { if (!r.ok) throw new Error(r.status); return r.json(); })
    .then(build)
    .catch(function () {
      $('verdict').textContent = 'The list of additions could not be loaded. Reload the page; if it keeps failing, paste your request on its own.';
    });
})();
