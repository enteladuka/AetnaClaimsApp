class ClaimsController < ApplicationController

  def index
  end

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(claim_params)
      if @claim.save
      flash[:info] = "Thank you for your submission!"
      redirect_to claims_path
      else
      flash[:danger] = "Invalid form submission. Please complete all fields"
      redirect_to new_claim_path
      end
  end

  def import
    Claim.import(params[:file])
    if params[:file] == nil
      flash[:danger] = "Please choose a file to continue"
      redirect_to new_claim_path
    else
      flash[:info] = "Thank you for your submission!"
      redirect_to claims_path
    end
  end

  private
    def claim_params
      params.require(:claim).permit(:claim_date, :provider, :drug, :total_cost, :plan_paid, :patient_paid, :JSONInput, :Other_insurance, :Covered_entities)
    end
end
