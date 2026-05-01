(function () {
  var select = document.getElementById('language-select');
  var base = '/ProjectBasedLearning';
  var path = window.location.pathname;
  var isRu = path.indexOf(base + '/ru/') === 0;

  function targetPath(lang) {
    if (lang === 'ru') {
      if (isRu) return path;
      if (path === base + '/' || path === base + '/index.html') return base + '/ru/';
      return path.replace(base + '/', base + '/ru/');
    }

    if (!isRu) return path;
    var next = path.replace(base + '/ru/', base + '/');
    return next === base + '/' ? base + '/' : next;
  }

  function chooseInitialLanguage() {
    var saved = localStorage.getItem('pbl-language');
    if (saved === 'ru' || saved === 'en') return saved;
    return (navigator.language || '').toLowerCase().indexOf('ru') === 0 ? 'ru' : 'en';
  }

  if (select) {
    select.value = isRu ? 'ru' : 'en';
    select.addEventListener('change', function () {
      localStorage.setItem('pbl-language', select.value);
      window.location.href = targetPath(select.value);
    });
  }

  var selected = chooseInitialLanguage();
  var redirected = sessionStorage.getItem('pbl-language-redirected') === '1';
  if (!redirected && selected === 'ru' && !isRu) {
    sessionStorage.setItem('pbl-language-redirected', '1');
    window.location.replace(targetPath('ru'));
  }
})();
