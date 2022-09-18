# frozen_string_literal: true

Heart::Core::Config.instance.set_config('default/rabbit/listener_attributes') do
  auto_delete true
  block true

end
