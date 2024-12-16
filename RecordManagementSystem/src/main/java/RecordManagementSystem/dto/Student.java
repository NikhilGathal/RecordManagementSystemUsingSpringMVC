package RecordManagementSystem.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Student {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String name;
	private String address;
	private String email;
	private String course;
	private long phone;
	private int fees;
	private int paidfees;
	private int remainfees;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCourse() {
		return course;
	}
	public void setCourse(String course) {
		this.course = course;
	}
	public long getPhone() {
		return phone;
	}
	public void setPhone(long phone) {
		this.phone = phone;
	}
	public int getFees() {
		return fees;
	}
	public void setFees(int fees) {
		this.fees = fees;
	}
	public int getPaidfees() {
		return paidfees;
	}
	public void setPaidfees(int paidfees) {
		this.paidfees = paidfees;
	}
	public int getRemainfees() {
		return remainfees;
	}
	public void setRemainfees(int remainfees) {
		this.remainfees = remainfees;
	}
	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + ", address=" + address + ", email=" + email + ", course="
				+ course + ", phone=" + phone + ", fees=" + fees + ", paidfees=" + paidfees + ", remainfees="
				+ remainfees + "]";
	}
	


}
