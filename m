Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78207282E1
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Dec 2024 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734294863; cv=none; b=p0zVYaVypqLgstLhlWv64W41jB3Fwo28JbkdycwwvtSPUyhh46/E+Jo9tlNIrMKB0rB8KKDwomQFXQ/91GkJ6Epfk0OJ3sojMPTsLugd2wFBg/ihZnOw5I99E0PO4ycKv4nT1qu41e4UiUsObu2FAEbFQ8jkkyFMFqOQQQj6L98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734294863; c=relaxed/simple;
	bh=Waxxm3a03RHGWskTJV98NxUCkL7ROLnmm6efw8OOYHc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WQXRTlzi9mND8auwfzbsTCBzg3u9Z2YPKDxxjBs2ARbkxIvvvmEjJvIkrWdABx5HPc9xKktqbk7E+0vrjnMjGVz1EfCsZ5Jc6ZGOfLdc3arr5qU80MMUVpcHAczFz1g8s8izRxPpyZXkUq8FyVb+87XZWIXfisay0/OUa9TzZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso72870315ab.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734294860; x=1734899660;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dSjkkiQNsIWrWIqrh0S/fXKzopFI5nimNNSb7MyngE=;
        b=PjAU5Mlb/Qf+k5n1BOyAbr4WNpLjtGZSlA/85jV9BlsxyGT/rlzefeOR9pFSJRRPl/
         mw5MBSiTR0EuC3wpmwWnNjkO0VsG0OvelNE/fVmjW1rMCVEDzYJycvUDgRcfDtKvzhR9
         VqmFAD/F5FLvkq00N2wX/fTrBWJV8QT41GZzC2l/U+abReTgbeXi7d09OOH7qL8ytDoq
         wvoYiHz6vMtw8mST9fUYPw3KAfEkcOm+s215XiRm5fDuZedWatYikMqdPPipYz1Rng7n
         dN+tkZr/Xc6+030vo+Ahrw7wMVO/EZfoV7yapazS6K8LIUJF/NdPYX8c97xKE2FT2Cke
         ISxg==
X-Forwarded-Encrypted: i=1; AJvYcCWKzBwAxucIc+rnz2kXE/Ldu+zVe/+LErMyPMHVtWKX1Ua8/o3mgxY9P/7kceBo9igBnTHG7017MI8RrubnFaZzKUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmlqkPNuNJJdSTnirABrAVXL6NFQWKEC1PYAsBb9WlxfLcU0C
	myaY599/uGGRZ8d3JgXu3sxrWoYKYu3kfmllR6h4LwUbL+Jrzpm50XU3m8O6jaFCPZa8XGnVJAy
	MTb1OAfMVIgE5a2tcINsmBi4bcDJ/Y2NQ+Vu6WDGg2wJ5BjxfK92YiHM=
X-Google-Smtp-Source: AGHT+IEfjwrujsZStOAZTnTtsItcJk3oZFrIZ6DB3Gp0HviM7eUu07ATY/n75HfkE5f83Zo+SUDdMUGTQE64hkvRzRImQJGgqAd5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a7:6e72:fbb3 with SMTP id
 e9e14a558f8ab-3afeda2e98emr104856965ab.4.1734294860681; Sun, 15 Dec 2024
 12:34:20 -0800 (PST)
Date: Sun, 15 Dec 2024 12:34:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f3d4c.050a0220.37aaf.0104.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close
From: syzbot <syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d92cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12de78f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d92cdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5829 at kernel/trace/trace.c:8464 tracing_buffers_mmap_close kernel/trace/trace.c:8464 [inline]
WARNING: CPU: 1 PID: 5829 at kernel/trace/trace.c:8464 tracing_buffers_mmap_close+0xe3/0x130 kernel/trace/trace.c:8459
Modules linked in:
CPU: 1 UID: 0 PID: 5829 Comm: syz-executor210 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:tracing_buffers_mmap_close kernel/trace/trace.c:8464 [inline]
RIP: 0010:tracing_buffers_mmap_close+0xe3/0x130 kernel/trace/trace.c:8459
Code: 75 46 48 8b 7b 08 e8 7c 85 ff ff 31 ff 89 c3 89 c6 e8 21 63 fb ff 85 db 75 0a 48 83 c4 08 5b e9 d3 60 fb ff e8 ce 60 fb ff 90 <0f> 0b 90 48 83 c4 08 5b e9 c0 60 fb ff e8 bb e7 5d 00 eb 87 e8 e4
RSP: 0018:ffffc90003857bb8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffed RCX: ffffffff819ddd0f
RDX: ffff8880339f3c00 RSI: ffffffff819ddd22 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffed R11: 0000000000000000 R12: ffffffff819ddc40
R13: 0000000000000001 R14: ffff88807610a548 R15: 0000000000000ff9
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f44ec4e1110 CR3: 000000000db7e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_close mm/internal.h:147 [inline]
 remove_vma+0x91/0x1b0 mm/vma.c:380
 exit_mmap+0x4e2/0xb20 mm/mmap.c:1692
 __mmput+0x12a/0x4c0 kernel/fork.c:1353
 mmput+0x62/0x70 kernel/fork.c:1375
 exit_mm kernel/exit.c:570 [inline]
 do_exit+0x9bf/0x2d70 kernel/exit.c:925
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
 x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f44ec464b49
Code: Unable to access opcode bytes at 0x7f44ec464b1f.
RSP: 002b:00007ffc68920f08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f44ec464b49
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f44ec4e02b0 R08: ffffffffffffffb8 R09: 0000000100000000
R10: 0000000000000012 R11: 0000000000000246 R12: 00007f44ec4e02b0
R13: 0000000000000000 R14: 00007f44ec4e0d00 R15: 00007f44ec436160
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
