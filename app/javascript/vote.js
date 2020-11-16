if (location.pathname.match("ballot_boxes/[0-9]\+\$")){
  document.addEventListener("DOMContentLoaded", () =>{
    const voteForm = document.getElementById("vote-form");
    if ( voteForm != null ) {
      const prosBtn = document.getElementById("pros-btn");
      const consBtn = document.getElementById("cons-btn");
      prosBtn.addEventListener("click", () => {
        voteForm.setAttribute("value", "1");
      });
      consBtn.addEventListener("click", () => {
        voteForm.setAttribute("value", "0");
      });
    }
  });
}
