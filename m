Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA63859FA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407341; cv=none; b=E3cafDvqw3xJud8ssab9pLyzOXyVMgwdH7iNIjonHn6v4YwrUc1frYiUmoJkzwC9B4VbJkeeLbbYkT+PxOLOyeLV5HGHHOVXWGuDvxuPGFqETL3Vr7RXSkzwihWYCOUlrXCgawUKARK7WbrN21z8vwd/srU+BMxj5lu0Cx1wTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407341; c=relaxed/simple;
	bh=EaY1vV68VobVf2ItM/llNt7Lon15UzQ6ByYx/LmMwNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAFjimcMtCnxwcDsJu58tUOyb9NnOeZuwEDjTsOT5P6CJ7nksZeBXJFns7jYtQPUzjVpY/vMP4HSV+OrOQBPP6HRjSdbtup1iWiXqLGpEJ/txWJOMMtg+PgLvAw8fwcxwnAtaoy6S7bO08rgv3xHRSM6S7RmVd+/zT46VcqAu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRFqtbWa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRFqtbWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779407325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8cJdETtqckVbOAFOQNlRpjMEoy2KAMuDd8RLGgp2wc=;
	b=YRFqtbWakHt5h0b7EM/rFiVVo18Yihr5HrA2WJb10lnL4LAzPC0/pHsp/ePA+JjuHKNhoq
	ECHJJZaE5Tl31cnxASPovNw5eoegOdGPK1OpKPxMFMYAGZoSW/rOAJNybxllLyU8GW+Yty
	QQfH0R00gHskFstVWgGhGNHiD35JSDk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-Air4Kxg4PxWTWziY__oIpQ-1; Thu, 21 May 2026 19:48:42 -0400
X-MC-Unique: Air4Kxg4PxWTWziY__oIpQ-1
X-Mimecast-MFC-AGG-ID: Air4Kxg4PxWTWziY__oIpQ_1779407321
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-914385ef371so1343956285a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 16:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779407321; x=1780012121;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt4vn/YPrdmVNLXRtgxHHbPT36tdnBWP5ruICQlDgsY=;
        b=KePwDy21kX6BPJ9VcQ+DNfrMaEvL2Luk/fgNC+sCz00jBGAISYDQuJibbI3vyNr8kI
         k2xt5nQy2gAMvOWtH4pT1g3l+5OW7/ejAZKqdxfGnf2y6kNRyuNxhtr56Q3UL5vAYd/M
         PeLQythXZT26smsNpk2g9A4dtT/aMMpLkohIl0qrqgEqXsfprf25o/Rz31Rs853HHxv5
         ZtYSdE/dztNPsNML9YFIY2ND3WwmzgszNorm5aDD/pY+3Ch+hUg0vs7cZWzZludRMDC5
         cwadoyUlb3AxkWywU4rqdy1R+ppbgoT0zfeNDnXmwdbYAwNR9hk8cNLKz1hscV/FS+jI
         75Zw==
X-Gm-Message-State: AOJu0Yx9eAS9a7eM6KynBBxQjic1yendZqCw5oeTT+f0CnbHcPcwCLYd
	iOZOo52G9McGse+fRxmso0BuILonQix+22xVR5TSCpQGWSqi2keSuDpgjEE39dxadbUagvd77GI
	YbSoj9wq5pzmoYcXOrt3w9G6AGA67LWqbE8faWyhWv3zLlk2tURI6qIxpaKWaIRlr8Z+snZ9POB
	NhrDK+Vw==
X-Gm-Gg: Acq92OG3fajrKHiAQBECMrBnWONKbNHv477CHEDLxD2axu69S96eA3/lC+KzBCYSIIW
	tYLbjOIutOSjiY4ko9PibPdCphISAGlmLChDM8VGdP29yVGb1AN1QluLsBt6GJrG5f8sCDHBw1E
	+GxKv6+FefTWs3WcgHnf/4hGH5OktXSMZlu7wNaRI8LRQcvMmk64Egb4m4eCHSRDIb3axEbDfRZ
	oLh4giffIyd6xujXxBXO3CtgTJ08N0mOtImv/rPgOr1sBnXMpSCM4ZAOdK/Ue9hmlGQ6zo9Z8sj
	TAL1peWXqbuPr2Uxb4SG5VRXEZwqSRFSAQd+NLBLIf8EFBQ+pX4P9LHcwKz+CnvsGtuLSFXV8HA
	wdAJsMfJtJvfuqIsPBcb+M2lCFXbw5wFoVVuGXSHmr5qlgf1e8a+H9tfToXTpJmyT
X-Received: by 2002:a05:620a:462c:b0:910:f8b4:8614 with SMTP id af79cd13be357-914b51668bdmr150680285a.31.1779407321167;
        Thu, 21 May 2026 16:48:41 -0700 (PDT)
X-Received: by 2002:a05:620a:462c:b0:910:f8b4:8614 with SMTP id af79cd13be357-914b51668bdmr150677585a.31.1779407320723;
        Thu, 21 May 2026 16:48:40 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914b5ffb74fsm40342485a.31.2026.05.21.16.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:48:40 -0700 (PDT)
Message-ID: <0c6606c49ab912904f00663f113289f546084925.camel@redhat.com>
Subject: Re: [PATCH v2] tracing/osnoise: Array printk init and cleanup
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
 Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Date: Thu, 21 May 2026 18:48:39 -0500
In-Reply-To: <20260520162810.3112a9d6@gandalf.local.home>
References: <20260511223035.1475676-1-crwood@redhat.com>
	 <20260520162810.3112a9d6@gandalf.local.home>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rJZx87GffYMcaJWJB_P7TYgLy8G4Y0_31_llyR-lXPI_1779407321
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-05-20 at 16:28 -0400, Steven Rostedt wrote:
> [ Replying to Sashiko: https://sashiko.dev/?list=3Dorg.kernel.vger.linux-=
trace-kernel#/patchset/20260511223035.1475676-1-crwood%40redhat.com ]
>=20
> > commit 859dc1eded9e36304f27e72643f28f30f327f078
> > Author: Crystal Wood <crwood@redhat.com>
> > tracing/osnoise: Array printk init and cleanup
> > This commit initializes the trace array buffer for osnoise instances on
> > creation. It also introduces the osnoise_print() helper function and sw=
itches
> > the tracer to use trace_array_printk() instead of trace_array_printk_bu=
f().
> > > Use trace_array_printk() instead of trace_array_printk_buf(), as we'r=
e
> > > only writing to the main buffer (of a non-main instance) anyway -- an=
d
>=20
> > Is this description accurate? Can the osnoise tracer also be enabled on=
 the
> > global trace array, for example by writing to current_tracer?
> > If it is used on the global instance, trace_array_init_printk() explici=
tly
> > returns -EINVAL and refuses to allocate a buffer, and trace_array_print=
k()
> > will return 0 without printing.
>=20
> Hmm, I guess it would drop any of these prints if it's using the top leve=
l
> trace array. But I believe this is for use with RTLA which always creates=
 a
> trace instance.

It doesn't *have* to be used with rtla, but you won't get the printks if
you use the main instance.  The parenthetical was just meant to avoid
potential misunderstanding of the phrase "main buffer".

> > > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnois=
e.c
> > > index 75678053b21c5..2be188768ab42 100644
> > > --- a/kernel/trace/trace_osnoise.c
> > > +++ b/kernel/trace/trace_osnoise.c
> > > @@ -83,6 +83,22 @@ struct osnoise_instance {
> > > =20
> > >  static struct list_head osnoise_instances;
> > > =20
> > > +static void osnoise_print(const char *fmt, ...)
> > > +{
> > > +=09struct osnoise_instance *inst;
> > > +=09struct trace_array *tr;
> > > +=09va_list ap;
> > > +
> > > +=09rcu_read_lock();
> > > +=09list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> > > +=09=09tr =3D inst->tr;
> > > +=09=09va_start(ap, fmt);
> > > +=09=09trace_array_vprintk(tr, _RET_IP_, fmt, ap);
>=20
> > Does this code create a use-after-free on the trace array if an instanc=
e is
> > removed concurrently?

If so, it was already an issue with osnoise_taint(),
osnoise_stop_tracing(), osnoise_stop_exception(), etc.  Wouldn't be
surprising, as this file has a number of other synchronization issues as
well.

> > When a user deletes a trace instance via rmdir, the unregister function
> > removes the instance from the list using list_del_rcu(). However, the r=
emoval
> > routine does not appear to wait for an RCU grace period before freeing =
the
> > trace array itself.
> > Could a concurrent execution of this loop inside the rcu_read_lock() se=
ction
> > still access the unlinked instance, read the freed inst->tr, and pass i=
t to
> > trace_array_vprintk()? This appears to be an existing issue, but it sti=
ll
> > affects the loop here.
>=20
> Hmm, this is interesting. osnoise keeps track of its own instances via a
> osnoise_instances list. But it only use kfree_rcu() to free the list
> descriptor but doesn't take care of the tr being freed before hand!
>=20
> Something like this could work [not even compiled]
>=20
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 75678053b21c..bda1e0e0d2e1 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -476,8 +476,11 @@ static void print_osnoise_headers(struct seq_file *s=
)
>  =09=09=09=09=09=09=09=09=09=09\
>  =09rcu_read_lock();=09=09=09=09=09=09=09\
>  =09list_for_each_entry_rcu(inst, &osnoise_instances, list) {=09=09\
> +=09=09if (trace_array_get(inst->tr) < 0)=09=09=09=09\
> +=09=09=09continue;=09=09=09=09=09=09\
>  =09=09buffer =3D inst->tr->array_buffer.buffer;=09=09=09=09\
>  =09=09trace_array_printk_buf(buffer, _THIS_IP_, msg);=09=09=09\
> +=09=09trace_array_put(inst->tr);=09=09=09=09=09\
>  =09}=09=09=09=09=09=09=09=09=09\
>  =09rcu_read_unlock();=09=09=09=09=09=09=09\
>  =09osnoise_data.tainted =3D true;=09=09=09=09=09=09\

OK, I'll prepare a v3.

> > > @@ -1189,10 +1198,10 @@ static __always_inline void osnoise_stop_exce=
ption(char *msg, int cpu)
> > >  =09rcu_read_lock();
> > >  =09list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> > >  =09=09tr =3D inst->tr;
> > > -=09=09trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
> > > -=09=09=09=09       "stop tracing hit on cpu %d due to exception: %s\=
n",
> > > -=09=09=09=09       smp_processor_id(),
> > > -=09=09=09=09       msg);
> > > +=09=09trace_array_printk(tr, _THIS_IP_,
> > > +=09=09=09=09   "stop tracing hit on cpu %d due to exception: %s\n",
> > > +=09=09=09=09   smp_processor_id(),
> > > +=09=09=09=09   msg);
>=20
> > Does this switch to trace_array_printk() silently drop messages when tr=
acing
> > on the global instance?
> > Looking at trace_array_printk(), it explicitly returns 0 if the
> > TRACE_ARRAY_FL_GLOBAL flag is set on the trace array:
> > kernel/trace/trace_printk.c:trace_array_printk() {
> >     ...
> > =09if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
> > =09=09return 0;
> >     ...
> > }
> > This means stop and exception logs would be discarded if the tracer is
> > running on the global instance.
>=20
> Yep. But maybe that's not an issue?

I'd actually consider it a fix, if the policy is actually about not
allowing tracers to "spam" the main instance, rather than just avoiding
the percpu allocation.  Especially for osnoise_stop_exception(), which
is called only one place, that already printed the same message with
osnoise_taint(). :-P

As I mentioned in the v1 patch, if trace_array_printk_buf() is going to
bypass the global instance check, should probably be internal to the
core trace code.

-Crystal

