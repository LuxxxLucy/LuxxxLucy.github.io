#lang pollen

◊(define-meta title            "The problem: how we end up in reality")
◊(define-meta doc-publish-date "2022-04-01")
◊(define-meta author           "Jialin Lu")
◊(define-meta summary          "")



Designing fonts is an expensive job in terms of man-hour, and even more expensive for Chinese fonts.

Font design is both about rationally make decisions to ensure consistency as well as paying attention the nuances of very subtle details to create visual delusions to meet the eye.
1. Rational

While designing font for a Latin Alphabet-based language is already time consuming, Chinese fonts which includes a much large set of target characters to design multiply the man-hour by at least 1000 times.


A little bit context here. 

Written Chinese (to some extent CJKV) uses logographic symbols. 

As contrary to languages that use an alphabet to compose a relatively small set characters into syllables and then into the words, the logographic writing system relies on a huge ton of ten thousands of characters which are already words that convey some semantic meaning. 
the written system gradually develops to serve as a written medium where different pronunciations/speaks can be stacked on, including the various Sinitic languages (or by Beijing's perspective, dialects) and to some lesser extent Japanese and Korean.
The good thing about this system is that it democratizes the composition and invention of new words by combining several characters to an easy and common maneuver, and these new words are readily understandable by a second person without the need to lookup dictionary.

◊strong{However, regarding the making of font, the logogram-based system is a costly business}, and has been such for a long time before the digital age.◊note{Even though the Chinese invented movable type printing in 11-th century, the movable type system never really help the Chinese in advancing the printing industry, because the massive character set is a costly asset to maintain, unlike Gutenberg's case of alphabet which eventually boosted the printing press. An alphabet-based writing system makes much much more economical sense than a logographic system.
}
The big problem of a massive set of these logograms.
Each glyph needs to be implemented, the typographical consideration such as consistency enforces the designer to spend way more effort.
The time and human working need for a Chinese and English font.
Objectively speaking, a logogram-based system does not make much economical sense as it is easier to manage a alphabet of some 50 letters, than manage 10000 logographic glyphs.


This disadvantageous situation does not stopped there, though, it continue to exist in the digital age.

Font is important as ever in the digital age in the visual display of texts. Yet the main problem for Chinese fonts is that
1. there aren't so many fonts
2. all of the fonts are, strictly speaking, incomplete.

The main problem is the large size of the character set. 
A reasonable commercial font would need around 5000, while the remaining glyphs is absent, so make the font incomplete.
in special cases like in specific entity, historically used yet deprecate in modern times, professional usage in historical and literature materials, as well as newly invented characters.
It is very common to in real life to encounter cases where one or two character is not supported in a typeface.
Very few fonts managed to provide more than 60000, only one seem to cover the entirety of all UTF standard Chinese characters (though it is the Japanese variation, Kanji, which has a lot of minor differences), and they all are very boring and dull. And that is why in a lot of cases, people will still choose to use incomplete fonts because of its aesthetic value.

This first stage's goal is to provide such a way to produce reasonably well designed rare characters from a target typeface.

◊margin-note{Disclaimer: The legal implication of this application is complicated and I certainly do not want to get any trouble. Here I state that I do not intend to make commercial use of it; will not help anyone gaining such; and will report to the rightful owner of the font shall any misdeed occur and be discovered by myself.}
