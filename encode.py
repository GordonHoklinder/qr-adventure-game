KEY = [6, 3, 10, 2, 4, 8, 9, 5, 7, 1]

raw = []
while(True):
    try:
        raw.append(input())
    except:
        raw = " ".join(raw)
        print(raw)
        encoded = "".join([
            chr((KEY[i % len(KEY)] + max(0, ord(x) - 32)) % 95 + 32) for i, x in enumerate(raw)
        ])
        print()
        print(encoded)
        break

