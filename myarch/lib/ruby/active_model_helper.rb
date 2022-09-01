class ActiveModelHelper
  def self.build_all(klass, data)
    data = [data] unless data.instance_of?(Array)
    data.map do |props|
      klass.new(props)
    end
  end
end