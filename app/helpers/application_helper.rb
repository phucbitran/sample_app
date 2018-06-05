# frozen_string_literal: true

module ApplicationHelper
  def full_title page_title
    base_title = t "base_content"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
