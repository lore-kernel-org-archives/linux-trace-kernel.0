Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F93191F7E;
	Sat, 23 Aug 2025 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755913879; cv=none; b=QE44kwOIxpsxtKCSWLRsqRBcLUPn+9KDLcZx9GLXz1ZxwQdc7KkU2iW+ENj/280fXxcTo1hLYwdQxgU2ficRj1WcGwWCR0VTbsdFqv6E/T7K0SvfzOx6ROkdc3oUfasmmVbAU12LoNrYYuVY2v8CJoOUQ8XM9UBd3Y5e5BbWow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755913879; c=relaxed/simple;
	bh=9IL82+ZMHtNoUMUQCmi6SqEPo7vkl78u6IFjldBhIXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdzQ8PQqwpo+TdB5VogP1KhRg6B/ckMk8xbcaIuc40a/a+Y6I27lptoVQqJIxFCSia7ZfpHlrKPqFEIntwkXM8rR6eXJo12G9k1Ia6/e2Tk/fOSTkpG5mMli/vvxK1dBe7w7uXezmAQCtkcrMaxSB3ublcblQ85mv2Tw31zWZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkpZrRQa; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkpZrRQa"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109a95f09so19989811cf.1;
        Fri, 22 Aug 2025 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755913876; x=1756518676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SwRRHTQP0nBTdGAqIgIiFDxBUOe4QX/ARyfuI/2piY=;
        b=nkpZrRQaUFsOa3DyjKFUA9ddyS8s5WUapD6ZttOFDFEwURmJs+UK+QP0b2HC00I7cR
         l3YAJ46T1bqNn8lTdroajk71GLEdt3e1BypAkfCkf19iDonvqi5O3fINpj5sSdklWFtm
         4H+XKfbibPx2lxiBxfEPPQ/Y01Pj6/3soxysb6NqpcTnelzFN5Nfuh7KSIjFmjynOImR
         kA4oaSmgz1ow2f2LOJ2DWu92a6Hor0xRSVCIN40Er1N3NNlJiCFhl89IOg4f1Y14DX5A
         kkqXbvtJSKBUj2d9RsxduSs9ody9FwdUF2XWSl1xDx2OPeuOMTmCcv6RD61R5H8yhf4Z
         REvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755913876; x=1756518676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SwRRHTQP0nBTdGAqIgIiFDxBUOe4QX/ARyfuI/2piY=;
        b=IqrTNfjDlyLJlBp+1YuJOIgCto68T4S9behSO8auKuVc/tLiSwHY7PGxXmp53I+KIo
         GucRCwVQrHmPKEUyQFhiFfPVTyTEU+BSQD9xaxXSHa97QcOl/an1EGZ5kXIc3FLLuUo3
         VoXEnl/R7dxStftkkiojIXdRFJ23oq4Wt7tucOzseShQcBjQJGt5K6TK0ysLLSmuHWDD
         m+DHCqHTz3NY0GMm8UEtnmT+RZEFa+L/PulJI2kUewBhFA7wseeSliHTw4Sqg3+fH7Wb
         ayI5Wdy3sPC5tqBMWiUIxpL+YZF72cW5pQrEJ5/pBCbpBhECCIOuftzm6eKrDla1rIBi
         3GWw==
X-Forwarded-Encrypted: i=1; AJvYcCUZN18z7JtwK0DRecnrDZzJWnZDwubYSlZgZK6YrORCC11cw+mVOZ7ZpN8SGHBHGOpOM/9T/lsGQUi7BxY=@vger.kernel.org, AJvYcCVPcLgbQW+2pVGBPJ9X0Vatkxhdf59tD1lTRHacwNjLyNxvJgP/DpsIFOM7RRP/UawpBwlIihP3/XNLiQgrNfXs/9xN@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNWBEd1MDWTJGHhAIlFuzCp1m1PC4oUeHXmo4VN3tAs3CoTnb
	rYBwC1RwB8cuWqSISvF/dk0CKWdQRgjo4mJ2ewdUq6jeNVqtCe8aJV3bEQhd9Zeo7kkS63L6iJl
	51+G06t41WFPGWGbx6GW42A+dQpVluL8=
X-Gm-Gg: ASbGnctWIBG5w+Z3DUzQ7L7DXlyW6ug9GGYuWECp7pv60mFo6wmIUup8OGyUM7ZFJxz
	FvaAVmLoWnWH1X3g+9jWWIIzeeyTLkEcHc41Gfnr4yMkdsDXEQ8PWfpzzW7kwaao42Jdrhd09n+
	mvgIwP3YmKoTL1Eypp1ZmABaEtuz9SLAHMxFGJgamiq3/dYiHikKnCmJXQO9QCBE4wLnGF1uHEq
	/B2OqSo
X-Google-Smtp-Source: AGHT+IGs6gfyAjG2cAAtRWPgy4RZGMnSfLQFo8U3vfmfRrLb2XjrMHkj0jS212n0qWRQkwoVboPKFqUgJAxPNhLR1Tc=
X-Received: by 2002:ac8:5a50:0:b0:4b0:bc43:dd90 with SMTP id
 d75a77b69052e-4b2aab20de1mr52908911cf.48.1755913876311; Fri, 22 Aug 2025
 18:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820112621.4045-1-xuewen.yan@unisoc.com> <CAJuCfpE1pJ8qhHgqvExktsMeTBbtVSK2rkE5SfeTE2nOYrNozQ@mail.gmail.com>
In-Reply-To: <CAJuCfpE1pJ8qhHgqvExktsMeTBbtVSK2rkE5SfeTE2nOYrNozQ@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Sat, 23 Aug 2025 09:51:05 +0800
X-Gm-Features: Ac12FXyvEdmW-vCosNzcSpd6FMkQLKvDG84TYFc__CWuj8riz8C-TCCMP7KXRPM
Message-ID: <CAB8ipk8ywWv8j8OGugXjhwcZXj567LKULhLz7HS8Btx-_27yBQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2] sched: psi: Add psi events trace point
To: Suren Baghdasaryan <surenb@google.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, hannes@cmpxchg.org, peterz@infradead.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ke.wang@unisoc.com, yuming.han@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Suren,

Thanks for your review:)

On Thu, Aug 21, 2025 at 3:51=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 20, 2025 at 4:28=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.com=
> wrote:
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
> > v2:
> > -fix compilation error;
> > -export the tp;
> > -add more commit message;
> > ---
> >  include/trace/events/sched.h | 5 +++++
> >  kernel/sched/psi.c           | 4 ++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.=
h
> > index 7b2645b50e78..d54db5fcbca2 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
> >         TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> >         TP_ARGS(tsk, cpu, tif));
> >
> > +struct psi_trigger;
> > +DECLARE_TRACE(psi_event,
>
> DECLARE_TRACE will create a tracepoint but will not export it in the
> tracefs. Why should we not have it in the tracefs?

I haven't figured out what content should be displayed in the trace yet.
Until this is fully determined, I think it might be a better option to
just export the tracepoint and let users add their own hooks to print
the content they need.

>
> > +       TP_PROTO(struct psi_trigger *t),
> > +       TP_ARGS(t));
> > +
> >  #endif /* _TRACE_SCHED_H */
> >
> >  /* This part must be outside protection */
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 59fdb7ebbf22..f06eb91a1250 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -141,6 +141,8 @@
> >  #include <linux/psi.h>
> >  #include "sched.h"
> >
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event_tp);
>
> So, are you planning to attach some handler to this trace event in your d=
river?

Yes, our modules would attach a handler to observe the memory pressure.

>
> > +
> >  static int psi_bug __read_mostly;
> >
> >  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *group=
, u64 now,
> >                 if (now < t->last_event_time + t->win.size)
> >                         continue;
> >
> > +               trace_psi_event_tp(t);
>
> This should only be done if the below cmpxchg() check is true, right?
> Otherwise it will not match with what userspace is receiving.

If we put it below cmpxchg() check, we may lose some event before the
user space repose the signal.
Because the t->event needs to be set to 0 again.
In order to ensure that all events are displayed, it is better to put
it before the cmpxchg.

Thanks!

>
> > +
> >                 /* Generate an event */
> >                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> >                         if (t->of)
> > --
> > 2.25.1
> >
