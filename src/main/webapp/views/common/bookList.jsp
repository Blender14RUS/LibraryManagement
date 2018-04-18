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
            <th>Authors</th>
            <th><th>
        </tr>
        <c:forEach items="${books}" var="book">
            <tr>
                <td>${book.id}</td>
                <td>${book.title}</td>
                <td>${book.year}</td>
                <td>${book.available}</td>
                <td>
                        <c:forEach items="${book.authors}" var="author">
                        ${author}<br>
                        </c:forEach>
                </td>
                <td>
                    <form action="books/view/${book.id}" method="POST">
                        <button type="submit" class="btn btn-primary" >View
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <form action="/books" method="POST">
        <td><input name="bookTitle" class="form-control" placeholder="Enter the title"></td>
        <label class="switch">
            <input type="checkbox" name="available">
            <span class="slider round">Show books that not available</span>
        </label>
        <button type="submit" class="btn btn-primary"> Search
        </button>
    </form>
</div>
</body>
</html>