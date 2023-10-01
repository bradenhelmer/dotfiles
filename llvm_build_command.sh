# The amount of f'ing times I've had to build LLVM/Clang, here's the command...
# Run in llvm-project directory
mkdir -p build
CC=clang
CXX=clang++
cmake -B build/ -G "Ninja" -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_TARGETS_TO_BUILD="X86" llvm
sudo ninja -C build install
