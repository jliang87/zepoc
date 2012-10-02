class SetupQueueClassic < ActiveRecord::Migration
def up
  QC::Setup.create_functions
end

def down
  QC::Setup.drop_functions	
end
end
