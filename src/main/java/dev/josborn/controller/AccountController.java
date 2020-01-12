package dev.josborn.controller;

import javax.validation.Valid;

import dev.josborn.authentication.AuthProvider;
import dev.josborn.authentication.JwtTokenHandler;
import dev.josborn.authentication.UnauthorizedException;
import dev.josborn.authentication.UserCreationException;
import dev.josborn.model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * AccountController
 */
@CrossOrigin
@RestController
public class AccountController {
    @Autowired
    private AuthProvider auth;

    @Autowired
    private JwtTokenHandler tokenHandler;

    @RequestMapping(path = "/login", method = RequestMethod.POST)
    public String login(@RequestBody User user, RedirectAttributes flash) throws UnauthorizedException {
    	
    	
        if (auth.signIn(user.getUsername(), user.getPassword())) {
            User currentUser = auth.getCurrentUser();
            return tokenHandler.createToken(user.getUsername(), currentUser.getRole());
        } else {
            throw new UnauthorizedException();
        }
    }

    @RequestMapping(path = "/register", method = RequestMethod.POST)
    public String register(@Valid @RequestBody User user, BindingResult result) throws UserCreationException {

        if (result.hasErrors()) {
            String errorMessages = "";
            
            for (ObjectError error : result.getAllErrors()) {
                errorMessages += error.getDefaultMessage() + "\n";
            }
            throw new UserCreationException(errorMessages);
        }
        auth.register(user.getUsername(), user.getPassword(), user.getRole());
        return "{\"success\":true}";
    }
    
    
    //user changing password
    @RequestMapping(path = "/changePassword", method = RequestMethod.POST)
    public String changePassword(@RequestBody User user) throws UserCreationException {
    	
        auth.changePassword(user.getUsername(), user.getPassword(), user.getNewPassword());
        return "{\"success\":true}";
    }

}