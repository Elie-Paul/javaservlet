<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: elie
  Date: 15-06-2020
  Time: 01:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <h2>Liste des employes</h2>
    <button type="button" class="btn btn-primary mb-2" data-toggle="modal" data-target="#exampleModal">
        Enregistrer un employe
    </button>

    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>ID</th>
                <th>PRENOM NOM</th>
                <th>POSTE</th>
                <th>SALIRE</th>
                <th>SERVICE</th>
                <th>EDIT</th>
                <th>REMOVE</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${requestScope.employes}" var="employe">
                <tr>
                    <td>${employe.id}</td>
                    <td>${employe.nomComplet}</td>
                    <td>${employe.poste}</td>
                    <td>${employe.salaire}</td>
                    <td>${employe.service.libelle}</td>
                    <td> <a href="" role="button" data-toggle="modal" data-target="#exampleModal" data-target-id="${employe.id}" id="edit" class="btn btn-primary">editer</a> </td>
                    <td><a href="" role="button" class="btn btn-danger">supprimer</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Enregistrer un employe</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form method="post" action="${pageContext.request.contextPath}/employe">
                        <input type="hidden" name="action" value="add">
                        <div class="form-group row">
                            <label for="nom" class="col-sm-2 col-form-label">Prenom Nom</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="nom" id="nom" placeholder="Prenom Nom">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="poste" class="col-sm-2 col-form-label">Poste</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="poste" id="poste" placeholder="poste">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="salaire" class="col-sm-2 col-form-label">Salaire</label>
                            <div class="col-sm-10">
                                <input type="number" class="form-control" name="salaire" id="salaire" placeholder="salaire">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="service" class="col-sm-2 col-form-label">Service</label>
                            <div class="col-sm-10">
                                <select id="service" name="service" class="form-control">
                                    <option selected>Selectionner...</option>
                                    <c:forEach items="${requestScope.services}" var="service">
                                        <option value="${service.id}">${service.libelle}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Enregistrer</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    </form>
                </div>
                <!--div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                    <button type="button" class="btn btn-primary">Enregistrer</button>
                </div-->
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(
        function () {
            $("#edit").click(function(){
                var id = $(this).attr("data-target-id")
                console.log(id)
                $.ajax({
                    async: false,
                    url: "/servletTest/employe",
                    type: "get",
                    data: {action: "update", employe_id: id},
                    dataType: "json",
                    success: function (data) {
                        console.log(data)
                        $("#nom").val(data.nomComplet)
                        $("#poste").val(data.poste)
                        $("#salaire").val(data.salaire)
                        $("#service").val(data.service.id)
                    },
                    error: function (err) {
                        console.log(err)
                    }
                })
            })
        }
    )
</script>
</body>
</html>
