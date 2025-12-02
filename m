Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67202E8B60
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764705448; cv=none; b=dfNZcN8Qge6A8vCcCq0hOUCskwsLh1KXeecAEcIV+ljRI35KmuXsZ06zgYa5vQzJq5FPElIaFoEgG9F1sz4k8Rfs7kzWckkG5K99To/pfLiATrFx6KhN05kIq7j1KZL6sRZ3lTihMJKEesUhuHnd13vZerTfInY4F/9H/6oc91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764705448; c=relaxed/simple;
	bh=g2UhpqfjXKNF0OfaGHuJB23aihICNVRTNr7S9TvyMJo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DbegaQG4SiFFFvan6GUCUqm0EXCsHLrd8YhndUhd2L1yZLSDjNl6WMKKW/MjpesL1Bq8lnhsCdE4vd6tx3JAt4Do9pHVnXTLJ+IeIipqv5yBsM/QAhH21FXXCQhiL5j4NppI7MNneEUBQYbI7wKH4h9DTpMNRfxBGX445eTmZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-656b7cf5c66so5085288eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 11:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764705446; x=1765310246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nVLTKcIcuHBXvMeIWx1Hk/kgKfEFcDF9OYQg3t3Sb0=;
        b=VUvV7fcsLUT1NOe1DZH7nDgxQmPGn/1bN7uMlGv2fl6ib7zAxB+S2ab1rZ026fk3OK
         ieXKWmpEFt/sK8KKeeZEqaSvgAzMWqAG+kNxeLBGAOJPeS7EoOjslYtEynkTRHFqvVqw
         8I2Ybi97Cu2WPhQpHNT90cz3zK1aDYxZe8seTTC6OKDGloyj+q5fHu9BxVqod7SSzaxb
         +f2fd6Rl5behkKlv/sSueg6JV5wXjKv6oNWiMvhyebASGTWY+5N90CJ512+mEgWUEVBU
         pL8VNnHSCBPOPVqiDUUNQKXQyVuv4Pcdo9U6Kzcrxxiu4PBMTu4f+6YVxFf6+3NjTbRX
         cI6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvyzFrQOU2tKVpYdg1I0HMFKPT6SJvygRLIqaORl2IEYri5hLaEZUt2ib5q7w00JXyu9sVuG1pJ2CheznCELUEibw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUSWf0XTULg4B32Jtam9UmNngVGx03DIO3B8E2iYKUrX+VCzr
	xPylumE+9PPlCMK7HODWSG3FsxxIB5ff73a/rPRCH3kmL4FUTxK4q05/SvGswvg0HRgb3PZEqAV
	Sz1BXZaXP/Bnn5QWJ+Hpp+IlsFJiccabGUxAdqfgz3yOE5za+6H4h6cOUONo=
X-Google-Smtp-Source: AGHT+IHgv2lYu/lsfyny4iEWNS/pg6mOnYmZ875L8S1kg0vVMsMA82LcMzI9e+8pspRiImGfSvXNgUgdDuCuzQLop9eyToZUeY6o
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6b96:b0:450:1f44:da5c with SMTP id
 5614622812f47-4514e7de9a4mr14142489b6e.45.1764705446016; Tue, 02 Dec 2025
 11:57:26 -0800 (PST)
Date: Tue, 02 Dec 2025 11:57:26 -0800
In-Reply-To: <680049ca.050a0220.5cdb3.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692f44a5.a70a0220.2ea503.00c8.GAE@google.com>
Subject: Re: [syzbot] [trace?] WARNING in tracing_start_tr
From: syzbot <syzbot+ccdec3bfe0beec58a38d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    4a26e7032d7d Merge tag 'core-bugs-2025-12-01' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12131512580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f17615e99b9a69ec
dashboard link: https://syzkaller.appspot.com/bug?extid=ccdec3bfe0beec58a38d
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b492b4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b492b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/240381b0df51/disk-4a26e703.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2bfd9dded97e/vmlinux-4a26e703.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1ba9d12daee/bzImage-4a26e703.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccdec3bfe0beec58a38d@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/trace/trace.c:2497 at tracing_start_tr+0x21d/0x2b0 kernel/trace/trace.c:2497, CPU#0: syz.3.186/6257
Modules linked in:
CPU: 0 UID: 0 PID: 6257 Comm: syz.3.186 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:tracing_start_tr+0x21d/0x2b0 kernel/trace/trace.c:2497
Code: 48 85 db 74 0d e8 73 1c fb ff 48 89 df e8 fb 42 fd ff e8 66 1c fb ff 4c 89 ef e8 be c5 ff ff e9 1e ff ff ff e8 54 1c fb ff 90 <0f> 0b 90 c7 83 94 00 00 00 00 00 00 00 e9 01 ff ff ff e8 3c 1c fb
RSP: 0018:ffffc90003777bd8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffffff8e250de0 RCX: ffffffff81c203e7
RDX: ffff888027699e80 RSI: ffffffff81c204dc RDI: 0000000000000005
RBP: 1ffff920006eef7c R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: 000000003ca71f67 R12: 00000000ffffffff
R13: dffffc0000000000 R14: 0000000000000293 R15: ffffffff8e250ec0
FS:  0000555561d28500(0000) GS:ffff888124ba8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000075090000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 buffer_subbuf_size_write+0x1ca/0x260 kernel/trace/trace.c:9702
 vfs_write+0x2a0/0x11d0 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c50f8f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8ab04cc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f2c511e5fa0 RCX: 00007f2c50f8f7c9
RDX: 0000000000000040 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007f2c51013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2c511e5fa0 R14: 00007f2c511e5fa0 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
