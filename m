Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15836CE03
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727511; cv=none; b=CgLfn2tn3nIBeuDWjd72lGn4w6PXI3ml9qnC5l4zjkDUkmrJRRk+s8asmS0hXcz8+mgx0+NiAlW7o+laAPspfr0qRUgLPyAqfM4ty6ucfMu4TF1U5AsbK+TNJCRUy2e182QWjAWWl9udRQVNE8uECtgThpqAIQgpeRIz3aFVFes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727511; c=relaxed/simple;
	bh=D9kd2ZDOXCcQjW9+HthtTaufcYzyoyvzKwZZ8Bqds74=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JAR1OlheIYc0l8K/AY41BBzGohBoN2JXdJkjsQsLTAmtFvg91EpavudjEl4p2LTaeb8ryx3WsOev3umrcqihWsmRDpu2GhztfWJ4x2pWeixTrefkBUA55KNZ5y0jUyvNmjcIIFHhotmNn9uBG9aDIkIDVnxlleAU/WlnFIgdgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-662f3f6bafeso5901592eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 14:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769727508; x=1770332308;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sA3bgFkm7u/SOm6cTZfJC4oELPy3KLa5Wksg8U8PayU=;
        b=Vufc5rjJ8zYGQhcsCWr/vy23nrY7B/rawk1L+lJJt+jwmf8kzYrX5J+vF1jBAVK+mF
         TEPNtkGbeTyGrsN1AmjRbhgeR34OpVPjNi+9move/aHZXOXGLUgm8Fl6AXKqPHVRdlyl
         ceh1XIqDyuIZJ3LoDzE0QwgEUwMo/JT0KfIsGZCgAosUqs4WhiYXvWRMxjx/WoH7U+tw
         sLWqZKkjzWDFcUxm4mFTHyF7ju0PGZGvEZBUCYxiA7NfJXPg+GdeFroNGwEduvFK8Gvj
         RieVXOp7nrKSv8iPDi37wKjuAH5C/vHBFAijGsuQf3njgwQ4CcRw+wbsAwrj1ablUdk3
         w4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUvMY0okljLzAsQs+cpGMnlcHVADEEceXzbAvkL1ARsFHq4jv7ZuaB0oCwaiIdSu2U/l9XOLUzz0PzuaNPwmUvga2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgC2yrlbjkgApuS6ETtZlS0c5B2Juo1QSov8H6Pp5ZhZJ/7VdR
	0KGKqNPEFcjW74u29BBibA6MyoHvjDTBvuYv3KZP/4cUJUXp3WnUfVEkrASHaLeliXh6iTwV9SR
	YSg6oBbb9RkawZygEDr+IEMrSYUiRqitgkc1AgyK1HB+4bv3Npes53DMTkqA=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4cc7:b0:663:e77:3cde with SMTP id
 006d021491bc7-6630f3ab512mr459888eaf.76.1769727508286; Thu, 29 Jan 2026
 14:58:28 -0800 (PST)
Date: Thu, 29 Jan 2026 14:58:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697be614.a70a0220.8545c.0069.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in __dma_map_sg_attrs (2)
From: syzbot <syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8dfce8991b95 Merge tag 'pinctrl-v6.19-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14278073980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aae00ac5a9d2645
dashboard link: https://syzkaller.appspot.com/bug?extid=28cea38c382fd15e751a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1354085a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111f0d8a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-8dfce899.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4eaf4687f53f/vmlinux-8dfce899.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e1fab48af47/bzImage-8dfce899.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28cea38c382fd15e751a@syzkaller.appspotmail.com

------------[ cut here ]------------
perf buffer not large enough, wanted 24620, have 8192
WARNING: kernel/trace/trace_event_perf.c:407 at perf_trace_buf_alloc+0x1e2/0x280 kernel/trace/trace_event_perf.c:405, CPU#0: syz.0.17/5497
Modules linked in:
CPU: 0 UID: 0 PID: 5497 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:perf_trace_buf_alloc+0x1e9/0x280 kernel/trace/trace_event_perf.c:405
Code: 4c 89 f0 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 05 2d f6 ff 48 8d 3d 9e ca 24 0e 89 de ba 00 20 00 00 <67> 48 0f b9 3a 45 31 f6 eb cc 44 89 f9 80 e1 07 80 c1 03 38 c1 0f
RSP: 0018:ffffc90002a57720 EFLAGS: 00010293
RAX: ffffffff81ce59eb RBX: 000000000000602c RCX: ffff88801f9fa4c0
RDX: 0000000000002000 RSI: 000000000000602c RDI: ffffffff8ff32490
RBP: ffffc90002a578a8 R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1fde7cf R12: 0000000000000bfd
R13: 000000000000000c R14: ffffc90002a57820 R15: ffffc90002a57840
FS:  0000555569728500(0000) GS:ffff88808ccea000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbc8bc17368 CR3: 00000000453be000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 do_perf_trace_dma_map_sg include/trace/events/dma.h:278 [inline]
 perf_trace_dma_map_sg+0x2a9/0xc00 include/trace/events/dma.h:278
 __do_trace_dma_map_sg include/trace/events/dma.h:278 [inline]
 trace_dma_map_sg include/trace/events/dma.h:278 [inline]
 __dma_map_sg_attrs+0x390/0x520 kernel/dma/mapping.c:251
 dma_map_sgtable+0x67/0xf0 kernel/dma/mapping.c:323
 drm_gem_shmem_get_pages_sgt_locked drivers/gpu/drm/drm_gem_shmem_helper.c:758 [inline]
 drm_gem_shmem_get_pages_sgt+0x16e/0x360 drivers/gpu/drm/drm_gem_shmem_helper.c:798
 virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:171 [inline]
 virtio_gpu_object_create+0x1fe/0x1050 drivers/gpu/drm/virtio/virtgpu_object.c:231
 virtio_gpu_gem_create drivers/gpu/drm/virtio/virtgpu_gem.c:42 [inline]
 virtio_gpu_mode_dumb_create+0x2fb/0x5d0 drivers/gpu/drm/virtio/virtgpu_gem.c:90
 drm_mode_create_dumb drivers/gpu/drm/drm_dumb_buffers.c:227 [inline]
 drm_mode_create_dumb_ioctl+0x2bd/0x340 drivers/gpu/drm/drm_dumb_buffers.c:236
 drm_ioctl_kernel+0x2df/0x3b0 drivers/gpu/drm/drm_ioctl.c:804
 drm_ioctl+0x6ba/0xb80 drivers/gpu/drm/drm_ioctl.c:901
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f624939aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb40ecb88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6249615fa0 RCX: 00007f624939aeb9
RDX: 0000200000000040 RSI: 00000000c02064b2 RDI: 0000000000000004
RBP: 00007f6249408c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6249615fac R14: 00007f6249615fa0 R15: 00007f6249615fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	4c 89 f0             	mov    %r14,%rax
   3:	48 83 c4 08          	add    $0x8,%rsp
   7:	5b                   	pop    %rbx
   8:	41 5c                	pop    %r12
   a:	41 5d                	pop    %r13
   c:	41 5e                	pop    %r14
   e:	41 5f                	pop    %r15
  10:	5d                   	pop    %rbp
  11:	c3                   	ret
  12:	cc                   	int3
  13:	cc                   	int3
  14:	cc                   	int3
  15:	cc                   	int3
  16:	cc                   	int3
  17:	e8 05 2d f6 ff       	call   0xfff62d21
  1c:	48 8d 3d 9e ca 24 0e 	lea    0xe24ca9e(%rip),%rdi        # 0xe24cac1
  23:	89 de                	mov    %ebx,%esi
  25:	ba 00 20 00 00       	mov    $0x2000,%edx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	45 31 f6             	xor    %r14d,%r14d
  32:	eb cc                	jmp    0x0
  34:	44 89 f9             	mov    %r15d,%ecx
  37:	80 e1 07             	and    $0x7,%cl
  3a:	80 c1 03             	add    $0x3,%cl
  3d:	38 c1                	cmp    %al,%cl
  3f:	0f                   	.byte 0xf


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
