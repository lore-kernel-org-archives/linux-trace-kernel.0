Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB2284681
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194970; cv=none; b=uke2wednkeyQHDPV+hj45uIPNA07X4v4cAdI11puZjvRCJbTPA1jKcaK/i0is4kfxp0Zop/2Ci/Kd1Lrir72S+1Rx0UeaPqg0CUE4Wf2UZW3vuGpWAFbuVwhR4dVbSJ2rAJOCS66ICni6ZYD8QgReIO953gPTTcgGv/WH5slWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194970; c=relaxed/simple;
	bh=Hx8xg4Q3YZNg+B+YcciN/GqtXAP+VKmU7CPAN+XqUoE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dIB5BZpdiUbSPRM8SaeA9S49YlDB7xoDM0FflEhm8Q+JKNtn4x9IKGIo429qWcLu7IKL8nwR9gssbm/FefxvXLnTYfB8jdAN5qhwYLodtC2SvpCVoqZ+z0+t8j+7+DOWc/Y2Pqx4FFgcrELSI4vCNVQXfLJzx8DtdBHHaUGIa5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddcf82bb53so3686305ab.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Jun 2025 00:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749194968; x=1749799768;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkC1CQYhCFxp5umRR9A7rPhWTPMN+brYYVj9zEjlK/E=;
        b=ny9dPQQ3zzoyl+KD4jNwNGgaNwGHJ2HOLOmtwALgD5J1rdAcM6U0MMGyKEnWq5IB8A
         q5qTeY506bB0MVj66VzjpN2fJcx8DwUWvtFGXQPIe8CREFerA6OUtBSDFHGUI+OGMog7
         X0X9dPLT48r9kCZp/iQwFZ+trDwYxrTqqcXBnKqXpm6g3cHdgA9476Mjz7CSyEQwnxvX
         Scujyu4oGslVa77Qfa9yHWeKy0G9B8L5lzkwMZgxEl3/Dyz9vrEtgrrkoVOwDd+Ckap9
         byKHnmMBUQwiyXFA+ru6fPkBsilFQisfoVoOFDlsnXc9WVqQASdt/+IKe3zuy7TJ4IY9
         0vNA==
X-Forwarded-Encrypted: i=1; AJvYcCU+AMjDMpWz162quz1IFlVNSJfNBWZ4m4+kzUrv9IRlN5sfWHOn9ff2ZzJi5BFdYlDUQF5gBLOPCo0d4Cmwk8b0ico=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5hTAV94WZTx2E4D/4OXlSXyTcKjJJaFyMrurHcR4mFTnwuK7
	U+RkVauY0VmsFPLvxhAlrkWqXLX0ObIqH+WhTNxUSCooJ8coTnG8QqHMdT/zfGNmduQYCB+vRAh
	OFvr15lTxevg2+yqLOzmK2DKUY43Dj5qHrSWABy9bVMclJlFTzSC/uQucvx4=
X-Google-Smtp-Source: AGHT+IEE4pL5ZtStkDDa7mNGv2IgZ5NKSK97dVGNiOBCsyWhuONN/TeGZSwK3x2AHFF4EmLvrnSZ7BORYRne0UnJaiCrzEvM3xu6
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2142:b0:3dd:c4ed:39ba with SMTP id
 e9e14a558f8ab-3ddce3ce038mr26780965ab.1.1749194968203; Fri, 06 Jun 2025
 00:29:28 -0700 (PDT)
Date: Fri, 06 Jun 2025 00:29:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684298d8.050a0220.2461cf.0039.GAE@google.com>
Subject: [syzbot] [trace?] BUG: corrupted list in ring_buffer_subbuf_order_set
From: syzbot <syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cd2e103d57e5 Merge tag 'hardening-v6.16-rc1-fix1-take2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f0680c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d97b092471e3ab82
dashboard link: https://syzkaller.appspot.com/bug?extid=05d673e83ec640f0ced9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1795b970580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b281d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/14cc036168b8/disk-cd2e103d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ce688b4cfd5/vmlinux-cd2e103d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62da26310dac/bzImage-cd2e103d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com

 slab kmalloc-1k start ffff88801b488800 pointer offset 576 size 1024
list_del corruption. prev->next should be ffff88802a7d3180, but was ffff88801b488a40. (prev=ffff88801b488a40)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:62!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5851 Comm: syz-executor420 Not tainted 6.15.0-syzkaller-10820-gcd2e103d57e5 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__list_del_entry_valid_or_report+0x17a/0x200 lib/list_debug.c:62
Code: 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 8d 00 00 00 48 8b 55 00 48 89 e9 48 89 de 48 c7 c7 40 33 f5 8b e8 f7 0d be fc 90 <0f> 0b 4c 89 e7 e8 1c aa 21 fd 48 89 ea 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000436fb70 EFLAGS: 00010286
RAX: 000000000000006d RBX: ffff88802a7d3180 RCX: ffffffff819a75b9
RDX: 0000000000000000 RSI: ffffffff819af446 RDI: 0000000000000005
RBP: ffff88801b488a40 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88802a7d3e00
R13: ffff88802a7d3180 R14: ffff88802a7d3e00 R15: 0000000000000001
FS:  0000555580420380(0000) GS:ffff888124a75000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e1bcb9130 CR3: 0000000075590000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 ring_buffer_subbuf_order_set+0x92e/0x18f0 kernel/trace/ring_buffer.c:6921
 buffer_subbuf_size_write+0x182/0x280 kernel/trace/trace.c:9546
 vfs_write+0x2a0/0x1150 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1e1bc3eca9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe8f63c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1e1bc3eca9
RDX: 000000000000fdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 00000000000000a0 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000246 R12: 00000000000175b3
R13: 00007fffe8f63c5c R14: 00007fffe8f63c70 R15: 00007fffe8f63c60
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x17a/0x200 lib/list_debug.c:62
Code: 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 8d 00 00 00 48 8b 55 00 48 89 e9 48 89 de 48 c7 c7 40 33 f5 8b e8 f7 0d be fc 90 <0f> 0b 4c 89 e7 e8 1c aa 21 fd 48 89 ea 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000436fb70 EFLAGS: 00010286
RAX: 000000000000006d RBX: ffff88802a7d3180 RCX: ffffffff819a75b9
RDX: 0000000000000000 RSI: ffffffff819af446 RDI: 0000000000000005
RBP: ffff88801b488a40 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88802a7d3e00
R13: ffff88802a7d3180 R14: ffff88802a7d3e00 R15: 0000000000000001
FS:  0000555580420380(0000) GS:ffff888124a75000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1e1bcb60d0 CR3: 0000000075590000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
