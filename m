Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7817A583
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825672; cv=none; b=DMWaETAqL5egydyjr2MILDG+7kYW4vlCDPIBcVFDekiy8/cBANQtdX47iYj1BFkvd9pF1oTC+Ipc5I+Cl4F2SQjG4hvubpin1E+wVGBZdac+ExwJHns3qWS5Tp1MRLQ1WHN26E5kZYy7RoPUQPWrJGaFs2FtHzfbe2MES5Ln7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825672; c=relaxed/simple;
	bh=2RTqeRanCZRVuVwRYjm6xauwjoXLJTZUEYwZgSBi5Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dN0KP3e5ZiSHLLM8qwR6ewlw2CwvPqDbSUSmUYn2q81337CzVkdmPmUJ2AXtcrhDmDT4GMVKPX0lxpoNgZBI2yJIzUZBE1KZF0qy5pqIqdYBQ60EQc7txnIi7Qha4rOWT7y00Df4I3s5P0cowWnDGIjvxNq3IOv1jp8E3oFrtak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOxgUnap; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOxgUnap"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so4124881a91.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Nov 2024 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730825670; x=1731430470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V83vNZjqmDf/Us+3d1QTdKDw13qNe5x5q2rn92+ivN4=;
        b=NOxgUnapvlz0ESVt7a3X74FmTEn1ROQTpHkAz31pDBzcX/hpnx8+3XQQ1koZOf+Tlr
         cWIg6J/d61qX2rxG/SE1p8A69SbuAXEE0BWUmA8Zkf8ChxOS4EHdf50qqkFRVp2vleN0
         Kv2ahRBM2dSXeMIGzB/hM/5mZkalp23D5PHjzdcNlrmLeKOXniAqqD9ByLxI/pGY/Flp
         MEST6ARnUQHTw9uoH5GLIMUi/BLATRIvuKGj0ZJheDGRtf3ayzAUm9n62MwdyDWWk8Ai
         3TBFGDs/zKEWk9Y3+bBCICo6k0AAbHgkU7Fr3kCzxCuXJAoY9ZSH/R+96bWeQaN2D2A1
         g49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730825670; x=1731430470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V83vNZjqmDf/Us+3d1QTdKDw13qNe5x5q2rn92+ivN4=;
        b=RzdX/tj2AcZjWrWXsJOAjEDwulx9DONwo6cy2NoHkZoPj89RrHkxKrGZNa37eMh5lM
         hnalUPFI7ABRs2MC0fqjuqZhjHX3s+aH1Y187lCcYqDYFWB6bquTHKqBUBSCt2F6ufsA
         87qzqNIpY5a4Xuw6hWoyoSDQDzPeUzPrj8sAgCFl9Go8lStkiO8bBv/h0dZz/q3K0Tbu
         qh/zaQcF574tH7J6P76s5asFp1v8AvmiNWWmXc2CtK8DGZhWIuE95dIIN+qzslWgJZpO
         lcG+FxVXpFZOBaOsOvCFShAXxGusw2n8RIYHknOR9a+DLW9TEFYp57eQSpz9Mh5vuSqj
         nTNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/in+h8Bsz5+TujziHi3407bqHNU2lG2GLs9U56/eVjBm/3ZNzgRwny/llwsAZ4s75zKfCevUDHWkJ334SCXo6B0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPh/70LKBnNCuWkTBUp7hb3hvVNcqAZ2MUmSnYDdVkI22Lww4
	mnWti8JxzmohIpwekjZx10aDE/QbEaHLwg4CtS6OVoih9I5fB9fHcCWcdKf8fFDRU/DOeKpGYI7
	2I1CRO+e+JWijsL/9e5qSBPrZymAscp2XnK49
X-Google-Smtp-Source: AGHT+IHgGKjcXP9UPeBSqpiCbBmVO3rP7QuECe2VAKoOe368YeWDTYdo/IUd6rwIx/QwQAZVOP+TP42CuyvwwKmCHXg=
X-Received: by 2002:a17:90b:3908:b0:2d8:e7db:9996 with SMTP id
 98e67ed59e1d1-2e92ce50f8dmr27815450a91.13.1730825670072; Tue, 05 Nov 2024
 08:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133610.1937089-1-elver@google.com> <20241105113111.76c46806@gandalf.local.home>
In-Reply-To: <20241105113111.76c46806@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Tue, 5 Nov 2024 17:53:53 +0100
Message-ID: <CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 17:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue,  5 Nov 2024 14:34:05 +0100
> Marco Elver <elver@google.com> wrote:
>
> > prctl() is a complex syscall which multiplexes its functionality based
> > on a large set of PR_* options. Currently we count 64 such options. The
> > return value of unknown options is -EINVAL, and doesn't distinguish from
> > known options that were passed invalid args that also return -EINVAL.
> >
> > To understand if programs are attempting to use prctl() options not yet
> > available on the running kernel, provide the task_prctl_unknown
> > tracepoint.
> >
> > Note, this tracepoint is in an unlikely cold path, and would therefore
> > be suitable for continuous monitoring (e.g. via perf_event_open).
> >
> > While the above is likely the simplest usecase, additionally this
> > tracepoint can help unlock some testing scenarios (where probing
> > sys_enter or sys_exit causes undesirable performance overheads):
> >
> >   a. unprivileged triggering of a test module: test modules may register a
> >      probe to be called back on task_prctl_unknown, and pick a very large
> >      unknown prctl() option upon which they perform a test function for an
> >      unprivileged user;
> >
> >   b. unprivileged triggering of an eBPF program function: similar
> >      as idea (a).
> >
> > Example trace_pipe output:
> >
> >   <...>-366     [004] .....   146.439400: task_prctl_unknown: pid=366 comm=a.out option=1234 arg2=101 arg3=102 arg4=103 arg5=104
>
>           ^^^                                                       ^^^
>
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/trace/events/task.h | 43 +++++++++++++++++++++++++++++++++++++
> >  kernel/sys.c                |  3 +++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> > index 47b527464d1a..ab711e581094 100644
> > --- a/include/trace/events/task.h
> > +++ b/include/trace/events/task.h
> > @@ -56,6 +56,49 @@ TRACE_EVENT(task_rename,
> >               __entry->newcomm, __entry->oom_score_adj)
> >  );
> >
> > +/**
> > + * task_prctl_unknown - called on unknown prctl() option
> > + * @task:    pointer to the current task
> > + * @option:  option passed
> > + * @arg2:    arg2 passed
> > + * @arg3:    arg3 passed
> > + * @arg4:    arg4 passed
> > + * @arg5:    arg5 passed
> > + *
> > + * Called on an unknown prctl() option.
> > + */
> > +TRACE_EVENT(task_prctl_unknown,
> > +
> > +     TP_PROTO(struct task_struct *task, int option, unsigned long arg2, unsigned long arg3,
> > +              unsigned long arg4, unsigned long arg5),
> > +
> > +     TP_ARGS(task, option, arg2, arg3, arg4, arg5),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(        pid_t,          pid             )
>
> Why record the pid that is already recorded by the event header?

To keep in style with the other "task" tracepoints above. I can
certainly do without - it does seem unnecessary.

To cleanup, do we want to remove "pid=" from the other tracepoints in
this file as well (in another patch). Or does this potentially break
existing users?

> > +             __string(       comm,           task->comm      )
>
> I'm also surprised that the comm didn't show in the trace_pipe.

Any config options or tweaks needed to get it to show more reliably?

> I've
> updated the code so that it should usually find it. But saving it here may
> not be a big deal.

Thanks,
-- Marco
