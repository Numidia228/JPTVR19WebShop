<%@page contentType="text/html" pageEncoding="UTF-8" %>
<h3 class="text-center">Добавить категорию</h3>
<form action="createCategory" class="mt-5" method="get">

    <div class="input-group flex-nowrap w-25 my-3 mx-auto">
        <select disabled multiple class="mt-2 mx-auto w-50 form-select">
            <option style="font-weight: bold">Список категорий: </option>
            <c:forEach var="сategory" items="${categoryList}" varStatus="categoryId">
                <option>${categoryId.count}. ${сategory.categoryName}</option>
            </c:forEach>
        </select>
    </div>

    <div class="input-group flex-nowrap w-25 my-3 mx-auto">
        <span class="input-group-text">Категория</span>
        <input class="form-control" type="text" name="categoryName" id="categoryName" placeholder="Игровые ноутбуки" required>
    </div>
    <div class="row w-25 mx-auto mt-5">
        <div class="w-50 mx-auto">
            <input type="submit" class="btn btn-primary w-100" value="Добавить категорию">
            <a href="removeCategory" type="submit" class="btn btn-outline-danger w-100 mt-3">Удалить категорию</a>
        </div>
    </div>
</form>