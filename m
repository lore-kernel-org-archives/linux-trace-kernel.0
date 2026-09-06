Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB02D949F
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725738; cv=none; b=tqoz5xFhrJcTJX7xawjw5CLCr2/HlsCypOl+80DymlgJgsje9FVPsw3ggHDKIdWpOKs7ScQa//6fJN8656/NWUBcr4mxFYNoKpQBbHfz6H+F9dgRNgrV1CkW3Dya+oWgUlGc/GKmgg7dU9PjDXFl7jpVOVI4vCvFfOUFJH5PIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725738; c=relaxed/simple;
	bh=F4T0199APrqmC9FKuNhGCwCI97WAts+CH2fIQkbE2kA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mjdgj0BIYFb/W3KewfrBtiObvPXZg+Wse/E+WqypmNxbSKix0wizBuiKIopWu7NbxQg6jENc1rx9FKSpy6+scudqDCVDKUFXGWp7PVn+YhKcDBJmHWKFle2a6lxa3E6XGJKm9QGvDSC02Q/neRMojW13unZZKViSfprH1tdl3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b1bf394d3bso436138eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 13:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725735; x=1789330535;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y2RRAXKka4lw+dBbXHrY+ybPrCISunmGd9WDTiY5gpU=;
        b=K9JHini0YaMM0XomPx6mUi3kCUY/MDRFoUJZzq1IgbLXWSWbqZQkvHqYinHdzxVr4V
         mgmIAn0LMT83tazu8S61JBsmfAI2uczGCqdA9KCzD46WJmQ4YGwUtXNiQeDlcMBY+GSx
         BtW/8brOg2tPPBZ2R0V8F+RtSESJ0oIKFdM3GjSUa+p6qGkZNL7UfYmfDPV+1DJ6C1xc
         xKweOPztUaKcaZEXgflQlk4a8A0E/JW5ZSBpvmZcieT+mB/rUniDgQ+c576KX4e+QqKF
         4njULusd4xKpnqOQk7oCYXzraq8B7szxtkwW8/oR9Trav18F6oApJDRd1OIwU/gYCORN
         G+eA==
X-Forwarded-Encrypted: i=1; AKwUvBzcUbxu9h5DBRQj51Z0o6zy9KpYspEfSgi0ecNmpPK50kKZgqLna44EaANOlFp7uMHZIcDvPZgFUtsgm68w91pCNuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mbqC8YPQlOOUt1CHjddV5A8m53aDIu+DIW1BuNsgZ86wkNVvuk
	GueEX87ZRsUB40UHW3QRGJdPVtqj+rQ/Txliu1y87CppzRCeucguTBicoAjw+bvKkFAtgfEVQaj
	dt5UCw4QiGHln0wNyi9JbKLNZGuTmxBfEZcyzGc6MLS5WME9VPQCofsSDCnI=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ae7:b0:6b1:51fa:3562 with SMTP id
 006d021491bc7-6b6fe3aef1dmr17881614eaf.34.1788725735030; Sun, 06 Sep 2026
 13:15:35 -0700 (PDT)
Date: Sun, 06 Sep 2026 13:15:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9dc9e7.87c06881.102b7.0007.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in ring_buffer_map_get_reader (3)
From: syzbot <syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89a312991dc6 Merge tag 'cifs-fixes-7.3-rc2' of https://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e4bc15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=de3d7f9bcc9212f3fae1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-89a31299.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2299fb3a049a/vmlinux-89a31299.xz
kernel image: https://storage.googleapis.com/syzbot-assets/556be545d7b6/bzImage-89a31299.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com

Cannot find set identified by id 0 to match
------------[ cut here ]------------
!reader
WARNING: kernel/trace/ring_buffer.c:7927 at ring_buffer_map_get_reader+0x5f3/0x930 kernel/trace/ring_buffer.c:7927, CPU#0: syz.2.1764/13608
Modules linked in:
CPU: 0 UID: 0 PID: 13608 Comm: syz.2.1764 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:ring_buffer_map_get_reader+0x5f3/0x930 kernel/trace/ring_buffer.c:7927
Code: ff 48 89 df e8 2e 21 fe ff 48 89 c5 e8 46 8b fb ff 48 85 ed 0f 85 9f fc ff ff 4c 8b 74 24 58 4c 8b 7c 24 60 e8 2e 8b fb ff 90 <0f> 0b 90 e8 25 8b fb ff 49 8d bf d0 01 00 00 48 b8 00 00 00 00 00
RSP: 0018:ffffc90006b57d98 EFLAGS: 00010087
RAX: 000000000000086c RBX: ffff88801c0e5000 RCX: ffffc90024800000
RDX: 0000000000080000 RSI: ffffffff821064e2 RDI: ffff888027852580
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffff88801c0e50b0 R12: ffff88801c0e50b8
R13: dffffc0000000000 R14: ffff88801c0e5198 R15: ffff88801c0ab800
FS:  00007fa41bfdb6c0(0000) GS:ffff8880d5b61000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f60453c8ff8 CR3: 0000000035d0b000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 tracing_buffers_ioctl+0x2e6/0x3d0 kernel/trace/trace.c:7392
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa41b19e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa41bfdb028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa41b425fa0 RCX: 00007fa41b19e159
RDX: 0000000000000000 RSI: 0000000000005220 RDI: 0000000000000007
RBP: 00007fa41b235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa41b426038 R14: 00007fa41b425fa0 R15: 00007ffd22388a08
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
