# RHEFO ![GitHub release (latest by date)](https://img.shields.io/github/v/release/T-3B/rhefo) ![GitHub all releases](https://img.shields.io/github/downloads/T-3B/rhefo/total) ![GitHub](https://img.shields.io/github/license/T-3B/rhefo?color=informational)
Really High Efficient File Optimizer (RHEFO) will **losslessly** recompress files as much as possible, according to their mime-types.

## What is this?
This tool is a file optimizer, thus it will recompress given files as much as possible.\
It will choose the correct optimization software based on the file [mime-type](https://mimetype.io).\
There exist already a few of them: [nikkhokkho's FileOptimizer](https://nikkhokkho.sourceforge.io/static.php?page=FileOptimizer), [Papa's Best Optimizer](https://papas-best.com/optimizer_en), ...\
But they are Windows programs, and can be beaten quite easily (in term of output file size).\
Also, their code must be compiled and therefore are more difficult to modify and test.

The goal of RHEFO is not only to provide an easy way to optimize several file types, but also to allow the user to achieve maximum compression.\
Some max compression settings need quite a lot of time, thus need a flag to be set (see the output of `rhefo.sh -h`).\
This script intends to be "easily" editable, and **completely losslessly** (by default).\
For any question, file type support request, or if you find a way to produce a smaller file, feel free to open an issue!\
I will read them all :)

I want this program to be compatible with any Linux system, and Android support (using [Termux](https://github.com/termux/)) is planned (as I use it myself).\
I don't like Windows and don't plan to support it, but if someone knows how to use this script on Windows I'd really like to hear it!

## Dependencies
Here is a list of tools used by this script, listed in alphabetical order, easy to copy-paste for downloading (using `pacman` for example):\
`ffmpeg flac findutils gawk grep parallel perl vim`

## Plug-ins
This script also rely on several plug-ins. Since they are not available in repositories, I compile them myself and host them here.\
I provide only x86-64 and aarch64, in different branches (TODO).\
I'm open to suggestions (as always!).\
[apngopt](https://apng.sourceforge.io/) [ECT](https://github.com/fhanau/Efficient-Compression-Tool) [MP3Packer](https://hydrogenaud.io/index.php/topic,32379.0.html)

## Supported file types
Fully supported file types:
Extension|Mime-type|Behaviour
:---:|:---:|---
`.flac`|`audio/flac` `audio/x-flac`|Uses [reference FLAC encoder](https://github.com/xiph/flac), extract+optimize+remux embedded pictures, (non-)subset file, remove/keep seek-table, remove/keep vendor string, remove/keep metadata padding, normal/"insane" encoding time.
`.mp3`|`application/octet-stream` `audio/mpeg` `audio/mp3` `audio/mpeg3` `audio/x-mpeg-3`|Uses [MP3Packer](https://hydrogenaud.io/index.php/topic,32379.0.html), extract+optimize+remux embedded pictures, remove/keep metadata padding.

Work in progress file types: `APNG JPG PNG`

## License
Uses GNU Parallel.\
I'm "only" the author of this script, no more.\
Dependencies and plug-ins licenses/copyrights belong to their respective authors.\
This script is available under *GNU AGPLv3*.
Any modification/redistribution/use for non-personal purpose MUST link to this GitHub repository, as well as mentionning the changes made. Read the GNU AGPLv3 for further informations.

## Donations
Please consider donating, either to make a request (it will be given priority) or simply to support me. Thanks!\
[![Donate with PayPal](https://raw.githubusercontent.com/stefan-niedermann/paypal-donate-button/master/paypal-donate-button.png)](https://www.paypal.com/donate/?hosted_button_id=GK4MGMCVRUYZQ)
