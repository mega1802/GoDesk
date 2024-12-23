// const axios = require('axios');
// const sendOtp = require('./add');

// jest.mock('axios');

// describe('sendOtp', () => {
//   afterEach(() => {
//     jest.clearAllMocks();
//   });

//   it('should return data on successful OTP request', async () => {
//     const mockResponse = {
//       data: {
//         success: true,
//         message: 'OTP sent successfully',
//       },
//     };

//     axios.post.mockResolvedValueOnce(mockResponse);

//     const mobile = '6234567890';
//     const result = await sendOtp(mobile);

//     expect(axios.post).toHaveBeenCalledWith(
//       'http://43.205.35.224:8089/otp/send',
//       { mobile }
//     );
//     expect(result).toEqual(mockResponse.data);
//   });

//   it('should log and rethrow server error on OTP request failure', async () => {
//     const mockError = {
//       response: {
//         data: {
//           success: false,
//           message: 'Failed to send OTP',
//         },
//       },
//     };

//     axios.post.mockRejectedValueOnce(mockError);

//     const mobile = '6234567890';

//     await expect(sendOtp(mobile)).rejects.toEqual(mockError);

//     expect(axios.post).toHaveBeenCalledWith(
//       'http://43.205.35.224:8089/otp/send',
//       { mobile }
//     );
//     expect(console.error).toHaveBeenCalledWith(
//       'Error sending OTP:',
//       mockError.response.data
//     );
//   });

//   it('should log and rethrow network error on OTP request failure', async () => {
//     const mockError = new Error('Network Error');

//     axios.post.mockRejectedValueOnce(mockError);

//     const mobile = '6234567890';

//     await expect(sendOtp(mobile)).rejects.toThrow('Network Error');

//     expect(axios.post).toHaveBeenCalledWith(
//       'http://43.205.35.224:8089/otp/send',
//       { mobile }
//     );
//     expect(console.error).toHaveBeenCalledWith(
//       'Error sending OTP:',
//       mockError.message
//     );
//   });
// });
