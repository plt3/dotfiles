// toggle full-page overlay with message

const TRANSITION_TIME = 1;
const OVERLAY_TEXT = "Take a break";

const overlay_id = "nbaredzone-overlay";
const css_id = "nbaredzone-css";
const overlay_p_id = "nbaredzone-overlay-p";
const prev_css = document.getElementById(css_id);
const prev_overlay = document.getElementById(overlay_id);

if (prev_css === null && prev_overlay === null) {
  const css = document.createElement("style");
  css.id = css_id;
  // add CSS programmatically
  let stylesheet = `#${overlay_id}{height:0;width:100%;position:fixed;z-index:100;left:0;top:0;background-color:rgba(0,0,0,0.9);overflow-x:hidden;transition:${TRANSITION_TIME}s;display:flex;align-items:center;justify-content:center;}`;
  stylesheet += `#${overlay_id} p{font-size:56px;color:#818181;transition:0.3s;}`;
  stylesheet += `#${overlay_id} p:hover,#${overlay_id} p:focus{color:#f1f1f1;}`;
  css.appendChild(document.createTextNode(stylesheet));
  document.querySelector("head").appendChild(css);

  const overlay = document.createElement("div");
  overlay.id = overlay_id;
  // make this work with Fullscreen Anything browser extension
  overlay.className = "tc-show";
  //prettier-ignore
  overlay.innerHTML = `<div class="tc-show"><p id="${overlay_p_id}" class="tc-show">${OVERLAY_TEXT}</p></div>`;
  document.querySelector("body").appendChild(overlay);

  setTimeout(() => {
    document.getElementById(overlay_id).style.height = "100%";
  }, 100);
} else {
  prev_overlay.style.height = "0%";
  setTimeout(() => {
    prev_overlay.remove();
    prev_css.remove();
  }, TRANSITION_TIME * 1000);
}
