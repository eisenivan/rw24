module Menus
  module Admin
    # will be concatenated onto existing sites menu via javascript
    class Sites < Menu::Group
      define do
        namespace :admin
        menu :left, :class => 'main' do
          item :races, :action => :index, :resource => [@site, :race]
        end
      end
    end

    class Teams < Menu::Group
      define do
        id :main
        parent Sites.new.build(scope).find(:races)
        menu :left, :class => 'left', :type => Teams::Races

        menu :actions, :class => 'actions' do
          if @teams
            item :export, :content => link_to("Export", admin_site_race_teams_path(@site, @race, :format => :csv))
          end
          if @team or @teams
            item :new, :content => link_to_current("New", [:new, :admin, @site, @race, :team])
            if @team and !@team.new_record?
              item :delete, :content => link_to("Delete", [:admin, @site, @race, @team], :method => :delete)
            end
          elsif @rider and !@rider.new_record?
            item :delete, :content => link_to("Delete", [:admin, @site, @race, @team, @rider], :method => :delete)
          end
          item :new_race, :content => link_to_current("New Race", [:new, :admin, @site, :race])
        end
      end

      class Races < Menu::Menu
        define do
          Race.all.each do |race|
            item race.year.to_s, :content => link_to_current(race.year, [:admin, @site, race, :teams], :if => @race == race)
          end
        end
      end
    end
  end
end
