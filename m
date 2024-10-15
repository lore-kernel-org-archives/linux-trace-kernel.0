Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2919F132
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986745; cv=none; b=jzFBOW3iGP/x8L/fLjl1WVmfBejbstWY19Zf9Hu53TTXXZHShq2F0XTj5v/rMBo4r4pIOvsE7+EquRYO/Ezb0P85rwzSBY3y4LGJHW5CaRHqlAVqxo/L9wgxeyn0fVIbou22XOlIDrvAdn9RrDNYzu2qCkvEkpbwcGQYsAJ4HEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986745; c=relaxed/simple;
	bh=BPsnlM4jiS7NsX7J2NdZKdPrFoWf/4f2HMA3nR+Yv3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+tjGN/lMyvZK95ai2KOuEOIjlXOqxeKpljF4qUpDyL43hFLgZ7+lAdFqJ4LsOF3l1CStmnio64C8GWs3jbV8v9oSjlaTDVI9AmVcG4K9LpvzcUROoPiU4hZZKv3gEBl+S+c8Qq7jCibwPbIOS4wKl3UDAVmrLeg0PDBVrO15o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V6lwJAi9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6lwJAi9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0d9b70455so4022445a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728986743; x=1729591543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qrkg/ZRV10IdU56/7mYKjiH6Upw8Qx1eT1zUM9r+QU=;
        b=V6lwJAi9ATBprSXBlwBEAF/EGPX0fGKWZ5th8Gob+kRbtYG9mJs2uKI9PkK7Y0NN+H
         mUhOao3UYL2oE5vUuQFyLVjiUeGDpPeeEKqiSioPCd8IqttXBZtZSjFlFvbO7wZ+Oati
         NxNyw+6EhjvGJGDLKIN35YUJ6mQXyqkkmFlNAcszDk7mFsg3mLDB0ACbWEtav9EFsVik
         XxN5Su2yG0Rvi//ID9/qiV+AAqgCl2H9BTAP7b5NXKALPLLJfjUmg4dHl9szGAJUl9pw
         N/PcITj00ryexU6JjyWFleZzQYpxfQvcsx/9PlBcG1PgcB+LfV4ieboFg9rkyBAylrZV
         VStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986743; x=1729591543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Qrkg/ZRV10IdU56/7mYKjiH6Upw8Qx1eT1zUM9r+QU=;
        b=PdAYyqf+HgBVKG9HJcm8gUXrdnyc7l4axOnFvndaYVXNITnKaxeGo5lVOhlBIQl7P7
         Fc/xOjRcdSb+ihWJiIHH/W9eYuqadFL2nvMAX/D/GzNW/+Dkxj/evg/Xuat2oq6X5H5d
         7UJ/pmHB/uR3WK3jO8of7bu7HJOtrqPNPhCtsrtwCbvFVKFa0NyNcxXBVfxqf4MjYYtd
         V7VnKTiMHBIOSmxRMVVcVqaCUhDzUga+/pbNpEu/h9woL+cd8zGyYnZn9JiiGi/ZCRLJ
         f33S3VMrrieu3llOs2pJmU5ekjp9SAT2XnkS/2IB/jw4e2na4zKXmz3zrM7K/n24XoKE
         RHTA==
X-Forwarded-Encrypted: i=1; AJvYcCXZuKbIhSnIo+NCMj9Pj/RZd+brHwX9bEoMh+otW4YeaExRUDYMKvVRIjoqjO/rcLIIDE/rG4EIQ+Fy/ERxc9zavCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjtX4qWbGHQN/M7UIxTejksAV8LYz0707xOlMiVF9pNVfqg0/
	yTuAk2qTEditdA+IHX5TnLTXJ8BafpN2wejV9/KUHwiUdh7hKCHjtvhCZ4aQdiO9M35q32iX7dj
	Js4gzkZKa5t1iLW3dIiKRlyQufA54EYGr8Xj7
X-Google-Smtp-Source: AGHT+IHbXOGzJCKOgpup02dkaO5xVaIhqtf9TGZtn/M5v/vKmEv8ALqVeLPqkRz25CJYOQrboeLU0AvZT7KH0o5zi68=
X-Received: by 2002:a17:90a:ee85:b0:2e2:e8fc:e0dd with SMTP id
 98e67ed59e1d1-2e2f0dc33f8mr15829263a91.35.1728986742588; Tue, 15 Oct 2024
 03:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67094369.050a0220.4cbc0.000d.GAE@google.com> <20241011120028.1e4ed71c@gandalf.local.home>
In-Reply-To: <20241011120028.1e4ed71c@gandalf.local.home>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 15 Oct 2024 12:05:29 +0200
Message-ID: <CANp29Y4KERQxwOwMCW5a4+YahhA8gWyJ=btE=OxnNgrF6puFgw@mail.gmail.com>
Subject: Re: [syzbot] Monthly trace report (Oct 2024)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Thanks for the analysis!

On Fri, Oct 11, 2024 at 6:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 11 Oct 2024 08:25:29 -0700
> syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com> wrote:
>
> > Hello trace maintainers/developers,
> >
> > This is a 31-day syzbot report for the trace subsystem.
> > All related reports/information can be found at:
> > https://syzkaller.appspot.com/upstream/s/trace
> >
> > During the period, 1 new issues were detected and 0 were fixed.
> > In total, 10 issues are still open and 38 have been fixed so far.
> >
> > Some of the still happening issues:
> >
> > Ref Crashes Repro Title
> > <1> 34      Yes   INFO: task hung in blk_trace_ioctl (4)
> >                   https://syzkaller.appspot.com/bug?extid=3Ded812ed4614=
71ab17a0c
>
> If you check the maintainers file, blktrace.c has:
>
> BLOCK LAYER
> M:      Jens Axboe <axboe@kernel.dk>
> L:      linux-block@vger.kernel.org

Judging by MAINTAINERS and ./scripts/get_maintainer.pl,
kernel/trace/blktrace.c belongs to both "BLOCK LAYER" and "TRACING".

$ ./scripts/get_maintainer.pl kernel/trace/blktrace.c
< ... >
linux-block@vger.kernel.org (open list:BLOCK LAYER)
linux-kernel@vger.kernel.org (open list:TRACING)


>
>
>
> > <2> 32      Yes   WARNING in bpf_get_stack_raw_tp
> >                   https://syzkaller.appspot.com/bug?extid=3Dce35de20ed6=
652f60652
>
> bpf_trace.c has:
>
> M:      Alexei Starovoitov <ast@kernel.org>
> M:      Daniel Borkmann <daniel@iogearbox.net>
> M:      Andrii Nakryiko <andrii@kernel.org>
> R:      Martin KaFai Lau <martin.lau@linux.dev>
> R:      Eduard Zingerman <eddyz87@gmail.com>
> R:      Song Liu <song@kernel.org>
> R:      Yonghong Song <yonghong.song@linux.dev>
> R:      John Fastabend <john.fastabend@gmail.com>
> R:      KP Singh <kpsingh@kernel.org>
> R:      Stanislav Fomichev <sdf@fomichev.me>
> R:      Hao Luo <haoluo@google.com>
> R:      Jiri Olsa <jolsa@kernel.org>
> L:      bpf@vger.kernel.org

Same for kernel/trace/bpf_trace.c:

$ ./scripts/get_maintainer.pl kernel/trace/bpf_trace.c
< ... >
Matt Bobrowski <mattbobrowski@google.com> (maintainer:BPF [SECURITY &
LSM] (Security Audit and Enforc...)
Steven Rostedt <rostedt@goodmis.org> (maintainer:TRACING)

>
> > <3> 13      Yes   WARNING in get_probe_ref
> >                   https://syzkaller.appspot.com/bug?extid=3D8672dcb9d10=
011c0a160
> > <4> 6       Yes   INFO: task hung in blk_trace_remove (2)
> >                   https://syzkaller.appspot.com/bug?extid=3D2373f6be3e6=
de4f92562
> > <5> 4       Yes   possible deadlock in __mod_timer (4)
> >                   https://syzkaller.appspot.com/bug?extid=3D83a876aef81=
c9a485ae8
>
> None of these look like they are tracing infrastructure related.

Like get_maintainer.pl, syzbot relies on the MAINTAINERS file to
attribute bugs to the individual kernel subsystems. If several ones
are suitable, the bug is assigned several labels at once. It's now
actually the case for all open "trace" findings:

https://syzkaller.appspot.com/upstream/s/trace

(FWIW it's also possible to manually overwrite these labels and remove
specific bugs from the monthly reports).

I could make syzbot set "trace" only if there's no other good
candidate, but I wonder if that could hide the findings in the trace
infrastructure that manifested themselves in some specific traced
subsystem.

--=20
Aleksandr

>
> -- Steve
>
>
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > To disable reminders for individual bugs, reply with the following comm=
and:
> > #syz set <Ref> no-reminders
> >
> > To change bug's subsystems, reply with:
> > #syz set <Ref> subsystems: new-subsystem
> >
> > You may send multiple commands in a single email message.
>
