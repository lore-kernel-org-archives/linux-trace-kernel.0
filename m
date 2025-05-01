Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A52528EF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 May 2025 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141025; cv=none; b=MUYI1CewAoOc1qo5bESerlayX2y6QTgdHyYRylQ+zyART6UUYsP35HKRLTG5a6BwpY6vQ+R5GBRHQucyiaJaZQYH6beeO94l/eLEjHOZH3bDUKuaHuBdwOpLHR2PvvHHW3fEB8pmit2qujvMc4ab13j/7IMjKmt4IeKVjMuUJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141025; c=relaxed/simple;
	bh=rCiO67wSaKR/J66Y5RaJa3XiHHnRvsJAqdp3twkFRr0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L9WqZ66WWnsTwQ5pIm5zOBbnHJb7GcC6LasOe+ltdascSbfvvsnyz/Ne5mSsFZfBHB8+BYmWBomZjPlYrmhLJfw6n9bnTQbSybJIkqUlJ6ETcI0qLHIwGNz4S7QcaADDZ2Qo3qzhJSpe9mZYTVuhMI/Jy/VAiivnf0eQo4t95to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d96661c8a2so19196695ab.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 May 2025 16:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746141023; x=1746745823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmMunFqJ0wsYItBEBVvHHIbIV4X1ZAlRO6ddSnExrAM=;
        b=iVGqDkeAoSKVAKmmgUY6767T0Iq9BE0gng0DqYciwNHwWnAxlHcbpVZnFPg3Fownac
         hm4yncq04WJvuIT+sL4dEKBC7JzrKHOyq+gvPh9Bcq7BBagp6oJnccrN3JyPEJnAzV/p
         BqHieZr9TqKvU7++hQXPvF1aPCcV8c+tmL3HxUMlEGzFBj56P7QshlJ6mNmHZXAd4uSU
         P+D8dWqcW9jyyALgeZaoiTrJ1zbaf1id68ZZ6MYAsak0FEJXB+LW/sNLMHmDNsic/Xx4
         dQqBsmD8jZp4en2laxTJfcKoY7JyUpDMot8RS5VOhpD6xTxerNYFgHFcg544f1wEdpNz
         aJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyMVaARTZdmwIOevW6oyzt3SsdGuZYANqGmwX6y4lsYzAFYc+xKoYaUyBInAjGpoSmjfT+Yel1rn55dfopfNT9zyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6tRxLtDBOuvlbsP1VrE+C9TBA+EPt5cWcHqTYSDNygVn2tZLY
	M7p8zCqCCyk+w7OBriEAkp9E7Y0zprEK5tjcyoxizGPJzGurdTmIMHbHH/loKwiTu4n/MwKgAuu
	d+GZ5mtrYJWf8fzrl935C5M8ptuzYUzdEr1v0/XfudGXPwHBv7ikyR2o=
X-Google-Smtp-Source: AGHT+IHePGwor4oDjYFlZ6AgTMwp1kt5Ebu1QDtTzbj5/n5aPAKQAnbOGU5nfMeO/496/7sL6A6NdbF2PLqvXXmbxhyV7ATREENs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b46:b0:3d8:1d7c:e180 with SMTP id
 e9e14a558f8ab-3d97c186f80mr8708795ab.6.1746141022869; Thu, 01 May 2025
 16:10:22 -0700 (PDT)
Date: Thu, 01 May 2025 16:10:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6813ff5e.050a0220.14dd7d.001b.GAE@google.com>
Subject: [syzbot] [trace?] possible deadlock in print_event_fields
From: syzbot <syzbot+441582c1592938fccf09@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5bc1018675ec Merge tag 'pci-v6.15-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1246a374580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d61fd67fbda678a0
dashboard link: https://syzkaller.appspot.com/bug?extid=441582c1592938fccf09
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af5f43d5128c/disk-5bc10186.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a6f8aa6c1e6/vmlinux-5bc10186.xz
kernel image: https://storage.googleapis.com/syzbot-assets/423f4c1d2cde/bzImage-5bc10186.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+441582c1592938fccf09@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 Tainted: G     U             
--------------------------------------------
syz.3.3247/22963 is trying to acquire lock:
ffffffff8e44b590 (trace_event_sem){++++}-{4:4}, at: print_event_fields+0x70e/0xc90 kernel/trace/trace_output.c:1049

but task is already holding lock:
ffffffff8e44b590 (trace_event_sem){++++}-{4:4}, at: tracing_read_pipe+0x3e0/0xc60 kernel/trace/trace.c:6658

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(trace_event_sem);
  lock(trace_event_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz.3.3247/22963:
 #0: ffff888027fc37b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2a2/0x370 fs/file.c:1213
 #1: ffff8880785f8090 (&iter->mutex){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:201 [inline]
 #1: ffff8880785f8090 (&iter->mutex){+.+.}-{4:4}, at: tracing_read_pipe+0x65/0xc60 kernel/trace/trace.c:6626
 #2: ffffffff8e44b590 (trace_event_sem){++++}-{4:4}, at: tracing_read_pipe+0x3e0/0xc60 kernel/trace/trace.c:6658
 #3: ffffffff8e443170 (all_cpu_access_lock){++++}-{4:4}, at: trace_access_lock kernel/trace/trace.c:933 [inline]
 #3: ffffffff8e443170 (all_cpu_access_lock){++++}-{4:4}, at: trace_access_lock kernel/trace/trace.c:929 [inline]
 #3: ffffffff8e443170 (all_cpu_access_lock){++++}-{4:4}, at: tracing_read_pipe+0x8c7/0xc60 kernel/trace/trace.c:6659

stack backtrace:
CPU: 0 UID: 0 PID: 22963 Comm: syz.3.3247 Tainted: G     U              6.15.0-rc3-syzkaller-00342-g5bc1018675ec #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3042
 check_deadlock kernel/locking/lockdep.c:3094 [inline]
 validate_chain kernel/locking/lockdep.c:3896 [inline]
 __lock_acquire+0xff7/0x1ba0 kernel/locking/lockdep.c:5235
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 down_read+0x9b/0x480 kernel/locking/rwsem.c:1524
 print_event_fields+0x70e/0xc90 kernel/trace/trace_output.c:1049
 print_trace_fmt kernel/trace/trace.c:4208 [inline]
 print_trace_line+0x129a/0x17a0 kernel/trace/trace.c:4376
 tracing_read_pipe+0x4b9/0xc60 kernel/trace/trace.c:6664
 vfs_read+0x1de/0xc70 fs/read_write.c:568
 ksys_read+0x12a/0x240 fs/read_write.c:713
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f87f858e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f87f9439038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f87f87b5fa0 RCX: 00007f87f858e969
RDX: 0000000000000067 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007f87f8610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f87f87b5fa0 R15: 00007ffcda5a13e8
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
