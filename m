Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7973515EE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811834; cv=none; b=uW6GyB0XBnSAVmW+xuv5Dh9KSjHrs/do29fHpMOJ5ErnyaYLXdOMkFmXjn6LYOP63jrKElbBLHpiZWt/anouS3Wn0U7p/HT7scc5MfLqbrErJBj5T82SyjrvX7zql4Ddi9hec36LhgK4ntgbGOrJsFU5H83zDhMREvTEGVzO7pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811834; c=relaxed/simple;
	bh=X06aGt5TcD0ybUe4qxjs1/MvCceDrQgf7Pwby/2x9lU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HLiWlpPrcpPKhvHumg47E3o+mmTNbcFpWo6axMFmjSSk7DIP01tGsfUNfcyiFXy/Qq/XMagrcA9s6lLr/a3wCMD+iay78kULDq142LpZLk3m9bRoHiUpJgJvT1wgLu9D1xduIY7qeQCjZoFasy809pJVGhfmWVyZHj5VjexX2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e9fdc2870fso2568618a34.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 19:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785811831; x=1786416631;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4iu+m/OXgvK2cVLedf453MP76zfqaed/KskxWW5eNw=;
        b=GyBkeM2RbMnQV5jKrekA7xl1hT3R68j+nHgnujf/Z6W6xnsTa8uXZ4PQ3aARXI/VQK
         4nHuKLmxedz2vSK4AwZh9DARmuj3b1AAUKMMHK0nsXw/lvspAhL49m72aP3i8KZrELZM
         SQkuQ+TU1QQmXiL4c4skvPJGp/QVikWVeyJpvqdxgcTOPaAy5rW2b5fGmnD3TCtcBixX
         NtH3nRl29h2os36JOfBIMApgR41QE4ui+ewbHjyJ9ObpJ9sTpBBtlw1lu71gwN5b/C2O
         5fumuzjCH0z8p2SjAEsINBkmsEXi5TT1QmlUZ+HVl/w6HWGYfvnTblFLi9N3rtdAcymw
         tMpw==
X-Forwarded-Encrypted: i=1; AHgh+RrSINcnESlNUlOTDoSlXnGB/ETQ2j28UJWU2W90ioI2Whm5mvVEcVpjplcMrNX/LGkRM0FWKGyF2ZTjXwYXCYdetJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddO4c6owHflmp/eK6uc8pTV0PNnybF8fdFotVXjErGPcA6jZU
	EYqjiOzPNiM9QBiVnQPJ8C0/TPGml8JhDECQWRvU9uUbovhVNOQK1rfw/HJ+YN+nkkAOj314/IN
	ZUEfpQGQkgv2c92cmujyjaeqFtjTXF3WDRbQs8FYG/nAeFkIqC4u3iVa8qto=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1e8:b0:497:d371:21c8 with SMTP id
 5614622812f47-4af5e2cd936mr19260946b6e.19.1785811831365; Mon, 03 Aug 2026
 19:50:31 -0700 (PDT)
Date: Mon, 03 Aug 2026 19:50:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a715377.d35e88fd.de8b.000a.GAE@google.com>
Subject: [syzbot] [trace?] KCSAN: data-race in ring_buffer_unlock_commit / ring_buffer_unlock_commit
From: syzbot <syzbot+0168fe25f9e5d46bd5fe@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13731649580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=0168fe25f9e5d46bd5fe
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1a0ae21bd78/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9be505d18eb6/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ab6a3838bc0/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0168fe25f9e5d46bd5fe@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in ring_buffer_unlock_commit / ring_buffer_unlock_commit

write to 0xffff888100074cb4 of 1 bytes by task 8271 on cpu 1:
 rb_wakeups kernel/trace/ring_buffer.c:4295 [inline]
 ring_buffer_unlock_commit+0x6a/0x440 kernel/trace/ring_buffer.c:4495
 __buffer_unlock_commit kernel/trace/trace.h:1697 [inline]
 trace_buffer_unlock_commit_regs+0x43/0x310 kernel/trace/trace.c:2049
 trace_event_buffer_commit+0x149/0x590 kernel/trace/trace.c:2024
 do_trace_event_raw_event_hrtimer_setup include/trace/events/timer.h:193 [inline]
 trace_event_raw_event_hrtimer_setup+0xc9/0x170 include/trace/events/timer.h:193
 __do_trace_hrtimer_setup include/trace/events/timer.h:193 [inline]
 trace_hrtimer_setup include/trace/events/timer.h:193 [inline]
 debug_setup_on_stack kernel/time/hrtimer.c:523 [inline]
 hrtimer_setup_sleeper_on_stack+0xd1/0xf0 kernel/time/hrtimer.c:2366
 schedule_hrtimeout_range_clock+0x71/0x1a0 kernel/time/sleep_timeout.c:211
 schedule_hrtimeout_range+0x28/0x40 kernel/time/sleep_timeout.c:263
 poll_schedule_timeout fs/select.c:241 [inline]
 do_select+0xed3/0xfa0 fs/select.c:603
 core_sys_select+0x453/0x730 fs/select.c:677
 do_pselect fs/select.c:770 [inline]
 __do_sys_pselect6 fs/select.c:809 [inline]
 __se_sys_pselect6+0x23f/0x2a0 fs/select.c:800
 __x64_sys_pselect6+0x78/0x90 fs/select.c:800
 x64_sys_call+0x8d5/0x3020 arch/x86/include/generated/asm/syscalls_64.h:271
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888100074cb4 of 1 bytes by task 8264 on cpu 0:
 rb_wakeups kernel/trace/ring_buffer.c:4294 [inline]
 ring_buffer_unlock_commit+0x54/0x440 kernel/trace/ring_buffer.c:4495
 __buffer_unlock_commit kernel/trace/trace.h:1697 [inline]
 trace_buffer_unlock_commit_regs+0x43/0x310 kernel/trace/trace.c:2049
 trace_event_buffer_commit+0x149/0x590 kernel/trace/trace.c:2024
 do_trace_event_raw_event_sock_msg_length include/trace/events/sock.h:267 [inline]
 trace_event_raw_event_sock_msg_length+0x10f/0x1c0 include/trace/events/sock.h:267
 __do_trace_sock_recv_length include/trace/events/sock.h:304 [inline]
 trace_sock_recv_length include/trace/events/sock.h:304 [inline]
 call_trace_sock_recv_length+0xa2/0xc0 net/socket.c:1120
 sock_recvmsg_nosec+0xdf/0xf0 net/socket.c:1131
 ____sys_recvmsg+0x26f/0x280 net/socket.c:2902
 ___sys_recvmsg+0x11f/0x3a0 net/socket.c:2946
 do_recvmmsg+0x1e5/0x560 net/socket.c:3041
 __sys_recvmmsg net/socket.c:3115 [inline]
 __do_sys_recvmmsg net/socket.c:3138 [inline]
 __se_sys_recvmmsg net/socket.c:3131 [inline]
 __x64_sys_recvmmsg+0xe5/0x170 net/socket.c:3131
 x64_sys_call+0x80f/0x3020 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x01 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 8264 Comm: syz.5.1654 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
