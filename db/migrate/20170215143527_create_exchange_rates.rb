class CreateExchangeRates < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.float :nbu_usd
      t.float :nbu_euro

      t.float :private_usd
      t.float :private_euro

      t.timestamps null: false
    end
  end
end
