class LeadersController < ApplicationController

  def index
    @mass_assign_leaders = Leader.where(hack_type: 'mass-assign')
    @cookie_theft_leaders = Leader.where(hack_type: 'cookie-theft')
    #@leaders.paginate(page: params[:page])
  end

  def new
    ip = request.remote_ip
    @leader = Leader.new(:ip => ip)
    #@leader = Leader.new(params[:user].merge(:ip_address => ip))
  end

  def create
    ip = request.remote_ip
    @leader = Leader.new(params[:leader].merge(:ip => ip, :hack_type => "cookie-theft"))
    if @leader.save
      redirect_to leaderboard_path, :flash => { :success => "You are on the board!" }
    else
      render 'new'
    end

  end
end
