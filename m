Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3282475CB
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803847; cv=none; b=au4ARqGqyur+Tsk+w/iwDhwifWXuGXZp2R5yEbXScTwOIHjU5FXFU0aNYVkLNk68xjxVaCS7FED2y+6YqrU1YU2J/EoJ2RHK6LTEJOoLp+e4vzQLtUoUrN18S5wjNTL79eU9+Fken+39PUmD0TTKmyPtzqqYcc8c/It8APaN32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803847; c=relaxed/simple;
	bh=p4kBBPJEh7M7Hh3+LMzNRxux2nzwikxQglLPsFbl0Z8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bmbQ8VjDS9AfqfVtlEQPcgEUOUNS/OskNLMtMPDOpI2hm2AYUkQyhjmQ0kbF01cc74RJzDdVERmHmPGHjTypZMIggeqY6VqgyAWVrQx0VDp4B8ZR94I1UcaE/kEM4rFQJu8bUPSkP+fuZDmcTiA/8vdB5YNJrV+1WBaEznCvpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7f66ceea676so5477376a34.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 10:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788803845; x=1789408645;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q1thYKT71sMTsyiOqZTOT9885C0AwCOip12nNxtpG5g=;
        b=GpKMV/T7yEsJN0T6dlYkANkt7uhNNqHP/TY5kCsbfJeOEw6BALmxKj/zJZxJFp3Xpn
         cJmCtuIM2KOeGjY/Ci+69K7SfGKTo/KzmcJV1Yz+i6T07Ep8QDjd/hsPFhPCXisiD0Sg
         GBk6p2k1jkKz1QIHqr5dz3A7EcEVK7vwSim1hikU+s+ptrXc7tyJAaXghCPlK+sCpw5Q
         Ep1jb6KMgdHdSnHlKzInEv9yO3cJDbxJEyhF04MIgo0SuYWPA159cHEVjzTweCxNqYpr
         xOr2ePqYl2lCmwV1FPBHChNTTsyFqiQPcfDT3+lOcREiqSLF0LDT32/KKMkZbrIWd7xH
         U0kw==
X-Forwarded-Encrypted: i=1; AKwUvBzKCJIZ7UA4GaYdRjkGZ3CBDqes0CDuK3qNDWi606GghmRZOZZKKLhnMiL1OqLBkyhWWDqxwVM7LXzZmcMC53CfOrA=@vger.kernel.org
X-Gm-Message-State: AFuF++kSdkA1s5fK+uRZ/9u8KbxAlP2EsDQl4CdIYyYxiodOyhEzM0lL
	ZeEZsh8JOiSpXSY1n4uAfZMoXqEzrzzAjzcrgqmGIeLTevdiuhs3MbHXkfi8US1IymJqZQmm5uU
	m7EedVXc1HBJi9AGf+3a52SFfjcqHY0Y7zYqEHWg12vY8CLL2v1driAWVS/o=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:209:b0:6b1:858:28a9 with SMTP id
 006d021491bc7-6b6fafd7c7bmr14863495eaf.9.1788803845128; Mon, 07 Sep 2026
 10:57:25 -0700 (PDT)
Date: Mon, 07 Sep 2026 10:57:25 -0700
In-Reply-To: <6a9dc9e7.87c06881.102b7.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9efb05.f81106d8.4d30e.0002.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in ring_buffer_map_get_reader (3)
From: syzbot <syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    df2908090cda Linux 7.3-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1216caf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=de3d7f9bcc9212f3fae1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1616caf9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com

Ring buffer [0] commit overrun lost 3 events at timestamp:71798603963
------------[ cut here ]------------
!reader
WARNING: kernel/trace/ring_buffer.c:7998 at ring_buffer_map_get_reader+0x5f3/0x930 kernel/trace/ring_buffer.c:7998, CPU#1: syz-executor388/6024
Modules linked in:
CPU: 1 UID: 0 PID: 6024 Comm: syz-executor388 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:ring_buffer_map_get_reader+0x5f3/0x930 kernel/trace/ring_buffer.c:7998
Code: ff 48 89 df e8 be 22 fe ff 48 89 c5 e8 a6 88 fb ff 48 85 ed 0f 85 9f fc ff ff 4c 8b 74 24 58 4c 8b 7c 24 60 e8 8e 88 fb ff 90 <0f> 0b 90 e8 85 88 fb ff 49 8d bf d0 01 00 00 48 b8 00 00 00 00 00
RSP: 0018:ffffc90003977d98 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff88801c0e5000 RCX: 0000000000000001
RDX: ffff8880333d4b00 RSI: ffffffff82108882 RDI: ffff8880333d4b00
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: ffff88801c0e50b0 R12: ffff88801c0e50b8
R13: dffffc0000000000 R14: ffff88801c0e5198 R15: ffff88801c0ab800
FS:  00007f337024b6c0(0000) GS:ffff8880d5c5d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559c2c45caa0 CR3: 000000003dec3000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 tracing_buffers_ioctl+0x2e6/0x3d0 kernel/trace/trace.c:7381
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3370a8136b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007f337024b130 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f337024bcdc RCX: 00007f3370a8136b
RDX: 0000000000000000 RSI: 0000000000005220 RDI: 0000000000000004
RBP: 0000000000000021 R08: 0000000000000000 R09: 00007f337024b6c0
R10: 0000000000000008 R11: 0000000000000246 R12: ffffffffffffffd0
R13: 0000000000000000 R14: 00007ffc1cde9710 R15: 00007ffc1cde97f8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
