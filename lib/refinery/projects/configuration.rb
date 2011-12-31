# encoding: utf-8

module Refinery
  module Projects
    include ActiveSupport::Configurable

    config_accessor :default_fields, :default_categories

    self.default_fields = ["Address", "Developer", "Architect", "Area", "Construction Costs"]
    self.default_categories = ["Parker og byrum", "Børn // Institutioner skoler", "Kultur // Erhverv institutioner", "Bebyggelsesplaner // Beboelse", "Planlægning // Strukturplaner // Masterplaner //", "Renovering // Historiske anlæg"]
  end
end
