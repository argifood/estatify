# json.extract! property, :id, :listing_name, :summary, :address, :price, :active, :user_id, :latitude, :longitude, :space_type, :category, :flatness, :dimensions, :ground_type, :charge_per, :min_time, :power_supply, :water_supply, :animals, :vehicles, :drilling, :water_system, :tools, :pools_lakes, :constructions, :anti_fire, :lightning, :alarm_system, :cctv, :solar_panels, :wind_turbines, :fenced, :buildings, :created_at, :updated_at
# json.url property_url(property, format: :json)

json.property @property do |property|
  json.id property.id
  json.owner property.user.fullname
  json.listing_name property.listing_name
  json.summary property.summary
  json.address property.address
  json.latitude property.latitude
  json.longitude property.longitude
  json.space_type property.space_type
  json.price property.price
  json.charge_per property.charge_per
  json.min_time property.min_time
  json.active property.active

  json.photos property.photos.take(1).each do |photo|
    json.medium_photo photo.image.url
  end
end
