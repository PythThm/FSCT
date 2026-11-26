## 1. Review: Image Metadata

Metadata is not harmless. It can introduce several security and privacy risks.
- Privacy leakage: Metadata can reveal sensitive information.
- Covert storage: Metadata can be used to store hidden information.
- Exploitation vulnerabilities: Malicious metadata can trigger vulnerabilities.
- Untrusted input: Secure systems should treat metadata as untrusted input
### Can metadata reveal AI-generated images?
Metadata can provide clues about whether an image was generated using AI, but it is not automatic proof.

| Metadata type            | What it can reveal                                      |
| ------------------------ | ------------------------------------------------------- |
| Ordinary metadata        | Software, AI tools, models, prompts, or workflows       |
| Missing metadata         | May indicate export, screenshot, conversion, or sharing |
| Signed provenance (C2PA) | Signed claims about image creation and editing          |

Important forensic considerations:
- Metadata can be edited or fabricated.
- Missing metadata does not prove human creation.
- C2PA Content Credentials provide signed provenance claims.
- Signatures and the identity of the signer should be verified.
- Signed claims are not guarantees that the information is true.
Forensic rule: Corroborate metadata with signature verification and other evidence.
## 2. Definition of Steganography
Steganography is the art and science of communicating in a way that hides the existence of a message.

The word comes from two Greek words:
- Steganos: Covered or concealed.
- Graphy: Writing.
- 
Steganography takes one piece of secret information and hides it within another piece of information, called the carrier or cover.
### Example
An image may look completely normal to someone viewing it, but it can contain a hidden message encoded within its pixel values.

The person viewing the image may not even realize that a secret message exists.
### Why is steganography used?
Cybercriminals can use steganography to conceal communications during criminal activities, including:
- Terrorism.
- Botnet management.
- Data exfiltration.
- Concealed communication between attackers.
## 3. Cryptography vs. Steganography
Both techniques protect information, but they have different purposes.

|Cryptography|Steganography|
|---|---|
|Protects the contents of a message.|Conceals the existence of a message.|
|Converts plaintext into ciphertext.|Hides information inside a carrier.|
|The encrypted message may be visible.|The hidden message is intended to remain unnoticed.|
|Requires decryption to understand the message.|Requires extraction or decoding to reveal the message.|

Example:
- Cryptography: Someone intercepts an encrypted message but cannot understand its contents.
- Steganography: Someone intercepts an image without realizing it contains a hidden message.
### Combining both techniques
Cryptography and steganography can be used together.
1. Encrypt a secret message.
2. Hide the resulting ciphertext inside an image.
3. The recipient extracts the ciphertext.
4. The recipient decrypts it using the appropriate key.
5. 
This provides two layers of protection:
- Steganography hides the existence of the communication.
- Cryptography protects the contents of the communication.
## 4. Types of Steganograph
There are several ways to hide information depending on the carrier medium.

|Type|Description|
|---|---|
|Image steganography|Hides data within image pixels. Most common type.|
|Audio steganography|Hides data using sound changes that are undetectable by the human ear.|
|Video steganography|Hides information within video frames. Offers large data capacity because of the high number of frames.|
|Text steganography|Hides messages using whitespace, font variations, or compression representations.|
|Network steganography|Hides data within network protocol headers, such as TCP/IP.|

### Spatial Domain
The spatial domain refers to the actual pixels of an image.

A steganographer can insert secret information directly into the pixel values of a cover image.

For example:
- An image contains RGB pixel values.
- The pixel values are slightly modified.
- These modifications encode the secret message.
- The resulting image should look almost identical to the original.
## 5. Least Significant Bit (LSB) Steganography
Important exam topic
- LSB (Least Significant Bit) is a common image steganography technique.
- It works by modifying the least significant bit of pixel values to encode secret information.

### Understanding binary values
Every byte contains 8 bits.
Example:
```
Binary:  00100111
Decimal: 39
```

The least significant bit is the rightmost bit.
```
0010011[1]
         ↑
        LSB
```

Changing the LSB modifies the value by only 1.

For example:
```
Original: 00100111 = 39
Modified: 00100110 = 38
```

The difference is only 1, which generally creates a very small change in pixel color.

This makes LSB useful for hiding information without creating noticeable visual distortions.

### Why use the LSB?
- Small changes to pixel values.
- Difficult to notice visually.
- Allows information to be hidden inside images.
- Simple to implement programmatically.
## 6. Pixel Structure (RGB)
A standard RGB image uses three color channels:
- R = Red
- G = Green
- B = Blue
Each channel contains 8 bits (1 byte).

Therefore:

| Component       | Size    |
| --------------- | ------- |
| Red             | 8 bits  |
| Green           | 8 bits  |
| Blue            | 8 bits  |
| Total per pixel | 24 bits |

Each pixel contains 3 bytes.

When using LSB steganography, one bit can be hidden in each color channel.
```
Red:   1010101[0]
Green: 1100110[1]
Blue:  1110001[0]
```
This means 3 bits of secret information can be stored per RGB pixel when using one LSB per channel.
### RGBA images
RGBA adds another channel:
- R = Red
- G = Green
- B = Blue
- A = Alpha (transparency)

Each channel is 8 bits.

Total = 32 bits per pixel.

Using one LSB in every channel provides 4 bits of hiding capacity per pixel.
## 7. Data Capacity
The amount of information that can be hidden depends on the number of pixels and channels used.
### RGB capacity formula
For an RGB image:
\[ \text{Capacity (bits)} = W \times H \times 3 \]

Where:
- W = Image widths
- H = Image height.
- 3 = Number of RGB channels.

To calculate whole bytes:

\[ \text{Capacity (bytes)} = \left\lfloor \frac{W \times H \times 3}{8} \right\rfloor \]

For RGBA using all four channels:

\[ \text{Capacity (bits)} = W \times H \times 4 \]

Important: Subtract any space used by a terminator or length header.

### Example: 40 × 30 RGB image
Given:
- Width = 40 pixels.
- Height = 30 pixels.
- 3 RGB channels.
- 1 LSB per channel.

Step 1: Calculate total pixels.
\[ 40 \times 30 = 1200 \]

Step 2: Calculate bit capacity.
\[ 1200 \times 3 = 3600 \text{ bits} \]

Step 3: Convert to bytes.
\[ 3600 / 8 = 450 \text{ bytes} \]

Step 4: Subtract the null terminator (1 byte).
\[ 450 - 1 = 449 \text{ bytes} \]

Answer: 449 bytes

If only the red channel is used:
\[ 40 \times 30 \times 1 = 1200 \text{ bits} \]
\[ 1200 / 8 = 150 \text{ bytes} \]

After subtracting the null terminator:
\[ 150 - 1 = 149 \text{ bytes} \]
### Capacity vs. distortion
There is a trade-off:
- More hidden data = More bits modified.
- More bits modified = Greater risk of image distortion.
- Higher capacity can make steganography easier to detect.
## 8. Encoding and Decoding Process
### Encoding (Hiding a Message)
Encoding is the process of inserting secret information into the cover image.
General process:
1. Take the secret message.
2. Convert each character into binary.
3. Modify the LSBs of the image's pixel values.
4. Store the message bits inside the pixels.
5. Save the modified image as the output.
Example: Character `A`

```
Character: A
ASCII:     65
Binary:    01000001
```

The binary representation is inserted into the image's pixel values.

### Decoding (Extracting a Message)
Decoding is the reverse process.
1. Open the image containing the hidden message.
2. Read the LSB from the relevant pixel channels.
3. Reconstruct the binary sequence.
4. Convert the binary sequence back into characters.
5. Stop when the null character is encountered (if using a null terminator).
Example:

```
01000001
```

Converting this binary value back to ASCII produces:

```
A
```

## 9. Leveraging RGB Channels to Hide Information
Consider hiding the character `A` inside a color image.
The character `A` is represented by 8 bits:
```
01000001
```

If one bit is stored in each RGB channel, each pixel can store 3 bits.

Therefore, 3 pixels are required to store one 8-bit character when using one LSB per channel.
### Example of modifying a pixel
Original pixel:
```
R: 00100111
G: 11101001
B: 11001000
```

Modified pixel:
```
R: 00100110
G: 11101001
B: 11001000
```

- Only the red channel's LSB changed.
- The original red value was 39, and the modified red value is 38.
- The difference is only 1, so the visual change is generally very difficult to notice.

## 10. What Happens When Other Bits Are Modified?
Not all bits have the same impact on the pixel value.
Each bit position represents a different numerical value.

| Bit position | Value |
| ------------ | ----- |
| Bit 0 (LSB)  | 1     |
| Bit 1        | 2     |
| Bit 2        | 4     |
| Bit 3        | 8     |
| Bit 4        | 16    |
| Bit 5        | 32    |
| Bit 6        | 64    |
| Bit 7 (MSB)  | 128   |

LSB vs. MSB:
- LSB modifications produce the smallest numerical changes.
- MSB modifications produce the largest numerical changes.
- Modifying more significant bits creates more noticeable image distortion.
### Example: Binary value 10101100
Original binary:
```
10101100 = 172
```

| Modified bit     | New binary | New decimal | Absolute difference |
| ---------------- | ---------- | ----------- | ------------------- |
| Flip bit 0 (LSB) | 10101101   | 173         | 1                   |
| Flip bit 3       | 10100100   | 164         | 8                   |
| Flip bit 7 (MSB) | 00101100   | 44          | 128                 |

Remember: The more significant the modified bit, the greater the potential visual distortion.
### Capacity and noise
- More bits used for hiding = Higher capacity.
- More bits used for hiding = Higher noise and distortion.
- LSB modifications are generally less noticeable than modifications to more significant bits.
## 11. What Kind of Data Can Be Hidden?
Pretty much anything that can be represented as binary data.
Examples include:
- Text messages.
- Images.
- Files.
- Encrypted data.
- Arbitrary binary sequences.

Steganography is not limited to hiding readable text.
Encrypted information can also be hidden inside an image.

## 12. Python Implementation of LSB
The lecture introduces four core functions for implementing LSB steganography.

|Function|Purpose|
|---|---|
|`set_LSB()`|Modifies the least significant bit to store information.|
|`get_LSB()`|Extracts the least significant bit from a value.|
|`hide_message()`|Hides a message inside an image.|
|`extract_message()`|Retrieves the hidden message from an image.|

### Important functions
1. `set_LSB()`
	- Takes a pixel value and a bit to hide.
	- Changes the pixel value's LSB.
	- Preserves the other bits.
2. `get_LSB()`
	- Reads the least significant bit.
	- Used during message extraction.
3. `hide_message()`
	- Converts characters into 8-bit binary.
	- Modifies pixel values to store the message.
	- Saves the modified image.
4. `extract_message()`
	- Reads the LSBs from pixel values.
	- Reconstructs the binary message.
	- Converts binary back into characters.
## 13. Pixel Pair Strategy
The lecture also introduces a pixel pair strategy.

Instead of using three RGB pixels for one character, this approach uses two pixels per character.
- Each character contains 8 bits.
- Each pixel contributes 4 bits using RGBA.
- Two pixels provide 8 bits in total.
### Hiding the message
1. Convert the character into 8-bit binary.
2. Divide the binary into two groups of 4 bits.
3. Modify the pixel pairs.
4. Append any remaining pixels unchanged.
### Extracting the message
1. Read the LSBs from the pixel pairs.
2. Reconstruct the 8-bit character.
3. Convert binary into text.
4. Stop when the null character is found.

The lecture describes the resulting image as visually identical, with the hidden message fully recoverable.
## 14. Python Tools for Steganography
The lecture introduces three approaches to implementing steganography in Python.
### 1. Pillow (PIL)
- Manual implementation.
- Allows direct manipulation of pixel tuples.
- Useful for understanding how LSB steganography works internally.
### 2. Stegano
CLI-based tool
- Specialized command-line LSB tool.
- Can hide and reveal text.
- Can hide and reveal secret images inside PNG files.
### 3. Stepic
Python module
- Provides a streamlined Python implementation.
- Uses two main functions:

| Function   | Purpose                                    |
| ---------- | ------------------------------------------ |
| `encode()` | Hides information inside an image.         |
| `decode()` | Extracts hidden information from an image. |

## 15. Key Takeaways
1. Steganography hides the existence of a message rather than just protecting its contents.
2. Cryptography protects message contents, while steganography conceals communication.
3. Steganography can use images, audio, video, text, and network protocols.
4. LSB is a common technique that hides information by modifying the least significant bit of pixel values.
5. RGB images have 3 channels, with 8 bits per channel (24 bits per pixel).
6. RGBA images have 4 channels, with 8 bits per channel (32 bits per pixel).
7. Using one LSB per RGB channel allows 3 hidden bits per pixel.
8. Modifying the LSB creates smaller visual changes than modifying more significant bits.
9. Increasing the amount of hidden data increases the potential for image distortion.
10. Hidden payloads can contain text, images, files, encrypted data, or arbitrary binary information.
11. Python tools include Pillow, Stegano, and Stepic.
## 16. Quick Exam Review
These are the concepts worth being able to explain or calculate without referring to the notes.

| Question                                  | Answer                                             |
| ----------------------------------------- | -------------------------------------------------- |
| What is steganography?                    | Hiding the existence of a message.                 |
| What is cryptography?                     | Protecting the contents of a message.              |
| What does LSB stand for?                  | Least Significant Bit.                             |
| Where is the LSB located?                 | Rightmost bit of a binary value.                   |
| How many bits are in an RGB pixel?        | 24 bits.                                           |
| How many bits are in an RGBA pixel?       | 32 bits.                                           |
| How many bits can RGB store using LSB?    | 3 bits per pixel.                                  |
| How many bits can RGBA store using LSB?   | 4 bits per pixel.                                  |
| Which bit causes the least distortion?    | LSB.                                               |
| Which bit causes the greatest distortion? | MSB.                                               |
| What does `set_LSB()` do?                 | Modifies the LSB.                                  |
| What does `get_LSB()` do?                 | Extracts the LSB.                                  |
| What is a null terminator?                | A zero byte used to indicate the end of a message. |
| What does Stegano do?                     | Hides and reveals text and images.                 |
| What does Stepic use?                     | `encode()` and `decode()`.                         |

### Important formulas to memorize

RGB capacity:

\[ W \times H \times 3 \text{ bits} \]

RGB capacity in bytes:

\[ \left\lfloor \frac{W \times H \times 3}{8} \right\rfloor \]

RGBA capacity:

\[ W \times H \times 4 \text{ bits} \]

Absolute difference:

\[ |\text{Original value} - \text{Modified value}| \]
