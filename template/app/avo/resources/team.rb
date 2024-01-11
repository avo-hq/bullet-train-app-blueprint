class Avo::Resources::Team < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search = {
    query: -> { query.ransack(id_eq: params[:q], name_cont: params[:q], slug_cont: params[:q], m: "or").result(distinct: false) },
    item: -> {
      {
        title: record.name
      }
    }
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :slug, as: :text
    field :being_destroyed, as: :boolean, hide_on: :forms
    field :time_zone, as: :select, options: -> { view_context.time_zone_options_for_select(Avo::Current.user.time_zone, nil, ActiveSupport::TimeZone) }
    field :locale, as: :text
    field :users, as: :has_many, through: :memberships
    field :memberships, as: :has_many
    field :invitations, as: :has_many
  end
end
