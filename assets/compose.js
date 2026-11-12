/* Agent Playbook v2: composes the user's request with the additions they selected.
   One canonical data file (additions.json) feeds the page, the tests and the docs. */
(function (root) {
  'use strict';

  function compose(data, request, selectedIds) {
    var req = String(request || '').trim();
    var chosen = data.additions.filter(function (a) { return selectedIds.indexOf(a.id) !== -1; });
    var parts = [];
    if (req) parts.push(req);
    chosen.forEach(function (a) { parts.push(a.text); });
    return {
      text: parts.join('\n\n'),
      added: chosen.map(function (a) { return a.id; }),
      addedWords: chosen.reduce(function (n, a) { return n + a.text.split(/\s+/).length; }, 0),
      empty: !req
    };
  }

  var api = { compose: compose };
  if (typeof module !== 'undefined' && module.exports) module.exports = api;
  else root.APB = api;
})(this);
