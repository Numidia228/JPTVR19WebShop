package web.WEBINF.admin;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class ListBuyersPage {
    protected WebDriver driver;
    private final By checkProfileBy = By.cssSelector("#userProfile");
    private final By editProfileBy = By.cssSelector("#editProfile");

    public ListBuyersPage(WebDriver driver) {
        this.driver = driver;
    }

    public EditUserPage getEditUserPage(String login) {
        driver.findElement(checkProfileBy).click();
        driver.findElement(editProfileBy).click();
        return new EditUserPage(driver);
    }
}