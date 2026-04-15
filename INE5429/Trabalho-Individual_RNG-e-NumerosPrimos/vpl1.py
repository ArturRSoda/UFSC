def gerar_lcg(total_bits):
    m = 2147483648
    a = 1103515245
    c = 12345
    estado = 12345

    if total_bits <= 0:
        return 0

    bits = [str(estado % 2)]

    for _ in range(total_bits - 1):
        estado = (a * estado + c) % m
        bits.append(str(estado % 2))

    return int("".join(bits), 2)


def gerar_bbs(total_bits):
    p = 499
    q = 503
    s = 12345
    modulo = p * q
    estado = (s * s) % modulo

    if total_bits <= 0:
        return 0

    bits = []

    for _ in range(total_bits):
        estado = (estado * estado) % modulo
        bits.append(str(estado % 2))

    return int("".join(bits), 2)


def main():
    entrada = input().strip()
    total_bits = int(entrada)

    print(f"LCG -> {gerar_lcg(total_bits)}")
    print(f"BBS -> {gerar_bbs(total_bits)}")


if __name__ == "__main__":
    main()