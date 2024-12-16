package RecordManagementSystem.dao;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Query;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.PersistenceException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import RecordManagementSystem.dto.*;

@Repository
public class StudentDao {

	@Autowired
	private EntityManager entityManager;

	public void saveStudent(Student student) {
	EntityTransaction entityTransaction=entityManager.getTransaction();
	entityTransaction.begin();
	entityManager.persist(student);
	entityTransaction.commit();
		
	}

	public List<Student> getAllStudents() {
		
		    try {
		        // Try fetching the students from the database
		        Query query = entityManager.createQuery("select s from Student s");
		        return query.getResultList();
		    } catch (PersistenceException  e) {
		        // Log the exception if necessary (optional)
		        System.out.println("Error: Table not found or empty database.");
		        // Return an empty list or handle the error as needed
		        return new ArrayList<>();
		    }
	}

	public void deleteStudent(int id) {
		Student dbStudent=entityManager.find(Student.class, id);
		EntityTransaction entityTransaction=entityManager.getTransaction();
		entityTransaction.begin();
		entityManager.remove(dbStudent);
		entityTransaction.commit();
	}

	public Student getStudentById(int id) {
		Student dbStudent=entityManager.find(Student.class, id);
		return dbStudent;
	}

	public void updateStudent(Student student) {
		EntityTransaction entityTransaction=entityManager.getTransaction();
		entityTransaction.begin();
		entityManager.merge(student);
		entityTransaction.commit();
		
	}


}























