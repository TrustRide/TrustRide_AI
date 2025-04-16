
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
      timestamp: new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' })
    }
  ]);
  
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const handleSendMessage = (text: string, isBot: boolean = false) => {
    
    const newMessage: Message = {
      id: messages.length + 1,
      text,
      isBot,
      timestamp: new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' })
    };
    
    setMessages((prev) => [...prev, newMessage]);
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
