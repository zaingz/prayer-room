json.array!(@rooms) do |room|
  json.extract! room, :id, :name, :street, :floor, :city, :country, :description, :direction, :link
  json.url room_url(room, format: :json)
end
