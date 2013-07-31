---
layout: post
status: publish
published: true
title: Using Solarized colors with vim, Eclipse, and Ubuntu
date: 2011-04-11 16:59:17.000000000 -04:00
comments: true
categories: [Linux]
tags: [eclipse,ubuntu]
---

We discovered [Solarized](http://xorcode.net/ejFgVg) by Ethan Schoonover and instantly fell in love with its *"precision colors for machines and people."* Having read up on its properties and unique features we decided to try to make our Ubuntu systems use it as extensively as possible.

<!--more-->

> <img src="/uploads/2011/04/solarized-yinyang-150x150.png" class="pull-right"> Solarized is a sixteen color palette (eight monotones, eight accent colors) designed for use with terminal and gui applications. It has several [unique properties](http://xorcode.net/fK0voM). Ethan Schoonover designed this colorscheme with both precise [CIELAB](http://xorcode.net/ezzkDl) lightness relationships and a refined set of hues based on fixed color wheel relationships.

[Solarized](http://xorcode.net/ejFgVg) comes with color profiles for Mac OS X, Vim, Mutt, as well as with color palettes for Adobe Photoshop, Apple Color Picker, and GIMP.

<a class="btn js-btn" href="http://ethanschoonover.com/solarized/files/solarized.zip">Download Solarized</a>

![Solarized Explained](/uploads/2011/04/solarized-vim.png)

> Solarized works as a sixteen color palette for compatibility with common terminal based applications / emulators. In addition, it has been carefull designed to scale down to a variety of five color palettes (four base monotones plus one accent color) for use in design work such as web design. In every case it retains a strong personality but doesn’t overwhelm.

## Gnome Terminal

### New method

<span class="label label-info">Updated</span> Tim Martin supplied a script that will set your terminal colors directly from the terminal. Copy and paste the following directly into your terminal and the color scheme will be updated instantly.

{% highlight bash %}
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#00002B2B3636"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#65657B7B8383"
{% endhighlight %}

<a class="btn btn-js" href="http://xorcode.net/OrfzgP">View the Gist</a>

### Old Method

<span class="label label-warning">Deprecated!</span> Gnome Terminal can be a bit tricky to colorize since the application cannot import color profiles/themes. The easiest way of getting Solarized to work with Gnome Terminal includes some light work in the Gnome Configuration Editor, `gconf-editor`.

Start the configuration editor by hitting ALT+F2 and typing `gconf-editor`.

Open up the following folder in the configuration: `/apps/gnome-terminal/profiles/Default`

Uncheck `use_theme_background` and `use_theme_colors`.

Find `palette` and change the value as illustrated below:

{% highlight xml %}#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3{% endhighlight %}

Change the value of `background_color` as illustrated below:

{% highlight xml %}#00002B2B3636{% endhighlight %}

Finally change the value of `foreground_color` as illustrated below:

{% highlight xml %}#65657B7B8383{% endhighlight %}

## Vim

Close down Vim and copy the `solarized.vim` file into your Vim settings directory:

{% highlight bash %}
$ mkdir -p ~/.vim/colors; cp solarized.vim ~/.vim/colors
{% endhighlight %}

Now open up your Vim configuration file:

{% highlight bash %}$ vim ~/.vimrc{% endhighlight %}

Add the following to the top of the file:

{% highlight vim %}
syntax enable
if has('gui_running')
    set background=light
else
    set background=dark
endif
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized
{% endhighlight %}

## Eclipse

Eclipse requires you to download the Eclipse Color Theme plug-in before you can use the Solarized theme.

<a class="btn btn-js" href="http://xorcode.net/dSgWwf">Download Eclipse Color Theme</a>

Once you have downloaded and installed the Eclipse plug-in you can download the Solarized Dark and Solarized Light themes.

<a class="btn btn-js" href="http://xorcode.net/h0Op38">Solarized Dark Theme</a>

<a class="btn btn-js" href="http://xorcode.net/fL6Jps">Solarized Light Theme</a>

Several other syntax highlighters and adaptations of Ethan's Solarized exist, if you cannot find a scheme for your tool of choice, make your own and let Ethan know what you have contributed!

<span class="label label-info">Kudos!</span> Thanks to *Otis Bean* for pointing out that using `gconf-editor` is the right way to go about editing configuration files.
