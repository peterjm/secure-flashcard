module ApplicationHelper
  def application_name
    "Secure Flashcards"
  end

  def head_title
    prefix = "DEV " if Rails.env.development?
    title = page_title ? "#{application_name}: #{page_title}" : application_name
    [prefix, title].join(' ')
  end

  def page_title
    @page_title
  end

  def page_heading
    @page_heading
  end

  def set_page_title(title, heading: true)
    @page_title = title
    @page_heading = title if heading
  end
end
