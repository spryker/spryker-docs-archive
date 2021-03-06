def setup_current_page_version(page, config)
    return if config['page']['version']

    page.url.match(%r{/(?<version>\d+\.\d+)/});
    version = Regexp.last_match(:version)

    config['page']['version'] = version
end

def setup_all_page_versions(page, config)
    full_url_pattern = %r{\A#{page.url.gsub(%r{/\d+\.\d+/}, '/\d+\.\d+/')}\Z}
    versioned_page_urls = page.site.pages.select do |site_page|
      site_page.url.match full_url_pattern
    end.map(&:url)
    versions = get_versions versioned_page_urls
    config['page']['all_versions'] = versions.sort_by { |version| version['version'] }.reverse!
end

def get_versions(versioned_page_urls)
    version_pattern = %r{/(?<page_version>\d+\.\d+)/}

    versioned_page_urls.map do |url|
        version_pattern.match(url)
        {
            'version' => Regexp.last_match(:page_version),
            'url' => url
        }
    end
end

def can_be_versioned(page)
    product = page['product']
    role = page['role']
    versioned_categories = page.site.config['versioned_categories']

    return false if versioned_categories[product] == nil or
        versioned_categories[product][role] == nil

    page.url.match(%r{\A/docs/#{product}/#{role}/(?<category>[\w-]+)/});
    page_category = Regexp.last_match(:category)

    return versioned_categories[product][role].include? page_category
end

Jekyll::Hooks.register :pages, :pre_render do |page, config|
    next page unless File.extname(page.path).match?(/md|html/)
    next page unless page.url.start_with? '/docs/'
    next page unless can_be_versioned page

    setup_current_page_version page, config
    setup_all_page_versions page, config
end
