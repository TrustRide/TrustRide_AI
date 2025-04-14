
import { MessageCircleIcon } from "lucide-react";
import { useState } from "react";
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/sheet";
import { ChatWindow } from "@/components/ChatWindow";

export const ChatbotButton = () => {
  const [isOpen, setIsOpen] = useState(false);
  
  return (
    <Sheet open={isOpen} onOpenChange={setIsOpen}>
      <SheetTrigger asChild>
        <button className="fixed bottom-6 right-6 bg-chatbot-primary text-white rounded-full p-4 shadow-lg hover:bg-chatbot-accent transition-all duration-200 animate-bounce-in">
          <MessageCircleIcon className="h-6 w-6" />
          <span className="sr-only">채팅 열기</span>
        </button>
      </SheetTrigger>
      <SheetContent className="sm:max-w-md p-0 border-0" side="right">
        <div className="flex flex-col h-full">
          <h2 className="sr-only">채팅 어시스턴트</h2>
          <ChatWindow />
        </div>
      </SheetContent>
    </Sheet>
  );
};
