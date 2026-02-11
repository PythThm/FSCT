def cbc_encrypt(plaintext, salt, shift):
    def char_to_int(c):
        return ord(c) - ord("a")
    
    def int_to_char(i):
        return chr(i + ord("a"))

    ciphertext = ""
    prev = salt

    for i in plaintext:
        p = char_to_int(i)
        c = (p + shift + prev) % 26
        ciphertext += int_to_char(c)
        prev = c

    return ciphertext     

plaintext = "graffiti"
salt = 4
shift = 9

x = cbc_encrypt(plaintext, salt, shift)
print(x)