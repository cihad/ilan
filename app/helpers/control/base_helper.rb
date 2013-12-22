module Control::BaseHelper
  def logout_url
    protocol  = url_options[:protocol]
    user      = "invalid@"
    host      = url_options[:host]
    port      = ":" + url_options[:port].to_s
    path      = control_path
    [protocol, user, host, port, path].join
  end
end
