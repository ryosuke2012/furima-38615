document.addEventListener("DOMContentLoaded", () => {
  const tagNameInput = document.getElementById("item-tag");
    if (tagNameInput){
      const inputElement = document.getElementById("item-tag");
      inputElement.addEventListener("input", () => {
        const keyword = document.getElementById("item-tag").value;
        const XHR = new XMLHttpRequest();
        XHR.open("GET", `/items/search/?keyword=${keyword}`, true);
        XHR.responseType = "json";
        XHR.send();
        XHR.onload = () => {
          const tagName = XHR.response.keyword;
          const searchResult = document.getElementById("search-result");
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.tag_name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("item-tag").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      });
    };
  });