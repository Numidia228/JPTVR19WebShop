<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="random" class="java.util.Random" scope="application"/>

<div class="container mt-5 mb-5">
    <div class="d-flex justify-content-center row">
        <div class="row g-2 d-flex flex-nowrap">
            <div class="col-md-3" style="margin-right: 1rem">
                <div class="border rounded mt-2" style="background-color: #FFF;  padding: 20px">
                    <div class="category p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                                <h6 style="font-size: 16px; font-weight: 700">Категории</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <c:forEach var="category" items="${categoryList}" varStatus="categoryId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="categoryCheckBox">
                                        <label class="form-check-label text-muted"
                                               for="categoryCheckBox"
                                               style="font-size: 14px">${category.categoryName}</label>
                                    </div>
                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style=" margin-bottom: 0">
                    </div>

                    <div class="brand p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Бренд</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="brandSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="brandCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="brandCheckBox">${product.brand}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="series p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Серия</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="seriesSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="seriesCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="seriesCheckBox">${product.brand} ${product.series}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="brand p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Цена</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="d-flex justify-content-between mb-3">
                                <input type="text" class="form-control ml-3" id="priceFrom" value="100">
                                <span style="margin: auto 1rem">до</span>
                                <input type="text" class="form-control mr-3" id="priceTo" value="1000">
                            </div>
                            <input type="range" class="form-range" min="0" max="1000" name="priceFilter"
                                   value="0">
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="color p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Цвет корпуса</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="colorSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="colorCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="colorCheckBox">${product.color}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="weight p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Вес, кг</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="d-flex justify-content-between mb-3">
                                <input type="text" class="form-control ml-3" id="weightFrom" value="1">
                                <span style="margin: auto 1rem">до</span>
                                <input type="text" class="form-control mr-3" id="weightTo" value="3.3">
                            </div>
                            <input type="range" step="0.01" class="form-range" min="1" max="3.7"
                                   name="priceFilter"
                                   value="1">
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="screenDiagonal p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Диагональ экрана, "</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="d-flex justify-content-between mb-3">
                                <input type="text" class="form-control ml-3" id="screenDiagonalFrom"
                                       value="12.4">
                                <span style="margin: auto 1rem">до</span>
                                <input type="text" class="form-control mr-3" id="screenDiagonalTo"
                                       value="17.3">
                            </div>
                            <input type="range" step="0.1" class="form-range" min="1" max="3.7"
                                   name="priceFilter"
                                   value="12.4">
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="operationSystem p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Установленая операционная
                                система</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="operationSystemSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox"
                                               id="operationSystemCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="operationSystemCheckBox">${product.operationSystem}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="cpuType p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Класс процессора</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="cpuTypeSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="cpuClassCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="cpuClassCheckBox">${product.cpuType} ${product.cpuClass}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="cpuModel p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Модель процессора</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="cpuModelSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="cpuModelCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="cpuModelCheckBox">${product.cpuModel}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="ramType p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Тип оперативной памяти</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="ramTypeSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="ramTypeCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="ramTypeCheckBox">${product.ramType}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="ramSize p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Оперативная память (RAM)</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="ramSizeSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="ramSizeCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="ramSizeCheckBox">${product.ramSize}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="hdd p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Жесткий диск (HDD)</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="form-check">
                                <div>
                                    <input type="radio" id="hddYes" class="form-check-input" name="hdd" value="yes">
                                    <label for="hddYes" class="form-check-label text-muted"
                                           style="font-size: 14px">Да</label>
                                </div>

                                <div>
                                    <input type="radio" id="hddNo" class="form-check-input" name="hdd" value="no">
                                    <label for="hddNo" class="form-check-label text-muted"
                                           style="font-size: 14px">Нет</label>
                                </div>
                            </div>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="hddCapacity p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Объём жесткого диска (ГБ)</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="hddCapacitySearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="hddCapacityCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="hddCapacityCheckBox">${product.hddCapacity}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="ssd p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Твердотльный накопитель (SSD)</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="form-check">
                                <div>
                                    <input type="radio" id="ssdYes" class="form-check-input" name="ssd" value="yes">
                                    <label for="ssdYes" class="form-check-label text-muted"
                                           style="font-size: 14px">Да</label>
                                </div>

                                <div>
                                    <input type="radio" id="ssdNo" class="form-check-input" name="ssd" value="no">
                                    <label for="ssdNo" class="form-check-label text-muted"
                                           style="font-size: 14px">Нет</label>
                                </div>
                            </div>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="sddCapacity p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Объём твердотельного накопителя (ГБ)</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="ssdCapacitySearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox" id="ssdCapacityCheckBox">
                                        <label for="ssdCapacityCheckBox" class="form-check-label text-muted"
                                               style="font-size: 14px">${product.ssdCapacity}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="gpuType p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Серия видеокарты</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="gpuTypeSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox"
                                               id="gpuTypeCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="gpuTypeCheckBox">${product.gpuType}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="gpuModel p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Модель видеокарты</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="gpuModelSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox"
                                               id="gpuModelCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="gpuModelCheckBox">${product.gpuModel}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="diskDrive p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Дисковод</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="form-check">
                                <div>
                                    <input type="radio" id="diskDriveYes" class="form-check-input" name="diskDrive"
                                           value="yes">
                                    <label for="diskDriveYes" class="form-check-label text-muted"
                                           style="font-size: 14px">Да</label>
                                </div>

                                <div>
                                    <input type="radio" id="diskDriveNo" class="form-check-input" name="diskDrive"
                                           value="no">
                                    <label for="diskDriveNo" class="form-check-label text-muted"
                                           style="font-size: 14px">Нет</label>
                                </div>
                            </div>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="bodyMaterial p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Материал корпуса</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="bodyMaterialSearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox"
                                               id="bodyMaterialCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="bodyMaterialCheckBox">${product.bodyMaterial}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="russianKeyboardLayout p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Русская раскладка клавиатуры</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="form-check">
                                <div>
                                    <input type="radio" id="russianKeyboardLayoutYes" class="form-check-input"
                                           name="russianKeyboardLayout" value="yes">
                                    <label for="russianKeyboardLayoutYes" class="form-check-label text-muted"
                                           style="font-size: 14px">Да</label>
                                </div>

                                <div>
                                    <input type="radio" id="russianKeyboardLayoutNo" class="form-check-input"
                                           name="russianKeyboardLayout" value="no">
                                    <label for="russianKeyboardLayoutNo" class="form-check-label text-muted"
                                           style="font-size: 14px">Нет</label>
                                </div>
                            </div>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="estonianKeyboardLayout p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Эстонская раскладка клавиатуры</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="form-check">
                                <div>
                                    <input type="radio" id="estonianKeyboardLayoutYes" class="form-check-input"
                                           name="estonianKeyboardLayout" value="yes">
                                    <label for="estonianKeyboardLayoutYes" class="form-check-label text-muted"
                                           style="font-size: 14px">Да</label>
                                </div>

                                <div>
                                    <input type="radio" id="estonianKeyboardLayoutNo" class="form-check-input"
                                           name="estonianKeyboardLayout" value="no">
                                    <label for="estonianKeyboardLayoutNo" class="form-check-label text-muted"
                                           style="font-size: 14px">Нет</label>
                                </div>
                            </div>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="backlitKeyboard p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Подсветка клавиатуры</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="form-check">
                                <div>
                                    <input type="radio" id="backlitKeyboardYes" class="form-check-input"
                                           name="backlitKeyboard" value="yes">
                                    <label for="backlitKeyboardYes" class="form-check-label text-muted"
                                           style="font-size: 14px">Да</label>
                                </div>

                                <div>
                                    <input type="radio" id="backlitKeyboardNo" class="form-check-input"
                                           name="backlitKeyboard" value="no">
                                    <label for="backlitKeyboardNo" class="form-check-label text-muted"
                                           style="font-size: 14px">Нет</label>
                                </div>
                            </div>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="waterproofKeyboard p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Подсветка клавиатуры</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <div class="form-check">
                                <div>
                                    <input type="radio" id="waterproofKeyboardYes" class="form-check-input"
                                           name="waterproofKeyboard" value="yes">
                                    <label for="waterproofKeyboardYes" class="form-check-label text-muted"
                                           style="font-size: 14px">Да</label>
                                </div>

                                <div>
                                    <input type="radio" id="waterproofKeyboardNo" class="form-check-input"
                                           name="waterproofKeyboard" value="no">
                                    <label for="waterproofKeyboardNo" class="form-check-label text-muted"
                                           style="font-size: 14px">Нет</label>
                                </div>
                            </div>
                        </div>
                        <hr style="margin-bottom: 0">
                    </div>

                    <div class="batteryTechnology p-2">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h6 style="font-size: 16px; font-weight: 700">Технология батареи</h6>
                        </div>
                        <div class="d-flex justify-content-between flex-column mt-2">
                            <input type="text" class="form-control mb-3" placeholder="Поиск"
                                   name="batteryTechnologySearchInput">
                            <c:forEach var="product" items="${listProducts}" varStatus="productId">
                                <div class="form-check d-flex justify-content-between">
                                    <div>
                                        <input class="form-check-input" type="checkbox"
                                               id="batteryTechnologyCheckBox">
                                        <label class="form-check-label text-muted" style="font-size: 14px"
                                               for="batteryTechnologyCheckBox">${product.batteryTechnology}</label>
                                    </div>

                                    <div>
                                        <span class="text-muted" style="font-size: 12px">(10)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="p-2">
                        <div class="w-50 mx-auto">
                            <input type="submit" class="btn btn-outline-primary w-100" value="Искать">
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-10">
                <c:forEach var="product" items="${listProducts}" varStatus="productId">
                    <div class="row p-2 bg-white border rounded mt-2">
                        <div class="col-md-3 d-flex justify-content-center">
                            <img src="insertCover/${product.cover.path}" class="card-img-top" alt="..."
                                 style="max-width: 12rem; max-height: 15rem; margin: auto 10px auto 10px;">
                        </div>
                        <div class="col-md-6 mt-1">
                            <h5>${product.brand} ${product.series} ${product.model}</h5>
                            <div class="d-flex flex-row">
                                <div class="ratings mr-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor"
                                         class="bi bi-star-fill" viewBox="0 0 16 16" style="fill: #ffa500">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"></path>
                                    </svg>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor"
                                         class="bi bi-star-fill" viewBox="0 0 16 16" style="fill: #ffa500">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"></path>
                                    </svg>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor"
                                         class="bi bi-star-fill" viewBox="0 0 16 16" style="fill: #ffa500">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"></path>
                                    </svg>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor"
                                         class="bi bi-star-fill" viewBox="0 0 16 16" style="fill: #ffa500">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"></path>
                                    </svg>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                         fill="currentColor"
                                         class="bi bi-star-fill" viewBox="0 0 16 16" style="fill: #ffa500">
                                        <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"></path>
                                    </svg>
                                </div>
                                <span style="margin-top: 2px; margin-left: 4px">${random.nextInt(1000)}</span>
                            </div>
                            <div class="mt-1 mb-1 spec-1 d-flex flex-column">
                            <span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-dot" viewBox="0 0 16 16" style="fill: #007bff">
                                  <path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"></path>
                                </svg>
                                Процессор: ${product.cpuType} ${product.cpuModel} ${product.cpuFrequency}ГГц</span>
                                <span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-dot" viewBox="0 0 16 16" style="fill: #007bff">
                                  <path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"></path>
                                </svg>
                                Видеокарта: ${product.gpuType} ${product.gpuModel}
                            </span>
                                <span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-dot" viewBox="0 0 16 16" style="fill: #007bff">
                                  <path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"></path>
                                </svg>
                                ОЗУ: ${product.ramSize}Гб, ${product.ramType}, ${product.ramClockSpeed}МГц
                            </span>
                                <span>
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                     class="bi bi-dot" viewBox="0 0 16 16" style="fill: #007bff">
                                  <path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"></path>
                                </svg>
                                Аккумулятор: ${product.batteryTechnology}, время работы: ${product.batteryLife} часов
                            </span>
                            </div>
                            <a data-bs-target="#exampleModal${productId.count}" data-bs-toggle="modal"
                               id="viewDetailButton${productId.count}"
                               class="<c:if test="${product.count < 1}">disabled</c:if> d-flex"
                               style="cursor: pointer; margin: 6px 0">Смотреть подробнее</a>

                            <div class="modal fade" id="exampleModal${productId.count}" tabindex="-1"
                                 aria-labelledby="exampleModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Описание товара
                                                "<i>${product.brand} ${product.series} ${product.model}</i>"
                                            </h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Категория: <span
                                                    style="font-weight: bold">${product.category.categoryName}</span>
                                            </p>
                                            <hr>
                                            <p>Бренд: <span
                                                    style="font-weight: bold">${product.brand}</span></p>
                                            <p>Серия: <span
                                                    style="font-weight: bold">${product.series}</span></p>
                                            <p>Модель: <span
                                                    style="font-weight: bold">${product.model}</span></p>
                                            <p>Цвет: <span style="font-weight: bold">${product.color}</span>
                                            </p>
                                            <p>Вес: <span
                                                    style="font-weight: bold">${product.weight}кг</span></p>
                                            <p>Длина: <span
                                                    style="font-weight: bold">${product.length}мм</span></p>
                                            <p>Ширина: <span
                                                    style="font-weight: bold">${product.width}мм</span></p>
                                            <p>Высота: <span
                                                    style="font-weight: bold">${product.height}мм</span></p>

                                            <hr>

                                            <p>Диагональ экрана: <span
                                                    style="font-weight: bold">${product.screenDiagonal} "</span>
                                            </p>
                                            <p>Разрешение экрана: <span
                                                    style="font-weight: bold">${product.resolution}</span>
                                            </p>
                                            <p>Сенсорный экран: <span
                                                    style="font-weight: bold">${product.touchScreen}</span>
                                            </p>

                                            <hr>

                                            <p>Операционная система: <span
                                                    style="font-weight: bold">${product.touchScreen}</span>
                                            </p>

                                            <hr>

                                            <p>Тип процессора: <span
                                                    style="font-weight: bold">${product.cpuType}</span>
                                            </p>
                                            <p>Класс процессора: <span
                                                    style="font-weight: bold">${product.cpuClass}</span>
                                            </p>
                                            <p>Модель процессора: <span
                                                    style="font-weight: bold">${product.cpuModel}</span>
                                            </p>
                                            <p>Частота процессора: <span
                                                    style="font-weight: bold">${product.cpuFrequency}ГГц</span>
                                            </p>

                                            <hr>

                                            <p>Тип оперативной памяти: <span
                                                    style="font-weight: bold">${product.cpuFrequency}</span>
                                            </p>
                                            <p>Оперативная память (RAM): <span
                                                    style="font-weight: bold">${product.cpuFrequency}Гб</span>
                                            </p>
                                            <p>Частота оперативной памяти: <span
                                                    style="font-weight: bold">${product.cpuFrequency}МГц</span>
                                            </p>

                                            <hr>

                                            <p>SSD диск: <span
                                                    style="font-weight: bold">${product.ssd}</span></p>
                                            <p>Объем диска SSD: <span
                                                    style="font-weight: bold">${product.ssdCapacity}
                                                <c:if
                                                        test="${product.ssdCapacity != 'Не указано'}">Гб</c:if></span>
                                            </p>
                                            <p>HDD диск: <span
                                                    style="font-weight: bold">${product.hdd}</span></p>
                                            <p>Объем диска HDD: <span
                                                    style="font-weight: bold">${product.hddCapacity}
                                                <c:if
                                                        test="${product.hddCapacity != 'Не указано'}">Гб</c:if></span>
                                            </p>
                                            <p>Общий объём памяти: <span
                                                    style="font-weight: bold">${product.totalPcMemory}Гб</span>
                                            </p>

                                            <hr>

                                            <p>Тип видеокарты: <span
                                                    style="font-weight: bold">${product.gpuType}</span>
                                            </p>
                                            <p>Модель видеокарты: <span
                                                    style="font-weight: bold">${product.gpuModel}</span>
                                            </p>

                                            <hr>

                                            <p>Дисковод: <span
                                                    style="font-weight: bold">${product.diskDrive}</span>
                                            </p>
                                            <p>Видеокамера: <span
                                                    style="font-weight: bold">${product.camera}</span></p>
                                            <p>Микрофон: <span
                                                    style="font-weight: bold">${product.microphone}</span>
                                            </p>

                                            <hr>

                                            <p>Материал корпуса: <span
                                                    style="font-weight: bold">${product.bodyMaterial}</span>
                                            </p>
                                            <p>Русская раскладка: <span
                                                    style="font-weight: bold">${product.russianKeyboardLayout}</span>
                                            </p>
                                            <p>Эстонская раскладка: <span
                                                    style="font-weight: bold">${product.estonianKeyboardLayout}</span>
                                            </p>
                                            <p>Подсветка клавиатуры: <span
                                                    style="font-weight: bold">${product.backlitKeyboard}</span>
                                            </p>
                                            <p>Влагостойкая клавиатура: <span
                                                    style="font-weight: bold">${product.waterproofKeyboard}</span>
                                            </p>

                                            <hr>

                                            <p>Технология батареи: <span
                                                    style="font-weight: bold">${product.batteryTechnology}</span>
                                            </p>
                                            <p>Время работы батареи: <span
                                                    style="font-weight: bold">${product.batteryLife} часов</span>
                                            </p>

                                            <hr>

                                            <p>Гарантия: <span
                                                    style="font-weight: bold"> ${product.guarantee} месяца</span>
                                            </p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary"
                                                    data-bs-dismiss="modal">
                                                Закрыть
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="align-items-center align-content-center col-md-3 border-left mt-1">
                            <div class="d-flex flex-row align-items-center">
                                <h4 class="mr-1">${product.price}€</h4>
                            </div>
                            <h6 class="text-success">Доставка - 5€</h6>
                            <span class="card-text m-0">
                            <strong>
                            <c:if test="${product.count < 1}">Нет в наличии
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                     class="bi bi-clock-fill" viewBox="0 0 24 24" style="fill: red; margin-top: 6px">
                                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"></path>
                                </svg>
                            </c:if>

                            <c:if test="${product.count > 0}">В наличии
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                     style="fill: #32CD32; margin-top: 6px"
                                     class="bi bi-check-circle-fill" viewBox="0 0 24 24">
                                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"></path>
                                </svg>
                            </c:if>
                            </strong>
                        </span>
                            <div class="d-flex flex-column mt-4">
                                <form action="buyProduct" method="post">
                                    <a href="buyProduct?productId=${productId.count}"
                                       data-bs-target="#buyProductConfirmation${productId.index}"
                                       data-bs-toggle="modal"
                                       id="confirmationButton${productId.count}"
                                       class="btn btn-primary w-100 <c:if test="${product.count < 1}">disabled</c:if>"
                                       style="margin-top: -20px">Купить
                                        сразу</a>
                                </form>

                                <form action="addToBag">
                                    <a href="addToBag?productId=${productId.count}"
                                       class="btn btn-outline-primary w-100 mt-2 mb-3 <c:if test="${product.count < 1}">disabled</c:if>"
                                       data-bs-target="#addToBagConfirmation${productId.index}"
                                       data-bs-toggle="modal"
                                       id="productId=${productId.count}">
                                        Добавить в корзину
                                    </a>
                                </form>
                            </div>

                            <div class="modal fade" id="buyProductConfirmation${productId.index}"
                                 tabindex="-1"
                                 aria-labelledby="buyProductConfirmationModal"
                                 aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="buyProductConfirmationModal">
                                                Подтверждение
                                                покупки</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Вы уверены, что хотите купить товар
                                                "<strong>${product.brand} ${product.model}</strong>" за
                                                <strong>${product.price}</strong>€
                                            </p>
                                            <span>
                                            <i class="text-muted"><strong>Важно:</strong> при выборе "Купить сразу" Вы не сможете использовать промо-коды. Чтобы их использовать, совершите покупку через козрину.</i>
                                                <a href="shoppingCartForm">Перейти в корзину.</a>
                                            </span>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Нет
                                            </button>
                                            <a href="buyProduct?productId=${productId.count}"
                                               type="button"
                                               class="btn btn-primary">Да</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" id="addToBagConfirmation${productId.index}"
                                 tabindex="-1"
                                 aria-labelledby="addToBagConfirmationModal"
                                 aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addToBagConfirmationModal">
                                                Уведомление</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Хотите ли Вы добавить товар
                                                "<strong>${product.brand} ${product.model}</strong>" в
                                                корзину?
                                            </p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Нет
                                            </button>
                                            <a href="addToBag?productId=${productId.count}" type="button"
                                               class="btn btn-primary">Да</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>