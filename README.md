# RHEFO ![GitHub release (latest by date)](https://img.shields.io/github/v/release/T-3B/rhefo) ![GitHub all releases](https://img.shields.io/github/downloads/T-3B/rhefo/total) ![GitHub](https://img.shields.io/github/license/T-3B/rhefo?color=informational)
Really High Efficient File Optimizer (RHEFO) will **losslessly** recompress files as much as possible, according to their mime-types.


## What is this?
This tool is a file optimizer, thus it will recompress given files as much as possible while keeping the file type.\
It will choose the correct optimization software based on the file [mime-type](https://mimetype.io).\
There exist already a few of them: [nikkhokkho's FileOptimizer](https://nikkhokkho.sourceforge.io/static.php?page=FileOptimizer), [Papa's Best Optimizer](https://papas-best.com/optimizer_en), ...\
But they are Windows programs, and can be beaten quite easily (in term of output file size).\
Also, their code must be compiled and therefore are more difficult to modify and test.

The goal of RHEFO is not only to provide an easy way to optimize several file types, but also to allow the user to achieve maximum compression.\
Some max compression settings need quite a lot of time, thus need a flag to be set (see the output of `rhefo.sh -h`).\
This script intends to be "easily" editable, and **completely losslessly** (some options allow *lossy* operations on **metadata only**).\
For any question, file type support request, or if you find a way to produce a smaller file, feel free to open an issue!\
I will read them all :)

I want this program to be compatible with any Linux system, and Android support (using [Termux](https://github.com/termux/)) is planned (as I use it myself).\
I don't like Windows and don't plan to support it, but if someone knows how to use this script on Windows I'd really like to hear it!

## Installation
TODO (I'm thinking of placing everything - rhefo.sh + plug-ins - in a subfolder in PATH, easier to remove things when I drop an add-in).

## Usage & examples
This script will optimize any folder/file inputs given, with the possibility to write outputs to another directory (or optimize inplace).\
This script **completely supports exotic filenames**! For example, filenames can have `*`, start with a dash `-`, have a newline char `\n` or any non-printable chars.\
Symlinks were *not* tested (even embedded in archives), and could break your machine (well I don't think so, but you've been warned).

Optimize recursively current dir, inplace\
`rhefo .`\
Optimize as much as possible (**TAKES TIME!!!**) recursively current dir, inplace, keep timestamps and remove some useless metadata\
`rhefo -9kl .`\
Optimize with only 2 threads, and copy /indir *inside* /outdir\
`rhefo -o /outdir -j2 /indir`\
Optimize 2 files with default settings and write them to an existing /dir\
`rhefo -o /dir <firstFile> <secondFile>`\
Optimize all FLAC files in /path/to/dir, recursively and in hidden dirs and output will be copied to /out/dir (filetree is recreated from /path/to/dir)\
`rhefo -o /out -m "*.flac" /path/to/dir`\
Same as above, but flattened (no subdirectories in /out/dir)\
`find -name "*.flac" -type f -print0 | xargs -0 rhefo -s`

For further help and options, see the output of `rhefo -h` (and it's beautiful with lots of colors!).\
As you can see, there are *global options* (starting with `glob`) and type-specific options (starting with `flac`, `png`, ...).

## Dependencies
Here is a list of tools used by this script, listed in alphabetical order, easy to copy-paste for downloading (these are ArchLinux packages, name can change between distros).\
The more the formats supported by FFmpeg, the better ! (See `ffmpeg-full` in the AUR.)\
Global dependencies: `bash coreutils ffmpeg findutils grep parallel util-linux`.\
File type specific dependencies (see the table below): `flac gzip mupdf-tools qpdf tar`

## Plug-ins
This script also rely on several plug-ins. Since they are not available in repositories, I compile them myself and host them here.\
I provide only x86-64 and aarch64, in different branches (TODO). They are all compressed using `upx -9 --ultra-brute` (see [UPX](https://github.com/upx/upx)).\
I'm open to suggestions (as always!).\
[apngopt](https://apng.sourceforge.io/) [ECT](https://github.com/fhanau/Efficient-Compression-Tool) [MP3Packer](https://hydrogenaud.io/index.php/topic,32379.0.html)

## Supported file types

For each file type, I test many and many softwares, and only keep the one(s) providing the smallest output files.\
In many case different programs are used one after the other, allowing for the best compression.\
If you want to know which softwares I tested or more explanations, read the script comments.\
In the "Behaviour" column, texts in italics are the default behaviour.\
Fully supported file types:
// TODO remove normal/insane from "behaviour" description and add speed.

Extension|Mime-type|Dependencies|Behaviour|*Default*/insane&nbsp;speed
:---:|:---:|:---:|---|:---:
`.flac`|`audio/flac` `audio/x‑flac`|`flac`|Uses [reference FLAC encoder](https://github.com/xiph/flac), extract+optimize+remux embedded media files, (*non*-)subset file, remove/*keep* seek-table, remove/*keep* vendor string, *remove*/keep metadata padding, remove/*keep* metadata, *normal*/insane encoding time.|N/A
`.gz` `.tgz` `.svgz`|`application/gzip` `application/x‑gzip`|`gzip` `ect`|Uses [ECT](https://github.com/fhanau/Efficient-Compression-Tool), extract+optimize+remux, remove/*keep* original filename, *normal*/insane encoding time.|N/A
`.mp3`|`application/octet‑stream` `audio/mpeg` `audio/mp3` `audio/mpeg3` `audio/x-mpeg‑3`|`mp3packer`|Uses [MP3Packer](https://hydrogenaud.io/index.php/topic,32379.0.html), extract+optimize+remux embedded media files, delete/*write* Xing frame, *remove*/keep metadata padding, remove/*keep* metadata.|N/A
`.tar` `.cbt`|`application/x-tar` `application/x-cbt`|`tar`|Extract+optimize+remux files. Trust me, there **are** ways to optimize a TAR (without optimizing embedded files themselves). **Umask + owner/group are not preserved.**|N/A
---
Work in progress (already supported, but improvements can be done):
[]() | []() | []() | []()
:---:|:---:|:---:|---
`.jpg`|`image/jpeg`|`ect`|Uses [ECT](https://github.com/fhanau/Efficient-Compression-Tool), remove/keep metadata. I didn't test any other software for now.
`.pdf`|`application/pdf`|`mupdf‑tools` `qpdf`|Garbage collect unused objects/streams + merge/reuse duplicates + compact cross ref table + recompress Flate streams. No extraction for now (for both images and attached files).
`.png` `.apng`|`image/png` `image/x‑png` `image/vnd.mozilla.apng`|`ect` `apngopt`|Use [ECT](https://github.com/fhanau/Efficient-Compression-Tool) for PNG and [apngopt](https://apng.sourceforge.io/) for Animated PNG, remove/keep metadata, normal/"insane" encoding time.
`.zip`| . | . |Segmented archives not supported.


## License
Uses GNU Parallel.\
I'm "only" the author of this script, no more.\
Dependencies and plug-ins licenses/copyrights belong to their respective authors.\
This script is available under *GNU AGPLv3*.
Any modification/redistribution/use for non-personal purpose MUST link to this GitHub repository, as well as mentionning the changes made. Read the GNU AGPLv3 for further informations.

## Donations
Please consider donating, either to make a request (it will be given priority) or simply to support me. Thanks!\
[![Donate with PayPal](https://raw.githubusercontent.com/stefan-niedermann/paypal-donate-button/master/paypal-donate-button.png)](https://www.paypal.com/donate/?hosted_button_id=GK4MGMCVRUYZQ)
