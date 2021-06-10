<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="w-25 mx-auto">
    <h2 class="text-center mb-4">Введите логин и пароль</h2>
    <form action="login" method="POST" id="loginForm">
        <div>
            <div class="row mb-3 w-75 mx-auto">
                <input type="text" class="form-control" id="login" placeholder="Логин" name="login" ${login} required>
            </div>
            <div class="row mb-4 w-75 mx-auto">
                <input type="password" class="form-control" id="password" name="password" placeholder="Пароль" value="${password}" required>
            </div>
            <div class="mx-auto w-25">
                <input type="submit" value="Войти" id="submit" class="btn w-100 btn-primary submit">
            </div>
        </div>
    </form>
</div>

