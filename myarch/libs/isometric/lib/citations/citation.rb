class Citation
  class << self
    def set_root
      fragments = caller[0].split(/\//)
      @root = fragments[0, fragments.size - 1].join('/')

    end

    def create(name, links)
      @encyclopedia ||= {}
      @encyclopedia[name.to_sym] ||= {}
      @encyclopedia[name.to_sym][:links] = links
      @encyclopedia[name.to_sym][:references] = []
    end

    def add(name)
      full_path = caller[0]
      relative_path = full_path.sub(@root, '').gsub(/['`]/, '')
      @encyclopedia[name.to_sym][:references] = @encyclopedia[name.to_sym][:references] + [relative_path]
    end

    def encyclopedia
      @encyclopedia
    end

    def root
      @root
    end
  end
end
