# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  budget     :integer         not null
#  name       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Category do
  before { @category = Category.new(name: "cats", budget: "150.00") }

  subject { @category }

  it { should respond_to(:name) }
  it { should respond_to(:budget) }
  it { should be_valid }

  describe "when name" do
  	
  	describe "is not present" do
  		before { @category.name = " " }
  		it { should_not be_valid }
  	end

  	describe "is already taken" do
  		before do
  			category_with_same_name = @category.dup
  			category_with_same_name.save
  		end
  		it { should_not be_valid }
  	end
  end

  describe "when budget" do
  	
  	describe "is not present" do
  		before { @category.budget = "" }
  		it { should_not be_valid }
  	end

  	describe "is an integer" do
  		before { @category.budget = 150 }
  		it { should be_valid }
  	end

  	describe "is a decimal" do
  		before { @category.budget = 150.00 }
  		it { should be_valid }
  	end
  	
  	describe "is text" do
  		before { @category.budget = "nope" }
  		it { should_not be_valid }
  	end

  	describe "has fractions of a cent" do
  		before { @category.budget = 150.001 }
  		it { should_not be_valid }
  	end
  end
end
