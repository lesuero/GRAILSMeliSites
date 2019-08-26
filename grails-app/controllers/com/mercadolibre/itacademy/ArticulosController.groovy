package com.mercadolibre.itacademy

import grails.converters.JSON
import groovy.json.JsonSlurper

class ArticulosController {

    def index() {
        def url = new URL("http://localhost/sites")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def sites = json.parse(connection.getInputStream())
        [sites:sites]
    }

    def categorias(String idCat){
        String pathCategories = "https://api.mercadolibre.com/sites/"+idCat+"/categories"
        //String pathCategories = "https://api.mercadolibre.com/sites/MLA/categories"
        def url = new URL(pathCategories)
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def categories = json.parse(connection.getInputStream())
        def listaCategorias = [categories:categories]
        render listaCategorias as JSON
    }

    def subcategorias(String idCat){
        String pathCategories = "https://api.mercadolibre.com/categories/"+idCat
        //String pathCategories = "https://api.mercadolibre.com/sites/MLA/categories"
        def url = new URL(pathCategories)
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def categories = json.parse(connection.getInputStream())
        //def subcategories = categories.children_categories
        def listaCategorias = [categories:categories]
        render listaCategorias as JSON

    }
}
