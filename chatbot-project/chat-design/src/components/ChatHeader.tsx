
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { BotIcon } from "lucide-react";

interface ChatHeaderProps {
  botName: string;
}

export const ChatHeader = ({ botName }: ChatHeaderProps) => {
  return (
    <div className="flex items-center gap-3 border-b p-3 bg-white shadow-sm">
      <Avatar>
        <AvatarFallback className="bg-chatbot-primary text-white">
          <BotIcon className="h-5 w-5" />
        </AvatarFallback>
      </Avatar>
      <div>
        <h2 className="font-medium text-base">{botName}</h2>
        <p className="text-xs text-gray-500">온라인</p>
      </div>
    </div>
  );
};
