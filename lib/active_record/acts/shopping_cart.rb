module ActiveRecord
  module Acts
    module ShoppingCart
      attr_reader :shopping_cart_items_collection
      
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        #
        # Prepares the class to act as a cart.
        #
        # Receives as a parameter the name of the class that will hold the items
        #
        # Example:
        #
        #   acts_as_shopping_cart :cart_item
        #
        #
        def acts_as_shopping_cart_using(item_class)
          self.send :include, ActiveRecord::Acts::ShoppingCart::Cart::InstanceMethods
          self.send :include, ActiveRecord::Acts::ShoppingCart::Item::InstanceMethods
          @shopping_cart_items_collection = item_class.to_s.pluralize
          has_many @shopping_cart_items_collection.to_sym, :as => :owner, :dependent => :destroy
        end

        #
        # Alias for:
        #
        #    acts_as_shopping_cart_using :shopping_cart_item
        #
        def acts_as_shopping_cart
          acts_as_shopping_cart_using :shopping_cart_item
        end
      end
    end
  end
end
