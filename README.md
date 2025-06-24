# RISCV-CPU-Design
Bu ödev, Verilog dili kullanılarak bir **tek çevrim RISC-V işlemci tasarımı ve genişletilmesi** adımlarını içermektedir. Tasarımlar testbench'lerle doğrulanmış ve GtkWave çıktıları ile desteklenmiştir.

---

## Temel RISC-V İşlemci Tasarımı 

- **Desteklenen komutlar:** `lw`, `sw`, `add`, `sub`, `slt`, `or`, `and`, `beq`, `addi`, `slti`, `ori`, `andi`, `jal`
- **Kullanılan kaynak:** *Digital Design and Computer Architecture – RISC-V Edition* (Harris & Harris)
- **Dosyalar:**
  - `processor_q1.v`: Verilog işlemci tasarımı
  - `processor_q1_tb.v`: Testbench dosyası
  - `processor_q1.vcd`: GtkWave simülasyon çıktısı

---

## `sll` Komutu ile Genişletme 

- İşlemci, `sll` (Shift Left Logical) komutunu destekleyecek şekilde güncellenmiştir.
- Blok diyagramı çizilmiş, kontrol sinyalleri ve veri yolları güncellenmiştir.
- **Dosyalar:**
  - `processor_q2.v`: `sll` destekleyen genişletilmiş işlemci
  - `processor_q2_tb.v`: Testbench dosyası
  - `processor_q2.vcd`: GtkWave çıktısı

---

## `lui` Komutu ile Genişletme 

- İşlemci, `lui` (Load Upper Immediate) komutunu destekleyecek şekilde yeniden güncellenmiştir.
- - Gerekli kontrol yolları ve veri yolları yeniden düzenlenmiştir.
- **Dosyalar:**
  - `processor_q3.v`: `lui` destekli nihai işlemci tasarımı
  - `processor_q3_tb.v`: Testbench dosyası
  - `processor_q3.vcd`: Simülasyon çıktısı

---


