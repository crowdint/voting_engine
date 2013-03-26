module VotingApp
  class RequestsController < ApplicationController

    def index
      if params[:time] && params[:category]
        time = params[:time]
        category = params[:category]    
        @requests = filter_requests time, category
      else
        state = params[:state] || 'submitted'
        @requests = Request.send(state)
      end
    end

    def show
      @request = Request.find(params[:id])
    end

    def create
      params[:request].merge!({ user_id: current_user.id })
      @request = Request.create! params[:request]
      @request.notify_created(params)
      render status: :created
    end

    private
    
    def filter_requests(time, category)
      @requests = Request.where(state: ['promoted','accepted', 'rejected', 'done'])
      @requests = @requests.send(category)
      @requests = @requests.send("in_last_" + time) unless time == 'all'
      @requests
    end

    #def update
    #  @request = Request.find(params[:id])
    #  if @request.update_attributes(params[:request])
    #    render status: :no_content, nothing: true
    #  else
    #    render status: :unprocessable_entity, nothing: true
    #  end
    #end
    #
    #def destroy
    #  @request = Request.destroy(params[:id])
    #  render status: :no_content, nothing: true
    #end
  end
end