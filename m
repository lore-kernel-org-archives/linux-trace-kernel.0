Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F802321F30
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417974; cv=none; b=ihikj75r33lkXXRwAPgccv4Ft6pZ6rTnan0YFXkkKFdM7gUR73/7jMfARwytuJzybbKO72OZD+/QF8J9gWBN3PRcgomSy0ezoJH8HvyjN4if3Bpu5WnE6/AOFeYhvV6pzsg05Qx0+1quX3xjqrXFda9/asMOsEceC6jMdsRprPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417974; c=relaxed/simple;
	bh=mtfgJC6mRhWeUBamsoa21BCrYCeBPdeJ0l1lldAejIA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tN3ZIX8qc1MT2p1UsSoJUC/ZDTYBRln+x1T9NHR9ZPrE1B97BDoRNdFoaOmqSeKQ/ODhuVMCAxvCyFiOYEdIMg2SMPiAKVHAhuVOJqgLw1Ugzb0UYmdRcP1oRrz/OywzZqtepaKY9wD4OVnPKGbpVoWSP114aNP1k+mgE5ckufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8870219dce3so515130339f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417971; x=1758022771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DR1NbwOuCzEmWu0AkP/aduI1He0ADmflanoaSiOmxk=;
        b=dBtiXUTa+dMli9ygQTd+WiTfUqAYY4hJiQI6THKLGNtrOUn/Jvi3PA11pPdaaA9Frs
         0HKei7f+iAAq/m0WiJ5807kKFMb2qoeLM8I2ZzskKd2shtmItJDuAQTDBZ6OjFGbtzDP
         y/CBE3mB9Zfrn5e/CP2jAwB3Y/E3ZxCaSGMeXqkr3Kn53ZwZLN5idRt0czKY+ZlLuZYl
         vhVCtPIMshFBVSNDYd5/HYRUZVIxr+5r1fpC6Z7ckeDOKG9jclcqxcnLnKCcc4I3Tx8N
         CDPaV4ZHZ4etyPFgV914CtUOmCYmymoygxJP3ODFQ+8m/NbKdVy/B6I72pe4SDiGN6Aa
         1yjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn/DOr8TOVeBZTb9rb0lChGaCbZTPgW5BqjsjFaygXy2xtLqLx2KJ0GuiXRa5ayB3tMJ4uSRpwLUyi2FIzrbAzZNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6M65pQAb54dxykxhyUnLd7H/3gqC3LMuBWMnI7Zt+ZJsB/50
	VAyX8rcOnaoFKg58Qphf+Zve0eOqTwLpb2wMNl0Etz9UzHyZqCSGuUSoSF9ereTnvkkUf5u7qkM
	bMYk+s0rVvy/DhJBkbZxp70Rc08ANtk1mE9xuESTTja5HzfvEiDmkoRx4Zgk=
X-Google-Smtp-Source: AGHT+IF62rkxMyBfjOX8r3B7ezx1SAJDtsbixOyF1uN6h+vq0suHWhPGowKv7zE5VUYKTqLk5spLkMq/1EwguJXacmhYt/7RATzz
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-3fd8e98d28cmr172816265ab.10.1757417971719; Tue, 09 Sep 2025
 04:39:31 -0700 (PDT)
Date: Tue, 09 Sep 2025 04:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c011f3.050a0220.2ff435.0003.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in tracepoint_add_func (3)
From: syzbot <syzbot+eb730f6ee28e001e5a2e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f67162580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fecbb496f75d3d61
dashboard link: https://syzkaller.appspot.com/bug?extid=eb730f6ee28e001e5a2e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6f2a6d6a06c/disk-d69eb204.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3767a1bdccea/vmlinux-d69eb204.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2387e35c8e78/bzImage-d69eb204.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb730f6ee28e001e5a2e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 20575 at kernel/tracepoint.c:294 tracepoint_add_func+0xbf2/0xea0 kernel/tracepoint.c:294
Modules linked in:
CPU: 0 UID: 0 PID: 20575 Comm: syz.3.1826 Tainted: G          I         syzkaller #0 PREEMPT(full) 
Tainted: [I]=FIRMWARE_WORKAROUND
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:tracepoint_add_func+0xbf2/0xea0 kernel/tracepoint.c:294
Code: 54 12 fe ff 90 0f 0b 90 0f b6 74 24 43 31 ff bb ea ff ff ff e8 1f 0d fe ff 80 7c 24 44 00 0f 84 77 fb ff ff e8 2f 12 fe ff 90 <0f> 0b 90 e9 69 fb ff ff e8 21 12 fe ff 48 8b 44 24 10 48 8d 78 18
RSP: 0018:ffffc90004b3fb48 EFLAGS: 00010287
RAX: 000000000000128b RBX: ffffffffffffffef RCX: ffffc9000cf8c000
RDX: 0000000000080000 RSI: ffffffff81bcf8a1 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff8e645aa0 R15: ffffffff81c3bd00
FS:  00007f88b35446c0(0000) GS:ffff8881246bd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33600ff8 CR3: 000000004752c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tracepoint_probe_register_prio+0xbc/0x100 kernel/tracepoint.c:464
 register_trace_prio_sched_switch include/trace/events/sched.h:220 [inline]
 register_pid_events kernel/trace/trace_events.c:2390 [inline]
 event_pid_write.isra.0+0x480/0x7f0 kernel/trace/trace_events.c:2461
 vfs_write+0x29d/0x11d0 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x490 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f88b278ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f88b3544038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f88b29c5fa0 RCX: 00007f88b278ebe9
RDX: 000000000000fdf3 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f88b2811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f88b29c6038 R14: 00007f88b29c5fa0 R15: 00007ffc283ad408
 </TASK>


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
