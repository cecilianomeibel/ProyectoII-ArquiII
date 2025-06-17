import random 

NUM_WORDS = 256

with open("SRAM_DATA_tb.txt", "w") as f:
    for _ in range(NUM_WORDS):
        data = random.randint(0, 0xFFFF)
        f.write(f"{data:04X}\n")
    f.close()
    print("Tb data created")