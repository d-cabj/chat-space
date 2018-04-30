$(document).on('turbolinks:load', function(){
  if(window.location.href.match(/groups\/\d+\/messages/)){
    var group_id = $("#new_message").attr("action").match(/(\d+)/)[1]
    $(".group").each(function( index ) {
      var judge_group_id = $(".group:eq("+index+") a").attr("href").match(/(\d+)/)[1]
      if (judge_group_id == group_id){
        now_group_latest_message = $(".group:eq("+index+") a .group__message")
      }
    });
  }

  function buildHTML(message){
    if(message.messages){
      return;
    }
    if (message.body == ""){
      var chat_message = "";
    }else{
      var chat_message = '<p class="lower-message__content">' +
                            message.body +
                         '</p>'
    }
    if (message.message_img == null){
      var chat_message_img = "";
    }else{
      var chat_message_img = '<img class="lower-message__image" src="' + message.message_img + '">'
    }

    var html = '<div class="message" data-id="'+ message.id+'">'+
                  '<div class="upper-message">'+
                    '<div class="upper-message__user-name">'+
                      message.user_name +
                    '</div>'+
                    '<div class="upper-message__date">'+
                      message.created_at +
                    '</div>'+
                  '</div>'+
                  '<div class="lower-message">'+
                    chat_message+
                    chat_message_img+
                  '</div>'+
               '</div>'
    $('.js-messages').append(html);
  }

  function scroll(){
    $(".messages").stop().animate({ scrollTop: $(".messages")[0].scrollHeight }, { duration: "normal", easing: 'swing' } );
  };

  $('.form__submit').on('click', function(e){
    e.preventDefault();
    var formData = new FormData($("#new_message").get(0));
    $.ajax({
      url: $('#new_message').attr('action'),
      type: $('#new_message').attr('method'),
      data: formData,
      cache: false,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      buildHTML(data);
      scroll();
      $("#new_message")[0].reset();
      if($(".message:last-child .lower-message__content").length == 1 && now_group_latest_message){

        // 30文字以上のメッセージの場合は省略
        $(".message:last-child .lower-message__content").text().match(/^(.{50})/) != null ? emitted_message = $(".message:last-child .lower-message__content").text().match(/^(.{50})/)[0] + ".." : emitted_message = $(".message:last-child .lower-message__content").text()

        now_group_latest_message.text(emitted_message);
      }else{
        now_group_latest_message.text("画像");
      }
      // $(".message:last-child .lower-message__content").length == 1 ? now_group_latest_message.text($(".message:last-child .lower-message__content").text()) : now_group_latest_message.text("画像");
    })
    .fail(function(){
      alert('error');
    })
  })
})

// $(function () {
$(document).on('turbolinks:load', function(){
  function buildHTML(message){
    if(message.messages){
      return;
    }
    if (message.body == ""){
      var chat_message = "";
    }else{
      var chat_message = '<p class="lower-message__content">' +
                            message.body +
                         '</p>'
    }
    if (message.message_img == null){
      var chat_message_img = "";
    }else{
      var chat_message_img = '<img class="lower-message__image" src="' + message.message_img + '">'
    }

    var html = '<div class="message" data-id="'+ message.id+'">'+
                  '<div class="upper-message">'+
                    '<div class="upper-message__user-name">'+
                      message.user_name +
                    '</div>'+
                    '<div class="upper-message__date">'+
                      message.created_at +
                    '</div>'+
                  '</div>'+
                  '<div class="lower-message">'+
                    chat_message+
                    chat_message_img+
                  '</div>'+
               '</div>'
    $('.js-messages').append(html);
  }

  function scroll(){
    $(".messages").stop().animate({ scrollTop: $(".messages")[0].scrollHeight }, { duration: "normal", easing: 'swing' } );
  };

  if(window.location.href.match(/groups\/\d+\/messages/)){
    setInterval(function(){
      if($(".message:last").length == 0){
        return false;
      }
      var message_id = $(".message:last").data("id");
      group_id = window.location.href.match(/groups\/(\d+)/)[1]
      $.ajax({
        url: window.location.href,
        type: "GET",
        data: { message_id : message_id },
        dataType: 'json',
        contentType: false
      })
      .done(function(return_messages){
        if(!$.isEmptyObject(return_messages)){
          return_messages.forEach(function(return_message){
            buildHTML(return_message);
          });
          scroll();
        }else{
          scroll();
          return false;
        }
      })
      .fail(function(){
        alert("autoreload失敗")
      })
    },5000);
  }
})
