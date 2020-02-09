$(document).on("turbolinks:load", function() {
    window.loadingMore = false;
    var target = document.getElementById("load-more");
    function loadMoreOnScroll() {
        var link = document.getElementById("load-more-link");
        if(link)
        {
            //If user scrolled to the target element
            if(window.scrollY > (target.offsetTop + target.offsetHeight - window.innerHeight))
            {
                if(!window.loadingMore)
                {
                    link.click();
                    window.loadingMore = true;
                }
            }
        }
    }
    if(target)
    {
        addEventListener("scroll", loadMoreOnScroll);
    } else
    {
        removeEventListener("scroll", loadMoreOnScroll);
    }
});