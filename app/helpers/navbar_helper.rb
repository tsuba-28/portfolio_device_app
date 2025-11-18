module NavbarHelper
    def nav_link(name, path)
        active = current_page?(path) ? "active" : ""
        classes = ["nav-link" , active].join(" ").strip
        link_to name, path, class: classes
    end
end