<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
    <title>List of books</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<body>
<jsp:include page="_menu.jsp"></jsp:include>
<div class="container">
    <h2>List of books</h2>
    <table class="table table-striped">
        <thead>
        <tr>
        <tbody>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Year</th>
            <th>Available</th>
            <%--<th>Authors</th>--%>
        </tr>
        <c:forEach items="${books}" var="book">
            <tr>
            <td>${book.id}</td>
            <td>${book.title}</td>
            <td>${book.year}</td>
            <td>${book.available}</td>
            </tr>
        </c:forEach>
    </tbody>
    </table>
</div>
</body>
</html>