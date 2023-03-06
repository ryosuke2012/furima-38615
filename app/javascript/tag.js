document.addEventListener("DOMContentLoaded", () => {
  const tagNameInput = document.getElementById("item-tag");
    if (tagNameInput){
      const inputElement = document.getElementById("item-tag");
      inputElement.addEventListener("input", () => {
        const keyword = document.getElementById("item-tag").value;
        console.log(keyword);
      });
    };
  });