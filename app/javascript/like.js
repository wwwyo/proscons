function loadDocument(){
  if (location.pathname.match("/ballot_boxes/\.\+/rooms")){
    const likeBtns = document.querySelectorAll(".like")
    likeBtns.forEach((likeBtn) => {
      if (likeBtn.getAttribute("data-load") != null) {
        return null;
      }
      likeBtn.setAttribute("data-load", "true");
      likeBtn.addEventListener("click", () => {
        const path = location.pathname;
        const ballotBoxId = path.replace(/\D/g, '');
        const roomId = ballotBoxId; 
        let discussionNum = likeBtn.getAttribute("id");
        discussionNum = discussionNum.replace(/\D/g, '');
        let XHR = new XMLHttpRequest();
        if (likeBtn.getAttribute("style")){
          XHR.open("DELETE", `/ballot_boxes/${ballotBoxId}/rooms/${ballotBoxId}/discussions/${discussionNum}/likes/1`, true);
          XHR.responseType = "json";
          XHR.send();
          XHR.onload = () => {
            if (XHR.status == 204) {
              likeBtn.removeAttribute("style");
            }
          };
        }else{
          XHR.open("POST",`/ballot_boxes/${ballotBoxId}/rooms/${ballotBoxId}/discussions/${discussionNum}/likes`, true);
          XHR.responseType = 'json';
          XHR.send(discussionNum);
          XHR.onload = () =>{
            if (XHR.status == 204) {
              likeBtn.setAttribute("style", "color: blue;");
            }
          };
        }
      });
    });
  }
};
setInterval(loadDocument, 1000);
