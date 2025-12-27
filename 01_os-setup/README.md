# Other *nix Systems

## Maintaining more than one single only unique thing of anything is a no no

I know... I know...

I've stated somewhere else that supporting `N` variations of a `Y` thing is the worst for maintainability, and this is one exception or a choice to break that
approach.

As we may use different OSs and setups, I may provide in time different configuration guidelines for different platforms other than my own setup and
platform.

If I create them, I will not maintain them with the same rigor as my own platform, and my current platform will inevitably change over time.

## Why this actually is... _"One example why using `N` variations of a `Y` thing hurts a project maintainability."_

Consistency is paramount for so many reasons, but you most likely do not use the same tools as myself, OS included, and changing an OS is not trivial for many
people, or just impossible.

As long as you know what you are doing regarding this topic, choose what you like the most.

Fedora? Ubuntu? Arch? FreeBSD? Solaris? macOS? OpenIndiana? Haiku?
<br>(maybe not) All fine...

vsCode? vi? vim? neovim? phantomvim? tmntvim? rabbitvim?
youSawAYoutubeSensationThatIsAMegaProUsingVimSoYouAlsoWantVimAsItWillMakeYouAsProvim? emacs? intellij? eclipse? pen and paper?
<br>(probably not) All fine...

**_but...._**

Imagine at some point `n` developers have `n` different OSs and `y` base tools.
<br>It will be tough to give a hand every time "_something does not work on John's computer_".
<br>Onboarding, updates, questions... would be just a nightmare.

## Disclaimer

I know this project works just fine on most Linux OSs with none or minimal tweaks, but cannot tell on macOS or Windows. Even on linux it may be a challenge to
support all possible combinations regarding installation and configuration details.

It should be quite ok on macOS (BSDish after all), but running this on Windows may be a challenge or a lesser experience, even with / under Windows Subsystem
for Linux (WSL).

What the hell, not everybody uses `OpenSuSE`.
