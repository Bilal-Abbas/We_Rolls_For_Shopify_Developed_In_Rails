class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
    def store_admin?
	  	if has_role? :store_admin
	  		return true
	  	else
	  		return false
	  	end
	end

	def admin?
	  	if has_role? :admin
	  		return true
	  	else
	  		return false
	  	end
	end


	# private
    
	#      def after_add_user
	#      	#byebug

	#      	if self.type == 'seller'

	# 	 		self.add_role(:seller)
		 		
	# 	 	elsif self.type == 'buyer'

	# 	 		self.add_role(:buyer)
	# 	 	end
 #      end


end
