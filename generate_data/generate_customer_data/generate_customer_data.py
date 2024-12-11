import random
import datetime

# Các giá trị FamilyName, GivenName
family_names = ["Nguyen", "Tran", "Le", "Pham", "Hoang", "Phan", "Vu", "Dang", "Bui", "Do", "Ho", "Ngo", "Duong", "Ly"]
given_names = ["Customer1", "Customer2", "Customer3", "Customer4", "Customer5", "Customer6", "Customer7", "Customer8", "Customer9", "Customer10"]

# Hàm tạo dữ liệu ngẫu nhiên
def random_date(start_date, end_date):
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    return start_date + datetime.timedelta(days=random_days)

def generate_random_insert_customer(index):
    id_value = f"C{index:03d}"

    phone_number = f"012400{index:04d}"
    email = f"customer{index}@example.com"
    password = "password123"
    last_login = random_date(datetime.date(2024, 1, 1), datetime.date(2024, 12, 31)).strftime("%Y-%m-%d")

    family_name = random.choice(family_names)
    given_name = f"Customer{index}"
    role = "Customer"
    student_code = f"ST{index:03d}"

    # Nếu index bé hơn bằng 100 thì current_page = 0, ngược lại 1000
    current_page = 0 if index <= 100 else 1000

    return f"('{id_value}', '{phone_number}', '{email}', '{password}', '{last_login}', '{family_name}', '{given_name}', '{role}', '{student_code}', {current_page})"

# Tạo tập lệnh INSERT
num_records = 999
values = ",\n".join(generate_random_insert_customer(i) for i in range(1, num_records + 1))

insert_script = f"-- Thêm dữ liệu vào bảng Customer\nINSERT INTO InfoUser.Customer (Id, PhoneNumber, Email, Password, LastLogin, FamilyName, GivenName, Role, StudentCode, CurrentPage)\nVALUES \n{values};"

# Ghi vào tệp
with open("insert_customer.sql", "w", encoding="utf-8") as file:
    file.write(insert_script)

print("Tệp insert_customer.sql đã được tạo với 999 dòng INSERT.")