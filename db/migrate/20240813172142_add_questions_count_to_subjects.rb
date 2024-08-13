class AddQuestionsCountToSubjects < ActiveRecord::Migration[7.1]
  def change
    add_column :subjects, :questions_count, :integer
  end
end
