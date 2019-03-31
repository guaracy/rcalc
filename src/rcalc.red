Red [ needs: 'view]

π: func[][pi]
rnd: func[n][random n]
calcula: func[v l][
    attempt [
        eq: yes
        res: form math load v/text 
        c: copy v/text
        append c rejoin [" = " res]
        append l/data c
        ;l/selected: length? l/data
        append clear v/text res
    ]
]

view [
    title "Calculadora - [Red]"
    style mb: base 50x50 bold font-size 16 extra context [c: none]
        on-create [
            face/extra: make face/extra []
            face/extra/c: face/color
        ]
        on-over [
            face/color: either event/away? [face/extra/c][white] ;face/color / 2]
        ]
        [if eq [clear v/text] eq: no append v/text face/text]
    style bo: mb orange
    style bk: mb khaki
    style bt: mb tanned
    style bm: mb wheat
    style bc: mb beige font-color red
    space 1x1
    l: text-list 305x150 font-size 14 data []  [
        ;unless eq [exit]
        parse l/data/(l/selected) [copy t to "="]
        v/text: trim t
        l/selected: none
        eq: no
    ] return

    v: base 305x40 right ivory font-size 18 font-color green  "" return

    bm "M+" [attempt[m: m + math to block! load v/text]]
    bm "M-" [attempt[m: m - math to block! load v/text]]
    bm "MR" [if eq [clear v/text] eq: no append v/text m] 
    bc "MC" [m: 0]
    bc "C"  [either empty? v/text[clear l/data][clear v/text]] 
    bc "<=" [s: trim v/text v/text: trim copy/part s (length? s) - 1] return ;bt "%" return

    bo "7" bo "8" bo "9"   bk " + "  bk " - " bt "x" return
    bo "4" bo "5" bo "6"   bk " * "  bk " / " bt ":" return
    bo "1" bo "2" bo "3"   bk "("    bk ")"   bt "/" return
    bo "0" bo "." bo " π " bk " ** " bk "Rnd " bt "%" return

    mb "=" 305 [ calcula v l ]
    do [
        eq: no
        m: 0
        random/seed now
    ]
]

