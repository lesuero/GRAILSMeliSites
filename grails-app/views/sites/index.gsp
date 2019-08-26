<!doctype html>
<html>
<head>
    <meta name="layout" content="testlayout"/>
    <title>Sites Mercadolibre</title>
    <script src="https://unpkg.com/vue/dist/vue.min.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>

</head>

<body>
<div id="header">Busqueda de categoría</div>

<select id="select" onchange="tabla.fetchData()">
    <g:each in="${sites}" var = "site">
        <option value="${site?.id}">${site?.name} ${site?.id}</option>
    </g:each>
</select>



<div id="tabla">
    <table border="1" id="categoriesTable">
        <thead>


        <tr>
            <td>Categoria</td>
        </tr>



        </thead>
        <tr v-for="categoria in lista">

            <td><div id ="test"></div><a href="#" @click="getCategories(categoria.id)" id="linkHref"> {{ categoria.name }} </a></td>

        </tr>
    </table>
</div>
%{--
<div id = "idCategoria"></div>
<div id = "nameCategoria"></div>
<div id="imagen"><img id="pictureCategoria"></div>
<div id = "totalCategoria"></div>
--}%
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><div id = "nameCategoria"></div></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                ID Categoria:  <div id = "idCategoria"></div>
                <div id="imagen"><img class="img-responsive" style="max-height:250px;" id="pictureCategoria"></div>
                <div id = "totalCategoria"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="tabla.deleteItem(document.getElementById('idCategoria').innerText);alert('ARTICULO ELIMINADO!');" data-dismiss="modal">Eliminar</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<script>
    var tabla = new Vue({
        el: '#tabla',
        data: {
            lista: [],
            path: ""
        },
        methods: {
            fetchData:

                function () {
                    var idCat = document.getElementById('select').value
                    axios.get("/sites/categorias", {
                        params: {
                            idCat: idCat
                        }
                    }).then(function (response) {
                        tabla.lista = response.data.categories;
                        tabla.path = response.data.categories.path_from_root
                        //tabla.path = "http://api.mercadolibre.com/sites/"+idCat+"/categories"
                        document.getElementById("idCategoria").innerHTML = ""
                        document.getElementById("nameCategoria").innerHTML = ""
                        document.getElementById("pictureCategoria").src = ""
                        document.getElementById("pictureCategoria").alt = ""
                        document.getElementById("totalCategoria").innerHTML = ""
                        console.log(tabla.lista)
                    }).catch(function (error) {
                        console.log(error);
                    })
                },
            getCategories:
                function (idCat) {
                    //document.getElementById("test").innerHTML = idCat
                    axios.get("/sites/subcategorias", {
                        params: {
                            idCat: idCat
                        }
                    }).then(function (response) {
                        //tabla.lista = response.data.categories.children_categories;
                        //tabla.path = response.data.categories.path_from_root
                        //tabla.path = "http://api.mercadolibre.com/categories/"+idCat
                        document.getElementById("idCategoria").innerHTML = ""
                        document.getElementById("nameCategoria").innerHTML = ""
                        document.getElementById("pictureCategoria").src = ""
                        document.getElementById("pictureCategoria").alt = ""
                        document.getElementById("totalCategoria").innerHTML = ""
                        console.log(tabla.lista)
                        if (response.data.categories.children_categories.length == 0) {
                            document.getElementById("idCategoria").innerHTML =  response.data.categories.id;
                            document.getElementById("nameCategoria").innerHTML = response.data.categories.name;

                            $("#exampleModal").modal();
                            if (response.data.categories.picture != null) {
                                document.getElementById("pictureCategoria").src = response.data.categories.picture;
                            } else {
                                document.getElementById("pictureCategoria").alt = "NO POSEE IMAGEN";
                            }
                            document.getElementById("totalCategoria").innerHTML = "Cantidad de items en categoria: " + response.data.categories.total_items_in_this_category;
                        }else{
                            tabla.path = response.data.categories.path_from_root
                            tabla.lista = response.data.categories.children_categories;
                        }
                    }).catch(function (error) {
                        console.log(error);
                    })
                },
            deleteItem:
                function (idItem) {

                    //document.getElementById("test").innerHTML = idItem;
                    axios.get("/sites/deleteItem", {
                        params: {
                            idItem: idItem.toString()
                        }
                    }).then(function (response) {
                        $("#exampleModal").modal('hide');
                        tabla.fetchData()
                    }).catch(function (error) {
                        console.log(error);
                    })
                }



        },


        created: function () {
            this.fetchData(0)
        },
    })

</script>

</body>
</html>