class AddDefaultRoleToExistingUsers < ActiveRecord::Migration[7.1]
  def up
    User.where(role: nil).update_all(role: 'trader')
  end

  def down
    User.where(role: 'trader').update_all(role: nil)
  end
end