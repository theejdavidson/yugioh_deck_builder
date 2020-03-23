# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'open-uri'
require 'json'
require_relative '../config/environment.rb'

models = [
    Card
]

models.each {|model| model.destroy_all}

API_BASE= 'https://db.ygoprodeck.com/api/v6/'

def validate_api_response(response)
    case response
    when Net::HTTPSuccess then
        response
    else
        raise response.value
    end
end

def get_all_card_data
    uri = URI.parse(API_BASE + 'cardinfo.php')
    response = Net::HTTP.get_response(uri)

    response = validate_api_response(response)

    JSON.parse(response.body)
end

def single_card_test
    uri = URI.parse('https://db.ygoprodeck.com/api/v6/cardinfo.php?name=Decode%20Talker')
    response = Net::HTTP.get_response(uri)

    response = validate_api_response(response)

    JSON.parse(response.body)
end

def model_cards
    data = get_all_card_data

    data.map do |card|
        make_card(card)
    end
end


def make_card(data)
    name = data["name"]
    attack = data["atk"]
    defense = data["def"]
    card_type = data["type"]
    desc = data["desc"]
    race = data["race"]
    level = data["level"]
    image = data["card_images"][0]["image_url"]
    attr = data["attribute"]

    Card.create(
        name: name, 
        attack: attack, 
        defense: defense, 
        card_type: card_type,
        description: desc,
        race: race,
        level: level,
        img_url: image,
        attr: attr
        )
end


model_cards
