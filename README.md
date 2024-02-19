# RHEFO ![GitHub release (latest by date)](https://img.shields.io/github/v/release/T-3B/rhefo) ![GitHub all releases](https://img.shields.io/github/downloads/T-3B/rhefo/total) ![Static Badge](https://img.shields.io/badge/license-SSPL-blue) [![Static Badge](https://img.shields.io/badge/Support_me!-f5af05?logo=PayPal)](https://www.paypal.com/donate/?hosted_button_id=GK4MGMCVRUYZQ)
Really High Efficient File Optimizer (RHEFO) will **losslessly** recompress files as much as possible, according to their mime-types.
This program favors *compression ratio* over speed by maximizing CPU usage (can be restricted).


## What is this?
This tool is a file optimizer, thus it will recompress given files as much as possible while keeping the file type.\
It will choose the correct optimization software based on the file [mime-type](https://mimetype.io).\
There exist already a few of them: [nikkhokkho's FileOptimizer](https://nikkhokkho.sourceforge.io/static.php?page=FileOptimizer), [Papa's Best Optimizer](https://papas-best.com/optimizer_en), ...\
But they are Windows programs, and can be beaten quite easily (in term of compression ratio).\
Also, their code must be compiled and therefore is more difficult to modify and test.

The goal of RHEFO is not only to provide an easy way to optimize several file types in parallel, but also to allow the user to achieve maximum compression.\
Some max compression settings need quite a lot of time, thus need a flag to be set (see the output of `rhefo -h`).\
This script intends to be "easily" editable, and **completely losslessly** (some options allow *lossy* operations on **metadata only**).\
Please remember that this tool is under active development, and please read the table below in [supported file types](#supported-file-types) to check for possible unsupported stuffs (like metadata).\
For any question, file type support request, or if you find a way to produce a smaller file, feel free to open an issue!\
I will read them all :)

I want this program to be compatible with any Linux system, and Android support (using [Termux](https://github.com/termux/)) is planned (as I use it myself).\
For Windows, I guess this script works under WSL, but needs testing and I can't test.

## Installation
The download and installation was made as easiest as possible.\
First download the [dependencies](#dependencies) for your system.\
Then simply download a release with your system architecture.\
In the releases (**only there**) the add-ins are embedded in the script (which is self-extractable), so you only need *one* file.

## Usage & examples
This script will optimize any folder/file inputs given in parallel, with the possibility to write outputs to another directory (or optimize inplace).\
This script **completely supports exotic filenames**! For example, filenames can have `*`, start with a dash `-`, have a newline char `\n` or any non-printable chars.\
Symlinks were *not* tested (even embedded in archives), and could break your machine (well I don't think so, but you've been warned).

Optimize recursively current dir, inplace\
`rhefo .`\
Optimize as much as possible (**TAKES TIME!!!**) recursively current dir, inplace, keep timestamps and remove some useless metadata\
`rhefo -9kl .`\
Optimize with only 2 threads, and copy /indir *inside* /outdir\
`rhefo -o /outdir -j2 /indir`\
Optimize 2 files with default settings and write them to an existing /outdir\
`rhefo -o /outdir <firstFile> <secondFile>`\
Optimize all FLAC files in /indir, recursively and in hidden dirs and output will be copied to /outdir (filetree is recreated from /indir)\
`rhefo -o /outdir -m "*.flac" /indir`\
Same as above, but flattened (no subdirectories in /outdir)\
`find -name "*.flac" -type f -print0 | xargs -0 rhefo -o /out`

For further help and options, see the output of `rhefo -h` (and it's beautiful with lots of colors!).\
As you can see, there are *global options* (starting with `glob`) and type-specific options (starting with `flac`, `png`, ...).

## Dependencies
Here is a list of tools used by this script, listed in alphabetical order, easy to copy-paste for downloading (these are ArchLinux packages, name can change between distros - open issues/merge requests if you know the names under other distributions like Ubuntu).\
The more the formats supported by FFmpeg, the better ! See `ffmpeg-full` in the AUR. FFmpeg is an easy to solution for (de)muxing, but has some drawbacks. Therefore I try as much as possible not to use it, but in order to I have to write BASH code reading and extracting binary data, which takes time.\
Global dependencies: `bash coreutils ffmpeg findutils gawk grep parallel util-linux`.\
File type specific dependencies (see the [table below](#supported-file-types)): `flac gzip mupdf-tools qpdf tar`

## Add-ins
This script also rely on several add-ins. Since they are not distributed (through package managers), I compile them myself (when needed) and host them here.\
I provide only x86-64 and aarch64, see [here](addins/README.md) for more info.
I'm open to suggestions (as always!), and can try building them for Windows if someone manages to make this BASH script work on Windows.\
[apngopt](https://apng.sourceforge.io/) [ECT](https://github.com/fhanau/Efficient-Compression-Tool) [MozJPEG](https://github.com/mozilla/mozjpeg) [MP3Packer](https://hydrogenaud.io/index.php/topic,32379.0.html)

## Supported file types

For each file type, I try many softwares and settings, and only keep the one(s) providing the smallest output files.\
In many cases, different programs are used one after the other, to achieve the best possible compression.\
If you want to know which softwares I tested or more explanations, read the script comments.\
In the "Behaviour" column, texts in italics are the default behaviour.\
For easier reading, only the file extensions are listed, even if the script is using their mime-types.\
Fully supported file types:
// TODO remove normal/insane from "behaviour" description and add speed.

Extension|Dependencies|Behaviour|*Default*/insane&nbsp;speed
:---:|:---:|---|:---:
`.flac`|`flac`|Uses [reference FLAC encoder](https://github.com/xiph/flac), extract+optimize+remux embedded pictures, (*non*-)subset file, remove/*keep* seek-table, remove/*keep* vendor string, *remove* metadata padding, remove/*keep* metadata, *normal*/insane encoding time.|N/A
`.gz` `.tgz` `.svgz`|`gzip` `ect`|Uses [ECT](https://github.com/fhanau/Efficient-Compression-Tool), extract+optimize+remux, remove/*keep* original filename, *normal*/insane encoding time.|N/A
`.jpg`|`mozjpeg`|Uses [MozJPEG](https://github.com/mozilla/mozjpeg), remove/*keep* metadata (EXIF, ...).
`.mp3`|`mp3packer`|Uses [MP3Packer](https://hydrogenaud.io/index.php/topic,32379.0.html), extract+optimize+remux embedded media files, delete/*write* Xing frame, *remove*/keep metadata padding, remove/*keep* metadata.|N/A
`.tar` `.cbt`|`tar`|Extract+optimize+remux files. Trust me, there **are** ways to optimize a TAR (without optimizing embedded files themselves). ***Umask + owner/group are not preserved.***|N/A
---
Work in progress (already supported, but improvements can be done):
[]() | []() | []()
:---:|:---:|---
`.pdf`|`mupdf‑tools` `qpdf`|Garbage collect unused objects/streams + merge/reuse duplicates + compact cross ref table + recompress Flate streams. No extraction for now (for both images and attached files). cpdf & pdfsizeopt needs more test, and I'm willing to extract Deflate objects to compress them with `ect` (in the TODO list).
`.png` `.apng`|`ect` `apngopt`|Use [ECT](https://github.com/fhanau/Efficient-Compression-Tool) for PNG and [apngopt](https://apng.sourceforge.io/) for Animated PNG, remove/keep metadata, *normal*/insane encoding time. Only apng needs more testing. 
`.zip` `.zipx`| `ect` `zip` `7zz` |Segmented archives not supported. Only Deflate ZIP are supported for now. *Normal*/insane encoding time.


## License
Uses GNU Parallel.\
I'm "only" the author of this script, no more.\
Dependencies and add-ins licenses/copyrights belong to their respective authors (see [Add-ins](#add-ins) for links).

This BASH script is available under **SSPL** ([Server Side Public License](https://www.mongodb.com/licensing/server-side-public-license)).
Any modification/redistribution/use for non-personal purpose (even behind a web service) MUST link to this GitHub repository, as well as mentionning the changes made. Read the `LICENSE.txt` for further informations.

## Donations
Please consider donating, either to make a request (it will be given priority) or simply to support me. Thanks!
<div align="center">
  
  [![Static Badge](https://img.shields.io/badge/Support_me!-f5af05?style=for-the-badge&logo=PayPal)](https://www.paypal.com/donate/?hosted_button_id=GK4MGMCVRUYZQ)

</div>
