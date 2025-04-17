Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A12BD04
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849356; cv=none; b=e8AsWjox2Y3uqSCNJsKMo9euztTe9OKHIP0tlcn7jt5p5UyxWXhbyvvL3vk3cBmJJWCgBf1uJA0WufP3EwvLPe+SwtKj/CF3MIJBlaOq+Q6sPQojDggCAo2iXP3Go+3/3N4ZtzDI4STtDhNbJvmrzuNCHlqIIrYDDtEm7pV23tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849356; c=relaxed/simple;
	bh=svD0aEDFTX8S2VICiPdHHjm8xw/AGfSa/f98a6+Xi4I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SdrNa+oYVNYLfFXU7ICs09WF4aiS4y9tEL4BmAK9ECk99vhoXtAfvNZYinyzo8YBQwDlOFJhAebvDu9JNewRECyC90Ih0BXRYLfJ2I4toeYGfX2efxEa8GnkyYQ/JDD3dkj+OJL2vn9GiCCopgORnwevzIV0kP5i7sZ/LSZgDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85b5e46a526so22442639f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 17:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849354; x=1745454154;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEpwKm3tj+RqZkHblkz9yBygrPVmssWRced9seDC+7I=;
        b=RcxoUX71Gnuk6/zkfNahsM0DyQwcaY/srp4nSiVbpa7QzVCzjUgoqKqFLJzgYnvUE7
         b8tnX4/ST94CS+BXJoCKnoz2onWEfKHf5DY3e56qz7Y5vGF1vX9Cw6Oaj4bG5SlPe8yj
         /hTKm5EfcoQljXFFKK6fIMkUHMBwJlRm/UJwCsPaIUgmYgjkARRaOP+7/x+TCzrSode7
         TAH46aOROBsvCToU+oK8y+wrYiyRE9RE7sFTwQRnHffhxVLruOtZfSEGzivuRB1F0fFi
         JsMz7pMuR6Hl0pxadFV2NnVRaj8iEvuPd1BCGVL/6sXNCpc7KmLyV4czg+dzOIISXzN8
         kf3A==
X-Forwarded-Encrypted: i=1; AJvYcCW4VP7etH5o0u0hEphIuAhEWSsqtPe72dLG1UdweuUA/i4Dc07qAhwGydVVs843nfSwUlSDRzMz3tu+pcTLRa0AJ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBx2ISoREBxTdEsWyd5d9ZI+Xgo4SPWHvvC22q7FxDFi0yThaf
	E779kSv2w141u5VrCGnje5s/ap6Jwg3nUPK6UKofxCUiVUaBaEHBrOIGREMbAptpI2UJIhoynOJ
	VKshGFOnBPfKmcnBZkWAWztC/mSNhqN7Do7Q/EVwpFAbKx4Om6tJj9VE=
X-Google-Smtp-Source: AGHT+IEvofckmbvFi5fvj1vj/F9A/xh8+gAdXlN6UmYBsPt/mkfgSaFPPeMT+67VOjTc95D06uNMerJ9pO3Xd44dFkCDW2TF/+8R
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1787:b0:3d4:276:9a1b with SMTP id
 e9e14a558f8ab-3d815b5aef9mr36610315ab.16.1744849354256; Wed, 16 Apr 2025
 17:22:34 -0700 (PDT)
Date: Wed, 16 Apr 2025 17:22:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680049ca.050a0220.5cdb3.000a.GAE@google.com>
Subject: [syzbot] [trace?] WARNING in tracing_start_tr
From: syzbot <syzbot+ccdec3bfe0beec58a38d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3bde70a2c827 Merge tag 'v6.15-rc1-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1240cdac580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a4e108575159039
dashboard link: https://syzkaller.appspot.com/bug?extid=ccdec3bfe0beec58a38d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/385544917b90/disk-3bde70a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e29d15e8394/vmlinux-3bde70a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2dbcc4712371/bzImage-3bde70a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccdec3bfe0beec58a38d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6325 at kernel/trace/trace.c:2431 tracing_start_tr.part.0+0x1fc/0x2a0 kernel/trace/trace.c:2431
Modules linked in:
CPU: 0 UID: 0 PID: 6325 Comm: syz.2.94 Not tainted 6.15.0-rc1-syzkaller-00301-g3bde70a2c827 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:tracing_start_tr.part.0+0x1fc/0x2a0 kernel/trace/trace.c:2431
Code: 00 0f 85 97 00 00 00 48 83 3d 7f 52 62 0c 00 74 78 e8 28 55 fb ff 4c 89 ff e8 80 dd b2 09 90 e9 d9 fe ff ff e8 15 55 fb ff 90 <0f> 0b 90 c7 83 94 00 00 00 00 00 00 00 e9 c1 fe ff ff e8 ad c2 5f
RSP: 0018:ffffc9000f3e7b40 EFLAGS: 00010087
RAX: 000000000001dd6a RBX: ffffffff8e445400 RCX: ffffc9000e2a2000
RDX: 0000000000080000 RSI: ffffffff81bfe7ab RDI: 0000000000000005
RBP: 00000000ffffffff R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: 1ffff92001e7cf69
R13: 0000000000000283 R14: ffffffff8e4454e0 R15: ffffffff8e445420
FS:  00007f889698f6c0(0000) GS:ffff8881249b9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c430541 CR3: 0000000034dba000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tracing_start_tr kernel/trace/trace.c:9410 [inline]
 buffer_subbuf_size_write+0x226/0x280 kernel/trace/trace.c:9408
 do_loop_readv_writev fs/read_write.c:848 [inline]
 do_loop_readv_writev fs/read_write.c:833 [inline]
 vfs_writev+0x6c4/0xdc0 fs/read_write.c:1057
 do_writev+0x132/0x330 fs/read_write.c:1101
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8895b8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f889698f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f8895da6160 RCX: 00007f8895b8d169
RDX: 0000000000000008 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 00007f8895c0e990 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8895da6160 R15: 00007ffd37f16b28
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
