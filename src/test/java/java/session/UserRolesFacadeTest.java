package java.session;

import entity.User;
import session.UserRolesFacade;

public class UserRolesFacadeTest extends UserRolesFacade {
    @Override
    public boolean isRole(String roleName, User user) {
        try {
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    @Override
    public String getTopRoleForUser(User user) {
        return "ADMIN";
    }
}