// Inject a visible Table of Contents into print.html so it also appears in the PDF.
//
// mdbook-pdf renders `print.html`. mdBook intentionally keeps the sidebar TOC out of
// the main DOM (to avoid O(n^2) HTML size), and `toc.js` dynamically populates the
// sidebar. For the PDF we want a *single* visible TOC page, so we clone the already
// populated TOC markup from the sidebar into the document content.

(function () {
  const isPrintPage = () => {
    // `print.html` can be served from file:// or http(s):// and may have query/hash.
    const path = (window.location && window.location.pathname) || '';
    return /(?:^|\/|\\)print\.html$/i.test(path);
  };

  if (!isPrintPage()) return;

  const inject = () => {
    if (document.getElementById('pdf-toc')) return;

    const main = document.querySelector('#mdbook-content main');
    if (!main) return;

    // `toc.js` populates this custom element with an `<ol class="chapter">...`.
    const sidebarScrollbox = document.querySelector('#mdbook-sidebar mdbook-sidebar-scrollbox');
    if (!sidebarScrollbox) return;

    const tocRoot = sidebarScrollbox.querySelector('ol.chapter');
    if (!tocRoot) return;

    const section = document.createElement('section');
    section.id = 'pdf-toc';
    section.className = 'pdf-toc';

    const h1 = document.createElement('h1');
    h1.textContent = 'Table of Contents';
    section.appendChild(h1);

    const tocClone = tocRoot.cloneNode(true);

    // Hide fold toggles; in a PDF we want a fully expanded list.
    tocClone.querySelectorAll('.chapter-fold-toggle').forEach((el) => el.remove());
    tocClone.querySelectorAll('li.chapter-item').forEach((li) => li.classList.add('expanded'));

    // Ensure TOC links target anchors within print.html.
    // In mdBook 0.5+, print.html links should already be rewritten, but we keep this
    // as a safety net.
    tocClone.querySelectorAll('a[href]').forEach((a) => {
      const href = a.getAttribute('href');
      if (!href) return;
      if (href.startsWith('#')) return;
      // Ignore absolute URLs.
      if (/^(?:[a-z+]+:)?\/\//i.test(href)) return;

      const hashIndex = href.indexOf('#');
      if (hashIndex >= 0) {
        a.setAttribute('href', href.slice(hashIndex));
      }
    });

    section.appendChild(tocClone);

    // Put TOC at the very beginning of the book content.
    main.insertBefore(section, main.firstChild);
  };

  // `toc.js` runs early, but the custom element populates in its connectedCallback.
  // Try immediately, then observe until it becomes available.
  inject();

  const observer = new MutationObserver(() => {
    inject();
    if (document.getElementById('pdf-toc')) observer.disconnect();
  });

  observer.observe(document.documentElement, { childList: true, subtree: true });
})();
