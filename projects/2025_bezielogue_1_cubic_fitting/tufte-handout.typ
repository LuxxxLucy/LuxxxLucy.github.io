// This is Jialin's handout template
// which starts as a tweak of the tufte handout of https://github.com/jwhear/tufte-handout
// The main point is tufte's handout layout which split the paper into two column:
// one for main text and one for the margin note. (see grid->columns in `let template` definition below)
//
// Layout:
// +-------------------------------------+
// |                    |                |
// |                    |                |
// |                    |                |
// |  Main content      |  Margin notes  |
// |  (~65% width)      |  (~35% width)  |
// |                    |                |
// |                    |                |
// |                    |                |
// +-------------------------------------+

// Spacer so that main content and notes don't rub up against each other
#let main-margin-space-gap = 0.7in

// Size of the right "margin" (note area)
#let margin-size = 35%
// Size of the left "main" (content area)
#let main-size = 65%
// we use margin-note-size to bleed out the column for margin.

//
// Inserts a margin note containing `content`
//  `dy` can be used to adjust the note content vertically
//
#let margin-note(content) = {
    place(
        right,
        dx: margin-size+main-margin-space-gap,
        dy: -4.5em,
        block(width: margin-size, {
            set text(size: 0.65em, font: "Gill Sans", style: "italic")
            set align(left)
            content
        })
    )
}

// only enabled when "debug" is used as argument
// such as "typst comiple <...> --input debug=on"
// otherwise the content in the debug note will not be displayed
#let debug-note(content) = {
    if sys.inputs.keys().contains("debug") {
        block(width: 100%, {
            set text(size: 0.75em, style: "italic", fill: rgb(0,0,255))
            set align(left)
            v(-0.4em)
            h(3em)
            content
        })
    }
}


// Inserts a mian note containing `content` (in the left column, main content column)
// `dy` can be used to adjust the note content vertically
#let main-note(content) = {
    pad(left: 0.5em,
        block(width: 100%, {
            set text(size: 0.75em, font: "Gill Sans", style: "italic")
            set align(left)
            content
        })
    )
    v(0.5em)
}

// Renders `content` with the module's text styling.
//  This is useful for content that is outside of the `template` container but which should be visually consistent.
#let apply-text-styles(content) = {
    show heading.where(level: 1): it => text(
        weight: "extralight",
        size: 1.2em,
        style: "italic",
        {
            v(0.5em)
            h(-0.1em)
            it.body
            v(-0.5em)
        }
    )
    show heading.where(level: 2): it => text(
        weight: "extralight",
        size: 1em,
        style: "italic",
        {
            v(0.4em)
            it.body
            v(0.1em)
        }
    )

    // Lists
    set enum(
      indent: 1em,
      body-indent: 1em,
    )
    show enum: set par(justify: true)
    set list(
      indent: 1em,
      body-indent: 1em,
    )
    show list: set par(justify: true)
    content
}

#let show_header(title, name: none, date: none, email: none) = {
    block(width: 100%)[
        #h(-0.1em)
        #text(weight: "regular", 1.8em, font: "Gill Sans")[#title]
        #if name != none {
            v(0.3em)
            text(0.7em, font: "Gill Sans")[#name]
        }
        #if email != none {
            text(0.7em, font: "Gill Sans")[#h(1.2em) #email]
        }
        #if date != none {
            text(0.7em, font: "Gill Sans")[#h(1.2em) #date]
        }
        #v(1em)
    ]
}

// Call to wrap `doc` in the handout layout
//  `title` will be rendered in the page header
//  `wrapper` should be either `none` or a function that takes `doc` and returns
//    content.  This can be used to inject custom styles.
//
#let template(
    title: none,
    name: none,
    email: none,
    date: none,
    wrapper: apply-text-styles,
    doc,
) = {
    // the page header does not
    set page(
        header: if title != none {
            set text(size: 5pt, weight: "semibold", tracking: 1.25pt, font: ("Berkeley Mono"))
            h(1fr)
            upper(title)
            v(2.5em)
        },
        margin: (x: 8%, y: 2cm),
        width: 21.0cm,
        height: 230cm
    )

    // Set main text size to 9pt
    set text(size: 9pt, font: "Inter")
    show link: underline
    set math.equation(numbering: "(1)")
                
    // Show header if provided
    show_header(title, name: name, email: email, date: date)
    grid(
        columns: (main-size, margin-size),
        gutter: main-margin-space-gap,
        {
            wrapper(doc)
        }
    )
}

#let citet(..citation) = {
  cite(..citation, form: "prose")
}
#let citep(..citation) = {
  cite(..citation, form: "normal")
}

#let box(contents) = {
  rect(
    fill: rgb(242,242,242), 
    stroke: 0.5pt,
    width: 100%,
    align(center)[#contents]
  )
}

// Style for figure captions
#let figure-caption(content) = {
  set text(size: 0.7em, style: "italic")
  align(center)[#content]
}

// helper:
// no numbering block equation
#let nonumeq(eq) = math.equation(block: true, numbering: none, eq)
// numbering block equation.
#let numeq(eq) = math.equation(block: true, numbering: none, eq)