module VotingApp
  class RequestsController < ApplicationController

    def index
      state = params[:state] || 'submitted'
      @requests = Request.send(state).page params[:page] || 1
      render status: :not_found, nothing: true if @requests.empty?
    end

    def show
      @request = Request.find(params[:id])
    end

    def create
      params[:request].merge!({ user_id: current_user.id })
      @request = Request.create params[:request]
      if @request
        @request.notify_created(params)
        render status: :created
      else
        render status: :unprocessable_entity
      end
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
