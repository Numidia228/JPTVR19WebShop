<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<h3 class="w-100 text-center my-5">Добавить новый товар</h3>
<div class="row w-100">
    <label class="text-center w-25 mx-auto">
        <a href="uploadForm" class="w-100 col-4 mx-auto btn btn-lg btn-outline-primary">Загрузить обложку для
            товара
        </a>
    </label>

    <p class="fw-bold text-muted text-center mt-5">Общие характеристики</p>

    <form action="createProduct" method="POST">

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Категория</span>
            <select class="form-select" name="categoryId" required>
                <c:forEach var="category" items="${categoryList}" varStatus="categoryId">
                    <option value="${category.id}">${category.categoryName}</option>
                </c:forEach>
            </select>
            <a type="button" class="btn btn-outline-primary" href="addCategory">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard-plus" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M8 7a.5.5 0 0 1 .5.5V9H10a.5.5 0 0 1 0 1H8.5v1.5a.5.5 0 0 1-1 0V10H6a.5.5 0 0 1 0-1h1.5V7.5A.5.5 0 0 1 8 7z"></path>
                    <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1v-1z"></path>
                    <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5h3zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3z"></path>
                </svg>
                <span class="visually-hidden">Button</span>
            </a>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Бренд</span>
            <select class="form-select" name="brand" required>
                <option value="HP" selected>HP</option>
                <option value="Gateway">Gateway</option>
                <option value="Acer">Acer</option>
                <option value="Lenovo">Lenovo</option>
                <option value="Dell">Dell</option>
                <option value="Apple">Apple</option>
                <option value="Sony">Sony</option>
                <option value="Toshiba">Toshiba</option>
                <option value="ASUS">ASUS</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Серия</span>
            <input type="text" class="form-control" placeholder="MacBook Air" id="series"
                   name="series" value="${series}" required>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Модель</span>
            <input type="text" class="form-control" placeholder="MQD32ZE/A" id="model" value="${model}"
                   name="model" required>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Цвет</span>
            <input type="text" class="form-control" placeholder="Серый" id="color" value="${color}"
                   name="color">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Вес (кг)</span>
            <input type="number" step="0.01" class="form-control" placeholder="1.35" id="weight" name="weight"
                   value="${weight}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Длина (мм)</span>
            <input type="number" class="form-control" placeholder="325" id="length" name="length" value="${length}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Ширина (мм)</span>
            <input type="number" class="form-control" placeholder="227" id="width" value="${width}"
                   name="width">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Высота (мм)</span>
            <input type="number" class="form-control" placeholder="17" id="height" value="${height}"
                   name="height">
        </div>

        <p class="fw-bold text-muted text-center mt-5">Экран</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Диагональ экрана</span>
            <input type="number" step="0.1" class="form-control" placeholder="13.3" id="screenDiagonal"
                   name="screenDiagonal"
                   value="${screenDiagonal}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Разрешение экрана</span>
            <label for="resolution"></label>
            <input type="text" minlength="9" maxlength="11" class="form-control resolutionText"
                   placeholder="1440 x 900" id="resolution" name="resolution" value="${resolution}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Сенсорный экран</span>
            <select class="form-select" name="touchScreen">
                <option value="Да">Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <p class="fw-bold text-muted text-center mt-5">Операционная система</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Операционная система</span>
            <select class="form-select" name="operationSystem">
                <option disabled class="bg-secondary" style="color: white">Microsoft:</option>
                <option value="Windows 10" selected>Windows 10</option>
                <option value="Windows 8.1">Windows 8.1</option>
                <option value="Windows 8">Windows 8</option>
                <option disabled class="bg-secondary" style="color: white">macOS:</option>
                <option value="macOS Big Sur 11.2.3">macOS Big Sur 11.2.3</option>
                <option value="macOS Catalina 10.15.7">macOS Catalina 10.15.7</option>
                <option value="Mac OS X 10.15 Catalina">macOS Mojave 10.14.6</option>
                <option value="macOS Mojave 10.14.6">macOS High Sierra 10.13.6</option>
                <option value="macOS Sierra 10.12.6">macOS Sierra 10.12.6</option>
                <option value="OS X El Capitan 10.11.6">OS X El Capitan 10.11.6</option>
                <option value="OS X Yosemite 10.10.5">OS X Yosemite 10.10.5</option>
                <option value="OS X Mavericks 10.9.5">OS X Mavericks 10.9.5</option>
                <option value="OS X Mountain Lion 10.8.5">OS X Mountain Lion 10.8.5</option>
                <option value="OS X Lion 10.7.5">OS X Lion 10.7.5</option>
                <option value="OS X Snow Leopard 10.6.8">OS X Snow Leopard 10.6.8</option>
                <option value="ac OS X Leopard 10.5.8">Mac OS X Leopard 10.5.8</option>
                <option value="Mac OS X Tiger 10.4.11">Mac OS X Tiger 10.4.11</option>
                <option value="Mac OS X Panther 10.3.9">Mac OS X Panther 10.3.9</option>
                <option value="Mac OS X Jaguar 10.2.8">Mac OS X Jaguar 10.2.8</option>
                <option value="Mac OS X Puma 10.1.5">Mac OS X Puma 10.1.5</option>
                <option value="Mac OS X Cheetah 10.0.4">Mac OS X Cheetah 10.0.4</option>
            </select>
        </div>

        <p class="fw-bold text-muted text-center mt-5">Процессор</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Тип процессора</span>
            <select class="form-select" name="cpuType">
                <option value="Intel" selected>Intel</option>
                <option value="AMD">AMD</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Класс процессора</span>
            <select class="form-select" name="cpuClass">
                <option disabled class="bg-secondary" style="color: white">Intel:</option>
                <option value="Intel® Celeron®" selected>Intel® Celeron®</option>
                <option value="Intel® Core™ i">Intel® Core™ i3</option>
                <option value="Intel® Core™ i5">Intel® Core™ i5</option>
                <option value="Intel® Core™ i7">Intel® Core™ i7</option>
                <option value="Intel® Core™ i9">Intel® Core™ i9</option>
                <option value="Intel® Core™ серии X">Intel® Core™ серии X</option>
                <option disabled class="bg-secondary" style="color: white">AMD:</option>
                <option value="AMD Athlon™">AMD Athlon™</option>
                <option value="AMD Ryzen™">AMD Ryzen™</option>
                <option value="AMD Ryzen™ Threadripper™">AMD Ryzen™ Threadripper™</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Модель процессора</span>
            <input type="text" class="form-control" placeholder="Intel® Core™ i5-5350U" id="cpuModel"
                   name="cpuModel"
                   value="${cpuModel}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Частота процессора (ГГц)</span>
            <input type="number" step="0.1" class="form-control" placeholder="1.8" id="cpuFrequency"
                   name="cpuFrequency"
                   value="${cpuFrequency}">
        </div>

        <p class="fw-bold text-muted text-center mt-5">Оперативная память</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Тип оперативной памяти</span>
            <select class="form-select" name="ramType">
                <option value="DDR4" selected>DDR4</option>
                <option value="DDR3">DDR3</option>
                <option value="DDR2">DDR2</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Оперативная память (RAM)</span>
            <input type="number" class="form-control" placeholder="8" id="ramSize"
                   name="ramSize"
                   value="${ramSize}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Частота оперативной памяти</span>
            <select class="form-select" name="ramClockSpeed">
                <option disabled class="bg-secondary" style="color: white">DDR4</option>
                <option value="3333" selected>3333</option>
                <option value="3200">3200</option>
                <option value="3000">3000</option>
                <option value="2800">2800</option>
                <option value="2666">2666</option>
                <option value="2400">2400</option>
                <option value="2133">2133</option>
                <option disabled class="bg-secondary" style="color: white">DDR3</option>
                <option value="2400">2400</option>
                <option value="2200">2200</option>
                <option value="2133">2133</option>
                <option value="2000">2000</option>
                <option value="1800">1800</option>
                <option value="1600">1600</option>
                <option value="1333">1333</option>
                <option value="1066">1066</option>
                <option value="800">800</option>
                <option disabled class="bg-secondary" style="color: white">DDR2</option>
                <option value="1066">1066</option>
                <option value="800">800</option>
                <option value="667">667</option>
                <option value="533">533</option>
                <option value="400">400</option>
            </select>
        </div>

        <p class="fw-bold text-muted text-center mt-5">Жесткий диск</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">SSD диск</span>
            <select class="form-select" name="ssd">
                <option value="Да">Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Объем диска SSD (ГБ)</span>
            <select class="form-select" name="ssdCapacity">
                <option value="100" selected>100</option>
                <option value="120">120</option>
                <option value="128">128</option>
                <option value="240">240</option>
                <option value="250">250</option>
                <option value="256">256</option>
                <option value="275">275</option>
                <option value="400">400</option>
                <option value="480">480</option>
                <option value="500">500</option>
                <option value="512">512</option>
                <option value="600">600</option>
                <option value="800">800</option>
                <option value="960">960</option>
                <option value="1000">1000</option>
                <option value="1920">1920</option>
                <option value="2000">2000</option>
                <option value="3000">3000</option>
                <option value="3084">3084</option>
                <option value="4000">4000</option>
                <option value="5000">5000</option>
                <option value="6000">6000</option>
                <option value="8000">8000</option>
                <option value="10000">10000</option>
                <option value="12000">12000</option>
                <option value="14000">14000</option>
                <option value="16000">16000</option>
                <option value="Не указано">Не указано</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">HDD диск</span>
            <select class="form-select" name="hdd">
                <option value="Да">Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Объем диска HDD (ГБ)</span>
            <select class="form-select" name="hddCapacity">
                <option value="100" selected>100</option>
                <option value="120">120</option>
                <option value="128">128</option>
                <option value="240">240</option>
                <option value="250">250</option>
                <option value="256">256</option>
                <option value="275">275</option>
                <option value="400">400</option>
                <option value="480">480</option>
                <option value="500">500</option>
                <option value="512">512</option>
                <option value="600">600</option>
                <option value="800">800</option>
                <option value="960">960</option>
                <option value="1000">1000</option>
                <option value="1920">1920</option>
                <option value="2000">2000</option>
                <option value="3000">3000</option>
                <option value="3084">3084</option>
                <option value="4000">4000</option>
                <option value="5000">5000</option>
                <option value="6000">6000</option>
                <option value="8000">8000</option>
                <option value="10000">10000</option>
                <option value="12000">12000</option>
                <option value="14000">14000</option>
                <option value="16000">16000</option>
                <option value="Не указано">Не указано</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Общий объём памяти (ГБ)</span>
            <input type="number" class="form-control" placeholder="128" id="totalPcMemory"
                   name="totalPcMemory"
                   value="${totalPcMemory}">
        </div>

        <p class="fw-bold text-muted text-center mt-5">Видеокарта</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Тип видеокарты</span>
            <select class="form-select" name="gpuType">
                <option value="Intel" selected>Intel</option>
                <option value="AMD">AMD</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Модель видеокарты</span>
            <input type="text" class="form-control" placeholder="Intel HD Graphics 6000" id="gpuModel"
                   name="gpuModel"
                   value="${gpuModel}">
        </div>

        <p class="fw-bold text-muted text-center mt-5">Встроенные дополнительные устройства</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Дисковод</span>
            <select class="form-select" aria-label="Наличие дисковода:" name="diskDrive">
                <option value="Да">Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Видеокамера</span>
            <select class="form-select" aria-label="Наличие видеокамеры:" name="camera">
                <option value="Да">Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Микрофон</span>
            <select class="form-select" aria-label="Наличие микрофона:" name="microphone">
                <option value="Да">Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <p class="fw-bold text-muted text-center mt-5">Клавиатура и корпус</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Материал корпуса</span>
            <input type="text" class="form-control" placeholder="Сплав металлов" id="bodyMaterial"
                   name="bodyMaterial"
                   value="${bodyMaterial}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Русская раскладка</span>
            <select class="form-select" name="russianKeyboardLayout">
                <option value="Да">Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Эстонская раскладка</span>
            <select class="form-select" name="estonianKeyboardLayout">
                <option value="Да">Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Подсветка клавиатуры</span>
            <select class="form-select" name="backlitKeyboard">
                <option value="Да" selected>Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Влагостойкая клавиатура</span>
            <select class="form-select" name="waterproofKeyboard">
                <option value="Да" selected>Да</option>
                <option value="Нет">Нет</option>
            </select>
        </div>

        <p class="fw-bold text-muted text-center mt-5">Батарея и безопасность</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Технология батареи</span>
            <select class="form-select" name="batteryTechnology">
                <option value="Li-Pol" selected>Li-Pol</option>
                <option value="Li-Ion">Li-Ion</option>
                <option value="NiMH">NiMH</option>
                <option value="NiCD">NiCD</option>
                <option value="SLA">SLA</option>
            </select>
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Время работы батареи (час)</span>
            <input type="number" class="form-control" placeholder="12" id="batteryLife"
                   name="batteryLife"
                   value="${batteryLife}">
        </div>

        <p class="fw-bold text-muted text-center mt-5">Дополнительно</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Гарантия (месяцы)</span>
            <input type="number" class="form-control" placeholder="24" id="guarantee"
                   name="guarantee"
                   value="${guarantee}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Цена (€)</span>
            <input type="number" class="form-control" placeholder="500" id="price"
                   name="price"
                   value="${price}">
        </div>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Количество (шт.)</span>
            <input type="number" class="form-control" placeholder="20" id="count"
                   name="count"
                   value="${count}">
        </div>

        <p class="fw-bold text-muted text-center mt-5">Обложка товара</p>

        <div class="input-group flex-nowrap w-25 my-3 mx-auto">
            <span class="input-group-text">Обложка</span>
            <select class="form-select" name="coverId" aria-label="Выбрать обложку" required>
                <option selected>Выберите обложку для товара:</option>
                <c:forEach var="cover" items="${listCovers}">
                    <option value="${cover.id}">${cover.description}</option>
                </c:forEach>
            </select>
        </div>

        <div class="w-50 mx-auto mt-5" style="margin-bottom: 10rem">
            <div class="mx-auto w-25">
                <input class="btn btn-primary mx-auto w-100" type="submit" name="submit" value="Добавить товар">
            </div>
        </div>
    </form>
</div>

<script>
    $('.resolutionText').on('keyup', function () {
        let foo = $(this).val().split(" x ").join("");
        if (foo.length > 0) {
            foo = foo.match(new RegExp('.{1,2}', 'g')).join(" x ");
        }
        $(this).val(foo);
    });
</script>