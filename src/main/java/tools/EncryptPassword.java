package tools;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

public interface EncryptPassword {
    String createSalt();

    String createHash(String password, String salt);
}
