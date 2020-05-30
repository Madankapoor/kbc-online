-- -----------------------------------------------------
-- Schema kbc
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `kbc` ;

-- -----------------------------------------------------
-- Schema kbc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kbc` DEFAULT CHARACTER SET utf8 ;
USE `kbc` ;

-- -----------------------------------------------------
-- Table `kbc`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kbc`.`user` ;

CREATE TABLE IF NOT EXISTS `kbc`.`user` (
  `id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `points` INT NULL,
  PRIMARY KEY (`id`))
;

CREATE UNIQUE INDEX `email_UNIQUE` ON `kbc`.`user` (`email` ASC);


-- -----------------------------------------------------
-- Table `kbc`.`question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kbc`.`question` ;

CREATE TABLE IF NOT EXISTS `kbc`.`question` (
  `id` INT NOT NULL,
  `question` VARCHAR(255) NULL,
  `option1` VARCHAR(45) NULL,
  `option2` VARCHAR(45) NULL,
  `option3` VARCHAR(45) NULL,
  `option4` VARCHAR(45) NULL,
  `answer` INT NULL,
  PRIMARY KEY (`id`))
;


-- -----------------------------------------------------
-- Table `kbc`.`vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kbc`.`vendor` ;

CREATE TABLE IF NOT EXISTS `kbc`.`vendor` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
;


-- -----------------------------------------------------
-- Table `kbc`.`reward`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kbc`.`reward` ;

CREATE TABLE IF NOT EXISTS `kbc`.`reward` (
  `id` INT NOT NULL,
  `points_threshold` INT NULL,
  `vendor_id` INT NOT NULL,
  `coupon_type` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `vendor_id`),
  CONSTRAINT `fk_reward_vendor1`
    FOREIGN KEY (`vendor_id`)
    REFERENCES `kbc`.`vendor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX `fk_reward_vendor1_idx` ON `kbc`.`reward` (`vendor_id` ASC);


-- -----------------------------------------------------
-- Table `kbc`.`user_answers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kbc`.`user_answers` ;

CREATE TABLE IF NOT EXISTS `kbc`.`user_answers` (
  `question_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `choice` INT NULL,
  PRIMARY KEY (`question_id`, `user_id`),
  CONSTRAINT `fk_question_has_user_question`
    FOREIGN KEY (`question_id`)
    REFERENCES `kbc`.`question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `kbc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX `fk_question_has_user_user1_idx` ON `kbc`.`user_answers` (`user_id` ASC);

CREATE INDEX `fk_question_has_user_question_idx` ON `kbc`.`user_answers` (`question_id` ASC);


-- -----------------------------------------------------
-- Table `kbc`.`user_has_reward`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kbc`.`user_has_reward` ;

CREATE TABLE IF NOT EXISTS `kbc`.`user_has_reward` (
  `user_id` INT NOT NULL,
  `reward_id` INT NOT NULL,
  `reward_vendor_id` INT NOT NULL,
  `coupon` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`, `reward_id`, `reward_vendor_id`),
  CONSTRAINT `fk_user_has_reward_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `kbc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_reward_reward1`
    FOREIGN KEY (`reward_id` , `reward_vendor_id`)
    REFERENCES `kbc`.`reward` (`id` , `vendor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

CREATE INDEX `fk_user_has_reward_reward1_idx` ON `kbc`.`user_has_reward` (`reward_id` ASC, `reward_vendor_id` ASC);

CREATE INDEX `fk_user_has_reward_user1_idx` ON `kbc`.`user_has_reward` (`user_id` ASC);
