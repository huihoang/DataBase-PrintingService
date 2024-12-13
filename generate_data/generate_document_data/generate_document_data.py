import random
import datetime

# Các giá trị giả lập
file_types = ["PDF", "DOCX", "JPG", "TXT"]
file_names = ["Document", "Report", "File", "Image"]

# Hàm tạo dữ liệu ngẫu nhiên
def random_date(start_date, end_date):
    delta = end_date - start_date
    random_days = random.randint(0, delta.days)
    return start_date + datetime.timedelta(days=random_days)

def generate_random_document(student_index, doc_index):
    doc_id = f"D{student_index * 100 + doc_index:04d}"
    created_at = random_date(datetime.date(2024, 1, 1), datetime.date(2024, 12, 31)).strftime("%Y-%m-%d %H:%M:%S")
    file_type = random.choice(file_types)
    file_name = f"{random.choice(file_names)}{doc_index}.{file_type.lower()}"
    print_log_id = None
    num_of_page = random.randint(1, 500)
    customer_id = f"C{student_index:03d}"

    if print_log_id is None:
        return f"('{doc_id}', '{created_at}', '{file_name}', '{file_type}', NULL, {num_of_page}, '{customer_id}')"
    else:
        return f"('{doc_id}', '{created_at}', '{file_name}', '{file_type}', {print_log_id}, {num_of_page}, '{customer_id}')"

# Tạo dữ liệu cho 50 sinh viên đầu tiên, mỗi sinh viên 20 tài liệu
num_students = 50
num_documents_per_student = 20
values = []

for student_index in range(1, num_students + 1):
    for doc_index in range(1, num_documents_per_student + 1):
        values.append(generate_random_document(student_index, doc_index))

values_script = ",\n".join(values)

insert_script = f"-- Thêm dữ liệu vào bảng Document\nINSERT INTO PrintService.Document (Id, CreatedAt, FileName, FileType, PrintLogId, NumOfPage, CustomerId)\nVALUES \n{values_script};"

# Ghi vào tệp
with open("insert_documents.sql", "w", encoding="utf-8") as file:
    file.write(insert_script)

print("Tệp insert_documents.sql đã được tạo với dữ liệu cho 50 sinh viên đầu tiên.")
