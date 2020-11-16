if (location.pathname.match("/ballot_boxes/\.\+/rooms")){
  document.addEventListener("DOMContentLoaded", () => {
    const changeVote = document.getElementById("change-vote")
    if ( changeVote != null ){
      changeVote.addEventListener('click', ()=> {
        alert("意見を変更してもコメントは残ります");
      });
    }
  });
}