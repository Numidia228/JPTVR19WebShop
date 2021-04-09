package web.general;

import org.junit.*;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import web.WEBINF.menu.MenuPage;

import java.util.concurrent.TimeUnit;

public class GeneralTest {
    static private WebDriver driver;
    private final MenuPage menuPage = new MenuPage(driver);

    public GeneralTest() {
    }

    @BeforeClass
    public static void setUpClass() {
        System.setProperty("webdriver.chrome.driver", "lib/chromedriver.exe");
        driver = new ChromeDriver();
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
        driver.get("http://localhost:8080/JPTVR19WebShop_jakarta-1.0-SNAPSHOT/");
    }

    @AfterClass
    public static void tearDownClass() throws InterruptedException {
        Thread.sleep(2000);
        driver.quit();
    }

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    @Test
    public void lostOfControlTest() {
        System.out.println("LostOfControlTest: ");
        loginUserTest("admin", "admin");
        changeRoleTest(false);
    }

    @Test
    public void disableAccessToAdminProfile() {
        System.out.println("DisableAccessToAdminProfileTest: ");
        logoutTest();
        loginUserTest("asd", "asd");
        changeUserProfile("admin", Boolean.FALSE);
    }

    public void loginUserTest(String login, String password) {
        System.out.println("loginUserTest: ");
        String result = menuPage.getLoginFormPage().loginValidUser(login, password).getMessageInfo();
        String expected = "Добро пожаловать " + "\"" + login + "\"" + ".";
        System.out.println("Expected: " + expected);
        System.out.println("Result: " + result);
        Assert.assertEquals(result, expected);
    }

    public void changeRoleTest(boolean allowed) {
        System.out.println("changeRoleTest(" + allowed + "):");
        menuPage.getAdminFormPage().validLostAccess();
        String result = menuPage.getMessageInfo();
        String expected;
        if (allowed) {
            expected = "Изменить роль невозможно!";
        } else {
            expected = "Роль изменена!";
        }
        System.out.println("Expected: " + expected);
        System.out.println("Result: " + result);
        Assert.assertEquals(result, expected);
    }

    public void logoutTest() {
        System.out.println("logoutTest: ");
        menuPage.logout();
        String result = menuPage.getMessageInfo();
        String expected = "Вы вышли из системы.";
        System.out.println("Expected: " + expected);
        System.out.println("Result: " + result);
        Assert.assertEquals(result, expected);
    }

    public void changeUserProfile(String login, boolean allowed) {
        System.out.println("changeUserProfile(" + login + "," + allowed + "): ");
        menuPage.getListBuyersPage().getEditUserPage(login).changeUserProfile();
        String result = menuPage.getMessageInfo();
        String expected = "Данные пользователя изменены";
        System.out.println("Expected: " + expected);
        System.out.println("Result: " + result);
        if (allowed) {
            System.out.println("Expected и Result должны совпадать");
            Assert.assertEquals(result, expected);
        } else {
            System.out.println("Expected и Result должны несовпадать");
            Assert.assertNotEquals(result, expected);
        }
    }
}