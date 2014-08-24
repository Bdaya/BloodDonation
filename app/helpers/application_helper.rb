module ApplicationHelper
  def title(page_title)
    content_for :title, page_title.to_s
  end
  def blood_types
    BloodType.all.map{ |b| [b.type, b.id]}
  end
end
