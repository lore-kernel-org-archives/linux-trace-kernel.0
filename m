Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A4343D85
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Apr 2026 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490737; cv=pass; b=bEJHjQ5YtFPuIn2jdLtuoMWrAY7awwMSBapUFnZWnJ6mvx9IMKedExw2oEqLeZH9rCRwtNlauKj0P1mpTypSLhbzv7utcFTKIOPcuX+krL1um6R1N0EU2DMzgHhLXMYUKSpUxiBrhzTKTWJzvHGVs2+6L33ZNMkJ+0bY5BVMAfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490737; c=relaxed/simple;
	bh=1l08R7ZQ50eRsY4/UZ/JPsZUSIkUWOUTj772drwjKG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stPzEsE42+9tBUvI3gg+xzYKqqMAD3r+1/Zrn6VPM6jo0rXIxVax65DWINRLRuoPlfVCqyat1vzGaCajB2IuF2QwusyQOp5FcmMbuIQ4j4ylnMV8xA3evYXnlXsEtJ1WXHq/5O4W5/G9gm5vlPLssw8Kp1gFRhoqEMwQw2yA04o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBAUtBQT; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBAUtBQT"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7b186dfc1d0so20090207b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Apr 2026 22:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776490735; cv=none;
        d=google.com; s=arc-20240605;
        b=kNdzJ+em2Mxha+kp7cl38tQg9BRKmgxG34XT/Ws5ii6rVs2Ne1leNwaAhWprHPxKi5
         ez3CP+wFgBXvqRBDCCJ6hsx+NqL838+D71skC8nXtDO9n1pwR0hZq+s71Wa9L+yz6avl
         dtW6F6z2+M9nsqA+7Ot5cGGZeXbHuyrHAuxyOXgl2GFkj2N9rdNs5avY9UuB/Axv1qg3
         ITxkzH22hI6o3v1cMjcH0eeWTzD3JISJkFpMJzJUlc3eOibrKbf6upzc2DyAbcv3vkSp
         OOXOgJyGAbC6GoSYK97I0SlUIuI+VGS/AYGOWf+pHPJqn5Dx86N6DzKU0eHTb3J7GkpP
         Omxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lDL4Vs6dqA+MI0aq/6FmGgsCzCeh95absu6jpu5ijw0=;
        fh=LVHtgPonfFSO6BciFDPFLrS9kTIMDYqPzSbTB91iC8w=;
        b=UkZ+1pvhBW5tXNdnr2vur5F4SgTD+hNA0HGHs9uOd7F0KQHggPrt6PFoGFlt6miOG7
         iZA3xOQuDsYOVngJiW4q9hrlsTkWMO5zoB+dsD4cG/ZbbYC3poum9qY2sLz/RageJ0L2
         LcFHZxejqlbMYUcmPOKLndIlxn83Mqd2gmwkgzWRYMTJuu5uLisR0WKFilF96pAJxQ1u
         Hj5UVYv9uLxG/99vl1Yw9j5ywxqnEm/8fzZ8siT1WZbppvmT9I7VoSnHH3v9FD2FjTOo
         NNPdLgrRkFRkhFgHDPi4uLvtMv0o/fm5o6lCaoEPAB9zHA54ovm1NAi4TnTBiVU5Qh4P
         6mlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490735; x=1777095535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDL4Vs6dqA+MI0aq/6FmGgsCzCeh95absu6jpu5ijw0=;
        b=XBAUtBQTY1GinY4dSNKbhhZURTVAQGDe84sGPmyJl3+QVAQFndnGVjsKZWEnyFLVmz
         1c+Ic0PqDX+myexqZo02FAnZEZ4RUB8ZwOjVxjT2Qmdi0dmEXnBBbpRu9JyLuZQAE0n4
         Anl2kHLQmOlExyevf6GxXQoJybbO9oih5RqfGdpt8qPX9+kuh73CcabcTb/UOE1hdFuA
         wE8mRbeT4IY+mFVjd3rnKHhXxnLjSF2Rd47PTRmwcboHx8uMkfBGVA37FXncSRMlQ4Bo
         bz4dEdstM/WA9uWOUfIB/KI+ag+bO5ok/7PmXcnWtu21Zm3DwRoWKLmTE76rM98qLZMn
         OCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490735; x=1777095535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDL4Vs6dqA+MI0aq/6FmGgsCzCeh95absu6jpu5ijw0=;
        b=IYUbCt5ivqgqQ6+ljEss89vYUaxT8vOdGgNCnEU1BffcCMArwJv3TX5oEtPNPbXCHQ
         VQAOe/IZzZqyzJ48TIXDfILTMnC77umrQbcPgxG8Jv0oWa7p4uY4bwQmlUwv1YMjd/i1
         1yqZgtQF13UzwH7fvIMXG7gkVIFtu7DgSWOwJFY2K9JMZUGqtXv2rbUZqaHQBxfepZKd
         HOzwNksjFi6eQONe/KRL9ysPEWMvwUFlOScrQEC3OWkftC4f5q1Z73ese9oMap655MrM
         WnUAFC5EVYtb9JLFsQQs+Ea4y+aP38Wp4fmES6113R9otLlRil84kM+Q9tV+G8DeauJG
         jzWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/n2d2QmGZuOOFi6H2RUaFGrYRVdWdCogNnJq3j+cHTQQO4WKXLJ/drUNEFMwD9smDAM0kHHDDtrsCd1C2YNyq32Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6nbYdlWtDqS51CxqtDiOLi+qKfY0hFXV9EjhWeNOAiDZup72
	pK5xvz/Jnl8gL9bPFGgrpYCz/5QuM1rc6cgEj5KZW8A31xP43wiocxPInwUg9cHqcRUBtyXQXN4
	w4A1K0KW0t24hFPuk7QKmoQewQGdjCjk=
X-Gm-Gg: AeBDievUbYNbQxs+ZxjoTccfsiXFk09zVV6/Ycl5VzGWUlxlSmnsy5IX5UXZBFLUIiW
	w/yxvrQm8ABGLWiUDpZ6WlPT/Z3yrsp5Q8SdM1oXbPYGBdRMwr4ta3yLL9hxKySu+OLWekbe2YB
	aD24fFEBh8gjCzUiN4XrewijJw2EHBlTmfWsEKUGFxAu7r5dg3eXgF+0TV07MHokWslAi8f95kj
	CvdI47OTCgQ9Ja+n9NJvOP2N3FovaBARdInFTAkkPDUTYhmqn4pW768nhonXakqmZdfixSOSwWF
	dzcfLEJXsHmtxKCLXg==
X-Received: by 2002:a05:690c:14:b0:79b:e346:9813 with SMTP id
 00721157ae682-7b9ed2ce09cmr47580547b3.10.1776490734557; Fri, 17 Apr 2026
 22:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417063827.84146-1-yashsuthar983@gmail.com> <20260417115258.65e216be@fedora>
In-Reply-To: <20260417115258.65e216be@fedora>
From: Yash Suthar <yashsuthar983@gmail.com>
Date: Sat, 18 Apr 2026 11:08:42 +0530
X-Gm-Features: AQROBzAtHLagAxO7CYz7IvyGx_VhwPM3nNhGuMdDeVbJ3hqyIFfwvM-3loLzy2U
Message-ID: <CAPfzD4kQg94qA0oRd+=JOju=+a76872WCsBSo8=aNG5QduNQbg@mail.gmail.com>
Subject: Re: [PATCH] trace: propagate registration failure from tracing_start_*_record()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, me@brighamcampbell.com, 
	syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Steven,
Thank you for taking a look and really sorry.

I did use ai assistance for commit message, but I reviewed, modified
and tested(with syzbot locally) the code myself. I should have
disclosed really sorry.

One thing I want to know (or I am still missing something):
sched_cmdline_ref is incremented before tracing_sched_register() and
register fails,  but sched_cmdline_ref stays at 1 and on disable
tracepoint_remove_func() sees NULL and return error (as syzbot
reported and reproduce also locally).
your suggestion WARN_ONCE correctly flags the upstream failure, but
the secondary WARN at  tracepoint.c:358 will still fire on the next
disable, since the refcount desync isn't addressed. Was that
intentional ?

in my earlier approach, I tried to propagate the error and handle this
desync under fault injection. I understand this may not align with the
preferred direction, but that was the motivation behind the change.

If you think it makes sense, I can prepare a v2 with your suggestion
while also addressing the refcount consistency.

Thank you

On Fri, Apr 17, 2026 at 9:23=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 17 Apr 2026 12:08:27 +0530
> Yash Suthar <yashsuthar983@gmail.com> wrote:
>
> > syzbot reported a WARN in tracepoint_probe_unregister():
> >
> > tracing_start_sched_switch() increments sched_cmdline_ref /
> > sched_tgid_ref before calling tracing_sched_register(), and its
> > return value is discarded because the API is void. When the first
> > register_trace_sched_*() fails (e.g. kmalloc under memory pressure
> > or failslab), the function's fail_deprobe* labels roll back any
> > partial probe registration, but the caller's refcount has already
> > been bumped. The state is now desynced: refs > 0 but no probes in
> > tp->funcs.
> >
> > Later, when the caller pairs the start with a stop, the refcount
> > walks back to 0 and tracing_sched_unregister() calls
> > unregister_trace_sched_*() against an empty tp->funcs.
> > func_remove() returns -ENOENT and the
> > WARN_ON_ONCE(IS_ERR(old)) in tracepoint_remove_func() fires.
> >
> > Fix: make tracing_start_sched_switch() and the two exported
> > wrappers, tracing_start_cmdline_record() and
> > tracing_start_tgid_record(), return int; register the probes
> > before bumping the refcount; and propagate the error to callers
> > so refs are only held on behalf of a caller whose registration
> > actually succeeded.
> >
> > Fixes: d914ba37d714 ("tracing: Add support for recording tgid of tasks"=
)
> > Reported-by: syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?id=3Df93e97cd824071a2577a40cd=
e9ecd957f59f87eb
>
> Did you use AI to create any of this? If so you must disclose it. This
> reads very much like an AI patch.
>
> >
> > Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> > ---
> >  kernel/trace/trace.c                 |  6 +++---
> >  kernel/trace/trace.h                 |  4 ++--
> >  kernel/trace/trace_events.c          | 28 +++++++++++++++++++--------
> >  kernel/trace/trace_functions.c       |  8 +++++++-
> >  kernel/trace/trace_functions_graph.c |  6 +++++-
> >  kernel/trace/trace_sched_switch.c    | 29 ++++++++++++++++++----------
> >  kernel/trace/trace_selftest.c        |  7 ++++++-
> >  7 files changed, 62 insertions(+), 26 deletions(-)
>
> NAK on all this. If you are under severe memory constraints that causes
> this to fail, then you'll be hitting a bunch more errors.
>
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 8bd4ec08fb36..e936eed99b27 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -3320,7 +3320,7 @@ void trace_printk_init_buffers(void)
> >        * allocated here, then this was called by module code.
> >        */
> >       if (global_trace.array_buffer.buffer)
> > -             tracing_start_cmdline_record();
> > +             (void)tracing_start_cmdline_record();
>
> WTF??? Why are you adding the typecast of (void) here? Don't do that!
>
>
> >  }
> >  EXPORT_SYMBOL_GPL(trace_printk_init_buffers);
> >
> > @@ -3329,7 +3329,7 @@ void trace_printk_start_comm(void)
> >       /* Start tracing comms if trace printk is set */
> >       if (!buffers_allocated)
> >               return;
> > -     tracing_start_cmdline_record();
> > +     (void)tracing_start_cmdline_record();
> >  }
> >
> >  static void trace_printk_start_stop_comm(int enabled)
> > @@ -3338,7 +3338,7 @@ static void trace_printk_start_stop_comm(int enab=
led)
> >               return;
> >
> >       if (enabled)
> > -             tracing_start_cmdline_record();
> > +             (void)tracing_start_cmdline_record();
> >       else
> >               tracing_stop_cmdline_record();
> >  }
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index b6d42fe06115..6fe2c8429560 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -751,9 +751,9 @@ void trace_graph_return(struct ftrace_graph_ret *tr=
ace, struct fgraph_ops *gops,
> >  int trace_graph_entry(struct ftrace_graph_ent *trace, struct fgraph_op=
s *gops,
> >                     struct ftrace_regs *fregs);
> >
> > -void tracing_start_cmdline_record(void);
> > +int tracing_start_cmdline_record(void);
> >  void tracing_stop_cmdline_record(void);
> > -void tracing_start_tgid_record(void);
> > +int tracing_start_tgid_record(void);
> >  void tracing_stop_tgid_record(void);
> >
> >  int register_tracer(struct tracer *type);
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 137b4d9bb116..e6713aa80a03 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -734,9 +734,9 @@ void trace_event_enable_cmd_record(bool enable)
> >                       continue;
> >
> >               if (enable) {
> > -                     tracing_start_cmdline_record();
> > -                     set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->fl=
ags);
> > -             } else {
> > +                     if (!tracing_start_cmdline_record())
> > +                             set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &=
file->flags);
> > +             } else if (file->flags & EVENT_FILE_FL_RECORDED_CMD) {
> >                       tracing_stop_cmdline_record();
> >                       clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->=
flags);
> >               }
> > @@ -755,9 +755,9 @@ void trace_event_enable_tgid_record(bool enable)
> >                       continue;
> >
> >               if (enable) {
> > -                     tracing_start_tgid_record();
> > -                     set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->f=
lags);
> > -             } else {
> > +                     if (!tracing_start_tgid_record())
> > +                             set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, =
&file->flags);
> > +             } else if (file->flags & EVENT_FILE_FL_RECORDED_TGID) {
> >                       tracing_stop_tgid_record();
> >                       clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT,
> >                                 &file->flags);
> > @@ -847,14 +847,26 @@ static int __ftrace_event_enable_disable(struct t=
race_event_file *file,
> >                               set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, =
&file->flags);
> >
> >                       if (tr->trace_flags & TRACE_ITER(RECORD_CMD)) {
> > +                             ret =3D tracing_start_cmdline_record();
> > +                             if (ret) {
> > +                                     pr_info("event trace: Could not e=
nable event %s\n",
> > +                                             trace_event_name(call));
> > +                                     break;
> > +                             }
> >                               cmd =3D true;
> > -                             tracing_start_cmdline_record();
> >                               set_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &=
file->flags);
> >                       }
> >
> >                       if (tr->trace_flags & TRACE_ITER(RECORD_TGID)) {
> > +                             ret =3D tracing_start_tgid_record();
> > +                             if (ret) {
> > +                                     if (cmd)
> > +                                             tracing_stop_cmdline_reco=
rd();
> > +                                     pr_info("event trace: Could not e=
nable event %s\n",
> > +                                             trace_event_name(call));
> > +                                     break;
> > +                             }
> >                               tgid =3D true;
> > -                             tracing_start_tgid_record();
> >                               set_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, =
&file->flags);
> >                       }
> >
> > diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functi=
ons.c
> > index c12795c2fb39..14d099734345 100644
> > --- a/kernel/trace/trace_functions.c
> > +++ b/kernel/trace/trace_functions.c
> > @@ -146,6 +146,8 @@ static bool handle_func_repeats(struct trace_array =
*tr, u32 flags_val)
> >  static int function_trace_init(struct trace_array *tr)
> >  {
> >       ftrace_func_t func;
> > +     int ret;
> > +
> >       /*
> >        * Instance trace_arrays get their ops allocated
> >        * at instance creation. Unless it failed
> > @@ -165,7 +167,11 @@ static int function_trace_init(struct trace_array =
*tr)
> >
> >       tr->array_buffer.cpu =3D raw_smp_processor_id();
> >
> > -     tracing_start_cmdline_record();
> > +     ret =3D tracing_start_cmdline_record();
> > +     if (ret) {
> > +             ftrace_reset_array_ops(tr);
> > +             return ret;
> > +     }
> >       tracing_start_function_trace(tr);
> >       return 0;
> >  }
> > diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_=
functions_graph.c
> > index 1de6f1573621..6b27ed62fee8 100644
> > --- a/kernel/trace/trace_functions_graph.c
> > +++ b/kernel/trace/trace_functions_graph.c
> > @@ -487,7 +487,11 @@ static int graph_trace_init(struct trace_array *tr=
)
> >       ret =3D register_ftrace_graph(tr->gops);
> >       if (ret)
> >               return ret;
> > -     tracing_start_cmdline_record();
> > +     ret =3D tracing_start_cmdline_record();
> > +     if (ret) {
> > +             unregister_ftrace_graph(tr->gops);
> > +             return ret;
> > +     }
> >
> >       return 0;
> >  }
> > diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sch=
ed_switch.c
> > index c46d584ded3b..683ea4ca1498 100644
> > --- a/kernel/trace/trace_sched_switch.c
> > +++ b/kernel/trace/trace_sched_switch.c
> > @@ -89,12 +89,22 @@ static void tracing_sched_unregister(void)
> >       unregister_trace_sched_wakeup(probe_sched_wakeup, NULL);
> >  }
> >
> > -static void tracing_start_sched_switch(int ops)
> > +static int tracing_start_sched_switch(int ops)
> >  {
> > -     bool sched_register;
> > +     int ret =3D 0;
> >
> >       mutex_lock(&sched_register_mutex);
> > -     sched_register =3D (!sched_cmdline_ref && !sched_tgid_ref);
> > +
> > +     /*
> > +      * If the registration fails, do not bump the reference count : t=
he
> > +      * caller must observe the failure so it can avoid a later matchi=
ng
> > +      * stop that would otherwise unregister probes that were never ad=
ded.
> > +      */
> > +     if (!sched_cmdline_ref && !sched_tgid_ref) {
> > +             ret =3D tracing_sched_register();
> > +             if (ret)
> > +                     goto out;
> > +     }
> >
> >       switch (ops) {
> >       case RECORD_CMDLINE:
> > @@ -105,10 +115,9 @@ static void tracing_start_sched_switch(int ops)
> >               sched_tgid_ref++;
> >               break;
> >       }
> > -
> > -     if (sched_register && (sched_cmdline_ref || sched_tgid_ref))
> > -             tracing_sched_register();
>
> The only change that should deal with this would be:
>
>         if (sched_register && (sched_cmdline_ref || sched_tgid_ref)) {
>                 WARN_ONCE(tracing_sched_register() < 0,
>                         "Failed to register trace command line caching. R=
equires reboot to fix");
>         }
>
> -- Steve
>
>
>
> > +out:
> >       mutex_unlock(&sched_register_mutex);
> > +     return ret;
> >  }
> >
> >  static void tracing_stop_sched_switch(int ops)
> > @@ -130,9 +139,9 @@ static void tracing_stop_sched_switch(int ops)
> >       mutex_unlock(&sched_register_mutex);
> >  }
> >
> > -void tracing_start_cmdline_record(void)
> > +int tracing_start_cmdline_record(void)
> >  {
> > -     tracing_start_sched_switch(RECORD_CMDLINE);
> > +     return tracing_start_sched_switch(RECORD_CMDLINE);
> >  }
> >
> >  void tracing_stop_cmdline_record(void)
> > @@ -140,9 +149,9 @@ void tracing_stop_cmdline_record(void)
> >       tracing_stop_sched_switch(RECORD_CMDLINE);
> >  }
> >
> > -void tracing_start_tgid_record(void)
> > +int tracing_start_tgid_record(void)
> >  {
> > -     tracing_start_sched_switch(RECORD_TGID);
> > +     return tracing_start_sched_switch(RECORD_TGID);
> >  }
> >
> >  void tracing_stop_tgid_record(void)
> > diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftes=
t.c
> > index d88c44f1dfa5..238e7451f8e4 100644
> > --- a/kernel/trace/trace_selftest.c
> > +++ b/kernel/trace/trace_selftest.c
> > @@ -1084,7 +1084,12 @@ trace_selftest_startup_function_graph(struct tra=
cer *trace,
> >               warn_failed_init_tracer(trace, ret);
> >               goto out;
> >       }
> > -     tracing_start_cmdline_record();
> > +     ret =3D tracing_start_cmdline_record();
> > +     if (ret) {
> > +             unregister_ftrace_graph(&fgraph_ops);
> > +             warn_failed_init_tracer(trace, ret);
> > +             goto out;
> > +     }
> >
> >       /* Sleep for a 1/10 of a second */
> >       msleep(100);
>
