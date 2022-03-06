# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength, Metrics/MethodLength, Metrics/ParameterLists
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

  def ui_form(path: nil, method: :post, object: nil, &block)
    @form_stack ||= []

    form_classes = %w[w-full max-w-xl]

    form_content = if object
      form_for(object, html: { class: form_classes }) do |f|
        @form_stack << f
        block.call(f)
      end
    else
      @form_stack << nil
      form_tag(path, method: method, class: form_classes) do
        block.call
      end
    end

    @form_stack.pop

    form_content
  end

  def ui_password_field(name:, value: nil, label: nil, options: {})
    html_options = options.merge(class: ui_text_field_classes)
    ui_field_with_label(label, name) do
      if current_form
        current_form.password_field(name, html_options)
      else
        password_field_tag(name, value, html_options)
      end
    end
  end

  def ui_text_field(name:, value: nil, label: nil, options: {})
    html_options = options.merge(class: ui_text_field_classes)
    ui_field_with_label(label, name) do
      if current_form
        current_form.text_field(name, html_options)
      else
        text_field_tag(name, value, html_options)
      end
    end
  end

  def ui_text_area(name:, value: nil, label: nil, options: {})
    html_options = options.merge(class: ui_text_field_classes)
    ui_field_with_label(label, name) do
      if current_form
        current_form.text_area(name, html_options)
      else
        text_area(name, value, html_options)
      end
    end
  end

  def ui_select(name:, options:, value: nil, label: nil, include_blank: nil, html_options: {})
    ui_field_with_label(label, name) do
      if current_form
        current_form.select(name, options, { include_blank: include_blank }, html_options)
      else
        options = options_for_select(options, value)
        select_tag(name, options, html_options.merge(include_blank: include_blank))
      end
    end
  end

  def ui_field_with_label(label, name, &)
    content_tag(:div, class: %w[md:flex md:items-center mb-4]) do
      if label
        ui_label_wrapper { ui_label(label, name) } + ui_field_wrapper(&)
      else
        ui_field_wrapper(&)
      end
    end
  end

  def ui_field_without_label(&)
    empty_block = -> {}
    content_tag(:div, class: %w[md:flex md:items-center mb-4]) do
      ui_label_wrapper(&empty_block) + ui_field_wrapper(&)
    end
  end

  def ui_label(label, name)
    return unless label

    label_classes = %w[
      block
      text-lg
      md:text-right
      mb-1
      md:mb-0
      pr-4
    ]

    if current_form
      current_form.label(name, class: label_classes)
    else
      label_tag(name, label, class: label_classes)
    end
  end

  def ui_label_wrapper(&)
    content_tag(:div, class: ["md:w-1/4"], &)
  end

  def ui_field_wrapper(&)
    content_tag(:div, class: ["md:w-3/4"], &)
  end

  def ui_submit(text)
    classes = ui_button_classes

    ui_field_without_label do
      if current_form
        current_form.submit(text, class: classes)
      else
        submit_tag(text, class: classes)
      end
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

  def ui_content_title(title = nil, &)
    if block_given?
      content_tag(:h2, class: "content-subhead", &)
    else
      content_tag(:h2, title, class: "content-subhead")
    end
  end

  def current_form
    @form_stack&.last
  end
end
# rubocop:enable Metrics/ModuleLength, Metrics/MethodLength, Metrics/ParameterLists
