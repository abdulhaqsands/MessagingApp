const JWT = require("jsonwebtoken");

class TokenService {
  constructor(secretKey) {
    if (!secretKey) throw new Error("secretKey must have a value");
    this.secretKey = secretKey;
  }

  generate_access_token = (id, role) => {
    return JWT.sign({ id, role }, this.secretKey, { expiresIn: "3d" });
  };

  generate_refresh_token = (id, role) => {
    return JWT.sign({ id, role }, this.secretKey, { expiresIn: "3d" });
  };

  verify_access_token = (access_token) => {
    try {
      return JWT.verify(access_token, this.secretKey);
    } catch (error) {
      return null; // invalid or expired token
    }
  };

  refresh_access_token(refreshToken) {
    try {
      const decoded = JWT.verify(refreshToken, this.secretKey);
      return {
        access_token: this.generate_access_token(decoded.id, decoded.role),
        refresh_token: this.generate_refresh_token(decoded.id, decoded.role),
      };
    } catch (error) {
      return null;
    }
  }
}

module.exports = TokenService;
