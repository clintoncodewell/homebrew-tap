# Homebrew Tap for Cat Eye

This is the official [Homebrew](https://brew.sh) tap for [Cat Eye](https://github.com/clintoncodewell/cat-eye), a lightweight native macOS menu bar app for monitoring GitHub Actions and PR status.

## Installation

```bash
brew install clintoncodewell/tap/cat-eye
```

Or add the tap first and then install:

```bash
brew tap clintoncodewell/tap
brew install cat-eye
```

To install the latest development version:

```bash
brew install --HEAD clintoncodewell/tap/cat-eye
```

## After Installation

1. Authenticate the GitHub CLI (if you haven't already):

   ```bash
   gh auth login
   ```

2. Configure which repos to monitor:

   ```bash
   mkdir -p ~/.config/cat-eye
   echo '{"repos":["owner/repo"]}' > ~/.config/cat-eye/config.json
   ```

3. Launch the app:

   ```bash
   open $(brew --prefix)/Cellar/cat-eye/1.0/CatEye.app
   ```

4. (Optional) Make it findable via Spotlight:

   ```bash
   ln -sf $(brew --prefix)/Cellar/cat-eye/1.0/CatEye.app ~/Applications/CatEye.app
   ```

## Available Formulae

| Formula | Description |
|---------|-------------|
| `cat-eye` | Lightweight macOS menu bar app for GitHub Actions and PR status |
