# class ApplicationDecorator < Draper::Decorator
#   # Define methods for all decorated objects.
#   # Helpers are accessed through `helpers` (aka `h`). For example:
#   #
#   #   def percent_amount
#   #     h.number_to_percentage object.amount, precision: 2
#   #   end
# end


# // decorators/application_decorator.rb
class ApplicationDecorator < Draper::Decorator
  def self.collection_decorator_class
    PaginatingDecorator
  end
end
