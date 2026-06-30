#include<stdio.h>
#include<fcntl.h>
#include<unistd.h>
#include<errno.h>
#include<string.h>
#include<syslog.h>


int writeBuf(int fd, char* content)
{
    ssize_t ret,len = strlen(content);
    while(len != 0 && (ret = write(fd,content,len))!=0)
    {
        if(ret == -1){
            if(errno == EINTR)
                continue;
            syslog(LOG_ERR, "write failed: %m");
            return 1;
        }
        len-=ret;
        content+=ret;
    }
    return 0;
}

int main(int argc, char**argv)
{
    openlog("WriteApp",LOG_PID,LOG_USER);

    if(argc!=3)
    {
        syslog(LOG_ERR, "Usage: %s <full_path> <content>",argv[0]);
        return 1;
    }

    char *path = argv[1];
    char *content = argv[2];

    int fd = creat(path, 0644);
    if(fd < 0)
    {
        syslog(LOG_ERR, "File creation failed: %m");
        return 1;
    }

    if(writeBuf(fd, content)) return 1;
    char endl[]="\n";
    if(writeBuf(fd, endl)) return 1;

    close(fd);
    syslog(LOG_DEBUG, "Writing %s to %s",content, path);
}