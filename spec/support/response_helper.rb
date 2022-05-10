module ResponseHelper
  def body
    JSON.parse(response.body)
  end
end
