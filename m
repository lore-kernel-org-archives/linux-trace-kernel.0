Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2C1DDD1
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734303924; cv=none; b=JB/gG/v1OaNJXJ3ZOG9ScKmzLjR+2QxIlW6mrDkaKj430+v3LDaKZo4NHwc8SvNs2y5ZjTyabLD3IApzLBEBR0aO5xzZDXfkUvqtyQktzZ8PWDm3N9DnW5+hKFpELA4eQLOX1Qissim6up3WWFk8WYv6NEyxSmS5UiLeStVsGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734303924; c=relaxed/simple;
	bh=ZCHHnsEAgSkfGbld3SLMl/LDEuEdIlPLTc+qLR2B1HQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nP6mt33Txb15zYFpXvUJVP1HSEABLVlFiX9y1ied2AUg69Yapy8RPYIWfi0y61P82AHq1mtNKZ4uuYCU2zoHrgDXDi0Kh0a3cqje/4Z9rC/BhFnegIrl9/j8LnxDBPDZPp0X8l+L90m+VPhGuTBtw2NpdD6oz6GKY9V522SB/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3abe7375ba6so74847955ab.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Dec 2024 15:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734303921; x=1734908721;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dce/12UJ1fnRvqwdj5c2f8CjHwfKlyXNjIxcN5WCROg=;
        b=noAKpLkjDoGLcrB1Mm+u2pXFkt6Hbq0LTzqYTj0tFEP3zPAoMXSVshZ0Vs+1dlyAQS
         CiC48aYiEU6OU9vESQgTspdFT6CWYQ1FLZVs8p3dpOl9mZKMRXsPMW9sxfOyofQcnD//
         xzZRVWP+hO1Y5kT0D7LRKdJN0rqWFBBr85pXWjF2mDY7U/WmMEl6/F7a4VeaZCXLJspo
         orPtC2JS+lz0URusNr56iS57a7OFzNGIANiEJnjW59bf4rQOY6xEtsxGOC093NhG097f
         73yHBbPNHwDD91+sLujE3MUF9yWMTmDEG4R4F933tZ0sptDluho/K8A1YvPyvJp0SPHd
         lSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOsR2uedvMbOsBQO2d2Et+KnY0NPfq26uNO/ncTXogZTEMZAZUJrPAdH0OUyIfNWy1X1bTfPBHSGtfShUJjOXh2vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDKkJ+HLHgrzyLh6gY6d5MbgLOPgp0hhLZT+QNnkjXoPKiS7r
	UNXI001nqKZpRxNdHyPG0pR0j8THZQUiNSMpYKzUQKKtU4J4avbUXG9NM4WytKhvCqMyiZHuLKn
	J0QVI/Szrp2teX/XHTdgWpvnE0hQv+f/ssVlsT8bXsvXM5yhY25g+/So=
X-Google-Smtp-Source: AGHT+IFMq97YLgRrPi4vqxBiOYULmSClhQMljl8hMy8WtdEtYDxueKUobAkHWomWY3W8JIIU/8B74hOnmRmlHjjLWNsAQ2wpH5HD
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a7:8149:6aa with SMTP id
 e9e14a558f8ab-3aff262a6b0mr116361505ab.24.1734303921545; Sun, 15 Dec 2024
 15:05:21 -0800 (PST)
Date: Sun, 15 Dec 2024 15:05:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f60b1.050a0220.37aaf.0107.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in bitmap_parse_user
From: syzbot <syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f92f4749861b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179d04f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=0aecfd34fb878546f3fd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11466cdf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15466cdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b85403132ddc/disk-f92f4749.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20613d034287/vmlinux-f92f4749.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d1ea80bf7e4e/bzImage-f92f4749.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5820 at mm/page_alloc.c:4727 __alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Modules linked in:
CPU: 0 UID: 0 PID: 5820 Comm: syz-executor318 Not tainted 6.13.0-rc2-syzkaller-00031-gf92f4749861b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__alloc_pages_noprof+0xeff/0x25b0 mm/page_alloc.c:4727
Code: 24 2c 00 00 00 00 89 cd 0f 84 8b f9 ff ff 8b 34 24 48 89 da 8b 7c 24 08 e8 0e b3 fe ff e9 69 f9 ff ff c6 05 21 45 16 0e 01 90 <0f> 0b 90 31 db e9 9f f3 ff ff 89 14 24 e8 9f a2 0c 00 8b 14 24 e9
RSP: 0018:ffffc90003eef958 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040cc0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 000000000000000b
R13: 0000000000040cc0 R14: 1ffff920007ddf3f R15: 00000000ffffffff
FS:  000055558bef6380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000580 CR3: 000000007d0f0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4228
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4255
 __do_kmalloc_node mm/slub.c:4271 [inline]
 __kmalloc_node_track_caller_noprof.cold+0x5/0x5f mm/slub.c:4302
 memdup_user_nul+0x2b/0x110 mm/util.c:305
 bitmap_parse_user+0x24/0x90 lib/bitmap-str.c:31
 cpumask_parse_user include/linux/cpumask.h:876 [inline]
 tracing_cpumask_write+0xfc/0x1a0 kernel/trace/trace.c:5231
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc57b8672a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd0ca10e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fffd0ca12c8 RCX: 00007fc57b8672a9
RDX: 000000000040fdef RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fc57b8da610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffd0ca12b8 R14: 0000000000000001 R15: 0000000000000001
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
