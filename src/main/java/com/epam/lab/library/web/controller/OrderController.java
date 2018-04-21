package com.epam.lab.library.web.controller;

import com.epam.lab.library.domain.*;
import com.epam.lab.library.service.BookService;
import com.epam.lab.library.service.OrderService;
import com.epam.lab.library.service.UserService;
import com.epam.lab.library.service.impl.DataBaseUserDetailService;
import com.epam.lab.library.service.impl.LocalizationController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

import static com.epam.lab.library.domain.Status.*;

@Controller
public class OrderController {

    @Autowired
    private BookService bookService;

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private DataBaseUserDetailService detailsService;

    @RequestMapping("/lib/requested-books")
    public String librarianRequestsForBooksIssue(Model model,
                                                 @RequestParam(value = "lang", defaultValue = "en_US") String language,
                                                 @RequestParam(value = "lang_changed", defaultValue = "false") boolean lang_changed) {
        List<Order> orders = orderService.getAllOrderByStatus(REQUESTED);
        model.addAttribute("orders", orders);
        if (lang_changed) {
            LocalizationController.setLang(language);
        }
        model.addAttribute("language", LocalizationController.getLang());
        return "librarian/requestedBooks";
    }

    @RequestMapping("/lib/returned-books")
    public String librarianGivenBooks(Model model,
                                      @RequestParam(value = "lang", defaultValue = "en_US") String language,
                                      @RequestParam(value = "lang_changed", defaultValue = "false") boolean lang_changed) {
        List<Order> orders = orderService.getAllOrderByStatus(GIVEN);
        model.addAttribute("orders", orders);
        if (lang_changed) {
            LocalizationController.setLang(language);
        }
        model.addAttribute("language", LocalizationController.getLang());
        return "librarian/returnedBooks";
    }

    @RequestMapping(value = "/books/give/{id}", method = RequestMethod.POST)
    public String giveBook(Model model,
                           @PathVariable("id") Long id,
                           @RequestParam(value = "lang", defaultValue = "en_US") String language,
                           @RequestParam(value = "lang_changed", defaultValue = "false") boolean lang_changed) {
        orderService.setBookStatus(GIVEN, id);
        if (lang_changed) {
            LocalizationController.setLang(language);
        }
        model.addAttribute("language", LocalizationController.getLang());
        return "redirect:/lib/requested-books";
    }

    @RequestMapping(value = "/books/return/{id}", method = RequestMethod.POST)
    public String returnBook(Model model,
                             @PathVariable("id") Long id,
                             @RequestParam(value = "lang", defaultValue = "en_US") String language,
                             @RequestParam(value = "lang_changed", defaultValue = "false") boolean lang_changed) {
        orderService.setBookStatus(IN_LIBRARY, id);
        if (lang_changed) {
            LocalizationController.setLang(language);
        }
        model.addAttribute("language", LocalizationController.getLang());
        return "redirect:/lib/returned-books";
    }

    @RequestMapping(value = "/books/request/{id}", method = RequestMethod.POST)
    public String requestBook(@PathVariable("id") Long bookId,
                              @RequestParam("location") Location location, Model model,
                              @RequestParam(value = "lang", defaultValue = "en_US") String language,
                              @RequestParam(value = "lang_changed", defaultValue = "false") boolean lang_changed) {
        Order order = new Order(null, null, bookId, location, Status.REQUESTED);
        Order orderCreated = orderService.requestBook(order);
        if (lang_changed) {
            LocalizationController.setLang(language);
        }
        model.addAttribute("language", LocalizationController.getLang());
        if (orderCreated.getId() == null) {
            model.addAttribute("alreadyRequested", true);
            Book book = bookService.getBook(bookId);
            model.addAttribute("book", book);
            model.addAttribute("role", detailsService.getRole());
            return "common/viewBook";
        } else {
            return "redirect:/user/orders/";
        }
    }

    @RequestMapping("/user/orders")
    public String userOrders(Model model,
                             @RequestParam(value = "lang", defaultValue = "en_US") String language,
                             @RequestParam(value = "lang_changed", defaultValue = "false") boolean lang_changed) {
        User user = userService.getUserByLogin(detailsService.getCurrentUsername());
        List<Order> orders = orderService.getAllUserOrders(user.getId());
        model.addAttribute("orders", orders);
        if (lang_changed) {
            LocalizationController.setLang(language);
        }
        model.addAttribute("language", LocalizationController.getLang());
        return "user/userOrders";
    }

    @RequestMapping(value = "/user/delete-request", method = RequestMethod.POST)
    public String returnBook(Model model,
                             @RequestParam("orderId") Long orderId, @RequestParam("bookId") Long bookId,
                             @RequestParam(value = "lang", defaultValue = "en_US") String language,
                             @RequestParam(value = "lang_changed", defaultValue = "false") boolean lang_changed) {
        if (lang_changed) {
            LocalizationController.setLang(language);
        }
        model.addAttribute("language", LocalizationController.getLang());
        orderService.deleteRequest(orderId, bookId);
        return "redirect:/user/orders";
    }

}