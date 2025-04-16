
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Send, Mic } from "lucide-react";

interface ChatInputProps {
  onSendMessage: (message: string, isBot: boolean) => void;
}

export const ChatInput = ({ onSendMessage }: ChatInputProps) => {
  const [message, setMessage] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const trimmed = message.trim();
    if (!trimmed) return;
    
    onSendMessage(trimmed, false); // 유저 메시지 추가
    setMessage(""); // 입력창 초기화

    try {
      const response = await fetch("http://localhost:8000/terms/ask", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ query: trimmed }),
      });

      if (!response.ok) {
        throw new Error("서버 오류");
      }

      const data = await response.json();
      
      if (data.answer === "") {
        onSendMessage("죄송해요, 해당 질문에 대한 답변이 없어요 😢", true);
      } else {
        // 챗봇 응답 추가
        onSendMessage(data.answer, true);
      }

    } catch (error) {
      console.error("LLM 요청 실패:", error);
      onSendMessage("죄송해요, 답변을 불러올 수 없어요 😢", true);
    }
  };  

  return (
    <form onSubmit={handleSubmit} className="flex items-center gap-2 p-2 border-t">
      <Button
        type="button"
        variant="ghost"
        size="icon"
        className="text-gray-500 hover:text-chatbot-primary"
      >
        <Mic className="h-5 w-5" />
      </Button>
      <Input
        value={message}
        onChange={(e) => setMessage(e.target.value)}
        placeholder="메시지를 입력하세요..."
        className="flex-1 bg-gray-100 border-none focus-visible:ring-1 focus-visible:ring-chatbot-primary"
      />
      <Button 
        type="submit" 
        size="icon" 
        disabled={!message.trim()}
        className="bg-chatbot-primary hover:bg-chatbot-accent text-white"
      >
        <Send className="h-4 w-4" />
      </Button>
    </form>
  );

};
