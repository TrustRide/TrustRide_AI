
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Send, Mic } from "lucide-react";

interface ChatInputProps {
  onSendMessage: (message: string) => void;
}

export const ChatInput = ({ onSendMessage }: ChatInputProps) => {
  const [message, setMessage] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (message.trim()) {
      onSendMessage(message);
      setMessage("");
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
