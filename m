Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13DF19D08F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749458; cv=none; b=I5bJ6qVZ4BJHTmvG6xCYRkTwGM2V6TzzmWFxNpgIraaJqkz6hcYSVdbkeQ/Txwrk16ITxjATD/Nh8lU732z9w4sLM+/aSJUvXSNGFtUbt6y4+xKDRbshlaTDmpvDAcY5e85ibcDSH+KTvOwHXfmnm/ZdO7nWHu1PiHPxU6E6Vsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749458; c=relaxed/simple;
	bh=4jDnpiNa5vbDQniS7C9yLyN0Nt34xAnHa+GBFlsVZP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mj+lIzpYX/tQWLWVLD+lglPKL/zvErOKriNArS7lsgDoTXlhzwhlkw79WhsCwnuzkvW6ace3nCfp9IU0VAhm03efTZHotvrxbmRvEMMcMGd/TyW1Gd+x/Pa8VvBeDSNJah5Vztyjde99lrYI/rquS0k89PB/GVAHVILP3FI2plA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7EepXCN; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7EepXCN"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ea12242d2eso335601cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761749455; x=1762354255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2GCr3HjnIb/dxyIVffNrVApa0qBSUzyDC5g+dFTLPA=;
        b=a7EepXCNBGQVU1Uf1JxPgjdBD0SLTP+To5jO1xwFEQwJuIuvDJZNpwO4xWQHLWGRVj
         fVyOqr70qtstT+EKneLoB+Wx17eR+DqdsT5g7D1K8I4g5aqI6QJGQW0fRqweENq6RXoM
         uK/T1XIInRGj2MQfqkIGOofJJGAsYp9gXVR3KwzngnGpxnP7PSIkMBbWjSXy9TD8QVU6
         Yndl4RquacOI7hHBGSMPWeU7j+J/mTvNcgIUZCvgRAs18Ow2L2ETPPk7EASSxm4r3Cyy
         NF7GJcx6D/BB1Y1dscQTlP9HeGVr81nM1aXYgEVb8b+vZtFWgu5kGWkbbWFXejBPitSX
         0xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749455; x=1762354255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2GCr3HjnIb/dxyIVffNrVApa0qBSUzyDC5g+dFTLPA=;
        b=brgKdrtAx/71CpOZebWoMG/z0sp6sUUNZXLPBGLL3afFsm35AumOIrkoSH9F5MTGGx
         kxcAkvfxa1AHZ32JS8QsqkmB9tK25w4GNpPaLFFvLhU/Jh+vG9mrxbB8oCBccchl0pHW
         deZKG29l10Bq2lY4flUPPKG3BaYnJi2ezdz2gHC1pS3jc+rcvG2ofFA4I9CPTfnOUpDK
         ACi4laoXmc+RteAysSbYPR2wkz5IJPcS50SVTmJ0FzriGEdARMbtJwOebb1yt3UYsVB8
         3x8z+VND/naYCDhvy2MTOaS1cltUzXKGnUOK1QpJAbUrZVqH52fQYJGiR8FxzTbAM7B/
         Xykg==
X-Forwarded-Encrypted: i=1; AJvYcCUf3Z7up/pUhN7FcKm0Sbdkey4gmurt1mf8N/uKWqciFoOURko6I6DdB5RHZI8Cyy6/EYj+StXcGFGounBAjCwBMhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYv9lGmoCdA1WLdfTVGBbCDX6QLpJrCBuEYq9LinBbAZujR4a
	otFzajCsw1dxvoZwipkrLRC05TZkzlvSTp831iXkPs4ZE7v7S80CdO4qT+sSlId1p99JGVveRxg
	hDsPShQWCu3iFLKBkXPZF2ACtoLlG3M95PVaszgZjMSLB2bP96Bme/ONu
X-Gm-Gg: ASbGncvoF6Y221k1zEGfXpEmVeKhLdhBcRpCNmNch5+gUN7PT8F6+IHEyYmGP7f4yDQ
	yzPAnw5F7TQHaK//M8K6tPSBmEb2nNN84PmTspusGfynM5StWg2qPr/6D5msQ+uHoSerDnC8F+V
	HHozQ1OTzpXOgQpbmDrQZNH3JQlUZ5qWCy3W+hAhWDIyfHR7ubWCRpiGIm1wqDPG81f0504bOhW
	/JqY31VKug2/Fo/C/04ouzMgw697aQNaLTDdyCvaxa1wNWUt8zlTWusGPQAXrvUB5G4b8GakCom
	DxadzjWYVRKRujU=
X-Google-Smtp-Source: AGHT+IGcOdn9pM+HsKz6/HPyK4Wssb1I6KCFZrss7CNVm3EJz7jqpksJBJFyetZbqo0GJdRvVDAHhYRJiYcnTEIRG7s=
X-Received: by 2002:a05:622a:4c0c:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4ed1657e953mr6438561cf.3.1761749454320; Wed, 29 Oct 2025
 07:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929014227.430-1-xuewen.yan@unisoc.com> <CAJuCfpE_aZKFB8O=KPq5uTv=WeJf6TCmneMnr8pp88SNWy3K-Q@mail.gmail.com>
 <CAB8ipk8oC2UKJu6f6qun3PYFwrzGZUT=YjQhfNGaVrF4GM2wdA@mail.gmail.com>
In-Reply-To: <CAB8ipk8oC2UKJu6f6qun3PYFwrzGZUT=YjQhfNGaVrF4GM2wdA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 29 Oct 2025 07:50:42 -0700
X-Gm-Features: AWmQ_bnCUdUZHMVJ1c32YJT4uabxF-Awnj_KVPGmYQ_uHFarqcy7EANdQw094Fo
Message-ID: <CAJuCfpF6sakmsDeqrVTxwqUjRtid-7oG9KjGSQYmb0R=BCp9zw@mail.gmail.com>
Subject: Re: [RFC PATCH V4] sched: psi: Add psi events trace point
To: peterz@infradead.org, hannes@cmpxchg.org, 
	Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, yuming.han@unisoc.com, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:53=E2=80=AFAM Xuewen Yan <xuewen.yan94@gmail.com>=
 wrote:
>
> Gentle ping....
>
> Sorry to ask, but may I know if this patch can be merged into the mainlin=
e?

Hi Peter,
If you have no objections to this patch, could you please accept it
into your tree?
Thanks,
Suren.

>
> Thanks!
>
> On Tue, Sep 30, 2025 at 7:17=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Sun, Sep 28, 2025 at 6:43=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.c=
om> wrote:
> > >
> > > Add trace point to psi triggers. This is useful to
> > > observe the psi events in the kernel space.
> > >
> > > One use of this is to monitor memory pressure.
> > > When the pressure is too high, we can kill the process
> > > in the kernel space to prevent OOM.
> >
> > Just FYI, Roman is working on a BPF-based oom-killer solution [1]
> > which might be also interesting for you and this tracepoint might be
> > useful for Roman as well. CC'ing him here.
> >
> > [1] https://lore.kernel.org/all/20250818170136.209169-1-roman.gushchin@=
linux.dev/
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> >
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
> >
> > > ---
> > > V4:
> > > -generate the event only after cmpxchg() passes the check
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
> > >  kernel/sched/psi.c           |  5 +++++
> > >  2 files changed, 32 insertions(+)
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
> > > index 59fdb7ebbf22..e8a7fd04ba9f 100644
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
> > > @@ -515,6 +517,9 @@ static void update_triggers(struct psi_group *gro=
up, u64 now,
> > >                                 kernfs_notify(t->of->kn);
> > >                         else
> > >                                 wake_up_interruptible(&t->event_wait)=
;
> > > +
> > > +                       trace_psi_event(aggregator, t->state, t->thre=
shold,
> > > +                                       t->win.size);
> > >                 }
> > >                 t->last_event_time =3D now;
> > >                 /* Reset threshold breach flag once event got generat=
ed */
> > > --
> > > 2.25.1
> > >
> > >
