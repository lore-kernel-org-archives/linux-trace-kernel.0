Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DC22CBF1
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Jul 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560776; cv=none; b=F0vIqEgRm1fsgyshfGEfqvHoobBU7KIsNW5j+G9vuzcMlH3rivv9XytLZJY+gmzwkGOADs5uUOM/E4yVEtLo2H+JdeS7rzkweScf0T9PNw82owLiCKuVmaQl6th5ONEqzm5kdWqG/9wB9B0xxpdkmVEFN6SA1gvwZ77nAEnytVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560776; c=relaxed/simple;
	bh=OP07TbxG1yKUNCRRs6J15K1uaEcQFidhIdr7TB2xTKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCZBbJr/rjFhwDGCopJLmR2rZE2B+P2n/9s7EHBdFFLZSeVqA62ddArkT9nbjOu6Dbaj7IRzNCf7TJTyVoXe3DWw/2Prq+IzRbBL6m325GsOEvrlJ6RCs6RDk5UHFT5uNpgJ2wQ1c/VjjxfBCqQGJYEr3c2VbX8Z5f2U/yEsXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFh0yIGy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFh0yIGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751560773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9aaJ9K1Jsig8CyIAL4XSu/uqU0yHOfuZhdHfnOnK8I=;
	b=CFh0yIGyxAtkmfhnczm9uPxSF3wGtPW3WFY5s4wQ/utTx7SCoCjun21LKNA88IWDqPhYOT
	7QxjfK9GJg3v1B9SFBs1fv47aUJovGHBJgYTN18PAMNAv9/kYO9ZTSNrVr64XHG6gTq6xC
	fmDvir1E/BLC4uXmGchulJ9y/+yI5Q4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-wTQky11gNkeK6tMq63KBRg-1; Thu, 03 Jul 2025 12:39:31 -0400
X-MC-Unique: wTQky11gNkeK6tMq63KBRg-1
X-Mimecast-MFC-AGG-ID: wTQky11gNkeK6tMq63KBRg_1751560770
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a57fea76beso852021cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Jul 2025 09:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751560770; x=1752165570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9aaJ9K1Jsig8CyIAL4XSu/uqU0yHOfuZhdHfnOnK8I=;
        b=Vx3D9I1Y4YM1eIsVwIE1ElOShkfiJde/EIdfaYGHGAbVT8RY3D4o0WjWwuZ2p9uRrk
         YxE+4QweUssIqUUqsWXKGAkzo7p57wcfOCMN/dHlQgOQkmgdoxhCqijlGxdT6JF5AUkU
         aKOsc3gPtdDIwEldlueNNGg/wqrPmDKqtEkWcE+fUemx1RYyeV3w2F9chqGKLvcrg4VG
         poEdO1qc7O5hhPDEp9qGgm+pO0K7oUoBMgZvUVPd+mygKAyW2e2JioTWnQO/VVRieYBm
         hMXNQziUWfakPlmj+3k/4vhy51IfxibuWySEjEox6YqBx7ye8OnCipAMsGnhe6GBLvGJ
         IHRw==
X-Forwarded-Encrypted: i=1; AJvYcCWml9b/UAt6gpiDYyoSl+66et5FgOe0b0nH6LRGfMaoZJ6ctqaxU+gXoPwNvl/m1k8xqZgK7CQFc9V/zMpcJaQmfK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSj9bJ45JgWS3KCzmoV1Yjis/nSEh7TC5WSXxJYj7mx6HwHXW
	+fzeWgRHHNfnvvR13+k18TMvRSz5wOtXh7pMbpWysvBALDy5BAhdF02gDGSnqRoaP+WrgQ/VJ/W
	kekrejetqNqBXhyqnFak/DeK3rNzP64xErHx21po9Vs0amLNpQwFyTMGrN7UTDR02e/1WMQRWLg
	PFH6Ov28NtWJkm/tAY2sgACQc323+ER+JA5Ubgk3NER1/5ydQh
X-Gm-Gg: ASbGncvlwyh6UO37BaaXGfmFAXPq1zjRYYWe44ykYaO7eytDh4puP89hvnwXLfSLqpT
	+AIMsLLETHS7P38lTLnOHWwjAVf0+t049CZR3W5RhkEocuxndm1FFbkRmOe/CGzrwChUMbrLzh6
	RQp5ygFaX3ecvFDIsvcv60DenBo+v0XLcYMu2F
X-Received: by 2002:a05:622a:4506:b0:4a9:7715:d843 with SMTP id d75a77b69052e-4a9771657a0mr88137491cf.11.1751560770246;
        Thu, 03 Jul 2025 09:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETAv4Y9b5MkPk/1qBNseE0yQz7deC/9dkZv8z3hyDuGn79yrD4ZTkJHHlrhQEMpD6zcBfzjUIpUF8geqfeofQ=
X-Received: by 2002:a05:622a:4506:b0:4a9:7715:d843 with SMTP id
 d75a77b69052e-4a9771657a0mr88137061cf.11.1751560769717; Thu, 03 Jul 2025
 09:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702143657.18dd1882@batman.local.home> <CA+wEVJYeDACQTO8g2L9_ZAM0mC2JwBm_pDahiGVmfc=c43caAA@mail.gmail.com>
In-Reply-To: <CA+wEVJYeDACQTO8g2L9_ZAM0mC2JwBm_pDahiGVmfc=c43caAA@mail.gmail.com>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Thu, 3 Jul 2025 18:39:18 +0200
X-Gm-Features: Ac12FXymlAS-7jjMoH0iosjqQrJC09aMvZ_C-K473ROSv8EEObuaSmUS9u3Y7Lw
Message-ID: <CA+wEVJbwPPJ6_DOXChTCQygQrraK785WCu97jdVpdUqJ483mdA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Remove EVENT_FILE_FL_SOFT_MODE flag
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7djrrlmmtvO9KJprd0BPN5MgsGuQtUF8uG5qessyYJU_1751560770
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 6:18=E2=80=AFPM Gabriele Paoloni <gpaoloni@redhat.co=
m> wrote:
>
> On Wed, Jul 2, 2025 at 8:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > When soft disabling of trace events was first created, it needed to hav=
e a
> > way to know if a file had a user that was using it with soft disabled (=
for
> > triggers that need to enable or disable events from a context that can =
not
> > really enable or disable the event, it would set SOFT_DISABLED to state=
 it
> > is disabled). The flag SOFT_MODE was used to denote that an event had a
> > user that would enable or disable it via the SOFT_DISABLED flag.
> >
> > Commit 1cf4c0732db3c ("tracing: Modify soft-mode only if there's no oth=
er
> > referrer") fixed a bug where if two users were using the SOFT_DISABLED
> > flag the accounting would get messed up as the SOFT_MODE flag could onl=
y
> > handle one user. That commit added the sm_ref counter which kept track =
of
> > how many users were using the event in "soft mode". This made the
> > SOFT_MODE flag redundant as it should only be set if the sm_ref counter=
 is
> > non zero.
> >
> > Remove the SOFT_MODE flag and just use the sm_ref counter to know the
> > event is in soft mode or not. This makes the code a bit simpler.
> >
> > Link: https://lore.kernel.org/all/20250702111908.03759998@batman.local.=
home/
> >
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  include/linux/trace_events.h |  3 ---
> >  kernel/trace/trace_events.c  | 24 ++++++++++++------------
> >  2 files changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.=
h
> > index fa9cf4292dff..04307a19cde3 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -480,7 +480,6 @@ enum {
> >         EVENT_FILE_FL_RECORDED_TGID_BIT,
> >         EVENT_FILE_FL_FILTERED_BIT,
> >         EVENT_FILE_FL_NO_SET_FILTER_BIT,
> > -       EVENT_FILE_FL_SOFT_MODE_BIT,
> >         EVENT_FILE_FL_SOFT_DISABLED_BIT,
> >         EVENT_FILE_FL_TRIGGER_MODE_BIT,
> >         EVENT_FILE_FL_TRIGGER_COND_BIT,
> > @@ -618,7 +617,6 @@ extern int __kprobe_event_add_fields(struct dyneven=
t_cmd *cmd, ...);
> >   *  RECORDED_TGID - The tgids should be recorded at sched_switch
> >   *  FILTERED     - The event has a filter attached
> >   *  NO_SET_FILTER - Set when filter has error and is to be ignored
> > - *  SOFT_MODE     - The event is enabled/disabled by SOFT_DISABLED
> >   *  SOFT_DISABLED - When set, do not trace the event (even though its
> >   *                   tracepoint may be enabled)
> >   *  TRIGGER_MODE  - When set, invoke the triggers associated with the =
event
> > @@ -633,7 +631,6 @@ enum {
> >         EVENT_FILE_FL_RECORDED_TGID     =3D (1 << EVENT_FILE_FL_RECORDE=
D_TGID_BIT),
> >         EVENT_FILE_FL_FILTERED          =3D (1 << EVENT_FILE_FL_FILTERE=
D_BIT),
> >         EVENT_FILE_FL_NO_SET_FILTER     =3D (1 << EVENT_FILE_FL_NO_SET_=
FILTER_BIT),
> > -       EVENT_FILE_FL_SOFT_MODE         =3D (1 << EVENT_FILE_FL_SOFT_MO=
DE_BIT),
> >         EVENT_FILE_FL_SOFT_DISABLED     =3D (1 << EVENT_FILE_FL_SOFT_DI=
SABLED_BIT),
> >         EVENT_FILE_FL_TRIGGER_MODE      =3D (1 << EVENT_FILE_FL_TRIGGER=
_MODE_BIT),
> >         EVENT_FILE_FL_TRIGGER_COND      =3D (1 << EVENT_FILE_FL_TRIGGER=
_COND_BIT),
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 120531268abf..0980f4def360 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -768,6 +768,7 @@ static int __ftrace_event_enable_disable(struct tra=
ce_event_file *file,
> >  {
> >         struct trace_event_call *call =3D file->event_call;
> >         struct trace_array *tr =3D file->tr;
> > +       bool soft_mode =3D atomic_read(&file->sm_ref) !=3D 0;
>
> I was checking why an atomic counter is needed here, and, since this
> function should be called with
> event_mutex locked, I think the atomic counter is not needed, so maybe
> it should be removed...
> On a different angle I also checked the callers of this function and
> it seems that in some cases
> event_mutex is not held when calling this function. E.g.:
> trace_event_trigger_enable_disable() -> trace_event_enable_disable()
> -> __ftrace_event_enable_disable()
>
> In general it seems that all the callers of
> trace_event_enable_disable() are outside trace_events.c, so maybe
> the modification below could solve this issue and concurrently we
> could replace the atomic sm_ref with a
> standard one...?

Sorry I had a better look at the code and event_mutex is locked/unlocked
also outside of trace_events.c so the modification below is not needed.
However I think we could still replace the atomic counter.

Gab

>
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -880,7 +880,9 @@ static int __ftrace_event_enable_disable(struct
> trace_event_file *file,
>  int trace_event_enable_disable(struct trace_event_file *file,
>                                int enable, int soft_disable)
>  {
> +       mutex_lock(&event_mutex);
>         return __ftrace_event_enable_disable(file, enable, soft_disable);
> +       mutex_unlock(&event_mutex);
>  }
>
> Thanks
> Gab
>
> >         int ret =3D 0;
> >         int disable;
> >
> > @@ -782,7 +783,7 @@ static int __ftrace_event_enable_disable(struct tra=
ce_event_file *file,
> >                  * is set we do not want the event to be enabled before=
 we
> >                  * clear the bit.
> >                  *
> > -                * When soft_disable is not set but the SOFT_MODE flag =
is,
> > +                * When soft_disable is not set but the soft_mode is,
> >                  * we do nothing. Do not disable the tracepoint, otherw=
ise
> >                  * "soft enable"s (clearing the SOFT_DISABLED bit) wont=
 work.
> >                  */
> > @@ -790,11 +791,11 @@ static int __ftrace_event_enable_disable(struct t=
race_event_file *file,
> >                         if (atomic_dec_return(&file->sm_ref) > 0)
> >                                 break;
> >                         disable =3D file->flags & EVENT_FILE_FL_SOFT_DI=
SABLED;
> > -                       clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->f=
lags);
> > +                       soft_mode =3D false;
> >                         /* Disable use of trace_buffered_event */
> >                         trace_buffered_event_disable();
> >                 } else
> > -                       disable =3D !(file->flags & EVENT_FILE_FL_SOFT_=
MODE);
> > +                       disable =3D !soft_mode;
> >
> >                 if (disable && (file->flags & EVENT_FILE_FL_ENABLED)) {
> >                         clear_bit(EVENT_FILE_FL_ENABLED_BIT, &file->fla=
gs);
> > @@ -812,8 +813,8 @@ static int __ftrace_event_enable_disable(struct tra=
ce_event_file *file,
> >
> >                         WARN_ON_ONCE(ret);
> >                 }
> > -               /* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else=
 clear it */
> > -               if (file->flags & EVENT_FILE_FL_SOFT_MODE)
> > +               /* If in soft mode, just set the SOFT_DISABLE_BIT, else=
 clear it */
> > +               if (soft_mode)
> >                         set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file-=
>flags);
> >                 else
> >                         clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &fil=
e->flags);
> > @@ -823,7 +824,7 @@ static int __ftrace_event_enable_disable(struct tra=
ce_event_file *file,
> >                  * When soft_disable is set and enable is set, we want =
to
> >                  * register the tracepoint for the event, but leave the=
 event
> >                  * as is. That means, if the event was already enabled,=
 we do
> > -                * nothing (but set SOFT_MODE). If the event is disable=
d, we
> > +                * nothing (but set soft_mode). If the event is disable=
d, we
> >                  * set SOFT_DISABLED before enabling the event tracepoi=
nt, so
> >                  * it still seems to be disabled.
> >                  */
> > @@ -832,7 +833,7 @@ static int __ftrace_event_enable_disable(struct tra=
ce_event_file *file,
> >                 else {
> >                         if (atomic_inc_return(&file->sm_ref) > 1)
> >                                 break;
> > -                       set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->fla=
gs);
> > +                       soft_mode =3D true;
> >                         /* Enable use of trace_buffered_event */
> >                         trace_buffered_event_enable();
> >                 }
> > @@ -840,7 +841,7 @@ static int __ftrace_event_enable_disable(struct tra=
ce_event_file *file,
> >                 if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
> >                         bool cmd =3D false, tgid =3D false;
> >
> > -                       /* Keep the event disabled, when going to SOFT_=
MODE. */
> > +                       /* Keep the event disabled, when going to soft =
mode. */
> >                         if (soft_disable)
> >                                 set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT=
, &file->flags);
> >
> > @@ -1792,8 +1793,7 @@ event_enable_read(struct file *filp, char __user =
*ubuf, size_t cnt,
> >             !(flags & EVENT_FILE_FL_SOFT_DISABLED))
> >                 strcpy(buf, "1");
> >
> > -       if (flags & EVENT_FILE_FL_SOFT_DISABLED ||
> > -           flags & EVENT_FILE_FL_SOFT_MODE)
> > +       if (atomic_read(&file->sm_ref) !=3D 0)
> >                 strcat(buf, "*");
> >
> >         strcat(buf, "\n");
> > @@ -3584,7 +3584,7 @@ static int probe_remove_event_call(struct trace_e=
vent_call *call)
> >                         continue;
> >                 /*
> >                  * We can't rely on ftrace_event_enable_disable(enable =
=3D> 0)
> > -                * we are going to do, EVENT_FILE_FL_SOFT_MODE can supp=
ress
> > +                * we are going to do, soft mode can suppress
> >                  * TRACE_REG_UNREGISTER.
> >                  */
> >                 if (file->flags & EVENT_FILE_FL_ENABLED)
> > @@ -3997,7 +3997,7 @@ static int free_probe_data(void *data)
> >
> >         edata->ref--;
> >         if (!edata->ref) {
> > -               /* Remove the SOFT_MODE flag */
> > +               /* Remove soft mode */
> >                 __ftrace_event_enable_disable(edata->file, 0, 1);
> >                 trace_event_put_ref(edata->file->event_call);
> >                 kfree(edata);
> > --
> > 2.47.2
> >
> >

