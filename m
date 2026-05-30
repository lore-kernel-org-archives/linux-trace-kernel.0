Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7D318EEE
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780112024; cv=none; b=GpgtxbEaeujmhG+2aR/CdAArugJvxKS/CI5n9qmSyJzGfm8LFOVY30R5basL9aG+olWrXQ1lz8bfR7YIEelEq5PPKUUUmaefEI3vLcQD3QZwKIawHPhkjMcg9zsfkHtpL/QjfHY8JFHJa4PuL754Apzg13x13403oZNDV1HfF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780112024; c=relaxed/simple;
	bh=IFI6sYcPQmKNmOqrHpONlcmdhOLZeCJw8xQLxIxD9CU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TA9v8NusQqkpR5p6JJBC8VzUoPFiMZA/hpK5Y2M0g7TbDD9+WhY/WbRNOJAgvpJphpnSpk/FiyS0dtaj4tOhq4YryMNzXNmIZzH/xwW9mLSBWwbLeqYY9Fv5pSEsHriasdD88it0SsyCzszmcpJvXWdT8O3/8NHmatFp+i4deho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGAYvHOD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGAYvHOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780112021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKshsE34Ej54G52qKAdqYDsrsfQi3PDZovluj+ciTtY=;
	b=dGAYvHODCsxuPDm7/svCU8szG8hxKq6HF8oPVXOJgrzDfYm2kBZs56cAH7kSlZIYUUjkFv
	e934sG+Y8zmrLEhoDBNmW/NNAkdXw8NVbesWbA6eOAg4tLlyxiC+0bfHqjUyvo767NaoV6
	t4zrtwFSAo9j/a/zWDW3EHu9ofQ7jos=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-OMFIDSs9M1CJ1gXSnigMdw-1; Fri, 29 May 2026 23:33:40 -0400
X-MC-Unique: OMFIDSs9M1CJ1gXSnigMdw-1
X-Mimecast-MFC-AGG-ID: OMFIDSs9M1CJ1gXSnigMdw_1780112020
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8cceaca5671so21550136d6.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 May 2026 20:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780112020; x=1780716820;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYMTrWIEGWTyvJqxHpESzH/Gg6triQriDVNWiwI0tqE=;
        b=g+g+EkMKk2v6SgoKuDUtLQwah64WUBQ3kp1VFb/MKr4y1JrIkygut8qRoqbgiNQoRk
         PLeJtxE59hvt1SesZvwyKTPGUaGUfXzAfQ24uiS1cRR/AgOj6k0lOkvHZygb29y3GMbu
         oYXbZtujuywQ/vGE0povArWOgM/wcdfEjDvYPi3U4LgewVhftzce01dvnhl1S5dRkW9+
         Q6vU7bvSF2H2fjwry/d9x3etY7poMiMFRLZDK91pyIoiqGuw9TMLZAez8ipi//CRvwip
         sNtFqpTzkCTRttm+riUhUUy0TsoFEEi0nWT2545Ad3vNF5DNOFWlKPRvIOl25FJiDeJT
         ilLA==
X-Gm-Message-State: AOJu0Yy0+GbNCbmrbmtVWl2aR/orf6zww82RmE+aKQisSd2bNDRUKNOV
	ySgi/aUejn/Z2BfMUIT8Oozno0VH0Qq3NjRuMQbP9DI7Cmvsr9OGmm7K0Ia/pzmLR0/2MCDU3Fd
	kzl4RhFqoXCLVxFzK9PP6YgXXDOqTin4N3wMJ3JsuMqxZKAUN4fikD+LIL/eJcAJOzZ8qnJAKno
	SklNei6g==
X-Gm-Gg: Acq92OHu2VSm5wtl4DJmjy6jIMeZvH8YYVMmw3NEJAaBMISjFNWe3kZszghlVJ2QuJX
	atW5XuXYpNVH5ikDcEKgavh5eOxhAISWy4/PzBDm4tqA4+lHYkksjPHqJu6u+TqVLCMQaYGdA/F
	WfDvULn7AHS6YzYABDr198WFAusMEqDz242SfIBP4CNzJuHPtH3PFTI4ohauGqjsF4/vMLf26f0
	XqcHF1oOTe0tDPcu2UkMzHe8YINVFB2PDlRSlhzGSOw36Ygfz8Zvqi37rnsKDse2KwiN977TvuH
	KxJdmUet+cC6abcRkA3w2GZbvBc9dAWc7GaZNuYdsj0DPkSLn9/mfcgtlivvd/xiB5yrfxhcbWS
	O4S3LOrPW2k3+Dh1WZpuv3l5dYMW3qAx/cB7tANu3YDNPLMO/YVNKFZJoxPT1AdvO
X-Received: by 2002:a05:620a:4005:b0:914:afb8:795e with SMTP id af79cd13be357-9153d975eaamr373795085a.19.1780112019932;
        Fri, 29 May 2026 20:33:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4005:b0:914:afb8:795e with SMTP id af79cd13be357-9153d975eaamr373792085a.19.1780112019462;
        Fri, 29 May 2026 20:33:39 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915326503d2sm391982685a.44.2026.05.29.20.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 20:33:38 -0700 (PDT)
Message-ID: <b555e6ba6f723c244edc88afbc6383022d51ed3c.camel@redhat.com>
Subject: Re: [PATCH v2] tracing/osnoise: Array printk init and cleanup
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
 Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Date: Fri, 29 May 2026 22:33:37 -0500
In-Reply-To: <0c6606c49ab912904f00663f113289f546084925.camel@redhat.com>
References: <20260511223035.1475676-1-crwood@redhat.com>
		 <20260520162810.3112a9d6@gandalf.local.home>
	 <0c6606c49ab912904f00663f113289f546084925.camel@redhat.com>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oiOZZXabyrpUECW84e7bty-NgpX5ewIM4NDmsKc5cmk_1780112020
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-21 at 18:48 -0500, Crystal Wood wrote:
> On Wed, 2026-05-20 at 16:28 -0400, Steven Rostedt wrote:
> > [ Replying to Sashiko: https://sashiko.dev/?list=3Dorg.kernel.vger.linu=
x-trace-kernel#/patchset/20260511223035.1475676-1-crwood%40redhat.com ]
> >=20
> > > > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osno=
ise.c
> > > > index 75678053b21c5..2be188768ab42 100644
> > > > --- a/kernel/trace/trace_osnoise.c
> > > > +++ b/kernel/trace/trace_osnoise.c
> > > > @@ -83,6 +83,22 @@ struct osnoise_instance {
> > > > =20
> > > >  static struct list_head osnoise_instances;
> > > > =20
> > > > +static void osnoise_print(const char *fmt, ...)
> > > > +{
> > > > +=09struct osnoise_instance *inst;
> > > > +=09struct trace_array *tr;
> > > > +=09va_list ap;
> > > > +
> > > > +=09rcu_read_lock();
> > > > +=09list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> > > > +=09=09tr =3D inst->tr;
> > > > +=09=09va_start(ap, fmt);
> > > > +=09=09trace_array_vprintk(tr, _RET_IP_, fmt, ap);
> >=20
> > > Does this code create a use-after-free on the trace array if an insta=
nce is
> > > removed concurrently?
>=20
> If so, it was already an issue with osnoise_taint(),
> osnoise_stop_tracing(), osnoise_stop_exception(), etc.  Wouldn't be
> surprising, as this file has a number of other synchronization issues as
> well.

It looks like it's actually also an issue in a bunch more places such as
record_osnoise_sample(), timerlat_dump_stack(), etc.

> > > When a user deletes a trace instance via rmdir, the unregister functi=
on
> > > removes the instance from the list using list_del_rcu(). However, the=
 removal
> > > routine does not appear to wait for an RCU grace period before freein=
g the
> > > trace array itself.
> > > Could a concurrent execution of this loop inside the rcu_read_lock() =
section
> > > still access the unlinked instance, read the freed inst->tr, and pass=
 it to
> > > trace_array_vprintk()? This appears to be an existing issue, but it s=
till
> > > affects the loop here.
> >=20
> > Hmm, this is interesting. osnoise keeps track of its own instances via =
a
> > osnoise_instances list. But it only use kfree_rcu() to free the list
> > descriptor but doesn't take care of the tr being freed before hand!
> >=20
> > Something like this could work [not even compiled]
> >=20
> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.=
c
> > index 75678053b21c..bda1e0e0d2e1 100644
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
> > @@ -476,8 +476,11 @@ static void print_osnoise_headers(struct seq_file =
*s)
> >  =09=09=09=09=09=09=09=09=09=09\
> >  =09rcu_read_lock();=09=09=09=09=09=09=09\
> >  =09list_for_each_entry_rcu(inst, &osnoise_instances, list) {=09=09\
> > +=09=09if (trace_array_get(inst->tr) < 0)=09=09=09=09\
> > +=09=09=09continue;=09=09=09=09=09=09\
> >  =09=09buffer =3D inst->tr->array_buffer.buffer;=09=09=09=09\
> >  =09=09trace_array_printk_buf(buffer, _THIS_IP_, msg);=09=09=09\
> > +=09=09trace_array_put(inst->tr);=09=09=09=09=09\
> >  =09}=09=09=09=09=09=09=09=09=09\
> >  =09rcu_read_unlock();=09=09=09=09=09=09=09\
> >  =09osnoise_data.tainted =3D true;=09=09=09=09=09=09\
>=20
> OK, I'll prepare a v3.

Many osnoise_taint() callers, as well as timerlat_dump_stack(), can have
preemption disabled, so the mutex in trace_array_get() won't work.

What is the intended way for a tracer to record to all of its
instances?  I tried looking at other tracers that allow instances, but
it seems that most of them only allow one instance, apart from
trace_function/trace_function_graph that are driven by a callback
mechanism that doesn't fit here, and that made my brain hurt when I
dove into the code to try to figure out how it ensures a valid tr.

We could have osnoise_unregister_instance() set inst->tr =3D NULL
under a raw lock, and then require users to hold the raw lock when
manipulating inst->tr (which can't go away until ->stop() completes),
skipping any that are NULL.

It's not great that we lose the ability to do things with tr that are
incompatible with a raw lock, but I don't know how to fix that without
something like changing the tr refcount mechanism to allow an atomic
refcount increase on a known-valid-for-now tr.  It looks like all the
current users of this list are OK with a raw lock.

We could go even further and simplify by un-RCUing the list, requiring
that the raw lock be held over traversal -- I'm not thrilled at the
idea of letting userspace create unbounded instances that are traversed
with preemption disabled, but as noted, we already do that in some places.

In any case, this patch is just moving the code around, not introducing
the problem, so I hope that whatever synchronization overhaul this file
requires (which goes well beyond this one issue) can wait for followup
patches.

-Crystal

