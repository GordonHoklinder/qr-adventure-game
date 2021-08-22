import re

ALPHABET = r"aábcčdďeéěfghiíjklmnňoópqrřsštťuúůvwxyýzžAÁBCČDĎEÉĚFGHIÍJKLMNŇOÓPQRŘSŠTŤUÚŮVWXYÝZŽ'„“-.,?!/:{}()|& "

raw = []
while(True):
    try:
        raw.append(input())
    except:
        raw = " ".join(raw)
        print()
        raw = re.sub(r"\s+", " ", raw)
        raw = "".join(
            [
                (
                    ("0" if ALPHABET.index(x) < 10 else "")
                    +
                    str(ALPHABET.index(x))
                )
                if x in ALPHABET
                else(
                    ("99" + x)
                    if "0" <= x <= "9"
                    else
                    x
                )
                for x in raw
            ]
        )
        print(raw)
        break

