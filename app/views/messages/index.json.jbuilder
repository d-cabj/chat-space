if @messages.present?
  json.array! @messages do |message|
    json.id message.id
    json.body message.body
    json.message_img message.message_img.url
    json.user_name message.user.name
    json.created_at message.created_at.strftime("%Y/%m/%d %H:%M")
  end
else

end
