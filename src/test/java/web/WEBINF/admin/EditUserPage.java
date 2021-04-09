package web.WEBINF.admin;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import web.IndexPage;

public class EditUserPage {
    protected WebDriver driver;
    private final By buttonSubmitBy = By.xpath("//input[@type='submit']");

    public EditUserPage(WebDriver driver) {
        this.driver = driver;
    }

    public IndexPage changeUserProfile() {
        driver.findElement(buttonSubmitBy).click();
        return new IndexPage(driver);
    }

}