class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners  = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    #binding.pry
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet.owner_id = @owner.id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if !params[:pet].keys.include?("owner_id")
    params[:owner]["pet_ids"] = []
    end
    #######
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
