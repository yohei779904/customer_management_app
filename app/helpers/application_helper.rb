module ApplicationHelper
  def document_title
    if @title.present?
      '#{@title} - customer_management'
    else
      'customer_management'
    end
  end
end
