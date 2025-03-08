class UpdateTodosTable < ActiveRecord::Migration[8.0]
  def change
    # titleカラムをnot nullに変更
    change_column :todos, :title, :string, null: false
    # doneカラムにデフォルト値falseを設定
    change_column :todos, :done, :boolean, default: false, null: false
  end
end
