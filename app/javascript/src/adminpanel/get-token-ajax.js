$("#getToken").click(function() {
    var btn = $(this);
    btn.prop('disabled', true);
    var role = $("#role-select").find("option:selected").text();
    if(role === "Administrator") role = "admin";
    else role = "user";
    var name = $("#name-select").val();
    // #TODO Request should be POST, not GET (for sake of security)
    $.get("/admin/users/token?role="+role+"&name="+name,function(data){
        var showToken = $("#show-token");
        var tokenAlert = $("#token-info");
        showToken.html(data.value);
        tokenAlert.removeClass('alert-hidden');
        setTimeout(function(){
            btn.prop('disabled', false);
        }, 2000);
    });
});