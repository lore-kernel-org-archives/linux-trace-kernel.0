Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B13998BE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854196; cv=none; b=jp/DI4b7JDmJK+OQNhWzAp/H4iIY7Zu6K0jNbqVUnevBXKYAuItTgnKeq87Pwg/ZB6ewHdESA/7diibk2WBBka3JF8zTtlfIuhwF6qMJnrsy54jL7VmwApZ8EcOn4JyqYP4jwHDIiQTGC0LeI3q57PNh2RTDMnUdcBdJoDXfp6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854196; c=relaxed/simple;
	bh=v50rnfyNHekOw3pkFFRsKufh9AeiT5Wh2yTuQCZH/Cc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tIc0jXUCsLGZN0LjAxegdliSqcHHm3ngt+4Vb8KTXtidRXauAlXp07B9dumsuqVapvmd00MFBXzFiUvFUl1fvIpADoKU3lO96u5NgE8KfjWGVl9KJ5ZJQ6i8XwpSkdAaokZ4IZyYJWGzLlVP0NZUJF0I7P01Q4olnWPylf2Jk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-464e69965b8so7033075fac.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 00:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854193; x=1789458993;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3BySEZRl8UhArKujmGigWk2ThQA+iSjb8SaLMLunxGc=;
        b=WqUI6IL5He2dJm4gNL74apwKM9nONZOZES701KuzhpyZPucGBCco1fhbjzcbTLBCTM
         Jn7QVEuCzqtVFctVPgBKXYNn/NHbcH4ADpCtu31Dyw3mMNpiZR4oxGHIM8+Lo+vaYJ91
         tLfdSJqLfJYy/C/7giSuHPts5anjNMUzfURX8mgUTVtK0EynecgTQMq1+D6Z2UGb5utd
         T5kKzqrPFWEoPurnZqhlGAWtxdF/B6q2UMks+whq9DQtD4hu9quPQdZCzmJGOF9EI02s
         ntKtqUScqacwNbD3wAg3YM87Es/ucE83U4GPWxFe0l6xkkfxfvLA0GS7rKRxypYxS31+
         OMfQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+qT3HEGdcy1JCaRIUwvPCrZgIczFdLXBdQ8vTNOuG+HIjfwWYUwPXjE8DtQWijfbiJTkr/0JC+hQuXBPbqaVX16I=@vger.kernel.org
X-Gm-Message-State: AFuF++lm8E+jqehytcWWYx9IhogpRpzjOf+i0UzsjSe0WLR+NJq/c7Bh
	aV+AmN19PbPk+Kp6b7b4yfOcpOhqCu9+y8/acOAMCzMIDWn4UAKsCziCoBK4IilMcZKpHlU847T
	kFq2pzAFl5N1kLxmZHvaBUhy3+4AWGRzEC38EqkpGs7C5IL7O3EHsl/dUmVM=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2007:b0:6b5:ec2f:356e with SMTP id
 006d021491bc7-6b5ec2f3676mr12495556eaf.31.1788854193238; Tue, 08 Sep 2026
 00:56:33 -0700 (PDT)
Date: Tue, 08 Sep 2026 00:56:33 -0700
In-Reply-To: <6a707c4f.13bfb6d0.1ecdd5.027e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9fbfb1.f614420e.2bf292.000a.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in trace_rb_cpu_prepare
From: syzbot <syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    28924df2a08f Merge tag 'perf-tools-fixes-for-v7.3-2026-09-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15761af9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe07bcf949966f3c00f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ea2af9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eb3af9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dec945b3d75e/disk-28924df2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e41f1bc0876/vmlinux-28924df2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec9e83ddda2c/bzImage-28924df2.xz

Bisection is inconclusive: the first bad commit could be any of:

6a80838814ee tracing: Add show_event_triggers to expose active event triggers
729757b96a66 tracing: Add show_event_filters to expose active event filters
e4ef389e761b tracing: Check the return value of tracing_update_buffers()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d7d4f9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com

------------[ cut here ]------------
failed to allocate ring buffer on CPU 1
WARNING: kernel/trace/ring_buffer.c:8103 at trace_rb_cpu_prepare+0x330/0x3c0 kernel/trace/ring_buffer.c:8102, CPU#0: syz.2.31/6050
Modules linked in:
CPU: 0 UID: 0 PID: 6050 Comm: syz.2.31 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:trace_rb_cpu_prepare+0x332/0x3c0 kernel/trace/ring_buffer.c:8102
Code: 08 f0 48 0f ab 03 31 c0 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 87 2e fc ff 48 8d 3d 40 36 eb 0d 89 ee <67> 48 0f b9 3a b8 f4 ff ff ff eb d2 e8 6d 2e fc ff e9 ef fe ff ff
RSP: 0018:ffffc90004a377d0 EFLAGS: 00010293
RAX: ffffffff81ca5f89 RBX: dffffc0000000000 RCX: ffff888027b3be80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff8fb595d0
RBP: 0000000000000001 R08: ffffffff8fb1e77f R09: 1ffffffff1f63cef
R10: dffffc0000000000 R11: fffffbfff1f63cf0 R12: 0000000000000000
R13: ffff88803e2a2908 R14: ffff88805d68b0a0 R15: 0000000000000000
FS:  00007f1a0c90e6c0(0000) GS:ffff888125bd1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555867aea68 CR3: 000000002b852000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 cpuhp_invoke_callback+0x498/0x810 kernel/cpu.c:204
 cpuhp_issue_call+0x3f0/0x750 kernel/cpu.c:-1
 __cpuhp_state_add_instance_cpuslocked+0x225/0x560 kernel/cpu.c:2423
 __cpuhp_state_add_instance+0x25/0x40 kernel/cpu.c:2444
 cpuhp_state_add_instance include/linux/cpuhotplug.h:383 [inline]
 alloc_buffer+0x188f/0x1d70 kernel/trace/ring_buffer.c:2917
 __ring_buffer_alloc+0x2c/0x40 kernel/trace/ring_buffer.c:2959
 allocate_trace_buffer+0x1d2/0x950 kernel/trace/trace.c:8465
 allocate_trace_buffers kernel/trace/trace.c:8498 [inline]
 trace_array_create_systems+0x590/0xe60 kernel/trace/trace.c:8676
 trace_array_create kernel/trace/trace.c:8719 [inline]
 instance_mkdir+0xd5/0x140 kernel/trace/trace.c:8734
 tracefs_syscall_mkdir+0x11a/0x190 fs/tracefs/inode.c:121
 vfs_mkdir+0x408/0x620 fs/namei.c:5410
 filename_mkdirat+0x289/0x520 fs/namei.c:5443
 __do_sys_mkdirat fs/namei.c:5464 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5461
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a0d2ae159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1a0c90e028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f1a0d535fa0 RCX: 00007f1a0d2ae159
RDX: 00000000000001ff RSI: 0000200000000140 RDI: ffffffffffffff9c
RBP: 00007f1a0d345024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1a0d536038 R14: 00007f1a0d535fa0 R15: 00007ffc0a111b18
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
  16:	c3                   	ret
  17:	cc                   	int3
  18:	cc                   	int3
  19:	cc                   	int3
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	e8 87 2e fc ff       	call   0xfffc2ea8
  21:	48 8d 3d 40 36 eb 0d 	lea    0xdeb3640(%rip),%rdi        # 0xdeb3668
  28:	89 ee                	mov    %ebp,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  34:	eb d2                	jmp    0x8
  36:	e8 6d 2e fc ff       	call   0xfffc2ea8
  3b:	e9 ef fe ff ff       	jmp    0xffffff2f


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
