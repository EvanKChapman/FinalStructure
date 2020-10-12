package com.study.tool.model;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.*;


@Table(name="accounts")
@Entity
public class Users {
	
	
	
	@Id 
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private String lname;
	private String fname;
	private String password;
	private String email; 
	private String image;
	private String role;
	@Transient
	private String password2;
	
	@OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
	private Addresses address;
	
	
	public Set<Role> getRoles() {
		return roles;
	}
	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private List<PaymentMethod> paymentMethod;
	
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private Set<PhoneBook> PhoneBook;

	
	@ManyToMany(cascade = CascadeType.DETACH )
	@JoinTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"),
	    inverseJoinColumns = @JoinColumn(name = "role_id"))
	    private Set<Role> roles =new HashSet <Role>();

	
	@OneToMany(mappedBy="users_id", cascade=CascadeType.ALL)
	private List<Products> products;
	
	

	
	
	public Addresses getAddress() {
		return address;
	}
	public void setAddress(Addresses address) {
		this.address = address;
	}
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public List<Products> getProducts() {
		return products;
	}
	public void setProducts(List<Products> products) {
		this.products = products;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword2() {
		return password2;
	}
	public void setPassword2(String password2) {
		this.password2 = password2;
	}
	
	
	public Set<PhoneBook> getPhoneBook() {
		return PhoneBook;
	}
	public void setPhoneBook(Set<PhoneBook> phoneBook) {
		PhoneBook = phoneBook;
	}
	
	
	
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public List<PaymentMethod> getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(List<PaymentMethod> paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	
	
	
	@Override
	public String toString() {
		return "Users [id=" + id + ", lname=" + lname + ", fname=" + fname + ", password=" + password + ", email="
				+ email + ", image=" + image + ", role=" + role + ", password2=" + password2 + ", address=" + address
				+ ", paymentMethod=" + paymentMethod + ", PhoneBook=" + PhoneBook + ", roles=" + roles + ", products="
				+ products + "]";
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}

}
