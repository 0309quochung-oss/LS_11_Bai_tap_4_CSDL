DROP PROCEDURE IF EXISTS GetPatientDebt;

DELIMITER //

CREATE PROCEDURE GetPatientDebt(
    IN p_patient_id INT,
    IN p_phone VARCHAR(20),
    OUT p_total_debt DECIMAL(15,2),
    OUT p_message VARCHAR(100)
)
BEGIN

    DECLARE v_count INT;

    -- Trường hợp NULL cả 2
    IF p_patient_id IS NULL AND p_phone IS NULL THEN

        SET p_total_debt = 0;
        SET p_message = 'Lỗi: Vui lòng nhập ID hoặc số điện thoại';

    ELSE

        -- Tìm theo ID
        IF p_patient_id IS NOT NULL THEN

            SELECT COUNT(*)
            INTO v_count
            FROM Patients
            WHERE patient_id = p_patient_id;

            IF v_count > 0 THEN

                SELECT total_debt
                INTO p_total_debt
                FROM Patients
                WHERE patient_id = p_patient_id;

                SET p_message = 'Tra cứu thành công';

            ELSE

                SET p_total_debt = 0;
                SET p_message = 'Không tìm thấy bệnh nhân';

            END IF;

        -- Tìm theo Phone
        ELSE

            SELECT COUNT(*)
            INTO v_count
            FROM Patients
            WHERE phone = p_phone;

            IF v_count > 0 THEN

                SELECT total_debt
                INTO p_total_debt
                FROM Patients
                WHERE phone = p_phone;

                SET p_message = 'Tra cứu thành công';

            ELSE

                SET p_total_debt = 0;
                SET p_message = 'Không tìm thấy bệnh nhân';

            END IF;

        END IF;

    END IF;

END //

DELIMITER ;
