json.properties @properties do |property|
  json.id property.id
  json.owner property.user.fullname
  json.user_id property.user.id
  json.listing_name property.listing_name
  json.summary property.summary
  json.address property.address
  json.latitude property.latitude
  json.longitude property.longitude
  json.space_type property.space_type
  json.dimensions property.dimensions
  json.price property.price
  json.charge_per property.charge_per
  json.min_time property.min_time
  json.active property.active

  json.photos property.photos.take(1).each do |photo|
    json.medium_photo photo.image.url
  end

  json.review property.reviews do |review|
    json.rating review.star
  end
end
