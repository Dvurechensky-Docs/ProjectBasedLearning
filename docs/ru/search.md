---
layout: default
lang: ru
title: 'Поиск'
seo_title: 'Поиск проектов для изучения программирования'
description: 'Поиск по подборке проектного обучения: Python, JavaScript, Rust, C#, HTML CSS, backend, frontend, мобильная разработка и практические туториалы.'
h1: 'Поиск проектов и туториалов'
date: 2025-08-21
published: true
---

<div id="search-container">
  <input type="text" id="search" placeholder="Искать проекты на Python, Rust, JavaScript, C#...">
  <ul id="results"></ul>
  <a href="index.html">Назад ко всем категориям</a>
</div>

<script src="https://unpkg.com/lunr/lunr.js"></script>
<script src="https://unpkg.com/lunr-languages/lunr.stemmer.support.js"></script>
<script src="https://unpkg.com/lunr-languages/lunr.ru.js"></script>
<script src="https://unpkg.com/lunr-languages/lunr.multi.js"></script>
<script src="https://cdn.jsdelivr.net/npm/marked@12.0.2/marked.min.js"></script>
<script>
fetch('{{ "/search.json" | relative_url }}')
  .then(res => res.json())
  .then(data => {
    const idx = lunr(function () {
      this.use(lunr.multiLanguage('ru','en'))
      this.ref('url')
      this.field('title')
      this.field('content')
      data.forEach(doc => this.add(doc))
    });

    const input = document.querySelector('#search');
    const results = document.querySelector('#results');

    input.addEventListener('input', function() {
      const query = this.value.trim().toLowerCase();
      results.innerHTML = '';
      if (query.length < 2) return;

      const searchResults = idx.search(query, {expand: true});
      const grouped = {};
      searchResults.forEach(r => {
        const doc = data.find(d => d.url === r.ref);
        if (!doc) return;
        const lines = doc.content.split(/[\r\n]+/);
        const matches = lines.filter(line => line.toLowerCase().includes(query));
        if (matches.length === 0) return;
        if (!grouped[doc.url]) grouped[doc.url] = {title: doc.title, rows: []};
        grouped[doc.url].rows.push(...matches);
      });

      for (const url in grouped) {
        const catBlock = document.createElement('div');
        catBlock.className = 'search-result';
        const localizedUrl = url.replace('/ProjectBasedLearning/', '/ProjectBasedLearning/ru/');
        catBlock.innerHTML = `<a href="${localizedUrl}">${grouped[url].title}</a>`;
        const ul = document.createElement('ul');
        ul.classList.add("search-ul-st");
        grouped[url].rows.forEach(row => {
          const li = document.createElement('li');
          li.innerHTML = marked.parseInline(row);
          li.classList.add("search-li-st");
          ul.appendChild(li);
        });
        catBlock.appendChild(ul);
        results.appendChild(catBlock);
      }
    });
  });
</script>
