<%@page contentType="text/html" pageEncoding="UTF-8" %>
<h3 class="text-center">Загрузить файл</h3>
<form action="uploadCover" class="mt-5" method="POST" enctype="multipart/form-data">
    <div class="row mb-3 w-25 mx-auto mt-5">
        <label for="file" class="form-label">Выберите локальный файл</label>
        <input class="form-control" type="file" name="file" id="file">
    </div>
    <div class="row mb-3 w-25 mx-auto">
        <label for="description" class="form-label">Описание</label>
        <input class="form-control" type="text" name="description" id="description" placeholder="MSI Gaming GL75 Leopard Notebook Black 43.9 cm (17.3')">
    </div>
    <div class="row w-25 mx-auto mt-5">
        <div class="w-50 mx-auto">
            <button type="submit" class="btn btn-primary w-100">Загрузить файл</button>
        </div>
    </div>
</form>