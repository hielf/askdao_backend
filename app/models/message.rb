class Message < ActiveRecord::Base
  belongs_to :user

  state_machine :status, :initial => :'待处理' do
    event :received do
      transition [:'待处理'] => :'已处理'
    end
  end

end
