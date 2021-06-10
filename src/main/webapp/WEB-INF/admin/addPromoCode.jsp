<%@page contentType="text/html" pageEncoding="UTF-8" %>
<h3 class="text-center">Добавить промо-код</h3>
<form action="createPromoCode" class="mt-5" method="get">

  <div class="input-group flex-nowrap w-25 my-3 mx-auto">
    <select disabled multiple class="mt-2 mx-auto w-50 form-select">
      <option style="font-weight: bold">Список промо-кодов: </option>
      <c:forEach var="promoCode" items="${promoCodeList}" varStatus="promoCodeId">
        <option>${promoCodeId.count}. ${promoCode.promoCodeName}</option>
      </c:forEach>
    </select>
  </div>

  <div class="input-group flex-nowrap w-25 my-3 mx-auto">
    <span class="input-group-text">Промо-код</span>
    <input class="form-control" type="text" name="promoCodeName" id="promoCodeName" placeholder="JPTVR19" required>
  </div>

  <div class="input-group flex-nowrap w-25 my-3 mx-auto">
    <span class="input-group-text">Процент промо-кода</span>
    <input class="form-control" type="number" name="percent" max="100" min="2" id="percent" placeholder="20" required>
  </div>

  <div class="row w-25 mx-auto mt-5">
    <div class="w-50 mx-auto">
      <input type="submit" class="btn btn-primary w-100" value="Добавить промо-код">
      <a href="deletePromoCode" type="submit" class="btn btn-outline-danger w-100 mt-3">Удалить промо-код</a>
    </div>
  </div>
</form>