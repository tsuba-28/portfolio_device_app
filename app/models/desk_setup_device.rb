class DeskSetupDevice < ApplicationRecord
  belongs_to :desk_setup
  belongs_to :device
end
