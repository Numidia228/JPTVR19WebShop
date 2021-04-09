<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<div class="p-5 w-75 mx-auto" style="background: #FFF; border-radius: 15px">
    <h1 class="text-center">Список покупателей</h1>
    <p class="text-center my-3" style="font-size: 18px">Всего зарегистрировано пользователей:
        <strong>${usersCount}</strong>
    <p>
    <table class="table table-striped table-hover mx-auto mt-5">
        <thead class="table table-striped text-center">
        <th>№</th>
        <th>Имя и фамилия</th>
        <th>E-mail</th>
        <th>Баланс</th>
        <th>Логин</th>
        <th>Роль</th>
        <th>Активность</th>
        <th>Статус</th>
        <th></th>
        </thead>
        <tbody class="text-center table-striped">
        <c:forEach var="entry" items="${usersMapWithArrayRoles}" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td>
                    <c:if test="${entry.key.id eq user.id}">
                        <strong>${entry.key.buyer.name} ${entry.key.buyer.lastname}<i class="text-muted">
                            (Вы)</i></strong>
                    </c:if>

                    <c:if test="${entry.key.id != user.id}">
                        <strong>${entry.key.buyer.name} ${entry.key.buyer.lastname}</strong>
                    </c:if>
                </td>
                <td>${entry.key.buyer.email}</td>
                <td><c:if test="${entry.key.buyer.money eq null}"><p class="text-muted">Недоступно</p></c:if> <c:if
                        test="${entry.key.buyer.money != null}">${entry.key.buyer.money}€</c:if></td>
                <td>${entry.key.login}</td>
                <td>
                    <c:if test="${entry.value[0] ne ''}">
                        <div class="d-flex flex-column">
                            <span>${entry.value[0]}</span>
                            <c:if test="${entry.key.id != 1}">
                                <small style="margin-top: -3px"
                                       class=" <c:if test="${entry.key.id eq user.id}">d-none</c:if>">
                                    <form action="changeRoleFromListUsers">
                                        <a href="changeRoleFromListUsers?userId=${entry.key.id}"
                                           class="badge bg-primary mx-auto">Изменить</a>
                                    </form>
                                </small>
                            </c:if>
                        </div>
                    </c:if>
                </td>
                <td><em><strong>Да</strong></em></td>
                <th>
                    <c:if test="${entry.key.userStatus eq 'confirmed'}">
                        <span>Подтверждён</span>
                    </c:if>

                    <c:if test="${entry.key.userStatus eq 'unconfirmed'}">
                        <div class="d-flex flex-column">
                            <span>Не подтверждён</span>
                            <form action="confirmUserFromListUsers" method="post" class="d-flex justify-content-center">
                                <small style="margin-top: -3px">
                                    <a href="confirmUserFromListUsers?userId=${entry.key.id}"
                                       class="badge bg-primary mx-auto">Подтвердить</a>
                                </small>
                            </form>
                        </div>
                    </c:if>
                </th>
                <th class="">
                    <c:if test="${user.buyer.id != entry.key.buyer.id}">
                        <a style="text-decoration: none; font-weight: bold" class="btn btn-primary"
                           href="checkUserProfile?buyerId=${entry.key.buyer.id}">Профиль</a>
                    </c:if>

                    <c:if test="${user.buyer.id == entry.key.buyer.id}">
                        <a style="text-decoration: none; font-weight: bold" class="btn btn-primary"
                           href="checkProfile?buyerId=${entry.key.buyer.id}">Профиль</a>
                    </c:if>
                </th>
            </tr>
        </c:forEach>

        </tbody>

    </table>
</div>