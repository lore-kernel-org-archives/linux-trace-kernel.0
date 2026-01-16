Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF653101D2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 22:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602306; cv=none; b=tLJOfwaoh394VXPL5ku9ePz/2/yfBqWRaTGvGE/auXSSB0zKKyWRarD+Q6hgpKmrDUOnPZ74MJshLo32qtvKVT2UnZsXbrH0ICRfLXI7mviC5zJmq1Ol44WVf7Xnl8zwUrK0vd+QNevMoSJNX5D8Mf8HIXwCTcQLZ657ZY72xIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602306; c=relaxed/simple;
	bh=qptEp8sEbtVPxJxGO0g+sItbsWbLaXt42kMa9TNE7OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTGi0zx9z75b0SVXMcG6bhNh+YiFUwrhJtSUsFu/VXaYUxjbV5fj0/gokHYvHH/h1RJNqCNi2uEyfOWeyZAZDQewJuPdzRTf0hy3pqyxgUugYw97EEClMa48WbJnrzYBuDc8wZ8CMemvb9v3t28cdplr2XcvGY7i4qwxM/DGy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYjAObTc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYjAObTc"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so1177327a91.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 14:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602305; x=1769207105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKu+95CPgLvp/C5TpNMES7nTK5oZeBFLzp4GfKdaUjQ=;
        b=BYjAObTcCgGFplePKZv6cz5XoZKBjmWL48jUdlDZp+DBFqebZubj0QRA4bvqAKBJj2
         nOYU2n4OFBgGt6K1rprnpPxbDV0F1Be1QAp0zgnqRP3RVFWuYHbfqccJm9uklvH9XPWp
         wjrUaGi0BLzqck69ZMRm5bFiz3e3xbFnNR5K1ubysC6TqXMzZ2K7SFtF+W0Zdct3D8I8
         RO/bq3JMjG+HJc0fQ+RQfnyv0fMrd2Q4HYoltQwAr3yNetP0aAyR5qcaJ9CHYXjAxT1s
         vo1WYdIveve1yhrffb7jD0b7KKXbvDlNpPWcJaIlMuBuHqziJbXUe/dfXcoN5LDISe/h
         GE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602305; x=1769207105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JKu+95CPgLvp/C5TpNMES7nTK5oZeBFLzp4GfKdaUjQ=;
        b=sYVY1hAh1sJ88vmNWPBYbSK1DUCi+VXe3eSHIh3zPp4nq/9234gRiQcDdIwkYTj9x9
         +AjImQrnYRdESk0skFs31p353v0ky+fERVbKjDMo6Csu1f7yCkTK1pM82E0CbQ7wbE30
         yuyH9uCC2Fi39LF9sUDUzkB0xuYhh3hACsnx2cf3cO0KQj4rIDA7QMWGwkq81YDCLLld
         VCfwL3W0m7FT+wRvME3crxIpLw/GNWX6drKroqHiCYGdji4EekRpXdBXg2Nj75moFTCf
         W04l1b2Q3pTM7xbHPLXj9intPk4FE8YwNW/ys/6jzkEr9zm/nGF//0wy/8o9ZNqMUBiW
         94pA==
X-Forwarded-Encrypted: i=1; AJvYcCVtoVjMpvIgQJj74U5zGbFai/ZUHiSqjqEocRnG6NhinwKBmFcLPcaxsumjVUHuOQej5sRpHBaU00ujXWEljZwktZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMrTGYOV+pJ5Ayl+LzfoBQlqBgN7pT+S/oSszBPh8ysvhhlci+
	rFmQ0SZtHOf5ZeM49q+ha9lR2J6ozsov2HnP6/zjggIfu+TLlBxVY539rT58AdM8ZnmXhJxma+a
	n5N/zCE0MMw4980gQWpfHX5hK9WlTuME=
X-Gm-Gg: AY/fxX4FVvlNEppVBkYLgsFUj1Wp+3yzkWYbq0aonf8MqM7ibDGIiV0e7th/vHdDnau
	JNbbsYAtxxJcAL1slZRxR3t4FUNGdprqYlCAEKUH0YyPuxlWUZEExWFR+U5HxkNwKqaJt6WGrC8
	6CF2/H9/QSH9VSDaZIU9Vsv+y3Gbs9DNdClLex0RJ+ZQctg5OwmKIgvyWn4czxdWaU9BVMdRMSF
	aW1LvWoO4jCy5j1jPaUnD97teh4Z1Gfw+mOU4X55LSzP9a+dtVwPwbIn3fbOCF6KZhUVra0GVAW
	eOaKcNLtncM=
X-Received: by 2002:a17:90b:3501:b0:340:d1a1:af8e with SMTP id
 98e67ed59e1d1-35272fe6ee0mr4031169a91.37.1768602305010; Fri, 16 Jan 2026
 14:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112214940.1222115-1-jolsa@kernel.org> <20260112214940.1222115-3-jolsa@kernel.org>
 <20260112170757.4e41c0d8@gandalf.local.home> <aWYv6864cdO2PWbb@krava>
 <CAEf4BzZ-sPD4UZF-TL2ep-zQOyeOC3K5XC2o3Gsx4Q6XpN-zQw@mail.gmail.com> <aWpme7kBw9xyzRFP@krava>
In-Reply-To: <aWpme7kBw9xyzRFP@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:24:51 -0800
X-Gm-Features: AZwV_QjlKAd57l3v7WOINdaUEuCO64fxYBxvdL4QvGUxnlSeVPU6ggFqHIo30QA
Message-ID: <CAEf4BzZyF2MsF5CkLEsrd0dumeCJ3-zzP+azCZ4TRoDkzjGLdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi program
 stack unwind to hw_regs path
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mahe Tardy <mahe.tardy@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 8:25=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jan 15, 2026 at 10:52:04AM -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 13, 2026 at 3:43=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Mon, Jan 12, 2026 at 05:07:57PM -0500, Steven Rostedt wrote:
> > > > On Mon, 12 Jan 2026 22:49:38 +0100
> > > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > > To recreate same stack setup for return probe as we have for entr=
y
> > > > > probe, we set the instruction pointer to the attached function ad=
dress,
> > > > > which gets us the same unwind setup and same stack trace.
> > > > >
> > > > > With the fix, entry probe:
> > > > >
> > > > >   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
> > > > >   Attaching 1 probe...
> > > > >
> > > > >         __x64_sys_newuname+9
> > > > >         do_syscall_64+134
> > > > >         entry_SYSCALL_64_after_hwframe+118
> > > > >
> > > > > return probe:
> > > > >
> > > > >   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
> > > > >   Attaching 1 probe...
> > > > >
> > > > >         __x64_sys_newuname+4
> > > > >         do_syscall_64+134
> > > > >         entry_SYSCALL_64_after_hwframe+118
> > > >
> > > > But is this really correct?
> > > >
> > > > The stack trace of the return from __x86_sys_newuname is from offse=
t "+4".
> > > >
> > > > The stack trace from entry is offset "+9". Isn't it confusing that =
the
> > > > offset is likely not from the return portion of that function?
> > >
> > > right, makes sense.. so standard kprobe actualy skips attached functi=
on
> > > (__x86_sys_newuname) on return probe stacktrace.. perhaps we should d=
o
> > > the same for kprobe_multi
> >
> > but it is quite nice to see what function we were kretprobing,
> > actually...
>
> IIUC Steven doesn't like the wrong +offset that comes from entry probe,
> maybe we could have func+(ADDRESS_OF_RET+1) ..but not sure how hard that
> would be
>
> still.. you always have the attached function ip when you get the stacktr=
ace,
> so I'm not sure how usefull it's to have it in stacktrace as well.. you c=
an
> always add it yourself

You can, but that's a custom thing that every single tool has to
implement. Having traced function right there in the stack would be so
nice and convenient.

I don't insist, but I'm just saying that practically speaking this
would make sense. Even conceptually, kretprobe is (logically) called
from traced function right before exit. In reality it's not exactly
like that and we don't know where ret happened, but having traced
function in kretprobe's stack trace is more useful than confusing,
IMO.

But again, I just found it interesting that we could have it, if we wanted =
to.

>
>
> > How hard would it be to support that for singular kprobe
> > as well? And what does fexit's stack trace show for such case?
>
> I think we will get the bpf_program address, so we see the attached
> function in stacktrace, will check
>
> thanks,
> jirka
