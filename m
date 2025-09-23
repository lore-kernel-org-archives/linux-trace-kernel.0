Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC81C2AD25
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598292; cv=none; b=s87B41uW+YdQwx6Elubun9mx/8Wee+rk9lX+JOB4JHMZD0ppyvXUx3mxJqaki/gfHNr9FvrcvXrEO3kBLrM9BE4fwCfe952UfdWNYY3CWl6giU+iUJCXnmPoWPfUPyVt1KIM1JaEVWmHEz1x/1/Sd3N0HEL3B2w99CLlNN7cO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598292; c=relaxed/simple;
	bh=rYtPIrmt0kZAQBBjvwr5VGhzxQCcEQBloCf401OHtGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjBN7wnshZ3l+ULzkYhUKcpj3BuRnfaPcbhBPrbCEYHS6lAV7xUBxmjh4L/PmO63j6yL64HdEKII/PCjh6BCa8cw+NDPPwHFdO5H3qyT/Pgtij0YGE/JFqyzN99iMlSPYJeX1QOer1Huv3omuLrVuxxYSoy61asRwNf935iuTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDvZiprr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDvZiprr"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b78657a35aso281591cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758598287; x=1759203087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WGJa7y47hpmLiB7kWkPwOGe9BYScK1xQQ88jtOYi+8=;
        b=mDvZiprrzsPwOMuwlT3f1b73QgW3Vm7Vl3oYoXvUl8cCLIh/JemNc0V9KtrvnljYhF
         h3t7OP7uwCwxoGRQXFpP3CAq6q8fPBB9BZz5WNNykS/MTnSsAkpX0m9xUjz06NzzaFKz
         71cFka9+DVrS3dJRaq2hA/yE2ynwZuaK5o/72fbIO5JDLp1CGDc3jxkjq6BZIb/lQQzv
         8HswoESEJrN5Ef82sfWV4YQYD4+/IxQjYfcj9SzASHy7bNwDO1XZ7LvmNi5/qBAQAwuC
         nUp8prEag6MMvupFcSCB9iGFOJAxuf7GwW9TyhWmrtYHcCCxMHHuf+syNKNXhvTDqBMc
         EFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758598287; x=1759203087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WGJa7y47hpmLiB7kWkPwOGe9BYScK1xQQ88jtOYi+8=;
        b=GzjYjAy2EKJtAffK9XXrHlvxchEWpjsj3VNI2L7LUpEGNR0pmZ496BaIRFjedZoOXd
         fPmQjohk5xVj1iPW/q97LfnqUTax00a3IQ2ovLr09sRcumvr18Wu69jlQ62Eu2547ZCE
         4JJP4hg24ZhOEeAibsw/0cGCjKXlI4n6KfKHqP6LXPAfxPkxH9SYR1ggvrTICMqE11KC
         b+ABmuWF19aO39wpRVlRaw5uWyth2yRHdB7BGQ+12vI6hOUyJSLljUo9udO+xdUgeGJT
         ELoG6GwTc57IEIahsjJqimDiW6LKUrmcmyRW1t6VYXHjHJKiUcyH2KzAW9Qakw94e2n2
         8mEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSKrwMR0ozv4ZxxZtOsx3Lk/e8AiKoBa0DVN8ASCXhIMCIe+Y2neMIb8S5sZ8RkQkOJ1cZ1NND6MUqi3RRtXfXqBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4aHZkQYrpqU4qyppMTTnmj4C4AIpgqkNKHDLB1v5WsEIL1cO
	8DWBF+Cct44s1FuJuvYHqLgvaUuxszjVdJ76jBeexxYmnHcUEHDF8IqMiI7DrgUNmeSp6lIBsKd
	DVb5TJFSVov86dn+28Qdhn5uYINcVu4oX7Pf/G5ih
X-Gm-Gg: ASbGncspPv63gAfZk9cpXjtr6JmnxYLB9e9NDnnRXVCs46a35GWQdPHSokyFarE+53X
	Bcx/35woAKYVMQKOvSueJCRsK2dMLB60Nn8zv8I9qqNMmoMC27bUfTfoMQUEJRczN0ygmz3IytE
	6hbOxbBj5SzsYpFWqV05UYOrvUluT07ZDaEajDLP7PZMzHjv8a7H87ooKPFGKp2OQH2ged+8dic
	C6W9A==
X-Google-Smtp-Source: AGHT+IG9M9qI4Nu6K1UD7ZOVSyvPnjLxqQLvz9ibrnDfMGEymJWCboEwdEn7EdGDxZDLpHlNav/cGzt8JE8iiHnlja8=
X-Received: by 2002:a05:622a:1884:b0:4ca:c49a:549d with SMTP id
 d75a77b69052e-4d369607c85mr2577381cf.9.1758598287031; Mon, 22 Sep 2025
 20:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911032823.19064-1-xuewen.yan@unisoc.com> <CAB8ipk-xqbsNh6EQ42JFV8CqPeJR0gjObOKvSs=-b=qcuLQxfg@mail.gmail.com>
In-Reply-To: <CAB8ipk-xqbsNh6EQ42JFV8CqPeJR0gjObOKvSs=-b=qcuLQxfg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Sep 2025 20:31:16 -0700
X-Gm-Features: AS18NWD0RZyd0dPQFmRzUC2-5ppOObz4yGCVgzRrO6RKH_SNijZZPS9mJqUNjg0
Message-ID: <CAJuCfpHVjDrng2=bCh=DBdn_LBK3-qVF46Jwm3_TFzCjQhn9CA@mail.gmail.com>
Subject: Re: [RFC PATCH V3] sched: psi: Add psi events trace point
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, hannes@cmpxchg.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ke.wang@unisoc.com, yuming.han@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 7:58=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.com>=
 wrote:
>
> A very gentle ping on this patch.
> Best regards,
> Thanks!

Thanks! Sorry I missed it.

>
> On Thu, Sep 11, 2025 at 11:30=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.co=
m> wrote:
> >
> > Add trace point to psi triggers. This is useful to
> > observe the psi events in the kernel space.
> >
> > One use of this is to monitor memory pressure.
> > When the pressure is too high, we can kill the process
> > in the kernel space to prevent OOM.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> > V3:
> > -export it in the tracefs;
> > ---
> > v2:
> > -fix compilation error;
> > -export the tp;
> > -add more commit message;
> > ---
> >  include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
> >  kernel/sched/psi.c           |  4 ++++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.=
h
> > index 7b2645b50e78..db8b8f25466e 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -826,6 +826,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
> >         TP_printk("cpu=3D%d", __entry->cpu)
> >  );
> >
> > +#ifdef CONFIG_PSI
> > +TRACE_EVENT(psi_event,
> > +
> > +       TP_PROTO(int aggregator, int state, u64 threshold, u64 win_size=
),
> > +
> > +       TP_ARGS(aggregator, state, threshold, win_size),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(int,    aggregator)
> > +               __field(int,    state)
> > +               __field(u64,    threshold)
> > +               __field(u64,    win_size)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->aggregator     =3D aggregator;
> > +               __entry->state          =3D state;
> > +               __entry->threshold      =3D threshold;
> > +               __entry->win_size       =3D win_size;
> > +       ),
> > +
> > +       TP_printk("aggregator=3D%d state=3D%d threshold=3D%llu window_s=
ize=3D%llu",
> > +               __entry->aggregator, __entry->state, __entry->threshold=
,
> > +               __entry->win_size)
> > +);
> > +#endif /* CONFIG_PSI */
> > +
> >  /*
> >   * Following tracepoints are not exported in tracefs and provide hooki=
ng
> >   * mechanisms only for testing and debugging purposes.
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 59fdb7ebbf22..5b7954b653ed 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -141,6 +141,8 @@
> >  #include <linux/psi.h>
> >  #include "sched.h"
> >
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event);
> > +
> >  static int psi_bug __read_mostly;
> >
> >  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *group=
, u64 now,
> >                 if (now < t->last_event_time + t->win.size)
> >                         continue;
> >
> > +               trace_psi_event(aggregator, t->state, t->threshold, t->=
win.size);

Again, this trace event should be generated only after cmpxchg()
passes the check. Otherwise trace events might be generated when
actual PSI events are not (false positives). That disconnect is not
acceptable.

> > +
> >                 /* Generate an event */
> >                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> >                         if (t->of)
> > --
> > 2.25.1
> >
