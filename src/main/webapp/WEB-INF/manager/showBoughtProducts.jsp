<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<div class="p-5 w-75 mx-auto" style="background: #FFF; border-radius: 15px">
    <h1 class="text-center">Список проданных товаров</h1>
    <p class="text-center">Всего проданных товаров: <strong>${historyCount}</strong>
    <p>
    <table class="table table-striped table-hover mx-auto mt-5">
        <thead class="table table-striped text-center">
        <th>№</th>
        <th>Товар</th>
        <th>Статус</th>
        <th>Имя и фамилия</th>
        <th>Номер телефона</th>
        <th>Дата покупки</th>
        <th>Цена</th>
        </thead>
        <tbody class="text-center table-striped">
        <c:forEach var="entry" items="${historyListMap}" varStatus="status">
            <tr>
                <td><em><strong>${status.count}.</strong></em></td>
                <td>${entry.key.product.brand} ${entry.key.product.series} ${entry.key.product.model}</td>
                <td>
                    <c:if test="${entry.key.status == 'success'}">
                        <span class="badge bg-success badge-success">Оплачен</span>
                    </c:if>

                    <c:if test="${entry.key.status == 'reserved'}">
                        <span class="badge bg-warning badge-warning">Зарезервирован</span>
                    </c:if>
                </td>
                <td>
                    <c:if test="${user.buyer.id != entry.key.buyer.id}">
                        <a style="text-decoration: none; font-weight: bold"
                           href="checkUserProfile?buyerId=${entry.key.buyer.id}">${entry.key.buyer.name} ${entry.key.buyer.lastname}</a>
                    </c:if>

                    <c:if test="${user.buyer.id == entry.key.buyer.id}">
                        <a style="text-decoration: none; font-weight: bold"
                           href="checkProfile?buyerId=${entry.key.buyer.id}">${entry.key.buyer.name} ${entry.key.buyer.lastname}</a>
                    </c:if>
                </td>
                <td>
                    <c:if test="${entry.key.buyer.phoneNumber == null}"><span
                            class="text-muted">Недоступно</span></c:if>
                    <c:if test="${entry.key.buyer.phoneNumber != null}">+372 ${entry.key.buyer.phoneNumber}</c:if>
                </td>
                <td>${entry.key.takeOn}</td>
                <td><span style="font-weight: bold">${entry.key.product.price}€</span></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>