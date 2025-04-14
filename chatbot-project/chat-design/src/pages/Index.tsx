
import { ChatbotButton } from "@/components/ChatbotButton";
import { ChatWindow } from "@/components/ChatWindow";

// const Index = () => {
//   return (
//     <div className="min-h-screen flex items-center justify-center bg-gradient-to-tr from-purple-50 to-blue-50 p-4">
//       <div className="w-full max-w-md text-center">
//         <h1 className="text-3xl font-bold text-chatbot-accent mb-2">한국어 채팅 어시스턴트</h1>
//         <p className="text-gray-600 mb-8">오른쪽 아래 아이콘을 클릭하여 채팅을 시작하세요</p>
//         <div className="bg-white p-6 rounded-lg shadow-md">
//           <h2 className="text-xl font-semibold text-gray-800 mb-4">사용 방법</h2>
//           <ol className="text-left text-gray-600 space-y-2">
//             <li className="flex items-start">
//               <span className="inline-flex items-center justify-center bg-chatbot-primary text-white rounded-full w-6 h-6 mr-2 flex-shrink-0 text-sm">1</span>
//               <span>오른쪽 하단의 동그란 채팅 아이콘을 클릭하세요</span>
//             </li>
//             <li className="flex items-start">
//               <span className="inline-flex items-center justify-center bg-chatbot-primary text-white rounded-full w-6 h-6 mr-2 flex-shrink-0 text-sm">2</span>
//               <span>질문이나 요청사항을 입력하세요</span>
//             </li>
//             <li className="flex items-start">
//               <span className="inline-flex items-center justify-center bg-chatbot-primary text-white rounded-full w-6 h-6 mr-2 flex-shrink-0 text-sm">3</span>
//               <span>AI 어시스턴트가 즉시 답변해 드립니다</span>
//             </li>
//           </ol>
//         </div>
//       </div>
//       <ChatbotButton />
//     </div>
//   );
// };

// const Index = () => {
//   return <ChatWindow />;
// };

const Index = () => {
  return (
    <div className="w-screen h-screen">  {/* 화면 전체 높이 */}
      <ChatWindow />
    </div>
  );
};

export default Index;
