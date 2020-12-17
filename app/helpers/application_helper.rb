module ApplicationHelper

  def flash_class(level)
    case level
    when "notice" then "alert alert-success"
    when "alert" then "alert alert-danger"
    end
  end

  def user_avatar(user)
    asset_pack_path('media/images/user.png')
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
