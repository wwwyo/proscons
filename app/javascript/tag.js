function hashtag(){
  document.addEventListener("DOMContentLoaded", () => {
    const addTag = document.getElementById("add-tag");
    let tagNum = 0
    addTag.addEventListener('click', () => {
      const tagForm = document.getElementById("tag-form");
      tagNum ++
      const inputTag = `
        <div class="d-flex" id="remove-tag${tagNum}-form">
          <div class="input-group-prepend " style="width: 100%;">
            <div class="input-group-text">#</div>
            <input type="text" name="names[name${tagNum}]" class="form-control add-tags" placeholder="1つずつ入力">
          </div>
          <button type="button" class=" remove-btn btn btn-outline-dark" id="remove-tag${tagNum}" >
            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-file-minus-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" d="M12 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM6 7.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1H6z"></path>
          </svg>
          </button>
        </div>`;
      tagForm.insertAdjacentHTML("beforeend", inputTag);
      const removeBtns = document.querySelectorAll(".remove-btn");
      removeBtns.forEach(function(removeBtn) {
        removeBtn.addEventListener('click', () =>{
          const removeTagNum = removeBtn.getAttribute("id");
          const removeTagForm = document.getElementById(`${removeTagNum}-form`);
          removeTagForm.remove();
        });
      });

      // const ballotCreate = document.getElementById("ballot_create");
      // ballotCreate.addEventListener("click", (e) => {
      //   e.preventDefault();
      //   const input = document.getElements
      //   console.log(input)
      //   const XHR = XMLHttpRequest();
      //   XHR.open("POST", "/ballot_boxes", true)
      //   XHR.responseType = "json"
      //   XHR.send()
      // })
    });
  });
};
window.addEventListener("load", hashtag());