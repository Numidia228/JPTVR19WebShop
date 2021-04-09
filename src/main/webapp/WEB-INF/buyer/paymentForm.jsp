<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form action="payment" method="get">
    <div class="container">
        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">

                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Ваша корзина</span>
                </h4>

                <ul class="list-group mb-3">
                    <c:forEach var="product" items="${cartList}" varStatus="productId">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0">${product.brand} ${product.series} ${product.model}</h6>
                                <a class="mb-2 small text-muted" type="button" data-bs-target="#exampleModal${productId.count}" data-bs-toggle="modal" id="viewDetailButton${productId.count}"
                                   style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis">Смотреть описание</a>
                            </div>
                            <div class="d-flex flex-column w-25 justify-content-center">
                                <span class="text-muted"
                                      style="margin-left: auto">${product.price}€</span>
                            </div>
                        </li>

                        <div class="modal fade" id="exampleModal${productId.count}" tabindex="-1" aria-labelledby="exampleModalLabel"
                             aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Описание товара "<i>${product.brand} ${product.series} ${product.model}</i>"
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Категория: <span style="font-weight: bold">${product.category.categoryName}</span></p>
                                        <hr>
                                        <p>Бренд: <span style="font-weight: bold">${product.brand}</span></p>
                                        <p>Серия: <span style="font-weight: bold">${product.series}</span></p>
                                        <p>Модель: <span style="font-weight: bold">${product.model}</span></p>
                                        <p>Цвет: <span style="font-weight: bold">${product.color}</span></p>
                                        <p>Вес: <span style="font-weight: bold">${product.weight}кг</span></p>
                                        <p>Длина: <span style="font-weight: bold">${product.length}мм</span></p>
                                        <p>Ширина: <span style="font-weight: bold">${product.width}мм</span></p>
                                        <p>Высота: <span style="font-weight: bold">${product.height}мм</span></p>

                                        <hr>

                                        <p>Диагональ экрана: <span style="font-weight: bold">${product.screenDiagonal} "</span></p>
                                        <p>Разрешение экрана: <span style="font-weight: bold">${product.resolution}</span></p>
                                        <p>Сенсорный экран: <span style="font-weight: bold">${product.touchScreen}</span></p>

                                        <hr>

                                        <p>Операционная система: <span style="font-weight: bold">${product.touchScreen}</span></p>

                                        <hr>

                                        <p>Тип процессора: <span style="font-weight: bold">${product.cpuType}</span></p>
                                        <p>Класс процессора: <span style="font-weight: bold">${product.cpuClass}</span></p>
                                        <p>Модель процессора: <span style="font-weight: bold">${product.cpuModel}</span></p>
                                        <p>Частота процессора: <span style="font-weight: bold">${product.cpuFrequency}ГГц</span></p>

                                        <hr>

                                        <p>Тип оперативной памяти: <span style="font-weight: bold">${product.cpuFrequency}</span>
                                        </p>
                                        <p>Оперативная память (RAM): <span
                                                style="font-weight: bold">${product.cpuFrequency}Гб</span>
                                        </p>
                                        <p>Частота оперативной памяти: <span
                                                style="font-weight: bold">${product.cpuFrequency}МГц</span>
                                        </p>

                                        <hr>

                                        <p>SSD диск: <span style="font-weight: bold">${product.ssd}</span></p>
                                        <p>Объем диска SSD: <span style="font-weight: bold">${product.ssdCapacity}<c:if
                                                test="${product.ssdCapacity != 'Не указано'}">Гб</c:if></span></p>
                                        <p>HDD диск: <span style="font-weight: bold">${product.hdd}</span></p>
                                        <p>Объем диска HDD: <span style="font-weight: bold">${product.hddCapacity}<c:if
                                                test="${product.hddCapacity != 'Не указано'}">Гб</c:if></span></p>
                                        <p>Общий объём памяти: <span style="font-weight: bold">${product.totalPcMemory}Гб</span></p>

                                        <hr>

                                        <p>Тип видеокарты: <span style="font-weight: bold">${product.gpuType}</span></p>
                                        <p>Модель видеокарты: <span style="font-weight: bold">${product.gpuModel}</span></p>

                                        <hr>

                                        <p>Дисковод: <span style="font-weight: bold">${product.diskDrive}</span></p>
                                        <p>Видеокамера: <span style="font-weight: bold">${product.camera}</span></p>
                                        <p>Микрофон: <span style="font-weight: bold">${product.microphone}</span></p>

                                        <hr>

                                        <p>Материал корпуса: <span style="font-weight: bold">${product.bodyMaterial}</span></p>
                                        <p>Русская раскладка: <span
                                                style="font-weight: bold">${product.russianKeyboardLayout}</span>
                                        </p>
                                        <p>Эстонская раскладка: <span
                                                style="font-weight: bold">${product.estonianKeyboardLayout}</span>
                                        </p>
                                        <p>Подсветка клавиатуры: <span style="font-weight: bold">${product.backlitKeyboard}</span>
                                        </p>
                                        <p>Влагостойкая клавиатура: <span
                                                style="font-weight: bold">${product.waterproofKeyboard}</span>
                                        </p>

                                        <hr>

                                        <p>Технология батареи: <span style="font-weight: bold">${product.batteryTechnology}</span>
                                        </p>
                                        <p>Время работы батареи: <span style="font-weight: bold">${product.batteryLife} часов</span>
                                        </p>

                                        <hr>

                                        <p>Гарантия: <span style="font-weight: bold"> ${product.guarantee}</span></p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Закрыть
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:forEach>

                    <li class="list-group-item d-flex justify-content-between bg-light <c:if test="${promoCodeUsed != true}">d-none</c:if>">
                        <div class="text-success">
                            <h6 class="my-0">Промо-код</h6>
                            <small>${promoCode}</small>
                        </div>
                        <span class="text-success">-20%</span>
                    </li>

                    <li class="list-group-item d-flex justify-content-between bg-light">
                        <span>Всего (€)</span>
                        <span id="endPrice" name="endPrice" class="font-weight-bold">${endPrice}€</span>
                    </li>
                </ul>
            </div>

            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Платежный адрес</h4>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="name">Имя</label>
                        <input name="name" type="text" class="form-control" id="name"
                               value="${buyer.name}"
                               required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="lastname">Фамилия</label>
                        <input name="lastname" type="text" class="form-control" id="lastname"
                               value="${buyer.lastname}" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="email">Email<span class="text-muted"></span></label>
                    <input name="email" type="email" class="form-control" id="email"
                           value="${buyer.email}" required>
                </div>

                <div class="row">
                    <div class="col-md-5 mb-3">
                        <label for="address">Адрес</label>
                        <input name="address" type="text" class="form-control" id="address"
                               value="${buyer.address}" required>
                    </div>

                    <div class="col-md-3 mb-3">
                        <label for="zip">Zip-код</label>
                        <input name="zip" type="text" class="form-control" id="zip" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="address2">Адрес 2<span class="text-muted"> (необязательно)</span></label>
                        <input name="address2" type="text" class="form-control" id="address2">
                    </div>

                    <hr class="mb-4">

                    <h4 class="mb-3">Оплата</h4>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="cc-name">Имя владельца карты</label>
                            <input name="cc-name" type="text" class="form-control" id="cc-name" placeholder=""
                                   required="">
                            <small class="text-muted">Полное имя написано на карте.</small>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label for="cc-number">Номер карты</label>
                            <input name="cc-number" type="text" class="form-control" id="cc-number" placeholder=""
                                   required="">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label for="cc-expiration">Срок действия</label>
                            <input name="cc-expiration" type="text" class="form-control" id="cc-expiration"
                                   placeholder="" required="">
                        </div>

                        <div class="col-md-3 mb-3">
                            <label for="cc-expiration">CVV</label>
                            <input name="cc-cvv" type="text" class="form-control" id="cc-cvv" placeholder=""
                                   required="">
                        </div>
                    </div>

                <hr class="mb-4">

                <input class="btn btn-primary btn-lg btn-block" value="Продолжить" type="submit">
            </div>
        </div>
    </div>
</form>