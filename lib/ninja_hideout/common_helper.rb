module NinjaHideout
  module CommonHelper

    def hello
      "Hello!"
    end

    def can_has_css(*args)
      content_for(:extra_head, stylesheet_link_tag(*args))
    end

    def can_has_js(*args)
      content_for(:extra_head, javascript_include_tag(*args))
    end

    def page_title
      h (@page_title || @title || params[:action].titleize)
    end

    def form_row(opts = {}, &blk)
      div_with_default_class("row", opts, &blk)
    end

    def button_row(opts = {}, &blk)
      div_with_default_class("buttons", opts, &blk)
    end

    def flash_messages_for(name, opts = {})
      unless flash[name.to_sym].blank?
        opts[:class] = merge_class_names(opts[:class], "flash #{name.to_s.underscore}")
        content_tag(:div, flash[name.to_sym], opts)
      end
    end

    def ul_based_menu(name, opts = {}, &blk)
      opts[:class] = merge_class_names(opts[:class], "#{name}-menu")
      menu = content_tag(:div, content_tag(:ul, capture(&blk)), opts)
      concat(menu, blk.binding)
    end

    def menu_item(*args)
      content_tag(:li, link_to(*args))
    end

    def correct_postfix(time)
      time < Time.now ? "ago" : "from now"
    end

    def copyright_time(start_year = Time.now.year)
      if Time.now.year <= start_year
        return Time.now.year.to_s
      else
        return "#{start_year} &mdash; #{Time.now.year.to_s}"
      end
    end

    private

    def div_with_default_class(class_name, opts = {}, &blk)
      opts[:class] = merge_class_names(opts[:class], class_name)
      contents = content_tag(:div, capture(&blk), opts)
      concat(contents, blk.binding)
    end

    def merge_class_names(current, default)
      current.blank? ? default : "#{current} #{default}"
    end

  end
end