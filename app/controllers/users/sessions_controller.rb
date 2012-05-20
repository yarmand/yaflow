class Users::SessionsController < Devise::SessionsController
  def create
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    resource = warden.authenticate!(:scope => resource_name, :recall => "user_sessions#failure")
    sign_in(resource_name, resource)
    respond_to do |format|
      format.html { respond_with resource, :location => redirect_location(resource_name, resource)}
      format.json { render json: { success: true} }
    end
  end
end
