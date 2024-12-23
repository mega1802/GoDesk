const config = {
    verbose: true,
    preset: 'react-native',
    moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
    transformIgnorePatterns: [
        "/!node_modules\\/lodash-es/",
      'node_modules/(?!(react-native' +
        '|@react-native' +
        '|@react-native-community' +
        '|@react-navigation' +
        '|@react-native-firebase/auth' +
        '|react-navigation-tabs' +
        '|react-native-splash-screen' +
        '|react-native-screens' +
        '|react-native-reanimated' +
        '|@expo/vector-icons' +
        '|expo-font' +  
        '|expo-modules-core' + // Add this for EventEmitter issues
        '|expo' + 
        'node_modules/(?!(@react-native-firebase)/)',  
        "node_modules/(?!cheerio)/",      
        ')/)',
    ],
    transform: {
      '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest',
    },
    moduleNameMapper: {
        '\\.(css|scss|sass)$': 'identity-obj-proxy',
        '\\.(png|jpg|jpeg|gif|svg)$': '<rootDir>/__mocks__/fileMock.js'
        
      },
      testEnvironment: 'jsdom',
    "setupFiles": [
    "./node_modules/react-native-gesture-handler/jestSetup.js",
    './jest.setup.js',
    '<rootDir>/node_modules/react-native-gesture-handler/jestSetup.js',
    
     

  ]
  };
  
  module.exports = config;
  