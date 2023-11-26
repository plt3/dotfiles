// https://github.com/brookhong/Surfingkeys configuration

// remap fromKey to toKey. If mapBothWays, also map toKey to fromKey
function mapKey(fromKey, toKey, mapBothWays = false) {
  if (!mapBothWays) {
    api.map(fromKey, toKey);
    api.unmap(toKey);
  } else {
    const tempKey = "longrandomstring";

    api.map(tempKey, fromKey);
    api.map(fromKey, toKey);
    api.map(toKey, tempKey);
    api.unmap(tempKey);
  }
}

settings.defaultSearchEngine = "d";
settings.modeAfterYank = "Normal";
api.Hints.setCharacters("aoeuidhtns");

api.Visual.style("marks", "background-color: #A3BE8C99;");
api.Visual.style("cursor", "background-color: #88C0D0;");

// link hints
mapKey("-", "f");
mapKey("_", "gf");
// navigate between tabs
mapKey("J", "E");
mapKey("K", "R");
// scroll by full page
mapKey("F", "P");
mapKey("B", "U");
// navigate through history
mapKey("H", "S", true);
mapKey("L", "D");
// open generic omnibar (and t to open new tab)
mapKey("O", "t");
mapKey("t", "on");
mapKey("gm", "om"); // open vim-like marks
mapKey("o", "go");
// paste URL from clipboard
api.mapkey("p", "Open the clipboard's URL in the current tab", function () {
  api.Clipboard.read(function (response) {
    window.location.href = response.data;
  });
});
mapKey("P", "cc");
// inspired by https://github.com/b0o/surfingkeys-conf
api.mapkey("gh", "Open the clipboard's GitHub URL", function () {
  api.Clipboard.read(function (response) {
    const quotes = ['"', "'"];
    let url = response.data;
    if (
      quotes.includes(url.charAt(0)) &&
      quotes.includes(url.charAt(url.length - 1))
    ) {
      window.location.href = `https://github.com/${url.slice(
        1,
        url.length - 1
      )}`;
    } else {
      window.location.href = `https://github.com/${url}`;
    }
  });
});
api.mapkey(
  "go",
  "Open DuckDuckGo search result with Google",
  function () {
    const params = new URLSearchParams(window.location.search);
    params.set("q", params.get("q") + " !g");
    window.location.search = params.toString();
  },
  { domain: /duckduckgo\.com/i }
);

// disable (at least partially) on some sites
api.unmapAllExcept(["J", "K", "o", "O"], /mail.google.com|cstimer.net/);
api.unmapAllExcept(["J", "K", "o", "O"], /mail.google.com|cstimer.net/);
api.unmapAllExcept(
  [],
  /localhost|https:\/\/bubble.io|coderbyte.com|docs.google.com|NBARedZone|bestsolaris.com/
);
api.unmap("j", /duckduckgo.com/);
api.unmap("k", /duckduckgo.com/);
api.unmap("0", /youtube.com/);

settings.theme = `
:root {
  --theme-ace-bg: #282828; /*Note the fourth channel, this adds transparency*/
  --theme-ace-bg-accent: #3c3836;
  --theme-ace-fg: #ebdbb2;
  --theme-ace-fg-accent: #7c6f64;
  --theme-ace-cursor: #928374ab;
  --theme-ace-select: #458588;
}
#sk_editor {
  background: var(--theme-ace-bg) !important;
}
.ace_dialog-bottom {
  border-top: 1px solid var(--theme-ace-bg) !important;
}
.ace-chrome .ace_print-margin,
.ace_gutter,
.ace_gutter-cell,
.ace_dialog {
  background: var(--theme-ace-bg-accent) !important;
}
.ace-chrome {
  color: var(--theme-ace-fg) !important;
}
.ace_gutter,
.ace_dialog {
  color: var(--theme-ace-fg-accent) !important;
}
.ace_cursor {
  color: var(--theme-ace-cursor) !important;
}
.normal-mode .ace_cursor {
  background-color: var(--theme-ace-cursor) !important;
  border: var(--theme-ace-cursor) !important;
}
.ace_marker-layer .ace_selection {
  background: var(--theme-ace-select) !important;
}
.sk_theme {
  font-family: Input Sans Condensed, Charcoal, sans-serif;
  font-size: 12pt;
  background: #24272e;
  color: #abb2bf;
}
.sk_theme tbody {
  color: #fff;
}
.sk_theme input {
  color: #d0d0d0;
}
.sk_theme .url {
  color: #61afef;
}
.sk_theme .annotation {
  color: #56b6c2;
}
.sk_theme .omnibar_highlight {
  color: #528bff;
}
.sk_theme .omnibar_timestamp {
  color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
  color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
  background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
  background: #3e4452;
}
#sk_status,
#sk_find {
  font-size: 20pt;
}`;
