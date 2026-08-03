Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F78401A3B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756754; cv=none; b=d7NwV4GtmbzLoDZHnvqowYwviN2BvnFCYuXrxWNP+H3H1dsOToI7UhJGQuTh2GM8B15WGufwmUcPH6htYC3Mn7DQcoHi2ATZ14F8U1CPO38bQAfyDdPGKRj4ms/8qX6vTlyt8ZkRlO6NSea4WGCMD1WjcZ3tp68AIcQCI4mUaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756754; c=relaxed/simple;
	bh=wvsK9N0UmIbkgF+IBy5AfLwmnohWsI2UFWAf+9tbGtM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pMQL8Zt2pSLU0DaMrRrLn5+NdKh33j8ntgkrgB2lBcfCAC87+KDyiLIVawzLmPVWMK5WbcxSb/Iegl49ylwZXj/UqTWXxvD1k3QQdX+VokBHdbQfqptxLuq5PnZ/ND0G4tzkQNGLkgq90JRmqExB6yUNnFtNyVUTOCJ6CFByJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4ab4dd46ddeso2221116b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 04:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756751; x=1786361551;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yAmPlani0w11bT73o0o9jtqvfkuLtfrRZrJ0cVAPF7U=;
        b=fbKw8X3N/FLvXTbX042PWsv8kebOvuqBm4A0vuq6QGa90VtT1fJ/Lmrz7PxuO9/r1x
         z+U3JTHG+nYe+9Z5JnZQytxw5COly7RsHwda/7mYuO8s/29OPDIaAfTDB31p/BbIpO3L
         1hX0c0NBd/533r/d8MO1C3xBCsUCwLjbHJAKRy/zMzhqK4CxKVzbfE+5Y7+b93kaiFfR
         FnkeEF2R1SWFKBzXa89ICUIUjX3jRBYqqez4GS/9AKnRBaH5mQaBbSLy4+Ney+WCI7ru
         AZwYSjvX+byIWdQ1NOtW/ukbruBLWPsDElO9GDs2Og35WgE9tzUVwYxb7ObyhQ6mCFua
         Vp+A==
X-Forwarded-Encrypted: i=1; AHgh+RpzQFX3lY0bZdnA9WVkDo5UoBHlccQVRDtckdcTJFL0ZYMC+3mQyX0olMWCH0zrW+/3ifDj7VVU/GAfHzK1hxq26dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyph5QUMOyQGTj1PVOVDqJ9DPHjPr3uyyrny1caTC0aApUMnacC
	mUc8BE7/+ymCGwMO8sTdff//ZnhPajz8BDN8XuJ+KfSSmBq96Ra5vc4XFCXo0KE1z8N1NUi/im9
	XpxEu3fqw/uG772QHStHvT/DhHDmzihkxh6c0kKOKt1CB9x5VvVU1c4wx5HQ=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:124e:b0:495:f67c:d96a with SMTP id
 5614622812f47-4af5e1c80efmr13990585b6e.12.1785756751624; Mon, 03 Aug 2026
 04:32:31 -0700 (PDT)
Date: Mon, 03 Aug 2026 04:32:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a707c4f.13bfb6d0.1ecdd5.027e.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in trace_rb_cpu_prepare
From: syzbot <syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075b74841bd0 Linux 7.2-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16368cc6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe07bcf949966f3c00f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/678e77cc37b9/disk-075b7484.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc9f771e7069/vmlinux-075b7484.xz
kernel image: https://storage.googleapis.com/syzbot-assets/71a5d4620b85/bzImage-075b7484.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com

------------[ cut here ]------------
failed to allocate ring buffer on CPU 0
WARNING: kernel/trace/ring_buffer.c:7977 at trace_rb_cpu_prepare+0x330/0x3c0 kernel/trace/ring_buffer.c:7976, CPU#0: syz.5.14324/5698
Modules linked in:
CPU: 0 UID: 0 PID: 5698 Comm: syz.5.14324 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:trace_rb_cpu_prepare+0x332/0x3c0 kernel/trace/ring_buffer.c:7976
Code: 08 f0 48 0f ab 03 31 c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 bd 2f 7e 09 cc e8 17 3b fc ff 48 8d 3d 70 05 ea 0d 89 ee <67> 48 0f b9 3a b8 f4 ff ff ff eb d2 e8 fd 3a fc ff e9 ef fe ff ff
RSP: 0018:ffffc90003ddf7e0 EFLAGS: 00010283
RAX: ffffffff81c9a0a9 RBX: dffffc0000000000 RCX: 0000000000080000
RDX: ffffc900125d3000 RSI: 0000000000000000 RDI: ffffffff8fb3a620
RBP: 0000000000000000 R08: ffffffff8fafa337 R09: 1ffffffff1f5f466
R10: dffffc0000000000 R11: fffffbfff1f5f467 R12: 0000000000000000
R13: ffff888025cfb380 R14: ffff88803896c0a0 R15: 0000000000000000
FS:  00007f467e1856c0(0000) GS:ffff888125c3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f582bc58658 CR3: 0000000075292000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 cpuhp_invoke_callback+0x498/0x810 kernel/cpu.c:204
 cpuhp_issue_call+0x3f0/0x750 kernel/cpu.c:-1
 __cpuhp_state_add_instance_cpuslocked+0x225/0x560 kernel/cpu.c:2423
 __cpuhp_state_add_instance+0x25/0x40 kernel/cpu.c:2444
 cpuhp_state_add_instance include/linux/cpuhotplug.h:384 [inline]
 alloc_buffer+0x18aa/0x1d50 kernel/trace/ring_buffer.c:2830
 __ring_buffer_alloc+0x2c/0x40 kernel/trace/ring_buffer.c:2872
 allocate_trace_buffer+0x1d2/0x950 kernel/trace/trace.c:8412
 allocate_trace_buffers kernel/trace/trace.c:8445 [inline]
 trace_array_create_systems+0x590/0xe60 kernel/trace/trace.c:8623
 trace_array_create kernel/trace/trace.c:8666 [inline]
 instance_mkdir+0xd5/0x140 kernel/trace/trace.c:8681
 tracefs_syscall_mkdir+0x11a/0x190 fs/tracefs/inode.c:121
 vfs_mkdir+0x402/0x620 fs/namei.c:5276
 filename_mkdirat+0x289/0x520 fs/namei.c:5309
 __do_sys_mkdirat fs/namei.c:5330 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5327
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f467ff4e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f467e185028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f46801d6090 RCX: 00007f467ff4e019
RDX: 00000000000001ff RSI: 0000200000000200 RDI: ffffffffffffff9c
RBP: 00007f467ffe500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f46801d6128 R14: 00007f46801d6090 R15: 00007fffce30c118
 </TASK>
----------------
Code disassembly (best guess):
   0:	08 f0                	or     %dh,%al
   2:	48 0f ab 03          	bts    %rax,(%rbx)
   6:	31 c0                	xor    %eax,%eax
   8:	48 83 c4 30          	add    $0x30,%rsp
   c:	5b                   	pop    %rbx
   d:	41 5c                	pop    %r12
   f:	41 5d                	pop    %r13
  11:	41 5e                	pop    %r14
  13:	41 5f                	pop    %r15
  15:	5d                   	pop    %rbp
  16:	e9 bd 2f 7e 09       	jmp    0x97e2fd8
  1b:	cc                   	int3
  1c:	e8 17 3b fc ff       	call   0xfffc3b38
  21:	48 8d 3d 70 05 ea 0d 	lea    0xdea0570(%rip),%rdi        # 0xdea0598
  28:	89 ee                	mov    %ebp,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  34:	eb d2                	jmp    0x8
  36:	e8 fd 3a fc ff       	call   0xfffc3b38
  3b:	e9 ef fe ff ff       	jmp    0xffffff2f


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
