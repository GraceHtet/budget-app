require 'rails_helper'

RSpec.describe "MoneyTransactions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/money_transactions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/money_transactions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/money_transactions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
