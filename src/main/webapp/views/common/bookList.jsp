<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <fmt:setLocale value="${language}"/>
    <fmt:bundle basename="messages">
    <title><fmt:message key="bookList.catalog"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../../resources/css/custom.css"/>
</head>
<body>

<jsp:include page="../layout/_menu.jsp"></jsp:include>
<div class="container">
    <div class="form-row">
        <h2><fmt:message key="bookList.catalog"/></h2>
    </div>
    <form action="${pageContext.request.contextPath}/books" method="POST">

        <div class="form-row center-block">
            <input name="bookTitle" class="form-control" placeholder=<fmt:message key="bookList.enterTheTitle"/>>
        </div>
        <div align="center" class="form-group col-md-3">
            <fmt:message key="bookList.showBooksThatNotAvailable"/>
            <label class="switch">
                <input type="checkbox" name="available">
                <span class="slider round"></span>
            </label>
        </div>
        <div align="center" class="form-group col-md-3 center">
            <fmt:message key="bookList.sort"/>
            <select name="sort">
                <option value="alphabet">A-Z</option>
                <option value="alphabetRev">Z-A</option>
                <option value="year"><fmt:message key="tab.year"/></option>
                <option value="amountL"><fmt:message key="bookList.amountLH"/></option>
                <option value="amountH"><fmt:message key="bookList.amountHL"/></option>
            </select>
        </div>
        <div align="center" class="form-group col-md-2 centerButton">
            <button type="submit" class="btn btn-primary"> Search</button>
        </div>
        <div class="form-group col-md-5">
        </div>

    </form>

    <table class="table table-striped">
        <thead>
        <tr>
        <tbody>
        <tr>
            <th class="cell"><fmt:message key="tab.id"/></th>
            <th class="cell"><fmt:message key="tab.title"/></th>
            <th class="cell"><fmt:message key="tab.year"/></th>
            <th class="cell"><fmt:message key="tab.available"/></th>
            <th class="cell"><fmt:message key="tab.authors"/></th>
            <th class="cell"><fmt:message key="tab.information"/></th>
        </tr>
            <c:forEach items="${books}" var="book">
                <tr>
                    <td class="cell">${book.id}</td>
                    <td class="cellVert">${book.title}</td>
                    <td class="cell">${book.year}</td>
                    <td class="cell">${book.available}</td>
                    <td class="cellVert">
                        <c:forEach items="${book.authors}" var="author">
                            ${author}<br>
                        </c:forEach>
                    </td>
                    <td class="cell">
                        <form action="${pageContext.request.contextPath}/books/view/${book.id}" method="POST">
                            <button type="submit" class="btn btn-primary"><fmt:message key="tab.view"/>
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    <div class="form-row">
        <div id="pagination">
            <c:url value="/books" var="prev">
                <c:param name="page" value="${page - 1}"/>
            </c:url>
            <c:if test="${page > 1}">
                <a href="<c:out value="${prev}" />" class="pn prev"><fmt:message key="bookList.prev"/></a>
            </c:if>
            <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                <c:choose>
                    <c:when test="${page == i.index}">
                        <span>${i.index}</span>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/books" var="url">
                            <c:param name="page" value="${i.index}"/>
                        </c:url>
                        <a href='<c:out value="${url}" />'>${i.index}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:url value="/books" var="next">
                <c:param name="page" value="${page + 1}"/>
            </c:url>
            <c:if test="${page + 1 <= maxPages}">
                <a href='<c:out value="${next}" />' class="pn next"><fmt:message key="bookList.next"/></a>
            </c:if>
        </div>
    </div>
</div>

</body>
</fmt:bundle>
</html>
