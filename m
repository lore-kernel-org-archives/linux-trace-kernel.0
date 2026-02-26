Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002EB38B7BD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772087644; cv=none; b=JBM/95k0S6jVSLV9of8vfWsnEttjyI1e/9psoNylvCpU465ykaQ5mSEm+vXj6NI9YaUShIFLx8Vk4WV5wE49eOIcibNNErNwiu2KFiyUE/5uTkmrdHP8dvP0BLg8cHe+QktqrhHhBwMXXANcT5aLFqh1MZtLkGaznS0KqNRZ5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772087644; c=relaxed/simple;
	bh=AfrOeuiiWhCtJIH2F/Nwt0t+34tj+YFHUD2tEMXMbyA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sIOghxMOY1fX8SXsbHPg4sT9ST97RPwI1bWOYi9687a8rpR3o0+f6GwCTvDGxkenWHnfZl8glvaeEhRNbhDaauXeBC/yFcz1fd9Z4ZYw4nhRSHNcOlRr15+M266kKR2kOtFGmeH/JA4nusZ6tH74W+7bQiHa+AfVvVUzSIVXT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67995e1ecacso13627395eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Feb 2026 22:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772087642; x=1772692442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=giGSYQ4Vx7fcq2sN/QOD8haee2uqxwuFuSC1ZnGpANc=;
        b=nLIvYbJXgc66FRfHvCc4r6TxEAHLWVNKBD3HC02sBN4I4Xm35STCcQ9i0RgTL+wkjv
         8Qi9ebYx3EIlECkjZp3VcS4T5yv4jVScqlzI2kC4jwHyqTaQcMd4vyyz+lEtipy6ZSSc
         3UtvsxfPe+1d3ixdgJJioYX5lLITt2zn9RyspOgKEuIPC/oOk9Ojlw3y152O2oZakhjM
         a13XoxC3npXpOJzUQJfvhgIoL6AkTk+r5reCKy1z8xADdr/Cx8GIeBtxpGiYKeVyEdRn
         777rtwOGr1504fMDOX1/8vdE9mUuCBUZTlnWO0aRw5gdHmsYh18zYoUiMistW5fz13Zl
         x9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUyOo19U1aXQzIOS86P/Nu1HGsn3rTijtd1SbladrMPM+IrUTRxmHl838pTZYAiEOeP/QK1eMzYnqE+tJjajpEBPQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYWfGzJWt2E1U65LdFPpFippCeePeoCkY9sK2x91LnP130pGY
	dZe9tZCSmQmXC8uWzMLHP5pYJKXdqQyI5K3uESoEqE+mr2NzRqZs5p5BNQa4Vl0JUWeblv0rPkZ
	FrwN4jaG5Qpnb2M6phZBrN3CbMpm7F07qgLetgoGan7pIVnETiCyXQbPGqPg=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b18:b0:66f:2d14:32b7 with SMTP id
 006d021491bc7-679c4646639mr9493668eaf.9.1772087642057; Wed, 25 Feb 2026
 22:34:02 -0800 (PST)
Date: Wed, 25 Feb 2026 22:34:02 -0800
In-Reply-To: <20260226061625.30751-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699fe95a.050a0220.2fcbed.0004.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in tracing_buffers_mmap_close (3)
From: syzbot <syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in tracing_buffers_mmap_close

------------[ cut here ]------------
ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file)
WARNING: kernel/trace/trace.c:8221 at tracing_buffers_mmap_close kernel/trace/trace.c:8221 [inline], CPU#0: syz.0.17/6401
WARNING: kernel/trace/trace.c:8221 at tracing_buffers_mmap_close+0xea/0x140 kernel/trace/trace.c:8216, CPU#0: syz.0.17/6401
Modules linked in:
CPU: 0 UID: 0 PID: 6401 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:tracing_buffers_mmap_close kernel/trace/trace.c:8221 [inline]
RIP: 0010:tracing_buffers_mmap_close+0xea/0x140 kernel/trace/trace.c:8216
Code: 08 e8 1a 74 ff ff 31 ff 89 c3 89 c6 e8 0f 50 fb ff 85 db 75 0f e8 56 55 fb ff 48 83 c4 08 5b c3 cc cc cc cc e8 47 55 fb ff 90 <0f> 0b 90 e8 3e 55 fb ff 48 83 c4 08 5b e9 54 55 83 09 e8 ff bd 66
RSP: 0018:ffffc90002f27ab8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffed RCX: ffffffff820ca621
RDX: ffff88801efcdac0 RSI: ffffffff820ca639 RDI: ffff88801efcdac0
RBP: ffffffff820ca550 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffed R11: 0000000000000000 R12: ffff888078da3048
R13: 0000000000000001 R14: 0000000000000005 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88812434f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4d99a17dac CR3: 000000000e598000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vma_close mm/internal.h:190 [inline]
 remove_vma+0x88/0x160 mm/vma.c:466
 tear_down_vmas+0x2a5/0x600 mm/mmap.c:1264
 exit_mmap+0x469/0xa30 mm/mmap.c:1322
 __mmput+0x12a/0x410 kernel/fork.c:1174
 mmput+0x67/0x80 kernel/fork.c:1197
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x78a/0x2aa0 kernel/exit.c:959
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1112
 __do_sys_exit_group kernel/exit.c:1123 [inline]
 __se_sys_exit_group kernel/exit.c:1121 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1121
 x64_sys_call+0x102c/0x1530 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4d9979c629
Code: Unable to access opcode bytes at 0x7f4d9979c5ff.
RSP: 002b:00007ffea34a0a28 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4d9979c629
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000000 R09: 00007f4d999e53e0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4d999e53e0 R14: 0000000000000003 R15: 00007ffea34a0ae0
 </TASK>


Tested on:

commit:         f4d0ec0a Merge tag 'erofs-for-7.0-rc2-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12efb55a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af6ed0125ed44356
dashboard link: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1484c24a580000

