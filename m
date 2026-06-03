Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53010421EF5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476641; cv=pass; b=ojCbiB+NBpuMd+JBNnY5/21u6SJX5j7O23s+fpx89+4UdzQ9FVymS6du2/ttHB8tukcED+8dgB9PAA9IVUsmiO0PbdC9xCbP/B4fiFTtOae2VMNm/lSUz4PB12TInbLwtlhTrF4IhWgtjn/ZUPCO3YL2fiic9wQ7Qh7sAQrefUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476641; c=relaxed/simple;
	bh=TduT7W6XlnVob/ystS+p6niXGO76mhr6LJ9MTHmYQCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNQ57dxA6gMjWySQ7Fdu+wQV8gxHKqT2bHc5/7X/NHvS5Bphd+8HY9b2ploD2zBhNKFmRM78b6jwPcpTQ+2jtXM3kkIHM/kOsVYrn78yu3CnV6xqY/Q9pTjPMEqyjp7v3CyC0ZMZ4VbVWnDPlhMjcxZvmvbE7EL5AUJnHlIbX5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKB+Wwav; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKB+Wwav"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68d233bf083so5591712a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 01:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780476638; cv=none;
        d=google.com; s=arc-20240605;
        b=Oftz2Gct6ngZHzDjMPMILL6iE41Yl0ay+iWQ11z+6jNNJ4l4fUOoypKy/7epMevheN
         cyF/Fwm/DjYKEdzBvO8gB98WUMJGy7jyUgota4qjs1OVeWoHjAjcdlFPq7WSOK1bDDet
         pwWVfIDlROPzBHwLClhitLo/qtv0UAtgpTgvb83/pUeWQG33Fh/FzeXNj3XxUtgrLHkh
         5lAMbkIYiqWBQ8A3Ns3lHcuxtSh59RCzbp/bnuGXfgK0P+9K3bkjEB/yyR6plpLEYNfH
         0YYx7PLYpwLOmb0fGnDBIWpd1QR4XK77eGbR5r4SEzXucdY+QRzDapah48Pn/decghE6
         Vy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rmIXOrovyBrCur0KanaPzZYnaNdJ3sGoi+MMbvRi4cw=;
        fh=SzM6Vuga+Iokjx51/Iyk4VNtJjoYaolRsM23fByeJV0=;
        b=OU7ik5rd4zRMvvMz8fqqTxMWbM/flztDxsq7LVWG0zDCH9YQuJXnfqzOU/+U4RganX
         N2RU+DKb5vDi8wzn6a8Qr4aiq6L8zDDJeV7Wnq0FQ91JpTrOJlIZyZge3G/lgZDkzEfB
         OjOy/cE2whJzEHDKM+8WfWITCRZ036I6j97dsFtOPUZQP2qcJPdlg/QK+FmqAWievBF6
         OOHvpw16DqvsPM8BLk8FQZuGmIis0TwrS2vG35YTGdn+LWeMCEl5qHdzQFDrn3NAV6wI
         jcUAyRGKOaitIG8IovpCHRCOVzzUE0tPEUuod/yE+A9oAj+0Bf1Gp/M4ud/w7GukMlIm
         AXTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780476638; x=1781081438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmIXOrovyBrCur0KanaPzZYnaNdJ3sGoi+MMbvRi4cw=;
        b=PKB+WwavZh+1dtttDPDBdDVKhjcBpNSkAXjaq+NQA3H+fRwuHZ7dam7wRKvom4J1wR
         /+1++bGLHfE6veAMTdnLxiWihhuoFbHzTk2fhp9Eb/7bdq0xX/jKvst3gd/c1/lGgBsK
         TLxmHalUvunjFneIoxRsTOEP3nFj1sj5nkt40LCvYV/Gq7+1BdEWT1h08X02nhY1cBfa
         nkR9hbJ+Klh78CwEoG5HnXTJCFEKL0CF45N1I7Q7QyWMd5LkflzOHlUlPsziTfmKzQn/
         6h10wwQ1amIV6ghToXuxFw2Ko1LyBi98JmLsJ56jd55WiFdyWQhKWz9b/MuH4hIfoshG
         xqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780476638; x=1781081438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmIXOrovyBrCur0KanaPzZYnaNdJ3sGoi+MMbvRi4cw=;
        b=FrojpbKD5m84MhdHpMFwiWRRsij9hJHnWKTFqTKcMu49W5qUtFG7yPjSQWNCd1miW0
         SzqzLvJwsEprDzl481z9i3BStr3s0GaTyfyrOVMlhQHlMKiVqGaJQewLiPUzZUf5EFeO
         kMYbS6J+dNFK6F0+puJ9TfdV/E4aHSFv049O5AlBcOOUNzj2D4b/nPq1B+SOiig4Yw8M
         kCcou3/IYdPBw28syfo+s/c6bopXUdeDV29nKTG6X4DWuChRmWOe4sk77kYbA/NrK+L+
         XMgBxZYD4c5n8T8zJwRvUqIDKBRz1cofqmq9LgmrfN/H43+nRDY8OcKDuvypCDFhtSRk
         yxXg==
X-Forwarded-Encrypted: i=1; AFNElJ/glI4LKafavrBnAkhOiKR6gBE8LrBeQEUniiIk2tC6FS8a6cnRZ6jylCgxXIdBin38i+v64UTBnphu3SyevR3jQmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEVXGtZlI2/MJB9VNvfg8c5d1znsxQLUhdH+GqPl8w0RYwyOA
	eB5ukFtO4rf76kSeb1CORDzRa0AgZAeGQNktMtOWkvzPlL3Mdbw0GoJwyZGG+A9FgsZ/xYIkRIG
	5JPqSmHGx6gW+HQ1459cqSobEA3uZXjwxfWHVr8OU
X-Gm-Gg: Acq92OHW/EpX2NKTPgRqp9ElphKIrIMGzX0nKQFKxRN8YzZXTwlN+N0dPrdxIVp9ER6
	oIQvlFI6bsujyz7Oda3i7hG+PYpcQAp4O/nZgVORoeBuciTy8a92gRUSAc8svN9irW/QArCjA2U
	IlS+7LvAts8UAh+TXR2M6YDGkS20BI7V77R9rmWPKRQr4eRhksVK3wg1rrlrcC4hHRvPOg2FiFv
	9r8p30DVRl++++0vqskBZHJ3GlgupUpJRQauDTBZO5E3mbN9WxEBMMw48Ru6gRC9bjjW9sSnAEv
	jAc+N/wTRklr9cAX6ziws6AyUN++Zvdads4SyuKIILb2H/c=
X-Received: by 2002:a05:6402:40c5:b0:66e:56a2:b67b with SMTP id
 4fb4d7f45d1cf-68e710f01bdmr1065423a12.20.1780476637337; Wed, 03 Jun 2026
 01:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a1ede7b.b4221f80.1326c5.0003.GAE@google.com> <20260602122829.4a91864f@gandalf.local.home>
 <20260603103445.236f260a3c5eafe140055761@kernel.org> <CANp29Y55QBfKT=FLpn=trH5Tmxj2P_7H7yhJG_xXCbCdR3Lv_A@mail.gmail.com>
In-Reply-To: <CANp29Y55QBfKT=FLpn=trH5Tmxj2P_7H7yhJG_xXCbCdR3Lv_A@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 3 Jun 2026 10:49:58 +0200
X-Gm-Features: AVHnY4JntfroBe3NrvyRqc36YDIhXOv_NPTCSElp_Y9avzoaDZuITLnuVVfUef0
Message-ID: <CAG_fn=WVfi9=M8VjJQt8jCpXf-0D30-BQDCZZM+FX_0d8V+yhA@mail.gmail.com>
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Write in ring_buffer_read_page
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:38=E2=80=AFAM Aleksandr Nogikh <nogikh@google.com>=
 wrote:
>
> On Wed, Jun 3, 2026 at 3:34=E2=80=AFAM 'Masami Hiramatsu' via syzkaller-b=
ugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > On Tue, 2 Jun 2026 12:28:29 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Tue, 02 Jun 2026 06:45:31 -0700
> > > syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com> wrote:
> > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    e7ae89a0c97c Linux 7.1-rc5
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16f06e2=
e580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D58acee1=
ac5406016
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2dd9d02f6=
0775ce5c1fb
> > > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils=
 for Debian) 2.44
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Looks like the test was doing something really weird to trigger this.
> > > Without a reproducer, it's pretty much impossible to find out what
> > > happened. Maybe AI could do it?
> > >
> >
> > Does the "I don't have any reproducer for this issue yet." means
> > this is not reproducible even if it runs completely same sequence
> > in the console output? If so, might this be a timing related issue?
> > (e.g. read v.s. write-event)
>
> Yes, syzbot normally re-plays the sequence of last programs executed
> on the crashed VM to find a reproducer, and, in many cases, they no
> longer crash the kernel..
>
> In the meanwhile, syzbot's AI bug reproduction functionality has found
> a C reproducer for a KASAN crash in the kernel/trace's ring buffer,
> although with a slightly different stack trace:
> https://syzkaller.appspot.com/ai_job?id=3Db2620161-1632-4d4e-9314-114a8a5=
e79ef
>
> Cc Alexander Potapenko

Yes, the bug that the AI reproduced manifests with a different stack:

BUG: KASAN: slab-use-after-free in instrument_copy_to_user
include/linux/instrumented.h:129 [inline]
BUG: KASAN: slab-use-after-free in _inline_copy_to_user
include/linux/uaccess.h:205 [inline]
BUG: KASAN: slab-use-after-free in _copy_to_user+0x79/0xb0 lib/usercopy.c:2=
6
Read of size 12288 at addr ffff888180423000 by task syz-executor144/5941

CPU: 1 UID: 0 PID: 5941 Comm: syz-executor144 Not tainted syzkaller #1
PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_copy_to_user include/linux/instrumented.h:129 [inline]
 _inline_copy_to_user include/linux/uaccess.h:205 [inline]
 _copy_to_user+0x79/0xb0 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:236 [inline]
 tracing_buffers_read+0x4cd/0xd60 kernel/trace/trace.c:7158
 vfs_read+0x20c/0xa70 fs/read_write.c:572
 ksys_read+0x150/0x270 fs/read_write.c:717
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9facd00cde
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89
c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90
41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f9fabc9e198 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f9fabca26c0 RCX: 00007f9facd00cde
RDX: 0000000000004000 RSI: 00007f9fabc9e200 RDI: 0000000000000006
RBP: 00007f9fabc9e200 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9facd7ab20
R13: 0000000000000000 R14: 00007ffd6ed73110 R15: 00007ffd6ed731f8
 </TASK>

Quoting the AI itself:

"""
The reproducer successfully triggered a KASAN use-after-free crash in
the tracing subsystem. Although the exact crash signature differs
slightly (a read in `_copy_to_user` called from `tracing_buffers_read`
vs a write in `ring_buffer_read_page` called from
`tracing_buffers_read`), both crashes are use-after-free bugs on ring
buffer pages accessed during `tracing_buffers_read`. The reproduced
crash shows the page being freed by `ring_buffer_subbuf_order_set`
(via `buffer_subbuf_size_write`) while being concurrently accessed by
`tracing_buffers_read`. This confirms the underlying race condition
between reading the trace buffers and modifying the buffer size/order
has been successfully reproduced.
"""

I took a glance at the reports, and the above makes sense: we just
happen to access filp->private_data->spare at different times after it
has been freed.

PS. Please bear with repro-c, it's making its baby steps.
The reproducer contains some dead code, and the results are hard to navigat=
e.
At some point we'll probably be able to link AI-generated repros from
the original bugs.
