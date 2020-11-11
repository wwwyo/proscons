import consumer from "./consumer"

consumer.subscriptions.create("DiscussionChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let nickname = data.nickname;
    let comment = data.comment.replace(/\n|\r\n|\r/g, '<br>');
    const commentsArea = document.getElementById('comments-area')
    let html;
    if(document.getElementById("true")){
      html = `
        <div class="col-8 my-3">
        <div class="my-1">
          <p class="mb-0"style="font-size: 80%;">${nickname}:賛成 </p>
          <div class="border p-3" style="border-radius: 5px; display: inline-block;">
            ${comment}
          </div>
        </div>
        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart-fill button" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
          <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
        </svg>
      </div>`;
    }else{ 
      html =`
        <div class="col-8 offset-4 my-3">
        <div class="my-1" style="text-align: right;">
          <p class="mb-0"style="font-size: 80%;">${nickname}:反対</p>
          <div class="border p-2" style="border-radius: 3px; text-align:left; display: inline-block;">
            ${comment} 
          </div>
        </div>
        <div style="text-align: right;">
          <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart-fill button" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
          </svg>
        </div>
      </div>`;
    }
    commentsArea.insertAdjacentHTML('beforeend', html);
    commentsArea.scrollIntoView(false);
    const discussionComment = document.getElementById('discussion_comment');
    discussionComment.value = "";
  }
});