// // import React from 'react';
// // import { render } from '@testing-library/react-native';

// // // You can customize this render function, mock specific parts of the component, etc.
// // export const renderWithMockedComponent = (component) => {
// //   return render(component);
// // };
// // app/utils/MobileNumberUtils.js
// // app/utils/MobileNumberUtils.js

// // login.js
// // export const isValidMobileNumber = (number) => {
// //     const regex =  /^[6-9][0-9]{9}$/;
// //     return regex.test(number);
// //   };
  

// //   export const generateOTP = () => {
// //     return Math.floor(100000 + Math.random() * 900000).toString();  
// //   };
  

// //   export const isValidOTP = (otp) => {
// //     const regex = /^[0-9]{6}$/;
// //     return regex.test(otp);
// //   };
  
// const axios = require('axios');

// const sendOtp = async (mobile) => {
//   try {
//     const response = await axios.post("http://43.205.35.224:8089/otp/send", { mobile });
//     return response.data;
//   } catch (error) {
//     console.error("Error sending OTP:", error.response?.data || error.message);
//     throw error; 
//   }
// };

// module.exports = sendOtp;
