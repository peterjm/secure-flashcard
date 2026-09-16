# frozen_string_literal: true

class UiFormBuilder < ActionView::Helpers::FormBuilder
  def button(text, path, size: "normal", method: nil, turbo: nil)
    link_params = { class: button_classes(size: size) }
    if turbo
      link_params[:data] = { turbo_method: method }
    else
      link_params[:data] = { turbo: false }
      link_params[:method] = method
    end

    button_to(text, path, **link_params)
  end

  def text_field(name:, label: nil, options: {})
    html_options = options.merge(class: text_field_classes)
    field_with_label(label, name) do
      super(name, html_options)
    end
  end

  def password_field(name:, label: nil, options: {})
    html_options = options.merge(class: text_field_classes)
    field_with_label(label, name) do
      super(name, html_options)
    end
  end

  def submit(text)
    field_without_label do
      super(text, class: button_classes)
    end
  end

  def field_with_label(label, name, &)
    @template.content_tag(:div, class: %w[md:flex md:items-center mb-4]) do
      if label
        label_wrapper { label(name, label, class: label_classes) } + field_wrapper(&)
      else
        field_wrapper(&)
      end
    end
  end

  def field_without_label(&)
    @template.content_tag(:div, class: %w[md:flex md:items-center mb-4]) do
      label_wrapper + field_wrapper(&)
    end
  end

  private

  def button_classes(size: "normal")
    classes = %w[
      bg-gray-500
      hover:bg-gray-800
      text-white
      font-bold
      rounded
      shadow
      focus:shadow-outline
      focus:outline-none
    ]

    classes += case size
    when "normal"
      %w[py-2 px-4]
    when "xlarge"
      %w[text-4xl py-4 px-6]
    end

    classes
  end

  def text_field_classes
    %w[
      bg-white
      appearance-none
      border-2
      border-gray-200
      rounded
      w-full
      py-2
      px-4
      text-gray-700
      leading-tight
      focus:outline-none
      focus:border-blue-500
    ]
  end

  def label_classes
    %w[
      block
      text-lg
      md:text-right
      mb-1
      md:mb-0
      pr-4
    ]
  end

  def label_wrapper(content = "", &)
    @template.content_tag(:div, content, class: ["md:w-1/4"], &)
  end

  def field_wrapper(&)
    @template.content_tag(:div, class: ["md:w-3/4"], &)
  end
end
