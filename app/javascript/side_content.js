if (location.pathname.match("ballot_boxes\$")){
  addEventListener("DOMContentLoaded", () => {
    const newVote = document.getElementById("new-vote");
    newVote.className += " active ";
  });
}

if (location.pathname.match("ballot_boxes/popular")){
  addEventListener("DOMContentLoaded", () => {
    const popularVote = document.getElementById("popular-vote");
    popularVote.className += " active ";
  });
}

if (location.pathname.match("ballot_boxes/\.\+/rooms")){
  addEventListener("DOMContentLoaded", () => {
    const roomId = location.pathname.replace(/\D/g, '');
    const userRoom = document.getElementById(`user-room-${Number(roomId)}`);
    if (userRoom != null ){
      userRoom.className += " active ";
    }
  });
}
