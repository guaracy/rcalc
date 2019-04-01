Red [ needs: 'view]

ch-valido: charset "0123456789()."
op-valida: charset "+-*/"
BS: #"^H"
π: pi

Rnd: func[n][random n]

calcula: func[][
    attempt [
        eq: yes
        res: form math to block! load v/text 
        c: copy v/text
        append c rejoin [" = " res]
        append l/data c
        append clear v/text res
    ]
]

visor-insere: func[c][
    if eq [clear v/text] eq: no append v/text c
]
visor-limpa: func[][
    either empty? v/text [clear l/data][clear v/text]
]
visor-delch: func[][
    s: trim v/text v/text: trim copy/part s (length? s) - 1
]

view [
    title "Calculadora - [Red]"
    on-key [
        case [
            find ch-valido event/key [visor-insere event/key]
            find op-valida event/key [visor-insere rejoin [" " event/key " "]]
            event/key = CR [calcula]
            event/key = BS [visor-delch]
            find "Cc" event/key [visor-limpa]
        ]
    ]
    style mb: base 50x50 bold font-size 16 extra context [c: none]
        on-create [
            face/extra: make face/extra []
            face/extra/c: face/color
        ]
        on-over [
            face/color: either event/away? [face/extra/c][white] ;face/color / 2]
        ]
        [visor-insere face/text] ;if eq [clear v/text] eq: no append v/text face/text]
    style bo: mb orange
    style bk: mb khaki
    style bt: mb tanned
    style bm: mb wheat
    style bc: mb beige font-color red
    space 1x1
    l: text-list 305x150 font-size 14 data []  [
        parse l/data/(l/selected) [copy t to "="]
        v/text: trim t
        l/selected: none
        eq: no
    ] return

    v: base 305x40 right ivory font-size 18 "" return

    bm "M+" [attempt[m: m + math to block! load v/text]]
    bm "M-" [attempt[m: m - math to block! load v/text]]
    bm "MR" [if eq [clear v/text] eq: no append v/text m] 
    bc "MC" [m: 0]
    bc "C"  [visor-limpa] 
    bc "<=" [visor-delch] return

    bo "7" bo "8" bo "9"   bk " + "  bk " - " bt "x" return
    bo "4" bo "5" bo "6"   bk " * "  bk " / " bt ":" return
    bo "1" bo "2" bo "3"   bk "("    bk ")"   bt "/" return
    bo "0" bo "." bo " π " bk " ** " bk "Rnd " bt "%" return

    mb "=" 305 [calcula]
    do [
        eq: no
        m: 0
        random/seed now
    ]
]