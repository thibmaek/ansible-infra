# Setup

```console
sudo xcode-select --install
sudo xcodebuild -license accept
```

```console
python3 -V
python3 -m pip install --user ansible
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
python3 -m pip install --user -r requirements.txt
ansible-galaxy install -r requirements.yaml
```

```console
export CI=true
ansible-playbook playbooks/macos/main.yaml --ask-become-pass --step --verbose
ansible-playbook playbooks/macos/defaults.yaml --ask-become-pass --step --verbose
```
