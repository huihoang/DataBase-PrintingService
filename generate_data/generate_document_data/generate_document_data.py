import random

# Các giá trị giả lập
file_types = ["PDF", "DOCX", "JPG", "TXT"]
file_names = ["Doc", "File", "Report", "Image"]

# Hàm tạo dữ liệu ngẫu nhiên
def generate_random_document(student_index, doc_index):
    doc_id = f"D{student_index * 100 + doc_index:04d}"
    file_type = random.choice(file_types)
    file_name = f"{random.choice(file_names)}{doc_index}.{file_type.lower()}"
    print_log_id = None  # PrintLogId có thể là NULL hoặc một giá trị hợp lệ
    customer_id = f"C{student_index:03d}"

    if print_log_id is None:
        return f"('{doc_id}', '{file_name}', '{file_type}', NULL, '{customer_id}')"
    else:
        return f"('{doc_id}', '{file_name}', '{file_type}', {print_log_id}, '{customer_id}')"

# Tạo dữ liệu cho 50 sinh viên đầu tiên, mỗi sinh viên 20 tài liệu
num_students = 50
num_documents_per_student = 20
values = []

for student_index in range(1, num_students + 1):
    for doc_index in range(1, num_documents_per_student + 1):
        values.append(generate_random_document(student_index, doc_index))

values_script = ",\n".join(values)

insert_script = f"-- Thêm dữ liệu vào bảng Document\nINSERT INTO PrintService.Document (Id, FileName, FileType, PrintLogId, CustomerId)\nVALUES \n{values_script};"

# Ghi vào tệp
with open("insert_documents.sql", "w", encoding="utf-8") as file:
    file.write(insert_script)

print("Tệp insert_documents.sql đã được tạo với dữ liệu cho 50 sinh viên đầu tiên.")
