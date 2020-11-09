import consumer from "./consumer"

consumer.subscriptions.create("DiscussionChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    let comment = data.content.comment.replace(/\n|\r\n|\r/g, '<br>');
    const html = `<div class="my-4" >
                    <div class="border p-2 d-flex" style="border-radius: 3px;">
                      ${comment}
                    </div>
                    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-heart-fill button" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                    </svg>
                  </div>`;
    const comments = document.getElementById('comments');
    const discussionComment = document.getElementById('discussion_comment');
    comments.insertAdjacentHTML('beforeend', html);
    discussionComment.value = "";
  }
});
