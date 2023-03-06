document.addEventListener("DOMContentLoaded", () => {
  const tagNameInput = document.getElementById("item-tag");
    if (tagNameInput){
      const inputElement = document.getElementById("item-tag");
      inputElement.addEventListener("input", () => {
        const keyword = document.getElementById("item-tag").value;
        const XHR = new XMLHttpRequest();
        XHR.open("GET", `/items/search/?keyword=${keyword}`, true);
        XHR.responseType = "json";
      });
    };
  });