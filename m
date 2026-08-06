Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5867231842
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998373; cv=none; b=RyoKemvMQ4TA1XIhwkB9uKk9EO8faEVdtRpN6t3+ErjACeNj6DcUEWx7pkhEy21uSb5DFRCqSWqL8cMOSumxWiAj0OY6OqaH/qq+MtLlHMsb70zdOXiW1TUsPPj6ITnOZYQFtSAmVGbqzwPR1jHchHq2aZDNER93J/nJ0Yp30Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998373; c=relaxed/simple;
	bh=3uh92xVb8X+OvjTCeVmfIimPbmGJO+n5aXGxfNSECL8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iFme5F8VLPDjx/yILzvKAWSO3veyKEZF2E0UeYd9wYkSe3CcKdn6xxy7FcmndWQDOUB8FQRqvOwTz2J6eJEwiY4jPZClKiu7h5nXbkLJXmccaLMT9jWBQuzDcFwpT3s29Ncts5jCjY84mFMin3Z4QfKxCPDtmws1Wtp/cApIdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7e9dee2f7b5so2470501a34.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 23:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998370; x=1786603170;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CVUycl24TN0EHAD8A38B03y01L7Z8dSQJrZ4ns1TTPM=;
        b=JPiKuRlcq6cs9kyVA0tHGdtSDKlJDSJrnhnhngAkLwC4IGUk+xigWdgY5imojDvLd8
         EGLFr0adcRGQLpHXZEjQCKIAwqyfEmq97p+nRTdT00IGPkYGee3y2S6hzbHH31qKpfYz
         nGTXQx5mu/FpQDzZgpYT/76I1i7evi0c5ZLz7VSbe19K/DXewNX4AesoHe52Kc6fDuZZ
         e07H3Zjui5oTXzwjw1x05aoMRbo1OGRrHaeeODES1mCEUlLsVcLKY32nbOzHdvDTVJMD
         I0uZjpubQ7tUloIiWu8epozABvM+CCgrYV4DjrH97wTQZp6IGOMrbxRXct0Ieg0c1o/v
         2IhQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHdw8p1SSG8gbYjHtFE3WNWsIrv4vd/tngknxVel3PBg8PuegUUCLT1hcFQIl018Bs+XoFRJoHMhmc0rkMFLJrZYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhStV6YDZ/EramCqSxcImK5KhsksEQbBXBU5H64+6ze4yelkM/
	Df4MjkSzuWHAoCZn6p/fCFsqLUiNm1r9oYy6DcxXXy8lntZbEm50C2ZDidz4sbpzFN7fp5U02UR
	GezlmK2WcMeh3xYlPf5YKwuIKsIOx2ODp0otPVaaKdu42ydfu+y7qT56W8sQ=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dcd:b0:6a1:363d:bc42 with SMTP id
 006d021491bc7-6ae96c55f8fmr6792771eaf.15.1785998370638; Wed, 05 Aug 2026
 23:39:30 -0700 (PDT)
Date: Wed, 05 Aug 2026 23:39:30 -0700
In-Reply-To: <6a707c4f.13bfb6d0.1ecdd5.027e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a742c22.9c11d2ce.289b96.0095.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in trace_rb_cpu_prepare
From: syzbot <syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164dbbb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=fbe07bcf949966f3c00f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115077b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ecb6d42b95f/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/53481594a62a/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11ad64300b74/bzImage-0d839570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com

------------[ cut here ]------------
failed to allocate ring buffer on CPU 1
WARNING: kernel/trace/ring_buffer.c:7976 at trace_rb_cpu_prepare+0x458/0x500 kernel/trace/ring_buffer.c:7976, CPU#1: syz.1.24/6005
Modules linked in:
CPU: 1 UID: 0 PID: 6005 Comm: syz.1.24 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:trace_rb_cpu_prepare+0x45a/0x500 kernel/trace/ring_buffer.c:7976
Code: 48 c1 ea 03 80 3c 02 00 0f 84 c7 fc ff ff 48 8b 3c 24 e8 29 0e 6c 00 e9 b9 fc ff ff e8 ff 83 fb ff 48 8d 3d b8 cc 17 0f 89 ee <67> 48 0f b9 3a bb f4 ff ff ff e9 df fd ff ff 4c 89 ef e8 ff 0d 6c
RSP: 0018:ffffc900036bf8c0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807a7604b8 RCX: ffff88807bafcf88
RDX: ffff88807b2dca80 RSI: 0000000000000001 RDI: ffffffff9126ada0
RBP: 0000000000000001 R08: ffff88807bafcf88 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff81000130 R12: 0000000000000001
R13: ffff88807a760410 R14: 0000000000000008 R15: 0000000000000162
FS:  00007f7d853056c0(0000) GS:ffff888123ed8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f118d5e5ff8 CR3: 000000006ff97000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 cpuhp_invoke_callback+0x205/0x9a0 kernel/cpu.c:204
 cpuhp_issue_call+0x1b8/0x970 kernel/cpu.c:2354
 __cpuhp_state_add_instance_cpuslocked+0x2d7/0x400 kernel/cpu.c:2423
 __cpuhp_state_add_instance+0xd7/0x2d0 kernel/cpu.c:2444
 cpuhp_state_add_instance include/linux/cpuhotplug.h:384 [inline]
 alloc_buffer+0x76c/0x1800 kernel/trace/ring_buffer.c:2830
 __ring_buffer_alloc+0x2d/0x40 kernel/trace/ring_buffer.c:2872
 allocate_trace_buffer+0x150/0xa30 kernel/trace/trace.c:8412
 allocate_trace_buffers kernel/trace/trace.c:8445 [inline]
 trace_array_create_systems+0x582/0xc30 kernel/trace/trace.c:8623
 trace_array_create kernel/trace/trace.c:8666 [inline]
 instance_mkdir+0xca/0x140 kernel/trace/trace.c:8681
 tracefs_syscall_mkdir+0x10e/0x180 fs/tracefs/inode.c:121
 vfs_mkdir+0x361/0x850 fs/namei.c:5276
 filename_mkdirat+0x48b/0x5e0 fs/namei.c:5309
 __do_sys_mkdirat fs/namei.c:5330 [inline]
 __se_sys_mkdirat fs/namei.c:5327 [inline]
 __x64_sys_mkdirat+0x89/0xc0 fs/namei.c:5327
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7d8439e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7d85305028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f7d84626090 RCX: 00007f7d8439e0d9
RDX: 00000000000001ff RSI: 0000200000000140 RDI: ffffffffffffff9c
RBP: 00007f7d84435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7d84626128 R14: 00007f7d84626090 R15: 00007ffdb6812d48
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 84 c7 fc ff ff    	je     0xfffffcd5
   e:	48 8b 3c 24          	mov    (%rsp),%rdi
  12:	e8 29 0e 6c 00       	call   0x6c0e40
  17:	e9 b9 fc ff ff       	jmp    0xfffffcd5
  1c:	e8 ff 83 fb ff       	call   0xfffb8420
  21:	48 8d 3d b8 cc 17 0f 	lea    0xf17ccb8(%rip),%rdi        # 0xf17cce0
  28:	89 ee                	mov    %ebp,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	bb f4 ff ff ff       	mov    $0xfffffff4,%ebx
  34:	e9 df fd ff ff       	jmp    0xfffffe18
  39:	4c 89 ef             	mov    %r13,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	ff                   	.byte 0xff
  3e:	0d                   	.byte 0xd
  3f:	6c                   	insb   (%dx),%es:(%rdi)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
