class DeleteQc < ActiveRecord::Migration
def up
  QC::Setup.drop
end

def down
end
end
