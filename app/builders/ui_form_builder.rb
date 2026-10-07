# frozen_string_literal: true

class UiFormBuilder < ActionView::Helpers::FormBuilder
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
      super(text, class: @template.ui_button_classes)
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

  def text_field_classes # rubocop:disable Metrics/MethodLength
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
