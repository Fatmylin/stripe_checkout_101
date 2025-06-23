class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  pay_customer stripe_attributes: :stripe_attributes

  def stripe_attributes(pay_customer)
    {
      email: email,
      metadata: {
        pay_customer_id: pay_customer.id
      }
    }
  end
end
