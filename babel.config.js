module.exports = function (api) {
  api.cache(true);
  return {
    presets: [["babel-preset-expo", {jsxImportSource: "nativewind" }],
    ['@babel/preset-env', { targets: { node: 'current' } }],
    '@babel/preset-react',
    "nativewind/babel",
  'module:metro-react-native-babel-preset'],
    plugins: [["module-resolver", {
      root: ["./"],
      alias: {
        "@": "./"
      }
    }]],
  };
};