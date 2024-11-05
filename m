Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D7A1C3050
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Nov 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827394; cv=none; b=BFUlnGkOcEl3zwBaxuw84awIEYh8WDMuVYtgBN3fNmCK0Ln1be1Z0YOJBffaeEpkD8G92mPsWR3nsyll0RntRPySz73YYVk/nzJH0N/7a4RPQQBmSnd92ugxhXbrTOMTutYNfaitIHmVZSerIpyjDFcZlx/fIRwwtlev4G5aFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827394; c=relaxed/simple;
	bh=X+nVM5Ux9ZuBPMElI2g/fbAvFXZkWSd4puN8DC0/0co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acmqZqv/iBhJ2+DQrvYNkHA6e7lhN5NrAXdV/Dul2haEnFfGqiN1ULdpLshv5L1IclPH1wFrwdGDZpXwDyTinrRBhRFUp4bfE8nsPMN5Ozgc44VgRx2x1818vRmGU85jtaiVR7OvYe8lNhrcG2BGt7dgS1RNXnzYy7WiBhIDygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyP/Mdt1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyP/Mdt1"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4124367a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Nov 2024 09:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730827393; x=1731432193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFEkJSmFiPqxmVdTIAWTeQZ4orXSMuinYyWJKTteJXA=;
        b=gyP/Mdt1RZQdQ5P+xfOA+FlR7nTT7nFhmb/drJGzuUeoOoVixSbrO1riueYMdLZieJ
         4W82Vi1hEQo7xPCJ6S7W1BppRwvaQVu34APK22aAwYhp49lQQ1+mRJO5U0WZRRtWSDG4
         hQKMa2y4ErarMOu9Q8vCliGDVUeaaILYUzij+be+cTY+ls2sphzMtKECaO1yBMh2n8eU
         jxDwYxKiE0Oj/tDSRLfIDGy0UqajLPLFeymM2A4zN/+TL3BP9gMIESFGcUCuR53qomNL
         3pZXSgFOrnjuhrZCp2HWvj48740egpSXUj1FcDQMe/rXTqzRyzxXfloXmab39N/9TG4w
         WX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827393; x=1731432193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFEkJSmFiPqxmVdTIAWTeQZ4orXSMuinYyWJKTteJXA=;
        b=Zf7Bw+SvuHxAFvn+QzmO7StltlmjWLPeaQHt4WYzwfpFew3bAgVbhXnO6dqWPu3kZ/
         U5aNLykFcqZm0n7UzBvVCCfmfzvVgkGDkI21otbP48oAzIrMPlZuI9WBAEVZAsARn96k
         Bk6ohxEgNFjPFcPfPl0AVxlF5uUDlHU3bLyul8yPrGrVp2zDaJuNvcabXBe/XZu8uAGc
         +kD8d5ogzEz4Dhppsx5jPeCA4lqnMwKYM9SNnfvTd2Xp5Dm712d25hgqN66EvinAsN2X
         XV6gegYVq9YHR6BK/V4f9PcDLA/NGhjNSYwMr1H2gHWEoMsxucQiQ24ZerOjgyNy2L7G
         q8wg==
X-Forwarded-Encrypted: i=1; AJvYcCXV03hk42w7r+x+i/2u4kgdskYMKpMdVYMH9avXrqCOPNvlAaQfuaJc9PeJoGok9depwoOfgzwDyoDd5I7UJrUBwD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqB9eXDhI3iA7vB9LWKOha66rr10ve0Mzv6mljBVAa+mkDLgwL
	aWTUgv96eTv8X6caZdfOaqNPD7VnM3n06THpJS5zEBoa2YKbv3xKswaH6wnrlZH4bO92kPXAYzK
	X3x4WTNtjkrpVM5aiHyE+icIABpnVplXGoKeN
X-Google-Smtp-Source: AGHT+IHma8fLUOn+H32JHjxE8FoZSYPSkUkdl8S3zm6eR6C0od/60rQM75LsVAzSrn9/BZfRkG+odt/kNEHn/zPcTIs=
X-Received: by 2002:a17:90b:4c8b:b0:2e2:cd80:4d44 with SMTP id
 98e67ed59e1d1-2e93c1d22famr25936840a91.28.1730827392768; Tue, 05 Nov 2024
 09:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133610.1937089-1-elver@google.com> <20241105113111.76c46806@gandalf.local.home>
 <CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com> <20241105120247.596a0dc9@gandalf.local.home>
In-Reply-To: <20241105120247.596a0dc9@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Nov 2024 18:22:36 +0100
Message-ID: <CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 18:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 5 Nov 2024 17:53:53 +0100
> Marco Elver <elver@google.com> wrote:
>
> > > > +/**
> > > > + * task_prctl_unknown - called on unknown prctl() option
> > > > + * @task:    pointer to the current task
> > > > + * @option:  option passed
> > > > + * @arg2:    arg2 passed
> > > > + * @arg3:    arg3 passed
> > > > + * @arg4:    arg4 passed
> > > > + * @arg5:    arg5 passed
> > > > + *
> > > > + * Called on an unknown prctl() option.
> > > > + */
> > > > +TRACE_EVENT(task_prctl_unknown,
> > > > +
> > > > +     TP_PROTO(struct task_struct *task, int option, unsigned long arg2, unsigned long arg3,
> > > > +              unsigned long arg4, unsigned long arg5),
> > > > +
> > > > +     TP_ARGS(task, option, arg2, arg3, arg4, arg5),
> > > > +
> > > > +     TP_STRUCT__entry(
> > > > +             __field(        pid_t,          pid             )
> > >
> > > Why record the pid that is already recorded by the event header?
> >
> > To keep in style with the other "task" tracepoints above. I can
> > certainly do without - it does seem unnecessary.
>
> Hmm, new_task, pid is different than the creator. But rename is pointless
> to record pid. I would get rid of it here, especially since it also creates
> a hole in the event (three int fields followed by a long).
>
> >
> > To cleanup, do we want to remove "pid=" from the other tracepoints in
> > this file as well (in another patch). Or does this potentially break
> > existing users?
>
> We can't from task_newtask as that's the pid of the task that's being
> created. In other words, it's very relevant. The task_rename could have its
> pid field dropped.

Ack - will do.

> >
> > > > +             __string(       comm,           task->comm      )
> > >
> > > I'm also surprised that the comm didn't show in the trace_pipe.
> >
> > Any config options or tweaks needed to get it to show more reliably?
> >
> > > I've
> > > updated the code so that it should usually find it. But saving it here may
> > > not be a big deal.
>
> How did you start it? Because it appears reliable for me.

Very normally from bash. Maybe my env is broken in other ways, I'll
dig a little.
