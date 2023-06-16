import random

with open("memory_binary.txt", "w") as file:
    file.write("// 0x00000000000000  --4bit op1, 2bit opr, 4bit op2, 4bit Expected Result\n")
    for i in range(100):
        a = random.randint(0, 15)
        b = random.randint(0, 15)
        op = random.choice(["+", "-", "*", "/"])
        if op == "+":
            sum = a + b
            binary = bin(sum)
            binary = binary[2:]
            end = len(binary)
            if (sum<8):
                decimal_num = int(binary, 2)
            else:
                start = end + 1 - 5
                binary = binary[start : end+1]
                decimal_num = int(binary, 2)
            file.write("{0:04b}00{1:04b}{2:04b}\n".format(a, b, decimal_num))
        elif op == "-":
            diff = a - b
            if (diff >= 0) :
                binary = bin(diff)
                binary = binary[2:]
                decimal_num = int(binary, 2)
                file.write("{0:04b}01{1:04b}{2:04b}\n".format(a, b, decimal_num))
            else:
                diff = abs(diff)
                diff = (1 << 4) - diff
                binary = bin(diff)
                if (diff <8):
                    decimal_num = int(binary, 2)
                else:
                    binary = binary[2:]
                    end = len(binary)
                    start = end + 1 - 5
                    binary = binary[start : end+1]
                    decimal_num = int(binary, 2)
                file.write("{0:04b}01{1:04b}{2:04b}\n".format(a, b, decimal_num))
        elif op == "*":
            prod = a * b
            binary = bin(prod)
            binary = binary[2:]
            end = len(binary)
            start = end + 1 - 5
            binary = binary[start : end+1]
            decimal_num = int(binary, 2)
            file.write("{0:04b}10{1:04b}{2:04b}\n".format(a, b, decimal_num))
        elif op == "/":
            if b == 0:
                b = 1
            quotient = a // b
            remainder = a % b
            quotient_str = "{0:04b}".format(quotient)
            file.write("{0:04b}11{1:04b}{2}\n".format(a, b, quotient_str))