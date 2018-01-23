$(function () {
  function buildSearchUserResult(user){
    var html = '<div id="chat-group-users">'+
                  '<div id="chat-group-user-'+ user.id + '" class="chat-group-user clearfix">'+
                    '<p class="chat-group-user__name">' + user.user_name + '</p>'+
                    '<a class="user-search-add chat-group-user__btn chat-group-user__btn--add js-add-btn" data-user-id="' + user.id + '" data-user-name="' + user.user_name + '">追加</a>'+
                  '</div>'+
                '</div>'
    $('#user-search-result').append(html);
  };

  function registUserSet(id, name){
    var html = '<div class="chat-group-user clearfix js-chat-member" id="chat-group-user-' + id +'">'+
                  '<input name="group[user_ids][]" type="hidden" value="' + id + '">'+
                  '<p class="chat-group-user__name">'+ name + '</p>'+
                  '<a class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn" data-user-id="'+ id +'" data-user-name="testman">削除</a>'+
               '</div>'

    $('.chat-group-users').append(html);

  };

  $("#user-search-field").on("keyup", function() {
    var input = $("#user-search-field").val();
    $.ajax({
      type: 'GET',
      url: '/users/search',
      data: {name: input},
      dataType:'json'
    })
    .done(function(users) {
      $("#user-search-result").empty();
      if($.isArray(users)){
        var added_user = new Array();
        $(".js-chat-member").each(function(i){
          var id = $(".js-chat-member:eq("+i+") a")[0].getAttribute("data-user-id");
          added_user.unshift(Number(id));
        });
        users.forEach(function(user){
          if($.inArray(user.id, added_user) == -1){
            buildSearchUserResult(user)
          };
        });
      }else{
        return false;
      }
    })
    .fail(function(){
      alert("ユーザーを検索できませんでした")
    })
  });

  $(document).on("click", ".user-search-add", function(event){
    var add_user = this
    user_id = this.getAttribute('data-user-id')
    user_name = this.getAttribute('data-user-name')
    registUserSet(user_id,user_name);
    $(this).parent().parent().remove();
  });

  $(document).on("click", ".user-search-remove", function(){
    $(this).parent().remove()
  });
});
