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
    let discussionId = data.discussion_id;
    let comment = data.comment.replace(/\n|\r\n|\r/g, '<br>');
    const commentsArea = document.getElementById('comments-area')
    let html;
    if(document.getElementById("true")){
      html = `
        <div class="col-8 my-5">
        <div class="my-0">
          <p class="mb-0"style="font-size: 80%;">${nickname}:賛成 </p>
          <div class="border p-2" style="border-radius: 5px; display: inline-block;">
            ${comment}
          </div>
        </div>
        <div type="button" class="like btn p-0" id="discussion-${discussionId}">
          <span class="fa fa-thumbs-o-up">いいね！</span>
        </div>
      </div>`;
    }else{ 
      html =`
        <div class="col-8 offset-4 my-5">
        <div class="my-0" style="text-align: right;">
          <p class="mb-0"style="font-size: 80%;">${nickname}:反対</p>
          <div class="border p-2" style="border-radius: 3px; text-align:left; display: inline-block;">
            ${comment} 
          </div>
        </div>
        <div style="text-align: right;">
          <div type="button" class="like btn p-0" id="discussion-${discussionId}">
            <span class="fa fa-thumbs-o-up">いいね！</span>
          </div>
        </div>
      </div>`;
    }
    commentsArea.insertAdjacentHTML('beforeend', html);
    commentsArea.scrollIntoView(false);
    const discussionComment = document.getElementById('discussion_comment');
    discussionComment.value = "";
  }
});