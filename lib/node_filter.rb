NodeFilter = Struct.new(:params) do
  def status
    status = params[:status] || ""
    status.empty? ? "pending_approval" : status
  end
end