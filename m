Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF8344034
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372591; cv=none; b=UaP28cXALW6yk2LxU42DDhF1tphUKGKitgO5GMemm4BMCzY43BG6OYKDYlAVcLa6nUXHzEcwS2Dlc7u6X+OQnnh0ZLMD4RpXFtVkWni9s43gr0lx0ZEM2kub1aFMEghLSTo6p5rqub+UfVIwafrq8y/2jY/10Js16V4PF1tFdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372591; c=relaxed/simple;
	bh=DA/TgFcrQsJdkNiib746rgjUVZmzRttIe9da/NbC0fQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cSRE8KgmRDmSJK8uAf1BOewNagDTG4CcmF2G5sSPjHkHsUjRN5SLIrbO3vAYG7qbpidMNQVwebdTfL/P0qEFZEUK6Jd7Hth62osqnf3ymzR5m3R+u/voXA4jVS2h/l9MdfUdveRvb3kSeprKp8bgVnj0HltUfTRwQi2f6eInZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4332ad10c91so5545575ab.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372588; x=1762977388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DsJIerXbiX87dCz1LLhmZWGziBLNayY2WNg901pyJbA=;
        b=r29laXGmsv3uU3VNBFO8F1NDC7tYpm7hzqhLfZofvxxcmP3eu5yXejsF9M2waqZMlI
         eXAr9afT53Fkz8vU1kBbgywAypxsfLjhchMYRBUTMVNkXoZ4Qk87qnT0VzeXvAWsC9SO
         54lK5Txq0TnFH1jYdMXQdfZC+3Av+pInmPD3pakv4BDb4fnz2gNodqYngNpulc/jZYb0
         Z52VzcDvkP1Qct7kTQNQ3CIqsI3JMwCmxL3wDC1Sk7CLfb/w7q7g5yBPLSPQ8KhSSdNM
         F/MYGKTKx2+gsJt5DFNwq9z1begwBzt8RrMZnNi0fJ7i1S8PTKex6dHCAvslwaYr0b0Y
         0q6g==
X-Forwarded-Encrypted: i=1; AJvYcCUX/RXS6Lcs8744SzRqcOvrYqrjIV5N7sniIherxLnfybQdaRh+34Para5OWe4t8GhAwiCDttDvkrIlnYvQIsuQbPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOmTF5EYUU35w39PPp76WHk7fxrK/VNz2Sx0oqmUN+PuN/HcJ
	OKeXERcZK9UrG1XSJkarINmQ1P3+iJRF221fq7PBs1l+7whAx1UrMxnlzpibf709/jTSSg7h4EW
	38pEvk7783id5bVkiIF7l2oaj9oMGgYsoA90c3Rq68abqc/b6JJVl19Pe4Uk=
X-Google-Smtp-Source: AGHT+IEwPu4aVxUjew24tnX4NK4p2HgqB3ivS5W1s02DNQalhuoV3OG/emTB2nC2LCQlj298Nc6cOTffAMSkxW9WvQtOVEJISneK
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:433:2aac:c540 with SMTP id
 e9e14a558f8ab-433407a409emr71594115ab.14.1762372588688; Wed, 05 Nov 2025
 11:56:28 -0800 (PST)
Date: Wed, 05 Nov 2025 11:56:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690babec.050a0220.baf87.0064.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in ring_buffer_map_get_reader
From: syzbot <syzbot+92a3745cea5ec6360309@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    691d401c7e0e Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1388b932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
dashboard link: https://syzkaller.appspot.com/bug?extid=92a3745cea5ec6360309
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5eaccda03e4f/disk-691d401c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0df5294a69bc/vmlinux-691d401c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4f242731772/bzImage-691d401c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92a3745cea5ec6360309@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9655 at kernel/trace/ring_buffer.c:7348 ring_buffer_map_get_reader+0x676/0x8e0 kernel/trace/ring_buffer.c:7348
Modules linked in:
CPU: 0 UID: 0 PID: 9655 Comm: syz.2.14601 Tainted: G     U  W I  L XTNJ syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER, [W]=WARN, [I]=FIRMWARE_WORKAROUND, [L]=SOFTLOCKUP, [X]=AUX, [T]=RANDSTRUCT, [N]=TEST, [J]=FWCTL
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ring_buffer_map_get_reader+0x676/0x8e0 kernel/trace/ring_buffer.c:7348
Code: 02 00 00 49 8b 0c 24 8b 74 24 3c 4c 89 f2 48 c7 c7 a0 09 93 8b e8 7a 1d da ff e9 e2 fe ff ff 4c 8b 74 24 58 e8 7b b0 fb ff 90 <0f> 0b 90 e8 72 b0 fb ff 48 89 df 31 db e8 88 f6 fd ff 48 8b 74 24
RSP: 0018:ffffc900053b7db0 EFLAGS: 00010083
RAX: 0000000000000773 RBX: ffff88813ff28800 RCX: ffffc900130af000
RDX: 0000000000080000 RSI: ffffffff81c0bcd5 RDI: 0000000000000007
RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffff88813ff288b0 R12: ffff88813ff288b0
R13: 0000000000000000 R14: ffff88813ff28818 R15: ffff88813ff14c00
FS:  00007f5e1e7046c0(0000) GS:ffff888124a10000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32a12ff8 CR3: 0000000021b1c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tracing_buffers_ioctl+0x2bd/0x370 kernel/trace/trace.c:8717
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e1d78efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5e1e704038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5e1d9e5fa0 RCX: 00007f5e1d78efc9
RDX: 0000000000000000 RSI: 0000000000005220 RDI: 0000000000000004
RBP: 00007f5e1d811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5e1d9e6038 R14: 00007f5e1d9e5fa0 R15: 00007ffcaeda0b48
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
