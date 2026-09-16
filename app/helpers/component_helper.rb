# frozen_string_literal: true

module ComponentHelper
  def ui_form(path: nil, object: nil, &)
    form_args = object ? { model: object } : { url: path }
    form_with(**form_args, builder: UiFormBuilder, class: "w-full max-w-xl", &)
  end

  def ui_side_menu_link(text, path, active: false, method: :get, confirm: nil)
    link_params = side_menu_link_params(active: active, method: method, confirm: confirm)
    content_tag :li, class: "mr-3" do
      if method == :get
        link_to text, path, link_params
      else
        button_to text, path, link_params
      end
    end
  end

  private

  def side_menu_link_params(active:, method:, confirm:)
    {
      class: side_menu_link_classes(active: active),
      method: method,
      form: ({ data: { turbo_confirm: confirm } } if confirm),
    }.compact
  end

  def side_menu_link_classes(active:)
    link_classes = %w[inline-block py-2 px-4 no-underline]
    link_classes += if active
      %w[text-white]
    else
      %w[text-gray-600 hover:text-gray-200 hover:text-underline]
    end
    link_classes
  end
end
