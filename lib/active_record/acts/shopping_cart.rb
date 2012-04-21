module ActiveRecord
  module Acts
    module ShoppingCart
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
          self.shopping_cart_items_collection = item_class.to_s.pluralize
          has_many self.shopping_cart_items_collection.to_sym, :as => :owner, :dependent => :destroy
        end

        #
        # Alias for:
        #
        #    acts_as_shopping_cart_using :shopping_cart_item
        #
        def acts_as_shopping_cart
          acts_as_shopping_cart_using :shopping_cart_item
        end
        
        def shopping_cart_items_collection
          @@shopping_cart_items_collection
        end
        
        def shopping_cart_items_collection=(collection_name)
          @@shopping_cart_items_collection = collection_name
        end
      end
    end
  end
end
