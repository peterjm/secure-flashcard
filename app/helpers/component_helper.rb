module ComponentHelper
  FORM_ALIGNED = 'aligned'
  FORM_COMPACT = 'compact'

  def ui_button(text, path, size: 'normal')
    button_class = case size
    when 'xlarge'
      'button-xlarge'
    end

    link_to(text, path, class: "pure-button pure-button-primary #{button_class}")
  end

  def ui_form(path: nil, layout: nil, method: :post, object: nil, &block)
    @form_stack ||= []

    form_class = case layout
    when FORM_ALIGNED
      'form-aligned'
    when FORM_COMPACT
      'form-compact'
    end

    form_content = if object
      form_for(object, html: { class: "pure-form #{form_class}" }) do |f|
        @form_stack << [f, layout]
        ui_form_wrapper do
          block.call(f)
        end
      end
    else
      @form_stack << [nil, layout]
      form_tag(path, method: method, class: "pure-form #{form_class}") do
        ui_form_wrapper do
          block.call
        end
      end
    end

    @form_stack.pop

    form_content
  end

  def ui_form_wrapper(&block)
    case current_form_layout
    when FORM_ALIGNED
      ui_content_container(grid_size_big: 4, &block)
    else
      block.call
    end
  end

  def ui_text_field(name:, value: nil, label: nil, placeholder: nil, html_class: "")
    ui_field_with_label(label, name) do
      if current_form
        current_form.text_field(name, placeholder: placeholder, class: html_class)
      else
        text_field_tag(name, value, placeholder: placeholder, class: html_class)
      end
    end
  end

  def ui_text_area(name:, value: nil, label: nil, placeholder: nil, html_class: "")
    ui_field_with_label(label, name) do
      if current_form
        current_form.text_area(name, placeholder: placeholder, class: html_class)
      else
        text_area(name, value, placeholder: placeholder, class: html_class)
      end
    end
  end

  def ui_select(name:, options:, value: nil, label: nil, include_blank: nil, html_class: "")
    ui_field_with_label(label, name) do
      if current_form
        current_form.select(name, options, { include_blank: include_blank }, class: html_class)
      else
        options = options_for_select(options, value)
        select_tag(name, options, include_blank: include_blank, class: html_class)
      end
    end
  end

  def ui_search_field(name:, value: nil, label: nil, placeholder: nil, html_class: "")
    ui_field_with_label(label, name) do
      if current_form
        current_form.search_field(name, placeholder: placeholder, class: "pure-input-rounded #{html_class}")
      else
        search_field_tag(name, value, placeholder: placeholder, class: "pure-input-rounded #{html_class}")
      end
    end
  end

  def ui_field_with_label(label, name, &block)
    if label
      ui_label_wrapper { ui_label(label, name) } + ui_field_wrapper(&block)
    else
      ui_field_wrapper(&block)
    end
  end

  def ui_label(label, name)
    if label
      if current_form
        current_form.label(name)
      else
        label_tag(name, label)
      end
    end
  end

  def ui_label_wrapper(&block)
    case current_form_layout
    when FORM_ALIGNED
      ui_content_section(grid_size_big: 1) do
        content_tag(:div, class: "form-label", &block)
      end
    else
      content_tag(:div, class: "form-label", &block)
    end
  end

  def ui_field_wrapper(&block)
    case current_form_layout
    when FORM_ALIGNED
      ui_content_section(grid_size_big: 3) do
        content_tag(:div, class: "form-field", &block)
      end
    else
      content_tag(:div, class: "form-field", &block)
    end
  end

  def ui_submit(text)
    ui_submit_wrapper do
      if current_form
        current_form.submit(text, class: "pure-button pure-button-primary")
      else
        submit_tag(text, class: "pure-button pure-button-primary")
      end
    end
  end

  def ui_submit_wrapper(&block)
    case current_form_layout
    when FORM_ALIGNED
      ui_content_section(grid_size_big: 1){} + ui_content_section(grid_size_big: 3, &block)
    else
      block.call
    end
  end

  def ui_side_menu_link(text, path, active: false, separated: false, disabled: false, link_params: {})
    li_classes = ['pure-menu-item']
    li_classes << 'pure-menu-selected' if active
    li_classes << 'pure-menu-disabled' if disabled
    li_classes << 'menu-item-divided' if separated
    content_tag :li, class: li_classes do
      link_to text, path, link_params.merge(class: 'pure-menu-link')
    end
  end

  def ui_content_container(grid_size_small: 1, grid_size_big: 1, &block)
    current_grid_size_stack.push({
      small: grid_size_small,
      big: grid_size_big
    })
    content = content_tag(:div, class: 'pure-g', &block)
    current_grid_size_stack.pop
    content
  end

  def ui_editable_content_section(title:, object:, field:, &block)
    render(layout: 'shared/inplace_editor', locals: { title: title, object: object, field: field }, &block)
  end

  def ui_content_title(title=nil, &block)
    if block_given?
      content_tag(:h2, class: 'content-subhead', &block)
    else
      content_tag(:h2, title, class: 'content-subhead')
    end
  end

  def ui_content_section(title: nil, grid_size_small: 1, grid_size_big: 1, &block)
    content = if title
      ui_content_title(title) + capture(&block)
    else
      capture(&block)
    end

    grid_classes = [
      grid_class(grid_size_small, current_grid_sizes[:small]),
      grid_class(grid_size_big, current_grid_sizes[:big], 'sm')
    ].uniq

    content_tag(:div, content, class: grid_classes)
  end

  def current_form
    @form_stack&.last&.first
  end

  def current_form_layout
    @form_stack&.last&.last
  end

  def current_grid_size_stack
    @current_grid_size_stack ||= []
  end

  def current_grid_sizes
    current_grid_size_stack.last
  end

  def grid_class(element_size, grid_size, media_size=nil)
    raise "element too large for grid" if element_size > grid_size

    if media_size
      "pure-u-#{media_size}-#{element_size}-#{grid_size}"
    else media_size
      "pure-u-#{element_size}-#{grid_size}"
    end
  end

end
