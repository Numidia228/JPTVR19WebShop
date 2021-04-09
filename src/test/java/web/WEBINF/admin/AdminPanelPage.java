package web.WEBINF.admin;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.Select;

public class AdminPanelPage {
    protected WebDriver driver;
    private final By infoBy = By.id("info");
    private final By userIdSelectBy = By.name("userId");
    private final By roleIdSelectBy = By.name("roleId");
    private final By buttonSubmitBy = By.xpath("//input[@type='submit']");

    public AdminPanelPage(WebDriver driver) {
        this.driver = driver;
    }
    public String getMessageInfo(){
        return driver.findElement(infoBy).getText();
    }

    public void validLostAccess(){
        Select selectUsers = new Select(driver.findElement(userIdSelectBy));
        selectUsers.selectByVisibleText("Kirill Goritski, логин: admin, роль: ADMIN");
        Select selectRoles = new Select(driver.findElement(roleIdSelectBy));
        selectRoles.selectByVisibleText("BUYER");
        driver.findElement(buttonSubmitBy).click();
    }
}
