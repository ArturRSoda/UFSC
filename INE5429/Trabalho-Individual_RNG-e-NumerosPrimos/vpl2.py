def mdc(a, b):
    while b != 0:
        a, b = b, a % b
    return abs(a)


def teste_fermat(a, n):
    if n < 2:
        return False

    if n in (2, 3):
        return True

    if mdc(a, n) != 1:
        return False

    return pow(a, n - 1, n) == 1


def teste_miller_rabin(a, n):
    if n < 2:
        return False

    if n in (2, 3):
        return True

    if n % 2 == 0:
        return False

    if mdc(a, n) != 1:
        return False

    m = n - 1
    k = 0

    while m % 2 == 0:
        m //= 2
        k += 1

    x = pow(a, m, n)

    if x == 1 or x == n - 1:
        return True

    for _ in range(k - 1):
        x = pow(x, 2, n)
        if x == n - 1:
            return True

    return False


def formatar_resultado(resultado):
    if resultado:
        return "Provavelmente primo"
    return "Composto"


def main():
    a, n = map(int, input().split())

    resultado_fermat = teste_fermat(a, n)
    resultado_miller_rabin = teste_miller_rabin(a, n)

    print(f"Fermat {n} -> {formatar_resultado(resultado_fermat)}")
    print(f"Miller-Rabin {n} -> {formatar_resultado(resultado_miller_rabin)}")

    if resultado_fermat and resultado_miller_rabin:
        conclusao = "provavelmente primo"
    else:
        conclusao = "composto"

    print(f"Resultado final: {n} é {conclusao}")


if __name__ == "__main__":
    main()