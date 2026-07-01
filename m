Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422D34E74B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782869549; cv=none; b=S2bj8GsITwV1IE8yMgNtJ4ebkXyBf++BscM1WED9h1XmSRpyMTIAsiVR+modPG1usjWvrAhqe2OZ4FVyvzE6W1ANfZt4ZrEBopdE0b9KmeZGHbep9RWcfedTlYxnJXCNVuaA1CMgYPPP67uSF54iCF1fwrmw48yqWz95egw53WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782869549; c=relaxed/simple;
	bh=MGt/CXb1FQ+zwB8X+Z0sWvDOfr75DR37Lj/mwzD/Vec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UiTkcJPnr4is42SI0Kogc9qkSMjveYah90+lIAwXF2SPxOruIQD71hVXetj4lFvH+sfWt9jR3g93sM1bQTQ8dsiK0zGPOoRB5/8rcHi8ShSCym4885wrVpxhAn9Fb/XCttvB/CUbT3aeOhEugvybZfVrd/EzDrUINl9UzPhfKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-4488805e2dcso130731fac.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 18:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782869544; x=1783474344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLnF9ESoJ0ktTgQJW6irrhK4/6+C8f1tN10//1c7ZTk=;
        b=HbdnNiwRTS4Js0OWFLw7rmg6aABh+96hFE/c9XkL89+dUTZHGkNVKorlVZTQqpGMPV
         r2b2oX9wll11gSyyBAezsqn4sUGMRtp2qpxcG+3rbxEUhiNFK/Zm8D1Br1HBKEWuHnxm
         MNbKLkke/Hlf1cwCf4LtpMz09BueYXbbjOJjJ5UNz45+RzVLC5KvdkPtkHj/jMjY8984
         7NKnS9sT1SQBxZmU2zH+A+9dAHucGHA8ijvvqs8JJmcmbix4e0duaSG3MNdOdQvoImXa
         IkMmbg0ebdMFX4P3MPg16uRevMd0iKduFXcneXmSSQbQgnb7RoChcHJIbhFvrLW45YIG
         GMhA==
X-Forwarded-Encrypted: i=1; AFNElJ+sCQM1NQ4Hf9KyqZGljIFfdNFx2zCejaKeq0EDGRnHK7LQdOQwnWZTnDVGabCWgIJYidJX5Vf3hK3cj8KaM0xYzko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkbZl5s5LADYEkuVvYjIsMaO6IX6cKaUll5yiFmRNJQE66rJw0
	0axjZvbjix2Nvt1jeoo5W+UDq0WG5a3ea3KLnTzk9j0gxpije+7NzekFWw6Z2YECgXboLFxdkWx
	/RWSNWvZrCSueL4uyVzdfEhq8EPOe421axqo/dexcMW2w3XG8E/96W1ahZ0o=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:508a:b0:495:fa73:2e40 with SMTP id
 5614622812f47-495fa7336c0mr3246730b6e.3.1782869544624; Tue, 30 Jun 2026
 18:32:24 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:32:24 -0700
In-Reply-To: <6a38dd47.713c5d62.148f7.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a446e28.854d4ab9.360e1d.0017.GAE@google.com>
Subject: Re: [syzbot] [trace?] general protection fault in mtree_load
From: syzbot <syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, mingo@redhat.com, oleg@redhat.com, olsajiri@gmail.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    dc59e4fea9d8 Linux 7.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c7d61c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9bf5d2bfae96234
dashboard link: https://syzkaller.appspot.com/bug?extid=61ce80689253f42e6d80
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bbb11c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130bf4ea580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dc59e4fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1bc8aed8d2e8/vmlinux-dc59e4fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b1fdfc4aa09/bzImage-dc59e4fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 3 UID: 0 PID: 6107 Comm: syz.0.85 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mas_root lib/maple_tree.c:759 [inline]
RIP: 0010:mas_start lib/maple_tree.c:1179 [inline]
RIP: 0010:mtree_load+0x16d/0xa90 lib/maple_tree.c:5657
Code: 00 00 00 00 48 c7 44 24 78 ff ff ff ff e8 5b c8 74 f6 48 8b 5c 24 50 c6 84 24 9c 00 00 00 00 48 8d 7b 48 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 d6 08 00 00 48 8b 5b 48 e8 3f 1a 08 00 31 ff
RSP: 0018:ffffc9000412f740 EFLAGS: 00010206
RAX: 0000000000000011 RBX: 0000000000000040 RCX: ffffffff8b94b796
RDX: ffff888035462540 RSI: ffffffff8b94b7c5 RDI: 0000000000000088
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888013522280 R14: 0000200000ffc007 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880d63e0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8aaa4cff8 CR3: 0000000038832000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 vma_lookup include/linux/mm.h:4238 [inline]
 __in_uprobe_trampoline arch/x86/kernel/uprobes.c:766 [inline]
 __is_optimized arch/x86/kernel/uprobes.c:1056 [inline]
 is_optimized arch/x86/kernel/uprobes.c:1067 [inline]
 set_orig_insn+0x1ec/0x2a0 arch/x86/kernel/uprobes.c:1098
 remove_breakpoint kernel/events/uprobes.c:1185 [inline]
 register_for_each_vma+0xbb7/0xdb0 kernel/events/uprobes.c:1318
 uprobe_unregister_nosync+0x12a/0x1c0 kernel/events/uprobes.c:1343
 bpf_uprobe_unregister kernel/trace/bpf_trace.c:2982 [inline]
 bpf_uprobe_multi_link_release+0xb3/0x1c0 kernel/trace/bpf_trace.c:2993
 bpf_link_free+0xec/0x4a0 kernel/bpf/syscall.c:3395
 bpf_link_put_direct kernel/bpf/syscall.c:3448 [inline]
 bpf_link_release+0x5d/0x80 kernel/bpf/syscall.c:3455
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x951/0x2ae0 kernel/exit.c:1004
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1147
 get_signal+0x1ec7/0x21e0 kernel/signal.c:3038
 arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x139/0x6f0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x666/0x870 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc8a9b9de59
Code: Unable to access opcode bytes at 0x7fc8a9b9de2f.
RSP: 002b:00007fc8aaa4d0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fc8a9e25fa8 RCX: 00007fc8a9b9de59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fc8a9e25fa8
RBP: 00007fc8a9e25fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc8a9e26038 R14: 00007fff99db45c0 R15: 00007fff99db46a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mas_root lib/maple_tree.c:759 [inline]
RIP: 0010:mas_start lib/maple_tree.c:1179 [inline]
RIP: 0010:mtree_load+0x16d/0xa90 lib/maple_tree.c:5657
Code: 00 00 00 00 48 c7 44 24 78 ff ff ff ff e8 5b c8 74 f6 48 8b 5c 24 50 c6 84 24 9c 00 00 00 00 48 8d 7b 48 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 d6 08 00 00 48 8b 5b 48 e8 3f 1a 08 00 31 ff
RSP: 0018:ffffc9000412f740 EFLAGS: 00010206

RAX: 0000000000000011 RBX: 0000000000000040 RCX: ffffffff8b94b796
RDX: ffff888035462540 RSI: ffffffff8b94b7c5 RDI: 0000000000000088
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888013522280 R14: 0000200000ffc007 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880d63e0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8aaa4cff8 CR3: 0000000038832000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	48 c7 44 24 78 ff ff 	movq   $0xffffffffffffffff,0x78(%rsp)
   b:	ff ff
   d:	e8 5b c8 74 f6       	call   0xf674c86d
  12:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
  17:	c6 84 24 9c 00 00 00 	movb   $0x0,0x9c(%rsp)
  1e:	00
  1f:	48 8d 7b 48          	lea    0x48(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 d6 08 00 00    	jne    0x90b
  35:	48 8b 5b 48          	mov    0x48(%rbx),%rbx
  39:	e8 3f 1a 08 00       	call   0x81a7d
  3e:	31 ff                	xor    %edi,%edi


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
