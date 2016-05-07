json.array!(@versions) do |version|
  json.extract! version, :id, :name, :street, :floor, :city, :country, :description, :direction, :link
  json.url version_url(version, format: :json)
end
