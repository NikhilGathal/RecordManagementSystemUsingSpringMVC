package RecordManagementSystem.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.StringJoiner;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import RecordManagementSystem.dao.StudentDao;
import RecordManagementSystem.dto.Student;
import RecordManagementSystem.dao.StudentDao;
import RecordManagementSystem.dto.Student;

import org.hibernate.exception.DataException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.ServletContext;
import java.util.ArrayList;
import java.util.List;

@Controller
public class StudentController {

	@Autowired
	private StudentDao studentDao;

	@Autowired
	private ServletContext servletContext; // For accessing context parameters

	@PostMapping("/signup")
	public String signup(@RequestParam("name") String name, @RequestParam("address") String address,
			@RequestParam("email") String email, @RequestParam(value = "course1", required = false) String course1,
			@RequestParam(value = "course2", required = false) String course2,
			@RequestParam(value = "course3", required = false) String course3,
			@RequestParam(value = "course4", required = false) String course4, @RequestParam("fees") int paidFees,
			@RequestParam("phone") long phone, Model model) {

		// Collect courses
		List<String> courses = new ArrayList<>();
		if (course1 != null)
			courses.add(course1);
		if (course2 != null)
			courses.add(course2);
		if (course3 != null)
			courses.add(course3);
		if (course4 != null)
			courses.add(course4);

		// Calculate fees and course string
		int totalFees = 0;
		int remainingFees = 0;
		StringBuilder courseString = new StringBuilder();

		for (String course : courses) {
			totalFees += Integer.parseInt(servletContext.getInitParameter(course));
			courseString.append(course).append(",");
		}

		if (paidFees <= totalFees) {
			remainingFees = totalFees - paidFees;
		}

		// Remove trailing comma from course string
		String finalCourseString = courseString.length() > 0 ? courseString.substring(0, courseString.length() - 1)
				: "";

		// Populate Student DTO
		Student student = new Student();
		student.setName(name);
		student.setAddress(address);
		student.setEmail(email);
		student.setPhone(phone);
		student.setCourse(finalCourseString);
		student.setFees(totalFees);
		student.setPaidfees(paidFees);
		student.setRemainfees(remainingFees);

		// Check if email already exists
		  List<Student> existingStudents = studentDao.getAllStudents();
		    
		    // Only check for email duplicates if there are existing students
		    if (!existingStudents.isEmpty()) {
		        boolean emailExists = existingStudents.stream().anyMatch(st -> st.getEmail().equals(email));

		        if (emailExists) {
		            // Email exists; return to signup page with an error message
		            model.addAttribute("message", "Student already exists");
		            return "signup.jsp";
		        }
		    }
		    
		    studentDao.saveStudent(student);

		    // Redirect to the display page
		    return "redirect:/display";
	}

	@PostMapping("/login")
	public String login(@RequestParam("email") String email, @RequestParam("password") String password,
			RedirectAttributes redirectAttributes, Model model) {

		// Check if email is correct
		if (!"nikhilgathal@gmail.com".equals(email)) {
			model.addAttribute("message", "Invalid email address.");
			return "login.jsp"; // Stay on login page if email is incorrect
		}
		// Check if password is correct
		else if (!"@Nikhil77".equals(password)) {
			model.addAttribute("message", "Invalid password.");
			return "login.jsp"; // Stay on login page if password is incorrect
		}
		// Successful login
		else {
			return "redirect:/display"; // Redirect to the display page on successful login
		}
	}

	@RequestMapping("/update")
	public ModelAndView updateStudent(@RequestParam int id) {
		ModelAndView modelAndView = new ModelAndView();
		Student student = studentDao.getStudentById(id);
		modelAndView.addObject("student", student);
		modelAndView.addObject("message", "Welcome to edit page");
		modelAndView.setViewName("edit.jsp");
		return modelAndView;
	}

	@RequestMapping("/edit")
	public String editStudent(HttpServletRequest req, @ModelAttribute Student student,
			RedirectAttributes redirectAttributes ,@RequestParam("email") String email ,Model model) {
		// Log the incoming student data for debugging
		System.out.println("Editing student: " + student);
		ServletContext servletContext = req.getServletContext();

		int totalFees = 0;
		int paidFees = Integer.parseInt(req.getParameter("paidfees"));
		System.out.println("paidfees is " + paidFees);

		// Get the selected courses using getParameterValues to handle multiple
		// selections

		String course1 = req.getParameter("course1");
		System.out.println("course is " + course1);
		String course2 = req.getParameter("course2");
		System.out.println("course is " + course2);
		String course3 = req.getParameter("course3");
		System.out.println("course is " + course3);
		String course4 = req.getParameter("course4");
		System.out.println("course is " + course4);

		List<String> c1 = new ArrayList<String>();
		c1.add(course1);
		c1.add(course2);
		c1.add(course3);
		c1.add(course4);
		StringJoiner courseJoiner = new StringJoiner(",");

		// Loop through courses and add them to StringJoiner
		for (String c : c1) {
		    if (c != null) {
		        courseJoiner.add(c); // Automatically handles commas
		        System.out.println("course " + c + " " + Integer.parseInt(servletContext.getInitParameter(c)));
		        totalFees += Integer.parseInt(servletContext.getInitParameter(c));
		    }
		}

		// Get the final joined string of courses
		String cour = courseJoiner.toString();
		student.setCourse(cour);

		// Calculate remaining fees
		int remainingFees = totalFees - paidFees;
		student.setFees(totalFees);
		student.setRemainfees(remainingFees);

		// Log the calculated fees
		System.out.println("Total fees: " + totalFees);
//		System.out.println("Remaining fees: " + remainingFees);
		System.out.println("Email is " + email);
		  List<Student> existingStudents = studentDao.getAllStudents();
		    
		    // Only check for email duplicates if there are existing students
		  
//		  boolean emailExists = existingStudents.stream()
//			        .anyMatch(st -> !st.getEmail().equals(student.getEmail()) && st.getEmail().equals(email));
		  boolean emailExists = existingStudents.stream().anyMatch(st -> st.getEmail().equals(email));     
		  if(existingStudents.size() > 1)
		  {
			  if (emailExists) {
		        	
	        	  model.addAttribute("message", "Email already exists");
	        	return "edit.jsp";
	        	
	        }
	        else
	        {
	        	studentDao.updateStudent(student); // Update the student in the database
				redirectAttributes.addFlashAttribute("list", studentDao.getAllStudents()); // Add the updated list
				return "redirect:/display"; // Redirect to the display page
	        }
	  
		  }
		  else
		  {
			  studentDao.updateStudent(student); // Update the student in the database
				redirectAttributes.addFlashAttribute("list", studentDao.getAllStudents()); // Add the updated list
				return "redirect:/display"; // Redirect to the display page
		  }
		  
	}

	@RequestMapping("/display")
	public ModelAndView displayStudents() {
		ModelAndView modelAndView = new ModelAndView();

		List<Student> students = null;
		try {
			// Attempt to fetch the student list from the database
			students = studentDao.getAllStudents();
		} catch (Exception e) {
			// If the database cannot be accessed or doesn't exist, you can log the error or
			// handle it accordingly
			students = new ArrayList<>(); // Set an empty list if there is an issue
		}

		// Add the student list (or empty list) to the model
		modelAndView.addObject("list", students);

		// Set the view name to the display page
		modelAndView.setViewName("display.jsp");

		return modelAndView;
	}

	@RequestMapping("/delete")
	public String deleteStudent(@RequestParam int id, RedirectAttributes redirectAttributes) {
		// Delete the student
		System.out.println("student is deleted");
		studentDao.deleteStudent(id);
		// Add the updated list to the redirect attributes
		redirectAttributes.addFlashAttribute("list", studentDao.getAllStudents());
		// Redirect to the display page
		return "redirect:/display";
	}

}
