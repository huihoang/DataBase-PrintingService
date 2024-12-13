import random

# Các giá trị giả lập
room_names = [f"Room {i:03d}" for i in range(101, 151)]  # 50 phòng
building_names = ["Building A", "Building B", "Building C", "Building D", "Building E"]
campus_names = ["Campus X", "Campus Y", "Campus Z"]
printer_brands = ["Canon", "HP", "Epson", "Brother", "Samsung"]
statuses = ["Active", "Inactive", "Moved"]

# Hàm tạo dữ liệu ngẫu nhiên cho PrinterLocation
def generate_random_location(index):
    room_name = room_names[index - 1]
    building_name = random.choice(building_names)
    campus_name = random.choice(campus_names)
    return f"('{room_name}', '{building_name}', '{campus_name}')"

# Hàm tạo dữ liệu ngẫu nhiên cho Printer
def generate_random_printer(index, location_id):
    brand_name = random.choice(printer_brands)
    status = random.choice(statuses)
    return f"('{brand_name}', '{status}', {location_id})"

# Tạo dữ liệu cho bảng PrinterLocation
num_locations = 50
location_values = [generate_random_location(i) for i in range(1, num_locations + 1)]

# Tạo dữ liệu cho bảng Printer, mỗi vị trí có 2 máy in
printer_values = []
for location_id in range(1, num_locations + 1):
    for printer_index in range(2):  # 2 máy in mỗi vị trí
        printer_values.append(generate_random_printer(printer_index, location_id))

# Tạo script chèn dữ liệu
location_insert_script = f"-- Thêm dữ liệu vào bảng PrinterLocation\nINSERT INTO InfoPrinter.PrinterLocation (RoomName, BuildingName, CampusName)\nVALUES \n{',\n'.join(location_values)};"

printer_insert_script = f"-- Thêm dữ liệu vào bảng Printer\nINSERT INTO InfoPrinter.Printer (BrandName, Status, LocationId)\nVALUES \n{',\n'.join(printer_values)};"

# Ghi dữ liệu vào tệp
with open("insert_printer_location.sql", "w", encoding="utf-8") as file:
    file.write(location_insert_script)

with open("insert_printer.sql", "w", encoding="utf-8") as file:
    file.write(printer_insert_script)

print("Tệp insert_printer_location.sql và insert_printer.sql đã được tạo.")
