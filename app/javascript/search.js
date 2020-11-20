if (location.pathname.match("ballot_boxes\$|/popular")){
  document.addEventListener("DOMContentLoaded", () => {
    const hashtags = document.querySelectorAll(".hashtags");
    if (hashtags != null ){
      hashtags.forEach((hashtag) => {
        hashtag.addEventListener("click", ()=> {
          const searchForm = document.getElementById("q_name_cont");
          const tagSearch = document.getElementById("tag_search");
          const searchHashtag = hashtag.innerHTML.replace(/^#/g, "");
          searchForm.setAttribute("value", searchHashtag);
          tagSearch.submit();
        });
      });
    }
  });
}
