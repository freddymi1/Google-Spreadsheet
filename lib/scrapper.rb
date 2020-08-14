require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'google_drive'
require 'csv'

class Scrapper
    
    attr_accessor :ville, :email

    def initialize(ville, email)
        @ville = ville
        @email = email
    end
    
    # Declaration de l'url du site a scrapper
    def urlp
        @base_url = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
        return @base_url
    end

    # La méthode get_townhall_email nous permet de scraper les les emails et la ville des mairies

    def get_townhall_email(townhall_url)
        page = Nokogiri::HTML(URI.open(townhall_url))
        tableau_email = []

        @email = page.xpath('//*[contains(text(), "@")]').text
        @ville = page.xpath('//*[contains(text(), "Adresse mairie de")]').text.split #/ on divise la string pour pouvoir récupérer uniquement le nom de la ville

        tableau_email.push({@ville[3] => @email})  #/ on indique la position du nom de la ville dans la string pour la récupérer
        
        return tableau_email
    end

    # La méthode get_townhall_urls permet d'aller sur le site pour scraper les informations.
    # Elle appelle la méthode urlp

    def get_townhall_urls
        page = urlp
        tableau_url = []
        urls = page.xpath('//*[@class="lientxt"]/@href') #/ toutes les URLs appartiennent à la classe lientxt
        #/ pour chaque URLs récupérées, il faut leur indiquer l'url parent "http://annuaire-des-mairies.com"
        for url in urls do
            #/ A l'url parent, on ajoute les urls récupérées du deuxième caractère au dernier caractère, car on veut se débarasser du point devant.
            url = "http://annuaire-des-mairies.com" + url.text[1..-1]
            tableau_url.push(url)	
        end
        return tableau_url 
    end

    #Generer les fichier emails.json et emails.csv dans le dossier lib

    def generateFile
        
        tableau_url = get_townhall_urls
        #/ pour chaque URL d'une ville du Val d'Oise, on associe l'adresse mail de la mairie
        File.open("db/emails.json","w") do |f|
            for townhall_url in tableau_url do
                f.write(JSON.pretty_generate(get_townhall_email(townhall_url)))
            end
        end

        CSV.open("db/emails.csv", "w") do |csv|
            for townhall_url in tableau_url do
                csv << get_townhall_email(townhall_url)
            end
        end

    end

    # La méthode generate_spreadsheet nous permet de créer / modifier un fichier dans google sheet.
    # Il y a 2 colonnes dont 1 pour le ville des mairies et l'autre pour les adresse emails correspondants au mairie
    def generate_spreadsheet

        array_spreadsheet = get_townhall_urls

        session = GoogleDrive::Session.from_config("config.json")
        ws = session.spreadsheet_by_key("af6d716a29a1c3ebb53bae2419082e2e364f3969").worksheets[0]
        i = 1
        # Parcourir les valeur dans le tableau
        for x in array_spreadsheet do
            ws[i, 1] = x.keys.join
            ws[i, 2] = x.values.join
            i += 1
        end
        # Attention ne pas mettre ws.save dans la boucle each sinon cela va faire autant de demandes à 
        # Google API qu'il y a de couples (keys, values)
        ws.save 
    end
  

 
end

