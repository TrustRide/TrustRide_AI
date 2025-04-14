
import { useRef, useEffect, useState } from "react";
import { ChatHeader } from "./ChatHeader";
import { ChatMessage } from "./ChatMessage";
import { ChatInput } from "./ChatInput";

interface Message {
  id: number;
  text: string;
  isBot: boolean;
  timestamp: string;
}

export const ChatWindow = () => {
  const [messages, setMessages] = useState<Message[]>([
    {
      id: 1,
      text: "안녕하세요! 무엇을 도와드릴까요?",
      isBot: true,
      timestamp: "오늘 14:25"
    }
  ]);
  
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const handleSendMessage = (text: string) => {
    // Add user message
    const newUserMessage: Message = {
      id: messages.length + 1,
      text,
      isBot: false,
      timestamp: new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' })
    };
    
    setMessages([...messages, newUserMessage]);
    
    // Simulate bot response after a short delay
    setTimeout(() => {
      const botResponses = [
        "더 필요한 것이 있으신가요?",
        "도움이 필요하시면 말씀해주세요.",
        "어떤 정보를 찾고 계신가요?",
        "더 구체적으로 말씀해주시면 더 잘 도와드릴 수 있어요.",
        "네, 알겠습니다. 다른 질문이 있으신가요?"
      ];
      
      const randomResponse = botResponses[Math.floor(Math.random() * botResponses.length)];
      
      const botReply: Message = {
        id: messages.length + 2,
        text: randomResponse,
        isBot: true,
        timestamp: new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' })
      };
      
      setMessages(prev => [...prev, botReply]);
    }, 1000);
  };

  return (
    <div className="flex flex-col w-full h-full rounded-lg overflow-hidden border shadow-lg">
      <ChatHeader botName="봇 어시스턴트" />
      <div className="flex-1 p-4 overflow-y-auto bg-chatbot-light">
        {messages.map((message) => (
          <ChatMessage
            key={message.id}
            message={message.text}
            isBot={message.isBot}
            timestamp={message.timestamp}
          />
        ))}
        <div ref={messagesEndRef} />
      </div>
      <ChatInput onSendMessage={handleSendMessage} />
    </div>
  );
};
