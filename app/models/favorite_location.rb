class FavoriteLocation < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :address, :lat, :lng, :user_id
end


# FavoriteLocation.create(name: "DevBootCamp", address: "351 W Hubbard St, Chicago, IL 60654",


  # FavoriteLocation.create(name: "DevBootCamp", address: "351 W Hubbard St, Chicago, IL 60654", lat: 41.889693, lng: -87.637654, user_id: 1)
