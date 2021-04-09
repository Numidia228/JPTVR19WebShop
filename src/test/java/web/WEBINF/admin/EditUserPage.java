package web.WEBINF.admin;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import web.IndexPage;

public class EditUserPage {
    protected WebDriver driver;
    private final By submitButtonBy = By.cssSelector("#submit");

    public EditUserPage(WebDriver driver) {
        this.driver = driver;
    }

    public void changeUserProfile() {
        driver.findElement(submitButtonBy).click();
        new IndexPage(driver);
    }

}