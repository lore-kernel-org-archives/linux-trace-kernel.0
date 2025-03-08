Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39E3C1F
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Mar 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392145; cv=none; b=a2D+gjdkbKXbyg7rFOImkiMdqwQil/Ohu7vDT/y1qUfe0+v8FcG7dbqicOm02AP5nF8s4DPtLAuqFzl1dZEnbaWhgCZNkV5oQlh2b1pjz33Cx3jSSpvfXsvTub8BCXaF3QkOkbUKuOQW75QdX7QyFqfZ5+SSe8Q6E6YT0nSxwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392145; c=relaxed/simple;
	bh=ym1gKgOZ8ndKCiW+GNMSZAf87EHU8Np/pIBi7mjUyIk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gIZVo4diwqVaxagXjiWYt/YJr188q3PMVWSWVxt1pDaqHlkLx3FJY5Ab8p/g5BfqzfvpekgHLfw+SANZ/UuFj814FxdBNdSqNybssB3bczOMzymvemilE4JUzyxSULY8HS07yNAlPeY+3C6XEDlsph78jVVGksM36WZ9I/UwQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so50702965ab.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Mar 2025 16:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392142; x=1741996942;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aqiyu/dMFS2r2s9XJYkQ3e5hk4SFcF8VLw2o4Me4TA=;
        b=PcENzYbVjpsxIUdtbFK8AdIw0lYbpR3MM+1Ult98qOMxLot3CS0sIkIJqWmp2akkvS
         r4CFEiIV4hFTCi+CFVAF1xsXJy4cWWqcK5MtSddqEMVgI2BEQP1yCO7LEKEPajcacN1a
         1eIgsSRxGhytimJKw3yZ5bb/8epXVPyV+z/uVPjvobEDRS4wuVOnwNj4p1KSMPHrsZvk
         Nlgsc0/56Sonqx/Kgx7rXRbljkpZb2M3szc/YbyQ/OtTLXp6tP2tBv1HBrGIpJz0LCi1
         d8vFXKC96Bj/7vq1SgeUjrj3aHKxrIfQknWkwhG44RMZL/lobF6g60mymQF0dot3dQJr
         IfTg==
X-Forwarded-Encrypted: i=1; AJvYcCUjajhAccs95TTDngnHkOTdvUE80I5CNlzt5oU1GZDbEdcUUMlDIIVrA2qkyo3CWyCxb+l2K+eROK96U7qIsyHmOoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0n2NIJpWlWz7f8C0JoI/HlOV1VKFQkSrCSD+q3jVcnEbg5BA
	K//o0DtN3BLy4yCBFm6VzCN+g1GIqDPCzV8o78LKuzdIdzQ7DGAZ5iCAu/V/4OO2QkUuB3LX9jC
	MzwDmWql7U3kSLFpxUkFdrHitPCGCUJ2bdpFcKgyK9dlaN6zl53NnvPQ=
X-Google-Smtp-Source: AGHT+IHJS5UKipvwJ5J6WhKRzJ7o8MTTNQFTg3AaCTXOp39f+S12aD5X8AfKPF2ytEaMAq6+ZhsmgyXO/BrX8cU/sNx/WIWcZPdT
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0b:b0:3d3:d4f0:271d with SMTP id
 e9e14a558f8ab-3d44196ff85mr69187845ab.12.1741392142308; Fri, 07 Mar 2025
 16:02:22 -0800 (PST)
Date: Fri, 07 Mar 2025 16:02:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb890e.050a0220.d8275.022e.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in tracepoint_add_func (2)
From: syzbot <syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eb172143d55 Linux 6.14-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b9a464580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bed8205d3b84ef81
dashboard link: https://syzkaller.appspot.com/bug?extid=161412ccaeff20ce4dde
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/06a492964134/disk-7eb17214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83adeaa22219/vmlinux-7eb17214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7386164633ed/bzImage-7eb17214.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+161412ccaeff20ce4dde@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 12326 at kernel/tracepoint.c:294 tracepoint_add_func+0xbfc/0xeb0 kernel/tracepoint.c:294
Modules linked in:
CPU: 1 UID: 0 PID: 12326 Comm: syz.6.10325 Tainted: G     U             6.14.0-rc5-syzkaller #0
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:tracepoint_add_func+0xbfc/0xeb0 kernel/tracepoint.c:294
Code: 09 fe ff 90 0f 0b 90 0f b6 74 24 43 31 ff 41 bc ea ff ff ff e8 45 04 fe ff 80 7c 24 44 00 0f 84 74 fb ff ff e8 95 09 fe ff 90 <0f> 0b 90 e9 66 fb ff ff e8 87 09 fe ff 48 8b 44 24 10 48 8d 78 18
RSP: 0018:ffffc9000414fb48 EFLAGS: 00010283
RAX: 00000000000012a1 RBX: ffffffff8e240ae0 RCX: ffffc90014b78000
RDX: 0000000000080000 RSI: ffffffff81bbd78b RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffffffffffffef
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff81c264f0
FS:  00007f27217f66c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e80dff8 CR3: 00000000268f8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tracepoint_probe_register_prio+0xc0/0x110 kernel/tracepoint.c:464
 register_trace_prio_sched_switch include/trace/events/sched.h:222 [inline]
 register_pid_events kernel/trace/trace_events.c:2354 [inline]
 event_pid_write.isra.0+0x439/0x7a0 kernel/trace/trace_events.c:2425
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f272398d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f27217f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2723ba5fa0 RCX: 00007f272398d169
RDX: 0000000000100082 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f2723a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2723ba5fa0 R15: 00007ffe80f479d8
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
