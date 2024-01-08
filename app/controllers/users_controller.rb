class UsersController < ApplicationController
  def index_liquid
    @users = User.all
    # render template: 'users/index', layout: 'application'
    # liquid_template = Liquid::Template.parse(File.read(Rails.root.join('app/views/users/index.liquid')))
    # render plain: liquid_template.render('users' => @users)#, layout: 'application'

    @users = User.all
    @template = Liquid::Template.parse(File.read(Rails.root.join('app/views/users/index.liquid')))
    render plain: @template.render('users' => @users), layout: 'application'

    @template = Liquid::Template.parse("hi {{name}}") # Parses and compiles the template
    # render plain: @template.render('name' => 'Brucelee'), layout: 'application'
  end

  def index
    @total_users_count = REDIS.get('user_count')
   @users = if params[:search].present?
              search_query = "%#{params[:search]}%"
              User.where("LOWER(name->>'first') ILIKE ? OR LOWER(name->>'last') ILIKE ?", search_query.downcase, search_query.downcase)
            else
              User.all
            end
  end

  def destroy
    @user = User.find(params[:id]) rescue nil
    @user.destroy  if @user
    redirect_to "/"
  end
end
