package com.mercadolibre.itacademy
import grails.converters.JSON
import groovy.json.JsonSlurper

class SitesController {

    def index() {
        def url = new URL("http://localhost:8090/marcas")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def sites = json.parse(connection.getInputStream())
        [sites:sites]
    }
    def categorias(String idCat){
        String pathCategories = "http://localhost:8090/marcas/"+idCat+"/articulos"
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
        String pathCategories = "http://localhost:8090/articulos/"+idCat
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

    def deleteItem(String idItem){
        String pathCategories = "http://localhost:8090/articulos/"+idItem
        def url = new URL(pathCategories)
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("DELETE")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        //def categories = json.parse(connection.getInputStream())
        //def subcategories = categories.children_categories
        //def listaCategorias = [categories:categories]
        render categories as JSON
    }
}
