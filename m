Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2FD360EF4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111562; cv=none; b=exV2pkK2bWDN0GwLyx1X+mnhut7qtJMwnMuqZzgetA8BC8XPH7gbLM15rsG1XjSrlI5pS4GRQWq+h1jekJsRgIgJES3FXr0c8SeGIf0PoJXCtLKzdaY1d+aXCjAC3WXgfzj0vsD2ru+Qr94/75nXzKWqTrmnibLRbfZzA8J7fTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111562; c=relaxed/simple;
	bh=AgcuzwIjjv8yYFF8QnqEVbIJ9+BBcQRSlSd2ixjkgcI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Oq6pUq1cPt4SFgqZrbolksZUfHQyGgP5U7Pcb8Xqr2VQj1VMuA27Ar8oOz1CM4d6J5TzE7w4QEiR/wYKyOlVXC8i9NPi+mi9akdWxnFvzur46javpn2DithVNdC+0dVgEPR31CvSjUHa127tGXUiz0lQKIXbSOZRlaMjYx0Gx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-485fdae1db3so7123055b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Jun 2026 23:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782111559; x=1782716359;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dee/d/lype2pOO/ItFtdTcT37BMlTqmm2dUXLU1k+7Q=;
        b=LQmqXM7rW4mLWEa+IJDLG6alRmUjLAfvJzmfEoU2h8kby8Za7MJflgLxLTOdwFa7Vn
         TTrROEdUwFPYrx1+fncbyX3nPSELQm0i/k7VEpuYEUF8BcVKkw7BLPwoFBpvkjglNHeU
         keHhM/0tOuZ1305vfU0fvZBz6fZffHykT6L3mogmwuDllC18Ofiym1/XbzA0sXLwGh65
         BzeGnSCkQvrR0Kr6iYIrxGNedbLbyOrCvQDbYlhVVndtEmtjMzQYs0JhjKcUiFPGaZgL
         OGLYq7jaTfay4xU3mpcYZWEY0sc60m1pZ25cYGAvIk0ay2B+/PTKky4UXavW7TysPd36
         B7ww==
X-Forwarded-Encrypted: i=1; AFNElJ9+IggSEmh8n1ve9+fWOBe5XpsV06Da/kOIR1eBmT7+yTGFmox0UbZ359OnXV9GHjnvE+EwUoM40xtFh6mUx9cU87Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkyvtV9POpCvwckdrM8lEf8veQ9eCH2N+TxK4BKz4MI92Tpmd
	Wil90BmpzgjRRTrTNQm0NDhUPCaoxu4cbKGRGnvifZoVfaOG/l9pIf6vZD+oZZXfK94d2dAhqQ/
	5hBE3Vw0PAftx1D50BVTDNv0b1nUH7is140XB4oHUs/Qmbfi3hphok4UbKAA=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14d6:b0:489:61e0:544a with SMTP id
 5614622812f47-48ac065c421mr7636488b6e.22.1782111559702; Sun, 21 Jun 2026
 23:59:19 -0700 (PDT)
Date: Sun, 21 Jun 2026 23:59:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a38dd47.713c5d62.148f7.000c.GAE@google.com>
Subject: [syzbot] [trace?] general protection fault in mtree_load
From: syzbot <syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, mingo@redhat.com, oleg@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6b5a2b7d9bc1 Merge tag 'trace-tools-v7.2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d56986580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea6584355d75e0cd
dashboard link: https://syzkaller.appspot.com/bug?extid=61ce80689253f42e6d80
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6b5a2b7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b3cb0499fbe9/vmlinux-6b5a2b7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47cfbe57f6ea/bzImage-6b5a2b7d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61ce80689253f42e6d80@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000011: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
CPU: 3 UID: 0 PID: 24402 Comm: syz.4.5217 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mas_root lib/maple_tree.c:759 [inline]
RIP: 0010:mas_start lib/maple_tree.c:1179 [inline]
RIP: 0010:mtree_load+0x16d/0xa90 lib/maple_tree.c:5657
Code: 00 00 00 00 48 c7 44 24 78 ff ff ff ff e8 6b bd 84 f6 48 8b 5c 24 50 c6 84 24 9c 00 00 00 00 48 8d 7b 48 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 d6 08 00 00 48 8b 5b 48 e8 6f 1a 08 00 31 ff
RSP: 0018:ffffc900039c76d8 EFLAGS: 00010206
RAX: 0000000000000011 RBX: 0000000000000040 RCX: ffffffff8b848746
RDX: ffff888041b6a540 RSI: ffffffff8b848775 RDI: 0000000000000088
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 000000000000751b R12: dffffc0000000000
R13: ffff88802693adc0 R14: 00001fff904365a7 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880d665f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f44aa04f156 CR3: 00000000364d5000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 vma_lookup include/linux/mm.h:4204 [inline]
 __in_uprobe_trampoline arch/x86/kernel/uprobes.c:766 [inline]
 __is_optimized arch/x86/kernel/uprobes.c:1056 [inline]
 is_optimized arch/x86/kernel/uprobes.c:1067 [inline]
 set_orig_insn+0x1ec/0x2a0 arch/x86/kernel/uprobes.c:1098
 remove_breakpoint kernel/events/uprobes.c:1185 [inline]
 register_for_each_vma+0xbb7/0xdb0 kernel/events/uprobes.c:1318
 uprobe_unregister_nosync+0x12a/0x1c0 kernel/events/uprobes.c:1343
 bpf_uprobe_unregister kernel/trace/bpf_trace.c:2936 [inline]
 bpf_uprobe_multi_link_release+0xb3/0x1c0 kernel/trace/bpf_trace.c:2947
 bpf_link_free+0xec/0x4a0 kernel/bpf/syscall.c:3273
 bpf_link_put_direct kernel/bpf/syscall.c:3326 [inline]
 bpf_link_release+0x5d/0x80 kernel/bpf/syscall.c:3333
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
 ret_from_fork+0x932/0xd50 arch/x86/kernel/process.c:167
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mas_root lib/maple_tree.c:759 [inline]
RIP: 0010:mas_start lib/maple_tree.c:1179 [inline]
RIP: 0010:mtree_load+0x16d/0xa90 lib/maple_tree.c:5657
Code: 00 00 00 00 48 c7 44 24 78 ff ff ff ff e8 6b bd 84 f6 48 8b 5c 24 50 c6 84 24 9c 00 00 00 00 48 8d 7b 48 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 d6 08 00 00 48 8b 5b 48 e8 6f 1a 08 00 31 ff
RSP: 0018:ffffc900039c76d8 EFLAGS: 00010206
RAX: 0000000000000011 RBX: 0000000000000040 RCX: ffffffff8b848746
RDX: ffff888041b6a540 RSI: ffffffff8b848775 RDI: 0000000000000088
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 000000000000751b R12: dffffc0000000000
R13: ffff88802693adc0 R14: 00001fff904365a7 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880d665f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c433cbf CR3: 00000000429b6000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	48 c7 44 24 78 ff ff 	movq   $0xffffffffffffffff,0x78(%rsp)
   b:	ff ff
   d:	e8 6b bd 84 f6       	call   0xf684bd7d
  12:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
  17:	c6 84 24 9c 00 00 00 	movb   $0x0,0x9c(%rsp)
  1e:	00
  1f:	48 8d 7b 48          	lea    0x48(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 d6 08 00 00    	jne    0x90b
  35:	48 8b 5b 48          	mov    0x48(%rbx),%rbx
  39:	e8 6f 1a 08 00       	call   0x81aad
  3e:	31 ff                	xor    %edi,%edi


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
