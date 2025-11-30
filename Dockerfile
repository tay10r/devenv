FROM ubuntu:25.10
RUN apt-get update
RUN apt-get install -y \
  g++ \
  cmake \
  git \
  python3 \
  python3-pip \
  python3-venv \
  neovim \
  curl \
  zip \
  unzip \
  tar \
  clangd \
  clang-format \
  pkg-config \
  autoconf \
  autoconf-archive \
  automake \
  libtool
RUN useradd dev --create-home --shell /usr/bin/bash
RUN curl -fsSL https://code-server.dev/install.sh | sh
USER dev
WORKDIR /home/dev
RUN git clone https://github.com/microsoft/vcpkg
RUN cd vcpkg && ./bootstrap-vcpkg.sh -disableMetrics

# install some common dependencies
#RUN cd vcpkg && ./vcpkg install \
#  gtest \
#  spdlog \
#  cxxopts \
#  opencv[dnn] \
#  protobuf \
#  nlohmann-json \
#  eigen3 \
#  glm \
#  libuv \
#  pybind11
RUN mkdir workspaces
ENV CMAKE_TOOLCHAIN_FILE=/home/dev/vcpkg/scripts/buildsystems/vcpkg.cmake
ENV CMAKE_EXPORT_COMPILE_COMMANDS=1
EXPOSE 5500
RUN code-server --install-extension ms-python.python
RUN code-server --install-extension llvm-vs-code-extensions.vscode-clangd
RUN code-server --install-extension xaver.clang-format
RUN code-server --install-extension vscodevim.vim
CMD [ "code-server", "--disable-telemetry", "--auth", "none", "--bind-addr", "0.0.0.0:5500" ]
