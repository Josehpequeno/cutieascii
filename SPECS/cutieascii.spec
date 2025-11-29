Name:           cutieascii
Version:        1.0
Release:        1%{?dist}
Summary:        Simple Go utility that displays cute ASCII art emojis from a text file

License:        MIT
URL:            https://github.com/Josehpequeno/cutieascii
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  golang
BuildRequires:  make

%description
A simple Go program that displays cute ASCII art emojis selected from a text file.

%prep
%setup -q

%build
make build

%install
make install DESTDIR=%{buildroot}

%files
%license LICENSE
%{_bindir}/cutieascii
%{_datadir}/cutieascii/cats.txt

%changelog
* Sat Nov 29 2025 Josehpequeno <hicarojbs21@gmail.com> - 0.1-1
- First release cutieascii