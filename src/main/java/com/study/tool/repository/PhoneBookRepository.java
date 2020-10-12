package com.study.tool.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.study.tool.model.PhoneBook;

public interface PhoneBookRepository extends JpaRepository<PhoneBook, Long> {

}
