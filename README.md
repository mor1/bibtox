# `bibtox`, a BibTeX/BibLaTeX handler

A simple tool to process one or more files containing BibTeX/BibLaTeX entries.

Invoked without configuration, it simply reads entries from `stdin`, sorts them
if directed to do so, and outputs as entries or marked-up HTML to `stdout`.

Invoked with a configuration file, it reads entries from the files specified for
each section, sorts if directed to do so, and writes entries into a per-section
output file or into a single marked-up HTML file with sections.

```
$ uv run bibtox --help
Usage: bibtox [OPTIONS] INPUT

  Process BibTeX/BibLaTeX input file.

  Sort entries if requested. Output to HTML and/or BibTeX.

Options:
  --debug
  --sort / --no-sort  Sort entries.  [default: sort]
  --html              Output HTML.
  --help              Show this message and exit.
```

## Sort and format a single file of entries

```sh
$ cat test/strings.bib test/test.bib | uv run bibtox - | head -10
[15:20:52] INFO     stats={'blocks': 21, 'entries': 6, 'comments': 0, 'strings': 15, 'preamble': 0, 'failures': 0}    bibtox:292
%%commment{datetime={2025-01-03T15:20:52.979990+00:00}, section={}}
@inproceedings{wilkins24:fedsz,
  author    = {Wilkins, Grant and Di, Sheng and Calhoun, Jon C. and Li, Zilinghan and Kim, Kibaek and Underwood, Robert and Mortier, Richard and Cappello, Franck},
  booktitle = {IEEE 44th International Conference on Distributed Computing Systems (ICDCS)},
  title     = {FedSZ: Leveraging Error-Bounded Lossy Compression for Federated Learning Communications},
...
```

## Sort and split entries by section, formatting as HTML

Content of configuration file, `test/bibinputs.json`:
```json
{
    "bibdir": "./test",
    "strings": "./test/strings.bib",
    "homepages": "./test/homepages.json",
    "sections": {
        "Test": [
            "test.bib"
        ]
    }
}
```

HTML formatting sorted output:

```sh
$ uv run bibtox --html test/bibinputs.json | head -5
[15:23:54] INFO     section='Test' filenames=['test.bib']    bibtox:354
           INFO     stats={'blocks': 21, 'entries': 6, 'comments': 0, 'strings': 15, 'preamble': 0, 'failures': 0}                                                          bibtox:292
{{dummy}}
<section class="papers">Test</section>
<ol class="papers">
  <li id="wilkins24:fedsz" class="paper conference"><span class="authors"><span class="author">Wilkins, G.</span>, <span class="author">Di, S.</span>, <span class="author">Calhoun, J.</span>, <span class="author">Li, Z.</span>, <span class="author">Kim, K.</span>, <span class="author">Underwood, R.</span>, <span class="author highlight"><a href="https://mort.io/">Mortier, R.</a></span> and <span class="author">Cappello, F.</span></span><span class="year"> (2024). </span><span class="title">&ldquo;FedSZ: Leveraging Error-Bounded Lossy Compression for Federated Learning Communications&rdquo;</span>. In <span class="venue">IEEE 44th International Conference on Distributed Computing Systems (ICDCS)</span> pp.&nbsp;577–588. <span class="date">October 2024</span>. <span class="doi"><a href="https://doi.org/10.1109/ICDCS60910.2024.00060">doi:10.1109/ICDCS60910.2024.00060</a></span>. </li>
  <li id="cicconetti24:edgel" class="paper conference"><span class="authors"><span class="author">Cicconetti, C.</span>, <span class="author">Carlini, E.</span>, <span class="author">Hetzel, R.</span>, <span class="author highlight"><a href="https://mort.io/">Mortier, R.</a></span>, <span class="author">Paradell, A.</span> and <span class="author">Sauer, M.</span></span><span class="year"> (2024). </span><span class="title">&ldquo;EDGELESS: A Software Architecture for Stateful FaaS at the Edge&rdquo;</span>. In <span class="venue">Proceedings of the 33rd International Symposium on High-Performance Parallel and Distributed Computing (HPDC)</span> pp.&nbsp;393-–396. Pisa, Italy<span class="publisher"> (Association for Computing Machinery)</span>. <span class="date">2024</span>. <span class="doi"><a href="https://doi.org/10.1145/3625549.3658817">doi:10.1145/3625549.3658817</a></span>. <span class="url"><a href="https://doi.org/10.1145/3625549.3658817">https://doi.org/10.1145/3625549.3658817</a></span>. </li>
...
```
