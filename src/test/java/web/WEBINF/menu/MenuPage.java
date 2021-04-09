package web.WEBINF.menu;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import web.WEBINF.admin.AdminPanelPage;
import web.WEBINF.guest.LoginFormPage;
import web.WEBINF.admin.ListBuyersPage;

public class MenuPage {
    protected WebDriver driver;

    private final By infoBy = By.id("info");
    private final By loginFormBy = By.id("loginForm");
    private final By adminFormBy = By.id("adminForm");
    private final By listBuyersBy = By.id("listBuyers");
    private final By logoutBy = By.id("logout");

    public MenuPage(WebDriver driver) {
        this.driver = driver;
    }

    public String getMessageInfo(){
        return driver.findElement(infoBy).getText();
    }

    public LoginFormPage getLoginFormPage() {
        driver.findElement(By.id("loginForm")).click();
        return new LoginFormPage(driver);
    }

    public AdminPanelPage getAdminFormPage() {
        driver.findElement(adminFormBy).click();
        return new AdminPanelPage(driver);
    }

    public ListBuyersPage getListBuyersPage() {
        driver.findElement(listBuyersBy).click();
        return new ListBuyersPage(driver);
    }

    public void logout() {
        driver.findElement(logoutBy).click();
    }
}