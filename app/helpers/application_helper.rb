module ApplicationHelper

  def flash_class(level)
    case level
    when "notice" then "alert alert-primary"
    when "success" then "alert alert-success"
    when "error" then "alert alert-danger"
    when "alert" then "alert alert-danger"
    end
  end

  def user_avatar(user)
    asset_pack_path('media/images/user.png')
  end
end
