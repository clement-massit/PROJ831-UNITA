$(document).ready(function () {
    rbLoginOption_onClick();
    ddlRoles_load();
});

/*RADIO BUTTONS: SHOW HIDE DIVS*/
function rbLoginOption_onClick(){
  $('input:radio[name="rbLoginOption"]').click(function() {
      var inputValue = $(this).attr("value");
      var targetBox = $("." + inputValue);
      $(".box").not(targetBox).hide();
      $(targetBox).show();
  });
}
/*LOAD DROPDOWN*/
function ddlRoles_load(){
  var url = ApplicationWS + '?id=101&applicationName=' + ApplicationName + '&jsonParams={"id" : 0}'; 
  var request  = new XMLHttpRequest()
  request.open('GET', url);
  request.setRequestHeader('Accept', 'application/json');
  request.setRequestHeader
  request.onload = function () {
    var data = JSON.parse(request.responseText);
    if (request.readyState == 4 && request.status == "200") {
      $.each(data, function(i, option) {
          $('#ddlRoles').append($('<option/>').attr("value", option.role_id).text(option.role_display_name));
      });
    } else {
        $("#content").load("error.html")
    }                       
  }
  request.send(null);  
}
/*ENTER*/
function btnLogin_onClick() {
  /*BY ROLE*/
  if ('role' == $('input:radio[name="rbLoginOption"]:checked').val()){
    myRole = $('#ddlRoles :selected').val();
    $("#content").load("index.html")
  }else{
    /*BY MAIL: GET ROLE BY MAIL*/
    var url = ApplicationWS + '?id=102&applicationName=' + ApplicationName + '&jsonParams={"user_mail" : "' + $('#txtEmail').val() +'"}'; 
    var request  = new XMLHttpRequest()
    request.open('GET', url);
    request.setRequestHeader('Accept', 'application/json');
    request.setRequestHeader
    request.onload = function () {
      var data = JSON.parse(request.responseText);
      if (request.readyState == 4 && request.status == "200") {
        if(null!=data)
          myRole = data[Object.keys(data)[0]];
        $("#content").load("index.html")
      } else {
          $("#content").load("error.html")
      }                       
    }
    request.send(null);  
  }
}
