SimpleForm.setup do |config|
  config.error_notification_class = 'has-error'
  config.label_class = 'col-sm-3 col-xs-12 control-label'
  config.input_class = 'form-control'

  config.wrappers :bootstrap, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'col-sm-9 col-xs-12' do |ba|
      ba.use :input
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.default_wrapper = :bootstrap
end
