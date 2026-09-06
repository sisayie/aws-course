mkdir -p build
  pandoc main.md \
    --from markdown \
    --to beamer \
    --template=templates/mytemplate.tex \
    --output build/slides.pdf