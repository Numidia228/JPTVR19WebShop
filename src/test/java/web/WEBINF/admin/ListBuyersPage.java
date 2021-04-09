package web.WEBINF.admin;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class ListBuyersPage {
    protected WebDriver driver;
    private final By tableListBuyersBy = By.id("tableListBuyers");
    private final By tagA_By = By.tagName("a");

    public ListBuyersPage(WebDriver driver) {
        this.driver = driver;
    }

    public EditUserPage getEditUserPage(String login) {
        WebElement table = driver.findElement(tableListBuyersBy);
        WebElement tr = table.findElement(By.xpath("//tr[td[text()='" + login + "']]"));
        tr.findElement(tagA_By).click();
        return new EditUserPage(driver);
    }
}