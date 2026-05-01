<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sm="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
>
  <xsl:output method="html" encoding="utf-8" indent="yes" />

  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Project Based Learning Sitemap</title>
        <style>
          :root {
            color-scheme: dark;
            --bg: #0d1117;
            --panel: #151b23;
            --text: #f4f7fb;
            --muted: #a7b0c0;
            --line: #303a49;
            --accent: #5eead4;
          }
          * { box-sizing: border-box; }
          body {
            margin: 0;
            color: var(--text);
            background: var(--bg);
            font: 15px/1.55 system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
          }
          main {
            width: min(1180px, calc(100% - 32px));
            margin: 0 auto;
            padding: 42px 0;
          }
          h1 {
            margin: 0 0 8px;
            font-size: clamp(2rem, 5vw, 3.2rem);
          }
          p {
            margin: 0 0 24px;
            color: var(--muted);
          }
          a { color: var(--accent); text-decoration: none; }
          a:hover { text-decoration: underline; }
          table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            border: 1px solid var(--line);
            border-radius: 8px;
            background: var(--panel);
          }
          th, td {
            padding: 12px 14px;
            border-bottom: 1px solid var(--line);
            text-align: left;
            vertical-align: top;
          }
          th {
            color: var(--text);
            background: #101722;
            font-size: 0.82rem;
            text-transform: uppercase;
          }
          td {
            color: var(--muted);
          }
          tr:last-child td {
            border-bottom: 0;
          }
          .url {
            word-break: break-word;
          }
          .number {
            width: 64px;
            color: var(--muted);
          }
          @media (max-width: 720px) {
            table, thead, tbody, tr, th, td { display: block; }
            thead { display: none; }
            tr { border-bottom: 1px solid var(--line); }
            td { border-bottom: 0; padding: 8px 12px; }
            td::before {
              display: block;
              color: var(--text);
              font-size: 0.75rem;
              font-weight: 700;
              text-transform: uppercase;
            }
            td:nth-child(1)::before { content: "#"; }
            td:nth-child(2)::before { content: "URL"; }
            td:nth-child(3)::before { content: "Last modified"; }
            td:nth-child(4)::before { content: "Changefreq"; }
            td:nth-child(5)::before { content: "Priority"; }
          }
        </style>
      </head>
      <body>
        <main>
          <h1>Project Based Learning Sitemap</h1>
          <p>
            This XML sitemap contains
            <strong><xsl:value-of select="count(sm:urlset/sm:url)" /></strong>
            canonical URLs with hreflang alternates.
          </p>
          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>URL</th>
                <th>Last modified</th>
                <th>Changefreq</th>
                <th>Priority</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="sm:urlset/sm:url">
                <tr>
                  <td class="number"><xsl:value-of select="position()" /></td>
                  <td class="url">
                    <a>
                      <xsl:attribute name="href"><xsl:value-of select="sm:loc" /></xsl:attribute>
                      <xsl:value-of select="sm:loc" />
                    </a>
                  </td>
                  <td><xsl:value-of select="sm:lastmod" /></td>
                  <td><xsl:value-of select="sm:changefreq" /></td>
                  <td><xsl:value-of select="sm:priority" /></td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </main>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
