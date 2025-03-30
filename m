Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE72A1D1
	for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Mar 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743323248; cv=none; b=VZIzUBEFDJbbhSHgr39PJNL8VsdUh7T1pUJs1Ote5gvyso9Jnfr8T54qEdDYMpcuYD/s7hZgk+86YvCdr++TSYK7NesMT4mU9u7xOPaDZ8L95X/A/IJiQz8hOc4LeqjIZM8ql90d4XLgH/jB3gvbnb/+GUfnwHZAD8MtUZdxrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743323248; c=relaxed/simple;
	bh=i5qsuuDAOBsXN2syyZbmDGo6Y6hote6MFwpxKHZ80dU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gnIbENT27bfBcJq6gnt2Hp0ezDAEJ0P3nmbXq3QyFMgrtd740KgKfuiGVfmn5tOShVJAjHa6BCudtfymy1kjgViXn9VKVzarZcFW1fCKw4p9aqnJl3bgk1wdV1MhSA79su92Rp+YHr3qT8oeh4k5J1S6DEqPlnxod5HYo8lpTrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85dad56a6cbso592110439f.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 30 Mar 2025 01:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743323246; x=1743928046;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dc9DfDBBeGygFQWkxgzzBjArRHMpQGngtPDo74FU8nU=;
        b=IxPn1MphA3mKWclKqXIsNZhLeBaUSjkyP0k6lNN8DxTWLIsemhCRSAASux0EZrMnOB
         1Eokwbl8x0seWXhqqsBTSJ3PcwscmpNV/VEfZJBa5CXT9bTPdgEntyk3Yms6jSxgYNB0
         IN/gopGhG88UagliwVQGG1RcUfDuBBhJw96wohlnnRpRh7KiJH/38Tb0F2UzfQxqjfsX
         YT3/t2OIxiUUYV1Op9+cDGw0A0kkyszzbT9mbSE9bczTYAbxmW97iXKPUJjIQGFPgzE2
         yf9wxNfCmsIQJi7rbOAT/DozxIPXd8oMJcgeHl9w1iPB4YWCnVt2eJ1OcYiEdDKSlVR1
         L/lw==
X-Forwarded-Encrypted: i=1; AJvYcCXd8EUn7WRGJBDmWfcEGCnsyPeph5nzwaxy0sppb8FFI0gIwaLuJHD1Ai5WFm1HhlG3BvpyFYd42iP7tozt7Lx8wD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpO90FYv2ULS2pSR1lHHK52luyFJHSXN2WAhhLLL5a4aRB/aoQ
	Jxq03GIT35GDOjwtm8HXDjLYf/uBJUhP+h+MkaFTD7o9867Tx2mriK6vVD6cr0P2ssIhf/UCPzO
	1jFtec1VhXmllQycJpcPzWMz+nkL8TlW3QOicPO6pkh3v7blkHe9dReQ=
X-Google-Smtp-Source: AGHT+IGSQ0ca88amKHtyvrCSpcwxt6Hn6Cn4XfpgQkkx0fbntcZ1YXfWS6lbBIkRepZP++1ERMWHDGJoWlb6Dg3da+2adayjo0aG
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c85:b0:3d3:de8a:630e with SMTP id
 e9e14a558f8ab-3d5e09f7a73mr46551685ab.16.1743323245904; Sun, 30 Mar 2025
 01:27:25 -0700 (PDT)
Date: Sun, 30 Mar 2025 01:27:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e9006d.050a0220.1547ec.0097.GAE@google.com>
Subject: [syzbot] [afs?] WARNING: ODEBUG bug in delete_node (3)
From: syzbot <syzbot+ab13429207fe1c8c92e8@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2df0c02dab82 x86 boot build: make git ignore stale 'tools'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e3aa4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f1762820c18874b
dashboard link: https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12985804580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1749a198580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/93b59f97f896/disk-2df0c02d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f0ade1042ab8/vmlinux-2df0c02d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c64e746afbb/bzImage-2df0c02d.xz

The issue was bisected to:

commit e2c2cb8ef07affd9f69497ea128fa801240fdf32
Author: David Howells <dhowells@redhat.com>
Date:   Mon Feb 24 16:06:03 2025 +0000

    afs: Simplify cell record handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f1e198580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f1e198580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f1e198580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab13429207fe1c8c92e8@syzkaller.appspotmail.com
Fixes: e2c2cb8ef07a ("afs: Simplify cell record handling")

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff888025e8e118 object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 5839 at lib/debugobjects.c:615 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:612
Modules linked in:
CPU: 1 UID: 0 PID: 5839 Comm: strace-static-x Not tainted 6.14.0-syzkaller-01103-g2df0c02dab82 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:debug_print_object+0x17a/0x1f0 lib/debugobjects.c:612
Code: e8 8b a3 2d fd 4c 8b 0b 48 c7 c7 40 24 80 8c 48 8b 74 24 08 48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 5b 2a 87 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 48 c6 40 0b 48 83 c4 10 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc90000a08838 EFLAGS: 00010282
RAX: bc12de5074ab4600 RBX: ffffffff8c2bc520 RCX: ffff88802edfda00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8c8025c0 R08: ffffffff81826ce2 R09: fffffbfff1d3a71c
R10: dffffc0000000000 R11: fffffbfff1d3a71c R12: 0000000000000001
R13: ffffffff8c8024d8 R14: dffffc0000000000 R15: ffff888025e8e118
FS:  00000000101f03c0(0000) GS:ffff88812535a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555db2c838 CR3: 000000007bba6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 debug_object_activate+0x350/0x5c0 lib/debugobjects.c:842
 debug_rcu_head_queue kernel/rcu/rcu.h:224 [inline]
 __call_rcu_common kernel/rcu/tree.c:3067 [inline]
 call_rcu+0x99/0xad0 kernel/rcu/tree.c:3202
 radix_tree_node_free lib/radix-tree.c:310 [inline]
 delete_node+0x1b2/0x780 lib/radix-tree.c:573
 radix_tree_delete_item+0x2e6/0x3f0 lib/radix-tree.c:1430
 afs_cell_destroy+0x175/0x2c0 fs/afs/cell.c:522
 rcu_do_batch kernel/rcu/tree.c:2568 [inline]
 rcu_core+0xaac/0x17a0 kernel/rcu/tree.c:2824
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xfb/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__preempt_count_add arch/x86/include/asm/preempt.h:80 [inline]
RIP: 0010:rcu_is_watching+0x9/0xb0 kernel/rcu/tree.c:735
Code: 03 eb cd 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 53 <65> ff 05 f0 cc 93 11 e8 6b 3a 6a 0a 89 c3 83 f8 08 73 7a 49 bf 00
RSP: 0018:ffffc90003fc78c8 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffff8880591cbc00 RCX: ffff88802edfda00
RDX: ffff88802edfda00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff818c7bf9 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff933c6020 R14: ffffffff818c7bc8 R15: 0000000000000000
 rcu_read_lock include/linux/rcupdate.h:842 [inline]
 __task_pid_nr_ns+0x62/0x460 kernel/pid.c:518
 task_pid_vnr include/linux/pid.h:242 [inline]
 wait_task_stopped kernel/exit.c:1359 [inline]
 wait_consider_task+0x1fab/0x30e0 kernel/exit.c:1529
 ptrace_do_wait kernel/exit.c:1569 [inline]
 __do_wait+0x205/0x850 kernel/exit.c:1677
 do_wait+0x1e9/0x550 kernel/exit.c:1707
 kernel_wait4+0x2ac/0x3c0 kernel/exit.c:1866
 __do_sys_wait4 kernel/exit.c:1894 [inline]
 __se_sys_wait4 kernel/exit.c:1890 [inline]
 __x64_sys_wait4+0x136/0x1e0 kernel/exit.c:1890
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x4d6ad6
Code: 00 00 00 90 31 c9 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 14 48 89 74 24
RSP: 002b:00007ffeafb16778 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004d6ad6
RDX: 0000000040000000 RSI: 00007ffeafb1679c RDI: 00000000ffffffff
RBP: 0000000000000000 R08: 0000000000000017 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000101f8f40
R13: 00007ffeafb1679c R14: 00000000101f28b0 R15: 000000000063f160
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 eb                	add    %ebx,%ebp
   2:	cd 66                	int    $0x66
   4:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   b:	84 00 00 00 00 00
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	f3 0f 1e fa          	endbr64
  25:	41 57                	push   %r15
  27:	41 56                	push   %r14
  29:	53                   	push   %rbx
* 2a:	65 ff 05 f0 cc 93 11 	incl   %gs:0x1193ccf0(%rip)        # 0x1193cd21 <-- trapping instruction
  31:	e8 6b 3a 6a 0a       	call   0xa6a3aa1
  36:	89 c3                	mov    %eax,%ebx
  38:	83 f8 08             	cmp    $0x8,%eax
  3b:	73 7a                	jae    0xb7
  3d:	49                   	rex.WB
  3e:	bf                   	.byte 0xbf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
