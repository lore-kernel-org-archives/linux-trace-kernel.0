Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A082E92BC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607667; cv=none; b=obN+46ZgymEOB2cjGX95igIWRIHiWb6nwtHxZ9XDM4gDkPndtHlK1qCI9LuFwIyCeUdduxs/00AjKYAyyEuhP0A0HYfatKiKr5Sy8O2WeVM4uTSPlvWIi+R+yhLoyIOBfbR0iUCIjlZO0AfxMFKgsDQ24HLqmz3NOlcNFXXsxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607667; c=relaxed/simple;
	bh=arDVeJ781a5JY4lU0Jvx71uXG6RVAnB7CUja4/NHmNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnv5gg4e9W9+LiX+Qq50ficGKbmPVkIwgrjrrbn4C/imA/rpJK5FHXi8A0+zdwFJ+q3IqS8uayZZOZZFHCZ0mQWxi5sBN50EoclFc5NWCZJdrtx66vDsOsgYxmGiH8xM4bz3DBlKHKDkcLi9XCMokDd3GjVt8TmEk01FFJBquPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBjTZ4c/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBjTZ4c/"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b38d4de61aso61656401cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758607663; x=1759212463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBw+oV2t8lt0sCTnWqXxyFqdNrsWHoU6HwpFH6UzjX0=;
        b=HBjTZ4c/qzYcvSyEi9LKjg52ue2hHwdUgyQGqe82Jyc6Jy1Lj4wtGwbNT9BSlksOTS
         jbnNEAJlro0XWsh7t8iNTbEv4RVk2qIbPwCKpqgKkUvkOxWYcUuaSq5ZQ9bnZqogSRmV
         SJHChwgJawFNo+dZWNyyIEK1awivlnFBojD1ttrnFbcUFJj7bbabj3kuKwyVpXXYD+m9
         tWmSFErSCEZSWj5Fm6IgowXHW8Wstvzt1NDVrcMyQicL9v2mOm8u2iak7lGrsF+Y0prJ
         OyNaQ987t+p9ZKqcjzOY/lV8xXk6RHozvI4cNhONiKwmiH/VQrfAn2FQrsIvhwaWHNIc
         Asjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758607663; x=1759212463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBw+oV2t8lt0sCTnWqXxyFqdNrsWHoU6HwpFH6UzjX0=;
        b=Y5clVnZrKLbm9em4+5lhachuc/Bx7G/oQJ1oDEjbnQx+BxnoOL6yoPAZR3jHF1rJtV
         IwuxuWZWKennpo9F85J7D8M9pqXk3brixHYpgibld94JPgaulvTFUU9oMjWUZ1shNAFQ
         L7CdLqegypcx8ai2tmIU1YYmuHETZByBDPV7WVe4fZgSFTsjtq7W1Yo14kaTqOyUUkLv
         ca+p+nI1BDZKGHvdPBgXMME+e4tQKVe4o7uWw6chkqSLqP5u2wK5cEmHCBpFYRn2jvhJ
         Q1R4xN8wSENKH3Cpfdx18BJNahWtI28Ja0pKGDjVuIpFwQmA8HZW8rpLHxNRzUxmkidM
         upsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu7EU/C8YLurgeRB3RThiXAEu9Wc+tKKRevC0sW/bufLb2DneFkabNJBk2MH5X9lOvETEP5OpzfBWUUrbqRwgQvYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO/DQJP8BddoWhiym8Gz2IwAeHsmw+3XQn8bf7XFiB6Qldw7ek
	qXnTGdfa0zTCVyKK3nT6oAY1lDdYBBv31BgCJxjn90efv86FxDp0/VIAk44VJWixXkw3tQiFm7U
	zUCAKp5ALr+U9HYK0cOnPdqZh3ufVArI=
X-Gm-Gg: ASbGncsiCJXU7Z5OnOx1xJL3h4xsGrfbBEFsBTPA6an4YaEkTnjO1eDRYsKkXgx+aBM
	G5IMD/K4TdMLf1Ncmy1cw1XzTjIXOhdkDUmmg4XSUFxzez48DO09y/O+KRNN+l7NjRfimphyvPl
	nmWDe9m4nhlBAEA3C9AASUxrpeGVHRhgyZNL91YP8AxZ5cOUgzsxt1RQDw1yQu3H33+AyQx4kXL
	Db7oerL
X-Google-Smtp-Source: AGHT+IHhWRqdPSNilQ7NDnUa+avCQNXPtnb6Fc5TbS5XEzojG+bYtzwzS9TIxtwMvX3/Xea6oZTCTsf/6qwe2opyx8s=
X-Received: by 2002:ac8:7dc5:0:b0:4d1:89c4:822 with SMTP id
 d75a77b69052e-4d36fc044c4mr15282621cf.41.1758607663111; Mon, 22 Sep 2025
 23:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911032823.19064-1-xuewen.yan@unisoc.com> <CAB8ipk-xqbsNh6EQ42JFV8CqPeJR0gjObOKvSs=-b=qcuLQxfg@mail.gmail.com>
 <CAJuCfpHVjDrng2=bCh=DBdn_LBK3-qVF46Jwm3_TFzCjQhn9CA@mail.gmail.com>
In-Reply-To: <CAJuCfpHVjDrng2=bCh=DBdn_LBK3-qVF46Jwm3_TFzCjQhn9CA@mail.gmail.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 23 Sep 2025 14:07:32 +0800
X-Gm-Features: AS18NWBffMFJu4JOI5B0Q8gjJRvpvqantKvpvb0ig8H71YWrBOUW7-N7WP6ubeI
Message-ID: <CAB8ipk-cCLWUg8A6tSMZW43fHj10XAzBU2O4Ed5TbDk73J8QBw@mail.gmail.com>
Subject: Re: [RFC PATCH V3] sched: psi: Add psi events trace point
To: Suren Baghdasaryan <surenb@google.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, hannes@cmpxchg.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ke.wang@unisoc.com, yuming.han@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Mon, Sep 22, 2025 at 7:58=E2=80=AFPM Xuewen Yan <xuewen.yan94@gmail.co=
m> wrote:
> >
> > A very gentle ping on this patch.
> > Best regards,
> > Thanks!
>
> Thanks! Sorry I missed it.
Not at all, thanks for your reply:)

>
> >
> > On Thu, Sep 11, 2025 at 11:30=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.=
com> wrote:
> > >
> > > Add trace point to psi triggers. This is useful to
> > > observe the psi events in the kernel space.
> > >
> > > One use of this is to monitor memory pressure.
> > > When the pressure is too high, we can kill the process
> > > in the kernel space to prevent OOM.
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > ---
> > > V3:
> > > -export it in the tracefs;
> > > ---
> > > v2:
> > > -fix compilation error;
> > > -export the tp;
> > > -add more commit message;
> > > ---
> > >  include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
> > >  kernel/sched/psi.c           |  4 ++++
> > >  2 files changed, 31 insertions(+)
> > >
> > > diff --git a/include/trace/events/sched.h b/include/trace/events/sche=
d.h
> > > index 7b2645b50e78..db8b8f25466e 100644
> > > --- a/include/trace/events/sched.h
> > > +++ b/include/trace/events/sched.h
> > > @@ -826,6 +826,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
> > >         TP_printk("cpu=3D%d", __entry->cpu)
> > >  );
> > >
> > > +#ifdef CONFIG_PSI
> > > +TRACE_EVENT(psi_event,
> > > +
> > > +       TP_PROTO(int aggregator, int state, u64 threshold, u64 win_si=
ze),
> > > +
> > > +       TP_ARGS(aggregator, state, threshold, win_size),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(int,    aggregator)
> > > +               __field(int,    state)
> > > +               __field(u64,    threshold)
> > > +               __field(u64,    win_size)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->aggregator     =3D aggregator;
> > > +               __entry->state          =3D state;
> > > +               __entry->threshold      =3D threshold;
> > > +               __entry->win_size       =3D win_size;
> > > +       ),
> > > +
> > > +       TP_printk("aggregator=3D%d state=3D%d threshold=3D%llu window=
_size=3D%llu",
> > > +               __entry->aggregator, __entry->state, __entry->thresho=
ld,
> > > +               __entry->win_size)
> > > +);
> > > +#endif /* CONFIG_PSI */
> > > +
> > >  /*
> > >   * Following tracepoints are not exported in tracefs and provide hoo=
king
> > >   * mechanisms only for testing and debugging purposes.
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 59fdb7ebbf22..5b7954b653ed 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -141,6 +141,8 @@
> > >  #include <linux/psi.h>
> > >  #include "sched.h"
> > >
> > > +EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event);
> > > +
> > >  static int psi_bug __read_mostly;
> > >
> > >  DEFINE_STATIC_KEY_FALSE(psi_disabled);
> > > @@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *gro=
up, u64 now,
> > >                 if (now < t->last_event_time + t->win.size)
> > >                         continue;
> > >
> > > +               trace_psi_event(aggregator, t->state, t->threshold, t=
->win.size);
>
> Again, this trace event should be generated only after cmpxchg()
> passes the check. Otherwise trace events might be generated when
> actual PSI events are not (false positives). That disconnect is not
> acceptable.

You=E2=80=99re absolutely right. I=E2=80=99ll resolve it in the next patch.

Thanks!

BR
---
xuewen

>
> > > +
> > >                 /* Generate an event */
> > >                 if (cmpxchg(&t->event, 0, 1) =3D=3D 0) {
> > >                         if (t->of)
> > > --
> > > 2.25.1
> > >
