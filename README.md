# kickstart.nvim

## Введение

Стартовая точка для настройки Neovim, которая:

* компактна
* состоит из одного файла
* полностью задокументирована

Это **не** дистрибутив Neovim, а основа для вашей собственной конфигурации.

## Установка

### Установка Neovim

Kickstart.nvim рассчитан *только* на последние релизы
['stable'](https://github.com/neovim/neovim/releases/tag/stable) и
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) Neovim.
Если возникают проблемы, убедитесь, что у вас установлены актуальные версии.

### Внешние зависимости

Необходимые инструменты:
- Базовые утилиты: `git`, `make`, `unzip`, C-компилятор (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation)
- Утилита для работы с буфером обмена (xclip/xsel/win32yank или другая, в зависимости от платформы)
- [Nerd Font](https://www.nerdfonts.com/) — необязательно, но позволяет отображать иконки
  - если шрифт установлен, задайте `vim.g.have_nerd_font = true` в `init.lua`
- Шрифты с emoji (для Ubuntu и только если нужны emoji): `sudo apt install fonts-noto-color-emoji`
- Языковые инструменты:
  - Для Typescript нужен `npm`
  - Для Golang нужен `go`
  - и так далее

> [!NOTE]
> Дополнительные сведения для Windows и Linux, а также готовые команды смотрите в разделе [Рецепты установки](#рецепты-установки)

### Установка Kickstart

> [!NOTE]
> Сначала сделайте [резервную копию](#faq) предыдущей конфигурации (если она есть)

Каталог с конфигурацией Neovim зависит от операционной системы:

| ОС | Путь |
| :- | :--- |
| Linux, macOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd) | `%localappdata%\nvim\` |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\` |

#### Рекомендуемый шаг

[Сделайте форк](https://docs.github.com/en/get-started/quickstart/fork-a-repo) репозитория,
чтобы получить собственную копию и свободно её изменять, затем клонируйте форк на локальную
машину, используя команды ниже (в зависимости от ОС).

> [!NOTE]
> URL вашего форка будет выглядеть так:
> `https://github.com/<ваш_логин_github>/kickstart.nvim.git`

Также имеет смысл убрать `lazy-lock.json` из `.gitignore` вашего форка — в оригинальном
репозитории этот файл игнорируется для упрощения сопровождения, но
[рекомендуется хранить его в системе контроля версий](https://lazy.folke.io/usage/lockfile).

#### Клонирование kickstart.nvim

> [!NOTE]
> Если следуете рекомендации выше (форк), замените в командах `nvim-lua`
> на `<ваш_логин_github>`

<details><summary>Linux и macOS</summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary>Windows</summary>

Для `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

Для `powershell.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### После установки

Запустите Neovim:

```sh
nvim
```

После первого запуска Lazy установит все плагины. Командой `:Lazy` можно посмотреть состояние
плагинов. Для выхода закройте окно клавишей `q`.

#### Почитайте документацию

Изучите файл `init.lua` в каталоге конфигурации, чтобы понять, как расширять и настраивать
Neovim. В нём также есть примеры подключения популярных плагинов.

> [!NOTE]
> За подробностями по конкретному плагину обращайтесь к документации его репозитория.

### Первые шаги

[Единственное видео, которое нужно, чтобы начать работу с Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* Что делать, если у меня уже есть конфигурация Neovim?
  * Сделайте резервную копию и удалите все связанные файлы.
  * В том числе `init.lua` и данные Neovim в `~/.local`, которые можно удалить командой `rm -rf ~/.local/share/nvim/`
* Можно ли оставить текущую конфигурацию параллельно с kickstart?
  * Да! Используйте [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`,
    чтобы поддерживать несколько конфигураций. Например, установите kickstart в `~/.config/nvim-kickstart`
    и создайте алиас:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    При запуске через `nvim-kickstart` Neovim будет использовать альтернативный каталог конфигурации и
    соответствующий локальный каталог `~/.local/share/nvim-kickstart`. Так можно запускать любое количество
    сборок Neovim.
* Как «удалить» эту конфигурацию?
  * См. описание [удаления lazy.nvim](https://lazy.folke.io/usage#-uninstalling)
* Почему `init.lua` в kickstart — это один файл? Разве не лучше разбить его на несколько?
  * Основная цель kickstart — быть учебным пособием и опорной конфигурацией, которую можно прочитать
    целиком и адаптировать под себя. По мере изучения Neovim и Lua вы можете разделить `init.lua`
    на части. Существуют форки, которые делают это без изменения функциональности:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Обсуждения на эту тему:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Рецепты установки

Ниже приведены инструкции по установке Neovim и зависимостей для разных ОС.
После установки всех зависимостей продолжайте с шага [Установка Kickstart](#установка-kickstart).

#### Windows

Для установки Neovim удобно использовать [scoop](https://scoop.sh/):

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh -outfile 'install.ps1'
.\install.ps1 -ScoopDir 'C:\bin' -ScoopGlobalDir 'C:\bin-global' -NoProxy
scoop bucket add extras
scoop install neovim git fd ripgrep gzip unzip
```

Чтобы задать переменную окружения, не открывая новое окно, выполните:

```powershell
$env:path += ';' + (Resolve-Path ~\scoop\apps\neovim\current)
```

Затем поставьте утилиту win32yank для работы с буфером обмена:

```powershell
scoop install win32yank
```

Установите [Nerd Font](https://www.nerdfonts.com/font-downloads) и задайте его в настройках Windows Terminal.

Дополнительно рекомендуется установить пакет [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
или [Visual Studio Community](https://visualstudio.microsoft.com/vs/community/) c компонентами C++.

#### Ubuntu Linux

```sh
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim ripgrep fd-find xclip
```

На Ubuntu бинарник `fd` называется `fdfind`, поэтому создадим ссылку:

```sh
ln -s $(which fdfind) ~/.local/bin/fd
```

При необходимости установите шрифт и emoji:

```sh
sudo apt install fonts-firacode fonts-noto-color-emoji
```

#### Fedora Linux

```sh
sudo dnf install -y neovim ripgrep fd-find xclip
```

Если хотите использовать buffer обмена через Wayland:

```sh
sudo dnf install -y wl-clipboard
```

Установите шрифты и emoji:

```sh
sudo dnf install -y fira-code-fonts google-noto-emoji-color-fonts
```

#### Arch Linux

```sh
sudo pacman -S --needed neovim ripgrep fd xclip
```

Для Wayland:

```sh
sudo pacman -S --needed wl-clipboard
```

Шрифт и emoji:

```sh
sudo pacman -S --needed ttf-firacode noto-fonts-emoji
```

### Благодарности

Эта конфигурация была создана людьми из сообщества Neovim, к которым относятся, в числе прочих:

- [@tpope](https://github.com/tpope)
- [@ThePrimeagen](https://github.com/ThePrimeagen)
- [@echasnovski](https://github.com/echasnovski)
- [@folke](https://github.com/folke)

И огромная благодарность всем, кто поддерживает и развивает Neovim.
