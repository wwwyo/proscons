if ( location.pathname.match("ballot_boxes\$\|/new")) {
  document.addEventListener("DOMContentLoaded", () => {
    const addTag = document.getElementById("add-tag");
    if (addTag != null ) {
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
      });
    }
    function load(){
      const removeBtns = document.querySelectorAll(".remove-btn");
      removeBtns.forEach(function(removeBtn) {
        if (removeBtn.getAttribute("data-load") != null) {
          return null;
        }
        removeBtn.setAttribute("data-load", "true");
        removeBtn.addEventListener('click', () =>{
          const removeTagNum = removeBtn.getAttribute("id");
          const removeTagForm = document.getElementById(`${removeTagNum}-form`);
          removeTagForm.remove();
        });
      });
    };
    setInterval(load, 1000)
  });
}
