require 'csv_hasher'

class PagesController < ApplicationController
    def home
        @new_page_path = '/new'
    end
    
    def update
        @status = _update(params['people'], params['building'])
        render "result"  
    end
    
    private def _update (person, bat)
        if person.present?
            if person.original_filename != 'people.csv'
                return 'erreur fichier. Selectionnez le bon fichier people.csv'
            end
            peoples = CSVHasher.hashify(person.path, { original_col_as_keys: true })
            peoples.each do |people|
                email = people['email']
                if Person.find_by(email: email) != nil
                    #update
                    up                      = Person.find_by(email: email)
                    up.email                = email
                    up.reference            = people['reference']
                    up.mobile_phone_number  = people['mobile_phone_number']
                    up.home_phone_number    = people['home_phone_number']
                    up.lastname             = people['lastname']
                    up.firstname            = people['firstname']
                    up.address              = people['address']
                    up.save
                else
                    #add
                    co = Person.new
                    co.email                = email
                    co.reference            = people['reference']
                    co.mobile_phone_number  = people['mobile_phone_number']
                    co.home_phone_number    = people['home_phone_number']
                    co.lastname             = people['lastname']
                    co.firstname            = people['firstname']
                    co.address              = people['address']
                    co.save
                end
            end
        end
        if bat.present?
            if bat.original_filename != 'building.csv'
                return 'erreur fichier. Selectionnez le bon fichier building.csv'
            end
            buildings = CSVHasher.hashify(bat.path, { original_col_as_keys: true })
            buildings.each do |building|
                reference  = building['reference']
                if Building.find_by(reference: reference) != nil
                    #update
                    up = Building.find_by(reference: reference)
                    up.reference    = reference
                    up.manager_name = building['manager_name']
                    up.country      = building['country']
                    up.city         = building['city']
                    up.zip_code     = building['zip_code']
                    up.address      = building['address']
                    up.save
                else
                    #add
                    co = Building.new
                    co.reference    = reference
                    co.manager_name = building['manager_name']
                    co.country      = building['country']
                    co.city         = building['city']
                    co.zip_code     = building['zip_code']
                    co.address      = building['address']
                    co.save
                end
            end
        end
    end
end
