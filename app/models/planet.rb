class Planet < ApplicationRecord

  scope(:order_by, proc { |field, order|
    if field && %w[name speed].include?(field)
      send "order_by_#{field}", order
    end
  })

  scope(:order_by_name, proc { |order|
    order(name: order || :desc)
  })

  scope(:order_by_speed, proc { |order|
    order(speed: order || :desc)
  })
end
