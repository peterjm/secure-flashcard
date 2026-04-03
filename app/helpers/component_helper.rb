# frozen_string_literal: true

module ComponentHelper
  def ui_button_classes(size: "normal")
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

  def ui_text_field_classes
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

  def ui_label_classes
    %w[
      block
      text-lg
      md:text-right
      mb-1
      md:mb-0
      pr-4
    ]
  end

  def ui_button(text, path, size: "normal", method: nil, turbo: nil)
    link_params = { class: ui_button_classes(size: size) }
    if turbo
      link_params[:data] = { turbo_method: method }
    else
      link_params[:data] = { turbo: false }
      link_params[:method] = method
    end

    button_to(text, path, **link_params)
  end

  def ui_form(path: nil, object: nil, &block)
    form_args = object ? { model: object } : { url: path }
    form_with(**form_args, class: "w-full max-w-xl") do |f|
      @ui_form = f
      block.call(f)
    end
  ensure
    @ui_form = nil
  end

  def ui_text_field(name:, label: nil, options: {})
    html_options = options.merge(class: ui_text_field_classes)
    ui_field_with_label(label, name) do
      @ui_form.text_field(name, html_options)
    end
  end

  def ui_password_field(name:, label: nil, options: {})
    html_options = options.merge(class: ui_text_field_classes)
    ui_field_with_label(label, name) do
      @ui_form.password_field(name, html_options)
    end
  end

  def ui_submit(text)
    ui_field_without_label do
      @ui_form.submit(text, class: ui_button_classes)
    end
  end

  def ui_field_with_label(label, name, &)
    content_tag(:div, class: %w[md:flex md:items-center mb-4]) do
      if label
        ui_label_wrapper { @ui_form.label(name, label, class: ui_label_classes) } + ui_field_wrapper(&)
      else
        ui_field_wrapper(&)
      end
    end
  end

  def ui_field_without_label(&)
    content_tag(:div, class: %w[md:flex md:items-center mb-4]) do
      ui_label_wrapper {} + ui_field_wrapper(&)
    end
  end

  def ui_side_menu_link(text, path, active: false, method: :get)
    link_classes = %w[inline-block py-2 px-4 no-underline]
    link_classes += if active
      %w[text-white]
    else
      %w[text-gray-600 hover:text-gray-200 hover:text-underline]
    end

    link_params = {
      class: link_classes,
      method: method,
    }.compact

    content_tag :li, class: "mr-3" do
      if method == :get
        link_to text, path, link_params
      else
        button_to text, path, link_params
      end
    end
  end

  private

  def ui_label_wrapper(&)
    content_tag(:div, class: ["md:w-1/4"], &)
  end

  def ui_field_wrapper(&)
    content_tag(:div, class: ["md:w-3/4"], &)
  end
end
