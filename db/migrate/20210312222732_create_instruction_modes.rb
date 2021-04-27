class CreateInstructionModes < ActiveRecord::Migration[6.0]
  def change
    create_table :instruction_modes do |t|
      t.string :mode

      t.timestamps
    end
  end
end
