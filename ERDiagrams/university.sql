-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`faculties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`faculties` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `departament_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`courses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `students_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`professors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `course_id` INT NOT NULL,
  `courses_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_professors_courses1_idx` (`courses_id` ASC),
  CONSTRAINT `fk_professors_courses1`
    FOREIGN KEY (`courses_id`)
    REFERENCES `university`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`departaments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`departaments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `proffesor_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `faculties_id` INT NOT NULL,
  `professors_id` INT NOT NULL,
  `courses_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_departaments_faculties1_idx` (`faculties_id` ASC),
  INDEX `fk_departaments_professors1_idx` (`professors_id` ASC),
  INDEX `fk_departaments_courses1_idx` (`courses_id` ASC),
  CONSTRAINT `fk_departaments_faculties1`
    FOREIGN KEY (`faculties_id`)
    REFERENCES `university`.`faculties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departaments_professors1`
    FOREIGN KEY (`professors_id`)
    REFERENCES `university`.`professors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departaments_courses1`
    FOREIGN KEY (`courses_id`)
    REFERENCES `university`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`students` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `faculty_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `faculties_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_students_faculties1_idx` (`faculties_id` ASC),
  CONSTRAINT `fk_students_faculties1`
    FOREIGN KEY (`faculties_id`)
    REFERENCES `university`.`faculties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`students_has_courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`students_has_courses` (
  `students_id` INT NOT NULL,
  `courses_id` INT NOT NULL,
  PRIMARY KEY (`students_id`, `courses_id`),
  INDEX `fk_students_has_courses_courses1_idx` (`courses_id` ASC),
  INDEX `fk_students_has_courses_students_idx` (`students_id` ASC),
  CONSTRAINT `fk_students_has_courses_students`
    FOREIGN KEY (`students_id`)
    REFERENCES `university`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_has_courses_courses1`
    FOREIGN KEY (`courses_id`)
    REFERENCES `university`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
