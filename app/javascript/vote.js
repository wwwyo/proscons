if (location.pathname.match("ballot_boxes/")){
  document.addEventListener("DOMContentLoaded", () =>{
    const prosBtn = document.getElementById("pros-btn");
    const consBtn = document.getElementById("cons-btn");
    const voteForm = document.getElementById("vote-form");
    prosBtn.addEventListener("click", () => {
      voteForm.setAttribute("value", "1");
    });
    consBtn.addEventListener("click", () => {
      voteForm.setAttribute("value", "0");
    });
  });
}
