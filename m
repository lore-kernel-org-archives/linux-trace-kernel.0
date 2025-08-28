Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C82676E9;
	Thu, 28 Aug 2025 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364427; cv=none; b=QyQSZtJEPY7n8eMhYGb8IGot9c025K59dJzNrzhCISc3WBs6wRtuD6MuULPpyGf/FS4s10AUTGoupvEETMChhttp4Q9rrUF6dkOMjabS+BVRKPcqhCRXYm25L8Hl2OV8wzwppwBhoy7WKuIIJxhhCa0+bmcUsqTpDe7NS4J9KYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364427; c=relaxed/simple;
	bh=udbIQSEPamCrzfR3SxCWA3q4BirD6kzgDECIv6Y64DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UadgLF1Hw8VCX2jykN09Kgw/Nkye5eKPriGdxweUuY/ZyuK+0MlbhARm88jlOFcHXco+8As+8sz2wLmNuVVhSG7pHvUK5LCKXA4LcNn6wAouvu7tgw3K6qUO34PABbdR7hEEf2DwZIophakcdpWAeB2PbZiujGsPab9O2m9oxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j94Cws2g; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j94Cws2g"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b297962b9cso6298541cf.2;
        Thu, 28 Aug 2025 00:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756364423; x=1756969223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVR0d4WpbShciuNT/b54V9sqHVLPJVoLEvkbaEwtQlo=;
        b=j94Cws2gfI2f15P/lGoKu6OpUZJcoLUpjFEEekqBOPsaSni8eu0mBvMD7fb2uHW2r4
         BUc6rxMX8slb8L83uiZ9peadLJt42M6zJYIhmYAyWq55E0rw2usczrrH1c5otI7y2VLe
         GUKI5Eq7uEy3EMGR70FZymWTICIQX6ErGQUTE85hFOkotRPkG1I1gQ+H84xlsbpVrF7r
         sM3eV8TTGWtCs1f4TrN7KVu9Bgv1b7g3qsDcWbC4JiiI80Ee0OKRXWEARSngCx7LEyzu
         4S4FT/g/eHvO/3dsjYN81wqNw3mcejNtewHK/zXZp/4SHspw9mQIFYPqgB5+ySr5G3SB
         nmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364423; x=1756969223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVR0d4WpbShciuNT/b54V9sqHVLPJVoLEvkbaEwtQlo=;
        b=V64n/nSB2QD66DDBbGdTVqg5/L+kEn0BvLN3usbVjHdaulItKhxEMAMMPQWWO3vw3Q
         pUDDD3N+RURm520XO/2HGSQ9uHcIiaKW2Ow8SrAM84VF8R2CCWrReu1E+fz5cKjGg321
         WZG6n3O1qYVQ7qiY6C+q50viETa+S1EvvOg/j6Xhtocf8y+1C2aYSr6xyhs2aJTbuD9G
         EozLy5yMl/sMO15t8MgBozaW/HpnArCep38H+gnGhQlI3BljINTE1bfTNfwPaxoJCgV1
         seFs/DeNfeQvAIv51isPCgu/hxdg86VCh3ZZTZGmwg8oKytXowCXv/JPJcsnsFDeZQ6i
         DKEg==
X-Forwarded-Encrypted: i=1; AJvYcCVGd3pETrGQrplOD/5o06KjQQolO4/iYB8zx56RDVIRs2p87vE1UTcKsSZJLTuAu8sla9ZuWI2Zaj5B61I=@vger.kernel.org, AJvYcCXJYuEInvmMPCDK4zcwvnyf7dl6CxOQ1YebCKFwvzcjECpuwq0ZqVCZ59yupUvUwDotNfV2oWdldHp7psZCl3Pr6clY@vger.kernel.org
X-Gm-Message-State: AOJu0YwPX1lKmOjmTtDAC59bw2rB5pF/7XPhkKBZE8yQ1uz6rnhOw1hD
	S9nTq57/fHKhWmFuJS/rB2vRp+r8R6RNvZv2DigEhMihUvNgdQqrLHsLZMsFAI6ovkndpKDqYvp
	vQl3neaUhcoaAxdSAfCU4RvF0xcTOBwg=
X-Gm-Gg: ASbGncuNM0/PUWlXC7BImy4F6VA0XbK3v9JDnjrhiVfQ8fi6+NUi2gdYgyRVJMRgYBu
	eBgjlB+rvHBqGypdx2BrbU7ya4YXMRDTwPxFLaVNZbKU7whhlWxynb1DorzRR3HYWI5TZYeBZVp
	0nKaqmBvjjMi2JTkRcwF3eMpNdQifvXt0TivKgx8TLSj7HozahJBCENvNqndgjCzCeuIAPBxaTj
	K8kWy9Aov73AeSmsqY=
X-Google-Smtp-Source: AGHT+IGwbRAS5Hnp4SPE2EKshAUJSh3gq1yFkD5zthp2GbV7EgQueIxZunecNm8uu4t5nHoNj5CbxGYpBAijsl2FGB8=
X-Received: by 2002:a05:622a:5e09:b0:4b2:cf75:bf10 with SMTP id
 d75a77b69052e-4b2cf75c106mr113268761cf.17.1756364422979; Thu, 28 Aug 2025
 00:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820112621.4045-1-xuewen.yan@unisoc.com> <CAJuCfpE1pJ8qhHgqvExktsMeTBbtVSK2rkE5SfeTE2nOYrNozQ@mail.gmail.com>
 <CAB8ipk8ywWv8j8OGugXjhwcZXj567LKULhLz7HS8Btx-_27yBQ@mail.gmail.com> <CAJuCfpGH4UKmuaVMAE-CCPo-J-Qzufs55_DDR0bPbzyOC8-deg@mail.gmail.com>
In-Reply-To: <CAJuCfpGH4UKmuaVMAE-CCPo-J-Qzufs55_DDR0bPbzyOC8-deg@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 28 Aug 2025 15:00:12 +0800
X-Gm-Features: Ac12FXwmEL1fWca1OtEvYTZnRoz-jLpoejzs5O82uVMaxXWiOIwVTBYFdC94SE0
Message-ID: <CAB8ipk8PZoMyNstOssfwscCgdZ2E_dTtThH94QAjwEGEWAR23Q@mail.gmail.com>
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

On Wed, Aug 27, 2025 at 8:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Aug 22, 2025 at 6:51=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.co=
m> wrote:
> >
> > Hi Suren,
> >
> > Thanks for your review:)
> >
> > On Thu, Aug 21, 2025 at 3:51=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Aug 20, 2025 at 4:28=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc=
.com> wrote:
> > > >
> > > > Add trace point to psi triggers. This is useful to
> > > > observe the psi events in the kernel space.
> > > >
> > > > One use of this is to monitor memory pressure.
> > > > When the pressure is too high, we can kill the process
> > > > in the kernel space to prevent OOM.
> > > >
> > > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > ---
> > > > v2:
> > > > -fix compilation error;
> > > > -export the tp;
> > > > -add more commit message;
> > > > ---
> > > >  include/trace/events/sched.h | 5 +++++
> > > >  kernel/sched/psi.c           | 4 ++++
> > > >  2 files changed, 9 insertions(+)
> > > >
> > > > diff --git a/include/trace/events/sched.h b/include/trace/events/sc=
hed.h
> > > > index 7b2645b50e78..d54db5fcbca2 100644
> > > > --- a/include/trace/events/sched.h
> > > > +++ b/include/trace/events/sched.h
> > > > @@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
> > > >         TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> > > >         TP_ARGS(tsk, cpu, tif));
> > > >
> > > > +struct psi_trigger;
> > > > +DECLARE_TRACE(psi_event,
> > >
> > > DECLARE_TRACE will create a tracepoint but will not export it in the
> > > tracefs. Why should we not have it in the tracefs?
> >
> > I haven't figured out what content should be displayed in the trace yet=
.
> > Until this is fully determined, I think it might be a better option to
> > just export the tracepoint and let users add their own hooks to print
> > the content they need.
>
> You can report what you think makes sense today for this tracepoint.
> Tracepoints can be enhanced later if needed since their format is
> exported to the userspace and well-designed userspace parsers should
> be able to parse new fields.

Okay, I would change this to be tracepoint.

>
> >
> > >
> > > > +       TP_PROTO(struct psi_trigger *t),
> > > > +       TP_ARGS(t));
> > > > +
> > > >  #endif /* _TRACE_SCHED_H */
> > > >
> > > >  /* This part must be outside protection */
> > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > index 59fdb7ebbf22..f06eb91a1250 100644
> > > > --- a/kernel/sched/psi.c
> > > > +++ b/kernel/sched/psi.c
> > > > @@ -141,6 +141,8 @@
> > > >  #include <linux/psi.h>
> > > >  #include "sched.h"
> > > >
> > > > +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event_tp);
> > >
> > > So, are you planning to attach some handler to this trace event in yo=
ur driver?
> >
> > Yes, our modules would attach a handler to observe the memory pressure.
> >
> > >
> > > > +
> > > >  static int psi_bug __read_mostly;
> > > >
> > > >  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > > > @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *g=
roup, u64 now,
> > > >                 if (now < t->last_event_time + t->win.size)
> > > >                         continue;
> > > >
> > > > +               trace_psi_event_tp(t);
> > >
> > > This should only be done if the below cmpxchg() check is true, right?
> > > Otherwise it will not match with what userspace is receiving.
> >
> > If we put it below cmpxchg() check, we may lose some event before the
> > user space repose the signal.
> > Because the t->event needs to be set to 0 again.
> > In order to ensure that all events are displayed, it is better to put
> > it before the cmpxchg.
>
> Huh? Are you modifying the t->event inside your handler?! If so, that
> is unacceptable and I will NAK this change. A driver should not
> interfere with core kernel mechanisms.

Sorry for missing this, the next patch, I would export some variables
instead of the pointer of t...

Thanks!

>
> >
> > Thanks!
> >
> > >
> > > > +
> > > >                 /* Generate an event */
> > > >                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> > > >                         if (t->of)
> > > > --
> > > > 2.25.1
> > > >
