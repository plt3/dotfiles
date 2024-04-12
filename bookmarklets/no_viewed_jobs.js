// remove viewed/applied jobs from different job boards

function linkedin() {
  // from https://www.reddit.com/r/linkedin/comments/nhzcyz/comment/hrdq2fk/
  let i = 0;
  const x = document.getElementsByClassName("jobs-search-results-list")[0];
  function phase2() {
    document.querySelectorAll("li").forEach(function (e) {
      e.id && e.innerHTML.match(/Viewed|Applied/) && e.remove();
    }),
      setTimeout(function () {
        x.scrollTop = 0;
      }, 0);
  }
  function wrapper() {
    x.scroll(0, 100 * ++i), i > 40 ? phase2() : setTimeout(wrapper, 0);
  }
  wrapper();
}

function indeed() {
  document.getElementById("mosaic-afterFifthJobResult")?.parentElement.remove();
  document.querySelectorAll("li.css-5lfssm").forEach((e) => {
    e.innerHTML.match(
      /Visited|We'll use this to show jobs you may be qualified for/,
    ) && e.remove();
  });
  document.querySelector("nav").scrollIntoView();
}

if (window.location.hostname.includes("linkedin")) {
  linkedin();
} else if (window.location.hostname.includes("indeed")) {
  indeed();
} else {
  alert("Not configured for this website");
}
