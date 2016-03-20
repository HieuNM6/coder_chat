module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", 
      notice: "alert-info" }[flash_type.to_sym] 
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end   

  def unread_message notifications
    counter = 0
    notifications.each do |n|
        if !n.read && !block_notification(n)
         counter += 1  
        end
    end
    counter
  end

  private
    def block_notification notification_id
      notification = Notification.find_by_id(notification_id)
      m = Message.find_by_id(notification.event_id)
      if block_list.include? m.user_id.to_s
         return true
      else
         return false
      end
    end

    def block_list
      block_list = []
      list ||= current_user.block_list.split(" ")
      list.each do |l|
        block_list << l
      end
      block_list
    end
end
