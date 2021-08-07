ALPHABET1 = [c for c in "aábcčdďeéĕfghiíjklmnňoópqrřsštťuúůvwxyýzžAÁBCČDĎEÉĚFGHIÍJKLMNŇOÓPQRŘSŠTŤUÚŮVWXYÝZŽ.,?{}()'$_"]
ALPHABET2 = [c for c in "GHz(QLŮČOí?ťfPg{žĎŠĕár_aÚyRNYEňŽŤDŘi.úkZpšmý'ctó,SeéXůAÁčsvwI)xKVBjTdU}qWÝ$ÍĚÉlhÓoŇCFnMJbuřď"]

raw = []
while(True):
    try:
        raw.append(input())
    except:
        raw = " ".join(raw)
        encoded = "".join([
            ALPHABET2[ALPHABET1.index(c)] if c in ALPHABET1 else c
            for c in raw
        ])
        print(encoded)
        break

