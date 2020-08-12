ldc2 -mtriple=wasm32-unknown-unknown-wasm -L-allow-undefined --output-bc app.d --of=bitcode/app.bc &&
emcc -O3 libs.cpp -s USE_SDL=2 \
-s USE_OGG=1 \
-s USE_VORBIS=1 \
-s USE_SDL_IMAGE=2 \
-s USE_SDL_MIXER=2 \
-s USE_SDL_TTF=2 \
-s USE_SDL_NET=2 \
-o out/libs.js &&
emcc -O0 bitcode/app.bc -s EXPORTED_FUNCTIONS='["_add"]' -s EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -o dtest/index.html