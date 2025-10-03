package br.com.fiap.governance.controller;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;

@RestController
public class AuthController {

    private final String secretKey = "W3r3a!*@w91UvkNl7rPs09zc?LmQyx#t";

    @PostMapping("/empresa")
    public String login(@RequestParam String username, @RequestParam String password) {
        if ("RM557696".equals(username) && "fiap25".equals(password)) {
            return Jwts.builder()
                    .setSubject(username)
                    .setIssuedAt(new Date())
                    .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 60))
                    .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                    .compact();
        }
        throw new RuntimeException("Credenciais inválidas");
    }
}
