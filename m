Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7AE3C17
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768177528; cv=none; b=JY1axRuCbe/1GqgGGJ/VpiRth5/ueSUYIuBYE9ed6AY58vb4NmoT5e0oEEVSALfL4Bi/+qRugVxGzk5QYe94Sa1R7UVl98G+CC2VBLDx48AZSjaKZgxHEqyXHMv8PGQ3ezPPLMG9Tg3Qve9hn6BP953nDPiDFSmh+0XQqczdJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768177528; c=relaxed/simple;
	bh=nrDZGFZaO0P3QWBP4A5cQyLofFBcaIHFWuZVxq54Ku0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K8yp/1RC+lqUdzP+BNj+SOHMXL/+TPnfMw8M1PGtBDQJc/Vp6Ox3nqRNjEqXRbr7Hu5DjPgLoLdAEari/vgzU6dY36e6MzVblHaYngdYti110K91vedTrn9AriAa1pwvH1X7aplsyHyzh1teageiRFQ2kFnxRo0Ksf1CpI6w/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-65b73eb22d2so5659701eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 16:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768177525; x=1768782325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5CdI+LHGD1oIYjo8i4mEjp3QkZf7AObmkripepwXvM=;
        b=UogFnEhOsnSFcglPHL/IiBd1LeeMesJyzShZmAzA5gKOKZbpVOHrh3RHMsCHQDafzB
         M4H7wZ6g6BkHbAi/byCqCtCxjhzuPjJyqx0JGGjLYscZXVNSUKQPdcgvtyQYthYpnxwi
         6syNGembeGRivdtMsQDUSE2FDZeb6mXqe2TEeEZVQqJFtd8WbL0shzoPo+0EF5Lh82Be
         y41zPHPlNhvQ1kDfJvBKEhwggJ2zL7yASua52XnuFepyBDkQJtr2KEVCkh3RkznkmMoZ
         A2OMNEAftgJaNlxnvmFAABCKUDY4KNwfQvmgmveqegIF8Bd9UCp/6XpkyEBqE2TJzEsI
         yrMA==
X-Forwarded-Encrypted: i=1; AJvYcCUA/haMWixbc580p2u8ueAv2gpOnR/QPc4yW7VUAilLWYT16Drn7ZoS9t+xpkVu06zIsmcSZxH7L/u/u9/aJ/eWkj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5URwAEGkG0iS2nTa/SZOZ1c3qz+cEgoULz8K8tGYnWQbySYsj
	8EF9QjrQASnJP8iDRuGN301GBJ82xiOb7R71oklhW6CMAogHBjyr//Gb/e2ntWzAq4qJDg60C4A
	8nwhWy3qxg5fhUfixLLabgF8clt03POzn4SBwDat2gvF7pOnH2UOIsu5Sqkw=
X-Google-Smtp-Source: AGHT+IGrQBq8ozZXBtjPQna0qFV2PGtZa23LZeSMNb9bq9wg1PL/iBOvSKuPISuJvzVLbRbvxdFb+XDICYq7feMUzhuQ5YaoJJOb
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e2d6:0:b0:659:9a49:8e82 with SMTP id
 006d021491bc7-65f5508a76emr5336039eaf.82.1768177525471; Sun, 11 Jan 2026
 16:25:25 -0800 (PST)
Date: Sun, 11 Jan 2026 16:25:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69643f75.050a0220.eaf7.007a.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in ring_buffer_map_get_reader (2)
From: syzbot <syzbot+c7143161d8215214a993@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6151c4e60e5 Merge tag 'erofs-for-6.19-rc5-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b8f19a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae589cd0a6acd9be
dashboard link: https://syzkaller.appspot.com/bug?extid=c7143161d8215214a993
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fa89172b8626/disk-b6151c4e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19077b87b7b3/vmlinux-b6151c4e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6793df315bec/bzImage-b6151c4e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c7143161d8215214a993@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/trace/ring_buffer.c:7363 at ring_buffer_map_get_reader+0x689/0x8d0 kernel/trace/ring_buffer.c:7363, CPU#0: syz.3.3873/24523
Modules linked in:
CPU: 0 UID: 0 PID: 24523 Comm: syz.3.3873 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:ring_buffer_map_get_reader+0x689/0x8d0 kernel/trace/ring_buffer.c:7363
Code: 02 00 00 49 8b 0c 24 8b 74 24 44 4c 89 ea 48 c7 c7 00 6c 93 8b e8 37 5f d9 ff e9 e6 fe ff ff 4c 8b 64 24 60 e8 f8 b3 fb ff 90 <0f> 0b 90 e8 ef b3 fb ff 48 89 df 31 db e8 c5 f9 fd ff 48 8b 74 24
RSP: 0018:ffffc9000bad7db0 EFLAGS: 00010087
RAX: 0000000000000790 RBX: ffff88813ff68800 RCX: ffffc9000eff9000
RDX: 0000000000080000 RSI: ffffffff81c2b728 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffff88813ff688b0 R12: ffff88813ff68990
R13: 0000000000000000 R14: ffff88813ff688a8 R15: ffff88813ff688b0
FS:  00007f7297ae16c0(0000) GS:ffff8881248fa000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f7d9ff8 CR3: 0000000087a78000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tracing_buffers_ioctl+0x2ab/0x360 kernel/trace/trace.c:8938
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7296b8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7297ae1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7296de6090 RCX: 00007f7296b8f7c9
RDX: 0000000000000000 RSI: 0000000000005220 RDI: 0000000000000006
RBP: 00007f7296c13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7296de6128 R14: 00007f7296de6090 R15: 00007ffcb9ff62d8
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
