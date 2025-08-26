---
layout: default
title: 'Поиск 🔍'
date: 2025-08-21
published: true
---

<style>
/* Стили для поиска */
#search-container {
  max-width: 700px;
  margin: 40px auto;
  font-family: Arial, sans-serif;
}
#search {
  width: 100%;
  padding: 10px 15px;
  font-size: 16px;
  border: 2px solid #333;
  border-radius: 6px;
  margin-bottom: 15px;
}

/* Стили для поиска */
#results {
  list-style: none;
  padding: 0;
}

.search-result {
  border: 1px solid #ccc;
  border-radius: 6px;
  padding: 15px 15px;
  margin-bottom: 10px;
  background: #161616;
  color: #b9b09e;
  transition: background 0.2s;
}

.search-result a {
  text-decoration: none;
  color: #ebcc10;
  font-weight: bold;
  font-size: 18px;
  padding: 16px;
}

.search-result:hover {
  background: #262626;
}

.search-result p {
  margin: 5px 0 0 0;
  font-size: 14px;
  color: #555;
}

.search-ul-st{
  color: #f9f9f9;
  margin: 0 10px;
  padding: 0px 0px 0px 20px;
  background: #242424;
  border-radius: 10px;
  border: 2px solid #6da312;
}

.search-li-st{
  color: #f9f9f9;
  background: #3e3e3e;
  border: 1px solid #545454;
  border-radius: 10px;
  padding: 5px;
  margin: 11px 5px;
}
</style>

<div id="search-container">
  <input type="text" id="search" placeholder="Введите текст для поиска 🔍">
  <ul id="results"></ul>
  <a href="index.html">⬆ Вернуться к оглавлению</a>
</div>

<!-- Подключаем elasticlunr.js -->
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
      
      // группируем по url
      const grouped = {};
      searchResults.forEach(r => {
        const doc = data.find(d => d.url === r.ref);
        if (!doc) return;

        // режем на строки
        const lines = doc.content.split(/[\r\n]+/);

        // ищем совпадения
        const matches = lines.filter(line => line.toLowerCase().includes(query));
        if (matches.length === 0) return;

        if (!grouped[doc.url]) grouped[doc.url] = {title: doc.title, rows: []};
        grouped[doc.url].rows.push(...matches);
      });

      for (const url in grouped) {
        const catBlock = document.createElement('div');
        catBlock.className = 'search-result';
        catBlock.innerHTML = `<a href="${url}">${grouped[url].title}</a>`;
        const ul = document.createElement('ul');
        ul.classList.add("search-ul-st");
        grouped[url].rows.forEach(row => {
          const li = document.createElement('li');
          // превращаем Markdown (таблицы, ссылки и т.п.) в HTML
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
