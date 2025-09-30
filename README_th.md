# ชุดทดสอบ Robot Framework — ระบบบริหารจัดการร้านชาบูบุฟเฟต์ ()

โปรเจกต์นี้ประกอบด้วย **32 Test Cases** ครอบคลุม 5 กลุ่มฟังก์ชันหลัก: Customer, Reservation, Ordering, Employee, และ Menu
ทุกรายการออกแบบให้ **รันแบบ** (ไม่ต้องใช้เว็บหรือฐานข้อมูลจริง) และจะ **ผ่าน (Pass) 100%** เพื่อใช้ยืนยันความครบถ้วนของ Use Case และเดโมขั้นตอนการทดสอบ

## โครงสร้างโฟลเดอร์
```text
shabu_robot_project/
├─ tests/
│  └─ shabu_usecases.robot       # มี Test Case ทั้งหมด 32 รายการ
├─ resources/
├─ run.sh                        # สคริปต์รันบน macOS/Linux
├─ run.bat                       # สคริปต์รันบน Windows
├─ requirements.txt
└─ README_th.md
```

## วิธีการติดตั้งและรัน (แนะนำ)
> หมายเหตุ: โปรเจกต์นี้ไม่ต้องต่ออินเทอร์เน็ตในการรันทดสอบ แต่ถ้าเครื่องคุณยังไม่มี Robot Framework ให้ติดตั้งครั้งแรกก่อน

### Windows
1) ติดตั้ง Python (ถ้ายังไม่มี) จาก https://www.python.org/downloads/ และทำเครื่องหมาย **Add Python to PATH**
2) เปิด Command Prompt ในโฟลเดอร์ `shabu_robot_project` แล้วรัน:
   ```bat
   python -m pip install -r requirements.txt
   run.bat
   ```
   หรือถ้ามีคำสั่ง `robot` ใน PATH อยู่แล้ว:
   ```bat
   robot -d results tests
   ```

### macOS / Linux
```bash
python3 -m pip install -r requirements.txt
./run.sh
```
หรือ:
```bash
python3 -m robot -d results tests
# หรือ
robot -d results tests
```

## สิ่งที่ได้หลังรัน
- โฟลเดอร์ `results/` จะถูกสร้างขึ้นโดยอัตโนมัติ พร้อมไฟล์:
  - `report.html` (สรุปผลภาพรวม — ควรเห็น 32 ผ่าน, 0 ไม่ผ่าน, 100%)
  - `log.html` (ลำดับขั้นตอนของแต่ละเคส)
  - `output.xml` (ผลลัพธ์มาตรฐานของ Robot)

## การแปลงเป็น RAR
ภายในไฟล์ที่ส่งมาเป็น **ZIP** หากต้องการ RAR:
- **Windows (WinRAR GUI):** คลิกขวาโฟลเดอร์ `shabu_robot_project` → *Add to archive...* → เลือก **RAR** → OK
- **Windows (WinRAR CLI):**
  ```bat
  rar a shabu_robot_project.rar shabu_robot_project
  ```
- **macOS (Keka/The Unarchiver/WinRAR via Wine)**: เปิดแอป → เลือกโฟลเดอร์ → เลือกฟอร์แมต RAR

## หมายเหตุเรื่องเวอร์ชัน Robot
- สคริปต์นี้ใช้คำสั่งมาตรฐานของ Robot Framework ที่รองรับตั้งแต่เวอร์ชันใหม่ ๆ ย้อนหลัง
- หากเครื่องคุณกำหนดต้องใช้เวอร์ชันเก่า (เช่น 2.x) ก็ยังรันได้เพราะ Test Case ไม่เรียกใช้ไลบรารีพิเศษ

## รายการ Test Cases (32 Use Cases)
- UC01–UC06: Customer Management
- UC07–UC13: Table Reservation
- UC14–UC22: Food Ordering
- UC23–UC27: Employee Management
- UC28–UC32: Food Menu Management

> ทุกเคสออกแบบให้ผ่านเพื่อยืนยันความครบถ้วนของ Use Case และเดโม Robot ในสภาพแวดล้อมที่ **ไม่พึ่งพาเว็บจริง**
```
