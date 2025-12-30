// import React, { useState, useEffect, useRef } from 'react';
// import { 
//   Building2, 
//   User, 
//   Briefcase, 
//   Lock, 
//   MapPin, 
//   ChevronRight, 
//   ChevronLeft, 
//   CheckCircle,
//   Upload,
//   Image as ImageIcon,
//   Map as MapIcon,
//   Search,
//   Loader2
// } from 'lucide-react';

// const apiKey = ""; // The environment provides the key at runtime

// // --- Components defined OUTSIDE the main component to prevent re-rendering/focus loss ---

// const Step1GeneralInfo = ({ formData, handleInputChange, handleFileChange }) => (
//   <div className="space-y-4 animate-fadeIn">
//     <h2 className="text-xl font-bold text-gray-800 mb-4">Company Details</h2>
    
//     <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
//       <div>
//         <label className="block text-sm font-medium text-gray-700 mb-1">Company Name</label>
//         <input
//           type="text"
//           name="companyName"
//           value={formData.companyName}
//           onChange={handleInputChange}
//           className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//           placeholder="e.g. Acme Services"
//         />
//       </div>
//       <div>
//         <label className="block text-sm font-medium text-gray-700 mb-1">Mobile Number</label>
//         <input
//           type="tel"
//           name="companyMobile"
//           value={formData.companyMobile}
//           onChange={handleInputChange}
//           className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//           placeholder="+91 98765 43210"
//         />
//       </div>
//     </div>

//     <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
//       <div>
//         <label className="block text-sm font-medium text-gray-700 mb-1">Company Email</label>
//         <input
//           type="email"
//           name="companyEmail"
//           value={formData.companyEmail}
//           onChange={handleInputChange}
//           className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//           placeholder="info@acme.com"
//         />
//       </div>
//       <div>
//         <label className="block text-sm font-medium text-gray-700 mb-1">Select Zone</label>
//         <select
//           name="zone"
//           value={formData.zone}
//           onChange={handleInputChange}
//           className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition bg-white"
//         >
//           <option value="">Select a zone</option>
//           <option value="india_north">India - North</option>
//           <option value="india_south">India - South</option>
//           <option value="india_east">India - East</option>
//           <option value="india_west">India - West</option>
//           <option value="usa">USA</option>
//           <option value="uk">UK</option>
//         </select>
//       </div>
//     </div>

//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Address</label>
//       <textarea
//         name="address"
//         value={formData.address}
//         onChange={handleInputChange}
//         // @ts-expect-error
//         rows="3"
//         className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//         placeholder="Enter full street address..."
//       ></textarea>
//     </div>

//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Upload Company Logo</label>
//       <div className="flex items-center justify-center w-full">
//         <label className="flex flex-col items-center justify-center w-full h-32 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 transition">
//           <div className="flex flex-col items-center justify-center pt-5 pb-6">
//             {formData.companyImagePreview ? (
//               <img src={formData.companyImagePreview} alt="Preview" className="h-20 object-contain" />
//             ) : (
//               <>
//                 <Upload className="w-8 h-8 mb-2 text-gray-500" />
//                 <p className="text-sm text-gray-500"><span className="font-semibold">Click to upload</span> or drag and drop</p>
//               </>
//             )}
//           </div>
//           <input type="file" className="hidden" onChange={(e) => handleFileChange(e, 'companyImage', 'companyImagePreview')} />
//         </label>
//       </div>
//     </div>
//   </div>
// );

// const Step2ContactPerson = ({ formData, handleInputChange }) => (
//   <div className="space-y-4 animate-fadeIn">
//     <h2 className="text-xl font-bold text-gray-800 mb-4">Contact Person Information</h2>
    
//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
//       <div className="relative">
//         <User className="absolute left-3 top-3 w-5 h-5 text-gray-400" />
//         <input
//           type="text"
//           name="contactName"
//           value={formData.contactName}
//           onChange={handleInputChange}
//           className="w-full pl-10 p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//           placeholder="John Doe"
//         />
//       </div>
//     </div>

//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Mobile Number</label>
//       <input
//         type="tel"
//         name="contactMobile"
//         value={formData.contactMobile}
//         onChange={handleInputChange}
//         className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//         placeholder="+1 234 567 890"
//       />
//     </div>

//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
//       <input
//         type="email"
//         name="contactEmail"
//         value={formData.contactEmail}
//         onChange={handleInputChange}
//         className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//         placeholder="john.doe@example.com"
//       />
//     </div>
//   </div>
// );

// const Step3BusinessInfo = ({ formData, handleInputChange, handleFileChange }) => (
//   <div className="space-y-4 animate-fadeIn">
//     <h2 className="text-xl font-bold text-gray-800 mb-4">Business & Identity</h2>
    
//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Identity Type</label>
//       <select
//         name="identityType"
//         value={formData.identityType}
//         onChange={handleInputChange}
//         className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition bg-white"
//       >
//         <option value="tax_id">Tax ID / GST / VAT</option>
//         <option value="passport">Passport</option>
//         <option value="driving_license">Driving License</option>
//         <option value="national_id">National ID Card</option>
//       </select>
//     </div>

//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Identity Number</label>
//       <input
//         type="text"
//         name="identityNumber"
//         value={formData.identityNumber}
//         onChange={handleInputChange}
//         className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//         placeholder="Enter ID number"
//       />
//     </div>

//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Upload Identity Document</label>
//       <div className="flex items-center space-x-4">
//         <label className="flex-1 flex flex-col items-center justify-center h-32 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 transition">
//           <div className="flex flex-col items-center justify-center pt-5 pb-6">
//             {formData.identityImagePreview ? (
//               <img src={formData.identityImagePreview} alt="ID Preview" className="h-20 object-contain" />
//             ) : (
//               <>
//                 <ImageIcon className="w-8 h-8 mb-2 text-gray-500" />
//                 <p className="text-sm text-gray-500">Upload ID Image</p>
//               </>
//             )}
//           </div>
//           <input type="file" className="hidden" onChange={(e) => handleFileChange(e, 'identityImage', 'identityImagePreview')} />
//         </label>
//       </div>
//     </div>
//   </div>
// );

// const Step4AccountInfo = ({ formData, handleInputChange }) => (
//   <div className="space-y-4 animate-fadeIn">
//     <h2 className="text-xl font-bold text-gray-800 mb-4">Account Setup</h2>
    
//     <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
//       <div>
//         <label className="block text-sm font-medium text-gray-700 mb-1">Login Phone</label>
//         <input
//           type="tel"
//           name="accountPhone"
//           value={formData.accountPhone}
//           onChange={handleInputChange}
//           className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//           placeholder="Phone number used for login"
//         />
//       </div>
//       <div>
//         <label className="block text-sm font-medium text-gray-700 mb-1">Login Email</label>
//         <input
//           type="email"
//           name="accountEmail"
//           value={formData.accountEmail}
//           onChange={handleInputChange}
//           className="w-full p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//           placeholder="Email used for login"
//         />
//       </div>
//     </div>

//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Password</label>
//       <div className="relative">
//         <Lock className="absolute left-3 top-3 w-5 h-5 text-gray-400" />
//         <input
//           type="password"
//           name="password"
//           value={formData.password}
//           onChange={handleInputChange}
//           className="w-full pl-10 p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//           placeholder="Min 8 characters"
//         />
//       </div>
//     </div>

//     <div>
//       <label className="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
//       <div className="relative">
//         <Lock className="absolute left-3 top-3 w-5 h-5 text-gray-400" />
//         <input
//           type="password"
//           name="confirmPassword"
//           value={formData.confirmPassword}
//           onChange={handleInputChange}
//           className="w-full pl-10 p-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition"
//           placeholder="Re-enter password"
//         />
//       </div>
//     </div>
//   </div>
// );

// const Step5Map = ({ formData, setFormData }) => {
//   const mapRef = useRef(null);
//   const [clickPos, setClickPos] = useState(null);
//   const [searchQuery, setSearchQuery] = useState("");
//   const [isSearching, setIsSearching] = useState(false);

//   // Use state latitude/longitude to set initial marker if they exist
//   useEffect(() => {
//     if (formData.latitude && formData.longitude) {
//       // In a real map, we'd convert coordinates to pixel position. 
//       // For this mock, we'll just center it if coordinates were found.
//       setClickPos({ x: '50%', y: '50%' }); 
//     }
//   }, []);

//   const handleMapClick = (e) => {
//     if (!mapRef.current || isSearching) return;
//     const rect = mapRef.current.getBoundingClientRect();
//     const x = e.clientX - rect.left;
//     const y = e.clientY - rect.top;
    
//     const xPercent = (x / rect.width) * 100;
//     const yPercent = (y / rect.height) * 100;

//     setClickPos({ x: `${xPercent}%`, y: `${yPercent}%` });

//     const mockLat = (20 + (Math.random() * 10)).toFixed(6);
//     const mockLng = (77 + (Math.random() * 10)).toFixed(6);

//     setFormData(prev => ({
//       ...prev,
//       latitude: mockLat,
//       longitude: mockLng
//     }));
//   };

//   const handleSearch = async (e) => {
//     e.preventDefault();
//     if (!searchQuery.trim()) return;

//     setIsSearching(true);
    
//     try {
//       const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent?key=${apiKey}`, {
//         method: 'POST',
//         headers: { 'Content-Type': 'application/json' },
//         body: JSON.stringify({
//           contents: [{ parts: [{ text: `Geocode the following address and provide the response in JSON format with "lat" and "lng" keys: ${searchQuery}` }] }],
//           generationConfig: { responseMimeType: "application/json" }
//         })
//       });

//       if (!response.ok) throw new Error('Search failed');
      
//       const result = await response.json();
//       const coords = JSON.parse(result.candidates[0].content.parts[0].text);
      
//       if (coords.lat && coords.lng) {
//         setFormData(prev => ({
//           ...prev,
//           latitude: coords.lat.toString(),
//           longitude: coords.lng.toString()
//         }));
//         // Center marker for mock visual
//         setClickPos({ x: '50%', y: '50%' });
//       }
//     } catch (error) {
//       console.error("Geocoding error:", error);
//       // Fallback for demo if API fails
//       const mockLat = (12 + (Math.random() * 20)).toFixed(6);
//       const mockLng = (72 + (Math.random() * 15)).toFixed(6);
//       setFormData(prev => ({ ...prev, latitude: mockLat, longitude: mockLng }));
//       setClickPos({ x: '50%', y: '50%' });
//     } finally {
//       setIsSearching(false);
//     }
//   };

//   return (
//     <div className="space-y-4 animate-fadeIn">
//       <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-2">
//         <div>
//           <h2 className="text-xl font-bold text-gray-800">Service Location</h2>
//           <p className="text-sm text-gray-500">Search or click on the map to pin your location.</p>
//         </div>
//       </div>

//       {/* Search Bar */}
//       <form onSubmit={handleSearch} className="flex gap-2">
//         <div className="relative flex-1">
//           <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
//           <input
//             type="text"
//             value={searchQuery}
//             onChange={(e) => setSearchQuery(e.target.value)}
//             placeholder="Search address, city, or landmark..."
//             className="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none transition"
//           />
//         </div>
//         <button
//           type="submit"
//           disabled={isSearching}
//           className="bg-blue-600 text-white px-5 py-2.5 rounded-lg font-medium hover:bg-blue-700 transition flex items-center gap-2 disabled:bg-blue-400"
//         >
//           {isSearching ? <Loader2 className="w-4 h-4 animate-spin" /> : "Search"}
//         </button>
//       </form>
      
//       <div 
//         ref={mapRef}
//         onClick={handleMapClick}
//         className="relative w-full h-80 bg-slate-100 rounded-xl overflow-hidden cursor-crosshair border-2 border-gray-200 group hover:shadow-inner transition-all"
//       >
//         {/* Mock Map Background Grid */}
//         <div className="absolute inset-0 opacity-10" 
//              style={{ 
//                backgroundImage: 'linear-gradient(#3b82f6 1px, transparent 1px), linear-gradient(90deg, #3b82f6 1px, transparent 1px)', 
//                backgroundSize: '40px 40px' 
//              }}
//         ></div>
        
//         <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
//           <div className="flex flex-col items-center opacity-20">
//             <MapIcon className="w-16 h-16 text-blue-900 mb-2" />
//             <span className="text-xl font-bold text-blue-900 uppercase tracking-widest">Interactive Map View</span>
//           </div>
//         </div>

//         {/* User Marker */}
//         {clickPos && (
//           <div 
//             className="absolute transform -translate-x-1/2 -translate-y-full transition-all duration-300 ease-out z-20"
//             style={{ left: clickPos.x, top: clickPos.y }}
//           >
//             <div className="relative">
//               <MapPin className="w-10 h-10 text-red-600 drop-shadow-lg" fill="currentColor" />
//               <div className="absolute -top-1 -right-1 w-3 h-3 bg-white rounded-full border-2 border-red-600 animate-ping"></div>
//             </div>
//           </div>
//         )}
        
//         {/* Instruction overlay if no selection */}
//         {!clickPos && !formData.latitude && (
//           <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
//             <div className="bg-white/90 backdrop-blur-sm px-6 py-3 rounded-full text-blue-800 text-sm font-semibold shadow-xl border border-blue-100">
//               Click anywhere or search to pin location
//             </div>
//           </div>
//         )}

//         {/* Loading Overlay */}
//         {isSearching && (
//           <div className="absolute inset-0 bg-white/40 backdrop-blur-[1px] flex items-center justify-center z-30">
//             <div className="bg-white p-4 rounded-2xl shadow-2xl flex items-center gap-3">
//               <Loader2 className="w-6 h-6 text-blue-600 animate-spin" />
//               <span className="font-semibold text-gray-700">Locating...</span>
//             </div>
//           </div>
//         )}
//       </div>

//       <div className="grid grid-cols-2 gap-4">
//         <div className="bg-white border border-gray-200 p-3 rounded-xl shadow-sm">
//           <label className="block text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Latitude</label>
//           <div className="text-gray-800 font-mono text-sm font-semibold">{formData.latitude || '--.------'}</div>
//         </div>
//         <div className="bg-white border border-gray-200 p-3 rounded-xl shadow-sm">
//           <label className="block text-[10px] font-bold text-gray-400 uppercase tracking-wider mb-1">Longitude</label>
//           <div className="text-gray-800 font-mono text-sm font-semibold">{formData.longitude || '--.------'}</div>
//         </div>
//       </div>
//     </div>
//   );
// };

// const SuccessScreen = ({ email, onReset }) => (
//   <div className="text-center py-12 animate-fadeIn">
//     <div className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
//       <CheckCircle className="w-10 h-10 text-green-600" />
//     </div>
//     <h2 className="text-3xl font-bold text-gray-800 mb-4">Registration Successful!</h2>
//     <p className="text-gray-600 mb-8 max-w-md mx-auto">
//       Your provider application has been submitted successfully. We have sent a confirmation email to <span className="font-semibold text-gray-800">{email}</span>.
//     </p>
//     <button 
//       onClick={onReset}
//       className="bg-blue-600 text-white px-8 py-3 rounded-lg shadow-lg hover:bg-blue-700 transition"
//     >
//       Back to Home
//     </button>
//   </div>
// );

// export default function Provider() {
//   const [currentStep, setCurrentStep] = useState(1);
//   const [isSubmitted, setIsSubmitted] = useState(false);
  
//   // Unified State for all steps
//   const [formData, setFormData] = useState({
//     companyName: '',
//     companyMobile: '',
//     companyEmail: '',
//     zone: '',
//     address: '',
//     companyImage: null,
//     companyImagePreview: null,
//     contactName: '',
//     contactMobile: '',
//     contactEmail: '',
//     identityType: 'tax_id',
//     identityNumber: '',
//     identityImage: null,
//     identityImagePreview: null,
//     accountPhone: '',
//     accountEmail: '',
//     password: '',
//     confirmPassword: '',
//     latitude: '',
//     longitude: ''
//   });

//   const steps = [
//     { id: 1, title: 'General Info', icon: Building2 },
//     { id: 2, title: 'Contact Person', icon: User },
//     { id: 3, title: 'Business Info', icon: Briefcase },
//     { id: 4, title: 'Account', icon: Lock },
//     { id: 5, title: 'Location', icon: MapPin },
//   ];

//   const handleInputChange = (e) => {
//     const { name, value } = e.target;
//     setFormData(prev => ({ ...prev, [name]: value }));
//   };

//   const handleFileChange = (e, fieldName, previewName) => {
//     const file = e.target.files[0];
//     if (file) {
//       setFormData(prev => ({
//         ...prev,
//         [fieldName]: file,
//         [previewName]: URL.createObjectURL(file)
//       }));
//     }
//   };

//   const nextStep = () => {
//     if (currentStep < 5) setCurrentStep(prev => prev + 1);
//   };

//   const prevStep = () => {
//     if (currentStep > 1) setCurrentStep(prev => prev - 1);
//   };

//   const handleSubmit = (e) => {
//     e.preventDefault();
//     if (formData.password !== formData.confirmPassword) {
//       alert("Passwords do not match!");
//       return;
//     }
//     console.log("Form Submitted:", formData);
//     setIsSubmitted(true);
//   };

//   return (
//     <div className="min-h-screen bg-slate-50 flex items-center justify-center p-4 md:p-8 font-sans">
//       <div className="bg-white w-full max-w-5xl rounded-3xl shadow-[0_20px_50px_rgba(0,0,0,0.1)] overflow-hidden flex flex-col md:flex-row min-h-[700px]">
        
//         {/* Sidebar */}
//         <div className="md:w-1/3 bg-blue-700 p-8 md:p-12 text-white flex flex-col justify-between relative overflow-hidden">
//           <div className="absolute top-0 left-0 w-full h-full opacity-10 pointer-events-none">
//              <div className="absolute -top-24 -left-24 w-64 h-64 bg-white rounded-full blur-3xl"></div>
//              <div className="absolute -bottom-24 -right-24 w-64 h-64 bg-blue-400 rounded-full blur-3xl"></div>
//           </div>

//           <div className="relative z-10">
//             <div className="flex items-center gap-3 mb-12">
//               <div className="bg-white p-2 rounded-xl shadow-lg">
//                 <Briefcase className="w-6 h-6 text-blue-700" />
//               </div>
//               <h1 className="text-2xl font-black tracking-tight">ServiFlow</h1>
//             </div>
            
//             <div className="space-y-8">
//               {steps.map((s, idx) => (
//                 <div key={s.id} className="flex items-center gap-4 relative group">
//                   {idx !== steps.length - 1 && (
//                     <div className={`absolute left-[15px] top-10 w-0.5 h-10 ${s.id < currentStep ? 'bg-emerald-400' : 'bg-blue-500/30'}`}></div>
//                   )}
                  
//                   <div className={`
//                     w-8 h-8 rounded-full flex items-center justify-center border-2 transition-all duration-500 z-10 font-bold text-xs
//                     ${s.id === currentStep ? 'bg-white text-blue-700 border-white scale-110 shadow-[0_0_15px_rgba(255,255,255,0.4)]' : ''}
//                     ${s.id < currentStep ? 'bg-emerald-400 border-emerald-400 text-blue-900' : 'border-blue-400/50 text-blue-300'}
//                   `}>
//                     {s.id < currentStep ? <CheckCircle className="w-5 h-5" /> : s.id}
//                   </div>
//                   <div className={`transition-all duration-300 ${s.id === currentStep ? 'text-white font-bold translate-x-1' : 'text-blue-200'}`}>
//                     <div className="text-[10px] uppercase tracking-widest opacity-60 leading-none mb-1">Step {s.id}</div>
//                     <div className="text-sm">{s.title}</div>
//                   </div>
//                 </div>
//               ))}
//             </div>
//           </div>
          
//           <div className="relative z-10 text-[10px] text-blue-300 font-medium uppercase tracking-widest mt-12">
//             Secure Onboarding Dashboard
//           </div>
//         </div>

//         {/* Content Area */}
//         <div className="md:w-2/3 p-8 md:p-12 flex flex-col w-full bg-white">
//           {isSubmitted ? (
//             <SuccessScreen email={formData.companyEmail} onReset={() => window.location.reload()} />
//           ) : (
//             <div className="flex flex-col h-full">
//               <div className="flex-1">
//                 {currentStep === 1 && <Step1GeneralInfo formData={formData} handleInputChange={handleInputChange} handleFileChange={handleFileChange} />}
//                 {currentStep === 2 && <Step2ContactPerson formData={formData} handleInputChange={handleInputChange} />}
//                 {currentStep === 3 && <Step3BusinessInfo formData={formData} handleInputChange={handleInputChange} handleFileChange={handleFileChange} />}
//                 {currentStep === 4 && <Step4AccountInfo formData={formData} handleInputChange={handleInputChange} />}
//                 {currentStep === 5 && <Step5Map formData={formData} setFormData={setFormData} />}
//               </div>

//               <div className="mt-10 pt-8 border-t border-slate-100 flex justify-between items-center">
//                 <button
//                   onClick={prevStep}
//                   disabled={currentStep === 1}
//                   className={`flex items-center px-6 py-3 rounded-xl font-bold text-sm transition-all
//                     ${currentStep === 1 
//                       ? 'text-slate-300 cursor-not-allowed' 
//                       : 'text-slate-500 hover:bg-slate-50 hover:text-slate-900'
//                     }`}
//                 >
//                   <ChevronLeft className="w-5 h-5 mr-1" />
//                   Back
//                 </button>

//                 <div className="flex items-center gap-3">
//                   <div className="hidden sm:block text-[10px] font-bold text-slate-400 uppercase tracking-tighter">
//                     {currentStep} / 5 Steps
//                   </div>
//                   {currentStep === 5 ? (
//                     <button
//                       onClick={handleSubmit}
//                       className="bg-emerald-500 text-white px-8 py-3 rounded-xl font-bold text-sm hover:bg-emerald-600 transition shadow-xl shadow-emerald-100 flex items-center gap-2"
//                     >
//                       Complete Registration
//                       <CheckCircle className="w-5 h-5" />
//                     </button>
//                   ) : (
//                     <button
//                       onClick={nextStep}
//                       className="bg-blue-600 text-white px-10 py-3 rounded-xl font-bold text-sm hover:bg-blue-700 transition shadow-xl shadow-blue-100 flex items-center gap-2"
//                     >
//                       Continue
//                       <ChevronRight className="w-5 h-5" />
//                     </button>
//                   )}
//                 </div>
//               </div>
//             </div>
//           )}
//         </div>
//       </div>
//     </div>
//   );
// }