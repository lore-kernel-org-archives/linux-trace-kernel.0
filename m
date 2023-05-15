Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4BC77B7D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 15 May 2023 18:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbjEOSCJ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 15 May 2023 14:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242467AbjEOSBb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F6313C00
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 May 2023 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684173422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qymjO9PUusO9BZPNaA/6iVZ5Rozh7oDjfMxnGEMSH6A=;
        b=JBnB5YCtlWDOifxjKWHztmlg9tveDi1F6IVAo4ZJmYff3O0B1EjnuJOPqFYBGu/eKnKNFc
        KRjkf7N+K+K/m5fff5ClafERvGxh3HRgva+rs13PwcCES473MQfbelIYM85uejs18JIjMS
        grfuKmKaJ8frHRt+vrUymTdHVJ68tdA=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-pf_yQzIjNNGuZkI90vf8Mg-1; Mon, 15 May 2023 13:57:01 -0400
X-MC-Unique: pf_yQzIjNNGuZkI90vf8Mg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-192486192fbso8220563fac.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 May 2023 10:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684173419; x=1686765419;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AxRKUz43mkyWHnl3hhc85iFtDBgXfNEcSSyxnUZSGk=;
        b=XjEBN5wWHLsWe1ilEz5Uy0IZrH+I+TRJJRHQsZomg+7U3TmoObNTlJFNMwye4zqGga
         Kp9DUDJXJGwAPudHCPfMC+xghi9hojCgiaH3gh8oFEdeDz6q4oHIYWt83C5gHV6/L2+b
         rNFvnqlJaq6WiTYJ0MHKi5fifWBQYBkeIGgF+FW2ipi3E0wLb4x2QmFGNMeIEni9cQ7+
         iy72jpK2933K5GxgNBHsmNFf8PwG34xcYoibc0WNdkcTkgVhwoxtC7dd3/ATgOEPom4y
         r4Cg7W4JQSvBm/87x8HQMD3NHQuCuH8oO39gl1gDGxT81FinFeTepUEScyrp1vG2a1Js
         xfug==
X-Gm-Message-State: AC+VfDwAYajM+f319KH5icIt8kGRL1JYh2ZA8huysklSw1/Q1AzwPzh1
        4HNnUXHZuwQlcDZitr+v8h0hmlvAU3/f1P3w+A+KKNEf/As47Q66ZrP/y4wdN5+Etptgu7eGjbp
        5gkBWMvd9Zvw1R1ic2jkEYGgMSGSGS70U
X-Received: by 2002:a05:6870:a8ac:b0:187:b836:4d33 with SMTP id eb44-20020a056870a8ac00b00187b8364d33mr16272167oab.30.1684173419052;
        Mon, 15 May 2023 10:56:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MnfqueXLdJ6vZqBxL7+2U0zreUXrURbrDpvt+0D82wLc+J7YxbrsaXtWgvNHkuh5Hof4oiA==
X-Received: by 2002:a05:6870:a8ac:b0:187:b836:4d33 with SMTP id eb44-20020a056870a8ac00b00187b8364d33mr16272148oab.30.1684173418667;
        Mon, 15 May 2023 10:56:58 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3? ([2804:1b3:a803:46cc:5b68:5c23:dd7a:8cb3])
        by smtp.gmail.com with ESMTPSA id g5-20020a05687085c500b00187e500e7b3sm12185025oal.49.2023.05.15.10.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 10:56:58 -0700 (PDT)
Message-ID: <27e4a2b4557ae24e673b6fb85b34fe0e32efa06f.camel@redhat.com>
Subject: Re: [RFC PATCH v3 1/1] trace,smp: Add tracepoints around remotelly
 called functions
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date:   Mon, 15 May 2023 14:56:53 -0300
In-Reply-To: <xhsmhsfc3i1bc.mognet@vschneid.remote.csb>
References: <20230510230128.150384-1-leobras@redhat.com>
         <xhsmhsfc3i1bc.mognet@vschneid.remote.csb>
User-Agent: Evolution 3.48.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 2023-05-11 at 11:56 +0100, Valentin Schneider wrote:
> On 10/05/23 20:01, Leonardo Bras wrote:
> > When running RT workloads in isolated CPUs, many cases of deadline miss=
es
> > are caused by remote CPU requests such as smp_call_function*().
> >=20
> > For those cases, having the names of those functions running around the
> > deadline miss moment could help (a lot) finding a target for the next
> > improvements.
> >=20
> > Add tracepoints for acquiring the function name & csd before entry and
> > after returning from the remote-cpu requested function.
> >=20
> > Also, add tracepoints on the remote cpus requesting them.
>=20
> Per the v1 thread, I got some context as to why we want this, but this
> changelog is quite sparse on the subject. How about:
>=20
> """
> The recently added ipi_send_{cpu,cpumask} tracepoints allow finding sourc=
es
> of IPIs targeting CPUs running latency-sensitive applications.
>=20
> For NOHZ_FULL CPUs, all IPIs are interference, and those tracepoints are
> sufficient to find them and work on getting rid of them. In some setups
> however, not *all* IPIs are to be suppressed, but long-running IPI
> callbacks can still be problematic.
>=20
> Add a pair of tracepoints to mark the start and end of processing a CSD I=
PI
> callback, similar to what exists for softirq, workqueue or timer callback=
s.
> """
>=20
> And you can probably split the csd_queue_cpu TP into a separate commit,
> with something along the lines of:
>=20
> """
> Add a tracepoint for when a CSD is queued to a remote CPU's
> call_single_queue. This allows finding exactly which CPU queued a given C=
SD
> when looking at a csd_function_{entry,exit} event, and also enables us to
> accurately measure IPI delivery time with e.g. a synthetic event:
>=20
>   $ echo 'hist:keys=3Dcpu,csd.hex:ts=3Dcommon_timestamp.usecs' >\
>       /sys/kernel/tracing/events/smp/csd_queue_cpu/trigger
>   $ echo 'csd_latency unsigned int dst_cpu; unsigned long csd; u64 time' =
>\
>       /sys/kernel/tracing/synthetic_events
>   $ echo \
>   'hist:keys=3Dcommon_cpu,csd.hex:'\
>   'time=3Dcommon_timestamp.usecs-$ts:'\
>   'onmatch(smp.csd_queue_cpu).trace(csd_latency,common_cpu,csd,$time)' >\
>       /sys/kernel/tracing/events/smp/csd_function_entry/trigger
>=20
>   $ trace-cmd record -e 'synthetic:csd_latency' hackbench
>   $ trace-cmd report
>   <...>-467   [001]    21.824263: csd_queue_cpu:        cpu=3D0 callsite=
=3Dtry_to_wake_up+0x2ea func=3Dsched_ttwu_pending csd=3D0xffff8880076148b8
>   <...>-467   [001]    21.824280: ipi_send_cpu:         cpu=3D0 callsite=
=3Dtry_to_wake_up+0x2ea callback=3Dgeneric_smp_call_function_single_interru=
pt+0x0
>   <...>-489   [000]    21.824299: csd_function_entry:   func=3Dsched_ttwu=
_pending csd=3D0xffff8880076148b8
>   <...>-489   [000]    21.824320: csd_latency:          dst_cpu=3D0, csd=
=3D18446612682193848504, time=3D36
> """

Sure, I will split the patch and add the commit msg as suggested.


>=20
> >=20
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
>=20
> Overall I like the CSD vs IPI split, it's a saner approach than logging i=
t
> all as IPIs, even if it does generate more events as we have to emit an
> event for every csd queued (i.e. no _cpumask() variant is possible).
>=20
> Some nitpicks below, and one other thing: are we happy with the smp event
> namespace, and with the new TP names? Should the namespace be csd instead=
,
> to match the trace_<namespace>_* nomenclature?

I selected "smp.h" filename because those tracepoints are getting used on s=
mp.c.

I think keeping a generic name is good for any future tracepoints people en=
d up
designing for smp.c, but I am open to discussion.

>=20
> > ---
> >=20
> > Changes since RFCv2:
> > - Fixed some spacing issues and trace calls
> >=20
> > Changes since RFCv1:
> > - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
> > - Using EVENT_CLASS in order to avoid duplication
> > - Introduced new helper: csd_do_func()
> > - Name change from smp_call_function_* to csd_function_*
> > - Rebased on top of torvalds/master
> >=20
> >  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
> >  kernel/smp.c               | 41 +++++++++++++---------
> >  2 files changed, 96 insertions(+), 17 deletions(-)
> >  create mode 100644 include/trace/events/smp.h
> >=20
> > diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
> > new file mode 100644
> > index 000000000000..c304318a0203
> > --- /dev/null
> > +++ b/include/trace/events/smp.h
> > @@ -0,0 +1,72 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM smp
> > +
> > +#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_SMP_H
> > +
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(csd_queue_cpu,
> > +
> > +=09TP_PROTO(const unsigned int cpu,
> > +=09=09 unsigned long callsite,
> > +=09=09 smp_call_func_t func,
> > +=09=09 call_single_data_t *csd),
> > +
> > +=09TP_ARGS(cpu, callsite, func, csd),
> > +
> > +=09TP_STRUCT__entry(
> > +=09=09__field(unsigned int, cpu)
> > +=09=09__field(void *, callsite)
> > +=09=09__field(void *, func)
> > +=09=09__field(void *, csd)
> > +=09),
> > +
> > +=09TP_fast_assign(
> > +=09=09__entry->cpu =3D cpu;
> > +=09=09__entry->callsite =3D (void *)callsite;
> > +=09=09__entry->func =3D func;
> > +=09=09__entry->csd  =3D csd;
> > +=09),
> > +
> > +=09TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
>                                        ^^^^^^^^
> This can be func=3D%ps, offsets should always be 0 so not very useful (I =
know
> I put %pS for the IPI TPs, that's a force of habit...)
>=20

I agree, let's do as suggested.

> > +=09=09  __entry->cpu, __entry->callsite, __entry->func, __entry->csd)
> > +);
>=20
> > +
> > +/*
> > + * Tracepoints for a function which is called as an effect of smp_call=
_function.*
> > + */
> > +DECLARE_EVENT_CLASS(csd_function,
> > +
> > +=09TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> > +
> > +=09TP_ARGS(func, csd),
> > +
> > +=09TP_STRUCT__entry(
> > +=09=09__field(void *,=09func)
> > +=09=09__field(void *,=09csd)
> > +=09),
> > +
> > +=09TP_fast_assign(
> > +=09=09__entry->func=09=3D func;
> > +=09=09__entry->csd=09=3D csd;
> > +=09),
> > +
> > +=09TP_printk("function %ps, csd =3D %p", __entry->func, __entry->csd)
>=20
> To match the style of the other TPs, that should be:
>=20
>         TP_printk("func=3D%ps csd=3D%p", __entry->func, __entry->csd)
>=20

Done!


Thanks for reviewing!
Leo

