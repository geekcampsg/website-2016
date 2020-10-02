# Geekcamp.SG

This website uses jekyll.

## Jekyll Installation in Linux
  1   sudo apt-get install ruby-full build-essential zlib1g-dev
  2   ~/.bashrc
  3   gem install jekyll bundler
## Submitting Talks

- Edit \_data/talks.yml
  - You may ignore the slug field, but if you pick something fitting, we'll leave it be
- If you don't want to link to your Twitter or GitHub profile, leave speaker.link as an empty string
- Submit a pull request!

## Adding Team Members

- Add your photo to images/
- Edit \_data/members.yml
  - Please ensure this file remains in alphabetical order.

## Testing

- `gem install jekyll`
- `jekyll serve`
