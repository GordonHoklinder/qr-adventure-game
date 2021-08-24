import re
import os
from typing import List

ALPHABET = r"aábcčdďeéěfghiíjklmnňoópqrřsštťuúůvwxyýzžAÁBCČDĎEÉĚFGHIÍJKLMNŇOÓPQRŘSŠTŤUÚŮVWXYÝZŽ'„“-.,?!/:{}()|& "
quotes = "'"
escaper = "|"
funcChar = "&"
separator = ","
underscore = "-"

def encoded(raw: str) -> str:
    """Encode the string."""
    raw = preprocess(raw)
    return "".join(
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


def closingBracesPosition(text: str, position: int, opening: str, closing: str):
    depth = 0
    insideQuotes = False
    for i in range(position, len(text)):
        if text[position] == quotes:
            insideQuotes = not insideQuotes
        if not insideQuotes:
            if text[i] == opening:
                depth+=1
            elif text[i] == closing:
                depth-=1
        if depth == 0:
            return i
    raise ValueError("There's no matching closing brace.")


def assertPosition(position: int, text: str):
    if position == len(text):
        raise ValueError("There's no matching closing quote.")


def getText(text: str, position: int):
    ret = ""
    position += 1
    assertPosition(position, text)
    while text[position] != quotes:
        if text[position] == escaper:
            position += 1
        assertPosition(position, text)
        ret += text[position]
        position += 1
        assertPosition(position, text)
    return [ret, position + 1]


def getFunction(text: str, position: int, filename: str):
    """Get the function name and its parameters."""
    openingBracesPos = position;
    while text[openingBracesPos] != "(":
        openingBracesPos+=1
    closingBracesPos = closingBracesPosition(text, openingBracesPos, "(", ")")
    name = text[position + 1:openingBracesPos]
    params = text[openingBracesPos + 1 : closingBracesPos].split(separator)
    openingBracesPos = closingBracesPos + 1
    if openingBracesPos != len(text) and text[openingBracesPos] == "{":
        closingBracesPos = closingBracesPosition(text, openingBracesPos, "{", "}")
        code = text[openingBracesPos + 1 : closingBracesPos]
        params.append(code)
        check(code, filename)
    return [name, params, closingBracesPos + 1]


def preprocess(raw: str) -> str:
    """Preprocess the file."""
    raw = re.sub(r"\s+", " ", raw)
    raw = re.sub(r"[‘’]", "'", raw)
    inQuotes = False
    ret = ""
    i = 0
    while i < len(raw):
        if raw[i] == quotes:
            res = getText(raw, i)
            i = res[1] - 1
            ret += quotes + res[0] + quotes
        elif raw[i] == underscore:
            ret += " "
        elif raw[i] != " ":
            ret += raw[i]
        i+=1
    return ret


items = []
needed = []

def add(item: str):
    items.append(item)


def need(item: str, filename):
    needers = re.split('[\|\&!]', item)
    for needer in needers:
        if needer:
            needed.append((needer, filename))

funcs = {
    "add" : 1,
    "remove": 1,
    "if" : 2,
    "option" : 2,
    "title" : 2,
    "entry" : 2
}

def check(code: str, name: str):
    """Check if the code has no errors."""
    try:
        code = preprocess(code)
        position = 0
        while position < len(code):
            if code[position] == quotes:
                position = getText(code, position)[1]
            elif code[position] == funcChar:
                res = getFunction(code, position, name)
                if res[0] not in funcs:
                    raise ValueError(f"Function {res[0]} does not exist.")
                if len(res[1]) != funcs[res[0]]:
                    raise ValueError(f"Function ${res[0]} was called with ${len(res[1])} arguments, but {funcs[res[0]]} were expected.")
                if res[0] == "if":
                    need(res[1][0], name)
                if res[0] == "remove":
                    need(res[1][0], name)
                if res[0] == "add":
                    add(res[1][0])
                if res[0] == "title":
                    add(res[1][1])
                position = res[2]
            else:
                raise ValueError(f"Unexpected character {code[position]}.")
    except ValueError as e:
        print(f"ERROR: In file {filename}, the following parsing error was found: {e}")


files = []

path = input("Enter your folder path:")


# Load files.
for file_path in os.listdir(path):
    if file_path.endswith(".txt"):
        complete_path = os.path.join(path, file_path)
        file = open(complete_path, "r")
        files.append([file.read(), complete_path])
        file.close()

# Check for parsing errors.
for code, filename in files:
    check(code, filename)

# Check for unadded items.
for needer, filename in needed:
    if needer not in items:
        print(f"WARNING: In file {filename}, the item {needer} was found in if/remove function, but was not found in any add/title function in any other file.")

# Encode files.
for i in range(len(files)):
    files[i][0] = encoded(files[i][0])

# Check for weird chars.
for file, filename in files:
    for char in file:
        if not "0" <= char <= "9":
            print(f"WARNING: In file {filename}, unencoded character {char}")

# Write qr codes.
for file, filename in files:
    write_file = open(filename[:-4] + "_encoded.txt", "w")
    write_file.write(file)
    write_file.close()
    print(f"SUCCESS: File {filename} encoded.")

