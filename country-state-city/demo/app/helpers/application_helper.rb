module ApplicationHelper
  def flash_class(level)
    level = level.to_s.to_sym
    case level
    when :notice then "bg-blue-100 border-blue-500 text-blue-700"
    when :success then "bg-green-100 border-green-500 text-green-700"
    when :error then "bg-orange-100 border-orange-500 text-orange-700"
    when :alert then "bg-orange-100 border-orange-500 text-orange-700"
    else "bg-blue-100 border-blue-500 text-blue-700 #{level}"
    end
  end
end
