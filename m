Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794116078;
	b=c93KmBzEHCASm56Brnz2RkayaxZe0S1Yv/53nPJl8/HPnPqa5YibKTQ37CHI61iq7KZu
	 FM/ZWTpAHoS6Mhy5W91jS70Tp4usgAeBxt92f8O3XbBq9IqAuhhtZ2op6qtBov7El6kmR
	 yI6IQtDx+z9/S8licrvxc253D7PRQwe4qTScl7kDfXe7zAxDL3ilHc6Fbu/uyj6wC8W+b
	 ZJL7bypHzRgIH8GHxZib1/oVk1kxFTxROsFLfwAazU1cjZ7/yrKlHDd+E0By8tGOscrJE
	 ly56If//FahQMrjSueeckQBgjeZuo5LnvjQRLiMiwuEPhHD8u69XON9VEa3UY6/yTHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794116078;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=j4pNxTToGDL12GNjvn16GWkBSsKG7Fmeufu8AS4sAds=;
	b=pIbrzEIC96fjZU/r6X/44VZRPSIuvHtnVcihmSzwzDsc54HEgFn1x1t8C3Zgnc/oXC6q
	 Q/66/MAeGvr+qJtzHRA9IzdQr6E8im3UlMhHOZ29Uj3eTG/zhTzQz35CpSTmSW0d6DOLy
	 O4qt+2gZQR3EkoVDV5fWjBInJ/BpSpkeR7mqfY828idgpyiz6dwz6HP1GB6yp72oMQFsF
	 Q8lEWmjRtaND1ZJ+RVrZarTaUO1jsZkComi1APUa8E9vZnlZ0245dq4g4s8kjazb1LW0G
	 9ysdUpUwwkBPL1C4oTcKhuDBZJa2w01JkIJEWeaUxFcVp2AbaZG09D1feOr6nse3roQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9A606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Nov 2026 05:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD9A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b26d8d2498so260932b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 21:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794116077; x=1794720877;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4pNxTToGDL12GNjvn16GWkBSsKG7Fmeufu8AS4sAds=;
        b=hClLsdpZXLswjqoNaGTCBCav5ZX3jxCyreJF/1VkRca2N444g/Bhx2N4sOBliCS14Y
         R8jE0s7r+mdblnsKQJGN/A2UOeucbgK7ZobN5gRBwEu67jCSxtIqMM6CMD8qFbu5J1vq
         85wE2jCcdKA3crCnoSZeRk8TAmx75TfdTpt+vSiJDSwRvkT8QGyeBKL039vdDQ73djE1
         HJZsZaR6T70HOfIAL1bbhzbtn13hxZMMkkO2X8c6be1f2g9w2xsoNRE2NOeeXqKggg1p
         QIbgasIsFNSIF5B+mqdIgksher/42lc6COP4kvKAbBosBjq6rKZgLYgrtQf/WFDo99Y7
         p8Pg==
X-Forwarded-Encrypted: i=1; AKwUvBw/pVOHMoaYuRcLTw6H3B8XD1vbvcUIt5ekuiW5f7lTJ4QnnEPjJlDPYTdSp1AZ/QLSZfauFDVCL0xQ6MCaty5pnac=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AOANlTOPuR5baxxkiPpl8vqwE7Pegvew3ip1WCCXHiejihAPg
	Xv6DZMkK6BuDpiWjNDWdomPuhblbXKE/jDIdHlMZdqvEOmXKxfyWXa7lfiO0qMdJFXj7cdlPggg
	fyb/5FgD8cw6Jgf/BH67L2X9j5sEfQMeTldh3mQdU26KtvL6sAsFE1ObLnPg=
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3096:b0:4bb:ac05:9ebf with SMTP id
 5614622812f47-5681431e1dfmr543308b6e.14.1794116077059; Sat, 07 Nov 2026
 21:34:37 -0800 (PST)
Date: Sat, 07 Nov 2026 21:34:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af009ed.4dd4714a.f8d02.000d.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in ring_buffer_nr_dirty_pages (2)
From: syzbot <syzbot+008851bf625629489e75@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, vdonnefort@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d48723711bae Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1075efdd580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d16c0eae9c338e3c
dashboard link: https://syzkaller.appspot.com/bug?extid=008851bf625629489e75
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/db075c0aa29d/disk-d4872371.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68dc5cfbbb35/vmlinux-d4872371.xz
kernel image: https://storage.googleapis.com/syzbot-assets/044cdc896523/bzImage-d4872371.xz

AI-generated root cause summary:
ring_buffer_subbuf_order_set() updates the sub-buffer order by allocating new
pages, freeing all old pages, and pointing head_page, tail_page, commit_page,
and reader_page to the newly allocated pages. However, it fails to reset the
per-CPU buffer accounting counters (pages_read, pages_touched, pages_lost, etc.)
or invoke rb_reset_cpu(). When pages had previously been read from the buffer,
pages_read remains positive; subsequent event reads on the newly allocated
buffer further increment pages_read while pages_touched remains 0 (since writes
have not yet filled and advanced the tail page). This violates the ring buffer
invariant that pages_read cannot exceed (pages_touched - pages_lost) + 1,
triggering the WARN_ON_ONCE(read > cnt + 1) warning in
ring_buffer_nr_dirty_pages().

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=008851bf625629489e75

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+008851bf625629489e75@syzkaller.appspotmail.com

------------[ cut here ]------------
read > cnt + 1
WARNING: kernel/trace/ring_buffer.c:866 at ring_buffer_nr_dirty_pages+0x1c6/0x1d0 kernel/trace/ring_buffer.c:866, CPU#1: syz.9.1552/10668
Modules linked in:
CPU: 1 UID: 0 PID: 10668 Comm: syz.9.1552 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/15/2026
RIP: 0010:ring_buffer_nr_dirty_pages+0x1c6/0x1d0 kernel/trace/ring_buffer.c:866
Code: 02 fe ff 4c 89 f8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 19 02 fe ff 90 0f 0b 90 45 31 ff eb df e8 0b 02 fe ff 90 <0f> 0b 90 45 31 ff eb d1 66 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90005caf880 EFLAGS: 00010087
RAX: ffffffff81c9d795 RBX: 0000000000000002 RCX: 0000000000080000
RDX: ffffc9001e6fa000 RSI: 00000000000000ef RDI: 00000000000000f0
RBP: 1ffff11027fc7a14 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1027fc8423 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000001 R15: fffffffffffffffe
FS:  00007fbb96ae66c0(0000) GS:ffff888124811000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5b66f85ff8 CR3: 0000000036bc0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 full_hit kernel/trace/ring_buffer.c:888 [inline]
 rb_watermark_hit+0x1e3/0x2d0 kernel/trace/ring_buffer.c:984
 ring_buffer_poll_wait+0x254/0x2f0 kernel/trace/ring_buffer.c:1141
 vfs_poll include/linux/poll.h:82 [inline]
 __io_arm_poll_handler+0x395/0xbb0 io_uring/poll.c:612
 io_poll_add+0x1a0/0x2c0 io_uring/poll.c:987
 __io_issue_sqe+0x180/0x450 io_uring/io_uring.c:1514
 io_issue_sqe+0x177/0x12a0 io_uring/io_uring.c:1537
 io_queue_sqe io_uring/io_uring.c:1794 [inline]
 io_submit_sqe io_uring/io_uring.c:2089 [inline]
 io_submit_sqes+0xea7/0x2500 io_uring/io_uring.c:2212
 __do_sys_io_uring_enter io_uring/io_uring.c:2903 [inline]
 __se_sys_io_uring_enter+0x364/0x1bb0 io_uring/io_uring.c:2852
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbb9888fb19
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbb96ae6028 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 00007fbb98b15fa0 RCX: 00007fbb9888fb19
RDX: 00000000fffffffd RSI: 0000000000000b38 RDI: 0000000000000004
RBP: 00007fbb98927b70 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000004b R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbb98b16038 R14: 00007fbb98b15fa0 R15: 00007ffd91292ae8
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
