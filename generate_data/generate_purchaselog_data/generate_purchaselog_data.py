import random
import datetime

# Hàm tạo dữ liệu ngẫu nhiên
def random_date(start_date, end_date):
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    return start_date + datetime.timedelta(days=random_days)

def generate_random_purchase_log(customer_id):
    transaction_time = random_date(datetime.date(2024, 1, 1), datetime.date(2024, 12, 31)).strftime("%Y-%m-%d")
    number_of_page = random.randint(1, 50)  # Số lượng trang ngẫu nhiên
    price = number_of_page * 200  # Giá mỗi trang là 200đ
    purchase_status = random.choice(["Success", "Failed"])

    return f"('{transaction_time}', {number_of_page}, {price:.2f}, '{purchase_status}', '{customer_id}')"

# Tạo tập lệnh INSERT
num_customers = 10
num_logs_per_customer = 100
values = []

for customer_index in range(1, num_customers + 1):
    customer_id = f"C{customer_index:03d}"
    for _ in range(num_logs_per_customer):
        values.append(generate_random_purchase_log(customer_id))

values_script = ",\n".join(values)

insert_script = f"-- Thêm dữ liệu vào bảng PurchaseLog\nINSERT INTO PrintService.PurchaseLog (TransactionTime, NumberOfPage, Price, PurchaseStatus, CustomerId)\nVALUES \n{values_script};"

# Ghi vào tệp
with open("insert_purchase_log.sql", "w", encoding="utf-8") as file:
    file.write(insert_script)

print("Tệp insert_purchase_log.sql đã được tạo với 1000 dòng INSERT.")
