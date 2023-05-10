Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29733C77B7D
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 10 May 2023 20:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbjEJU21 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 10 May 2023 16:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjEJU20 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD84C12
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 May 2023 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683750456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nv0DavZHzZ5p/wUdxoEPxOI+8uSA5PDGpnh2Hw9aExo=;
        b=H/WrOMKcD5eW+eHgGjenUa81PKImVzaaGCAfsb5xfmGHsXe1ZHwMvYq7KreCwA8M0eXOjc
        4o4fztr/8ehKbu/gXRU+cdWPWjQwuB4EswP+TLfLnwAT1bt16uEjqoEugSTeSW5fkGrPLK
        J6pSyvRylsNsBa/yB8RE6TehaAFHHQ8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-9zqvtKGpMKaIlqZ-OMe43Q-1; Wed, 10 May 2023 16:27:35 -0400
X-MC-Unique: 9zqvtKGpMKaIlqZ-OMe43Q-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6ab389bd0e4so755333a34.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 May 2023 13:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683750454; x=1686342454;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6t0uwhXM8LP+yxd68T/L0PMOcquVZp/F/3y9ewickU=;
        b=aImrI+IOr2N8DHr+qDqMtcV8/5FhxuDrHaNB2+U3xxAtiytAsJXgJJ9JVO2cn3tYHa
         lmQa/4f+wAhgGWQmhUceOPS2++RO6FV+LlBehZ9pi1gUUjzDEbnrQOw/MJVX7WNuaYOX
         a7AkDJVV0Qr0WNTE8WN+/JcFO11hanH8tLpH7fK/6ujbjiRLDYK7jUGi6LCHyVwAM6sE
         Ig2h4NpE9E36YVJ6o8zbPn1ppdNLWgWyLqagHo5bcgvhCok1DUIoCWmNNHjEz8kBO/f1
         tw0vO4yq/lDWYY2cOaddQb6JbRaoHnk9NyW+ZRSIKiVNj6teFgFDOpDBBXhIkQ0QgLT0
         cN5A==
X-Gm-Message-State: AC+VfDw3SWrt/ZrVgQC4ZEjBp2ylLkTygNnrDjEJmRPy//6DinaM2gnW
        1X6CP5EiC9fmhe7Hyy9PeJMSiXLqrxEEgYvolgnTmP7miFlFmXw7PKp08s3grrh0c8y6G8pencw
        DiDsyr5ufvL3OmSSVe6Fa3+3JP7K4sWL9
X-Received: by 2002:a05:6830:1e55:b0:6ab:b4e:8337 with SMTP id e21-20020a0568301e5500b006ab0b4e8337mr3453424otj.8.1683750454181;
        Wed, 10 May 2023 13:27:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6gSG8Cn3TGMgViFum8yITL8dsIGl5p6kQC2Vph9UBCHl8XLi9tKVFEJmMwRGbvhHP1CXz2Pw==
X-Received: by 2002:a05:6830:1e55:b0:6ab:b4e:8337 with SMTP id e21-20020a0568301e5500b006ab0b4e8337mr3453416otj.8.1683750453830;
        Wed, 10 May 2023 13:27:33 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:3602:abec:117:3c19:43b8? ([2804:1b3:a803:3602:abec:117:3c19:43b8])
        by smtp.gmail.com with ESMTPSA id e7-20020a05683013c700b006a3bd777dfdsm6630725otq.12.2023.05.10.13.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:27:32 -0700 (PDT)
Message-ID: <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Date:   Wed, 10 May 2023 17:27:26 -0300
In-Reply-To: <xhsmh7ctojoia.mognet@vschneid.remote.csb>
References: <20230406075718.68672-1-leobras@redhat.com>
         <20230406095519.GG386572@hirez.programming.kicks-ass.net>
         <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
         <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
         <xhsmh7ctojoia.mognet@vschneid.remote.csb>
User-Agent: Evolution 3.48.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 2023-05-04 at 12:59 +0100, Valentin Schneider wrote:
> +Daniel
>=20
> On 03/05/23 16:59, Peter Zijlstra wrote:
> > On Wed, Apr 19, 2023 at 12:45:08AM -0300, Leonardo Br=C3=A1s wrote:
> > >=20
> > > IIUC the last commits add tracepoints that are collected in the
> > > requesting CPU, at the moment of scheduling the IPI, which are also u=
seful in
> > > some scenarios.
> > >=20
> > > On my scenario, it could help a little,=C2=A0since it makes possible =
to filter what
> > > all other cpus are scheduling on the requested cpu. OTOH it could be =
also be
> > > misleading, as the requested cpu could be running something that was =
scheduled
> > > way before.
> > >=20
> > > The change I propose does exactly what my scenario need: track exactl=
y which
> > > function was running at given time in the requested CPU. With this in=
fo, we can
> > > check which (if any) remotely requested function was running on given=
 time
> > > window.
> >=20
> > I was thinking you could simply (graph)-trace
> > __flush_smp_call_function_queue() with a max_graph_depth or so (Steve
> > says that ought to work).
> >=20
> > But even that might be too specific, your use case sounds more like wha=
t
> > we have the irq-off latency tracer for, and that thing will immediately
> > tell you what functions were being ran.
> >=20
> > > (An unrelated thing I just thought: We could even use the commits you=
 pointed
> > > together with my proposed change in order to measure how long does it=
 take for a
> > > requested function to run / complete in the requested cpu)
> >=20
> > I don't think you could actually do that; the send tracepoints Valentin
> > added don't log the csd address, this means you cannot distinguish
> > two CSDs with the same function send from different CPUs.
> >=20
> > To do this you'd need to add the csd address to the the ipi_send
> > tracepoints and your own (possibly replacing info -- because I don't
> > think that's too useful).
> >=20
> > Valentin -- is any of this something you'd also find useful?
>=20
> Conceptually yeah, however:
>=20
> With isolcpus + NOHZ_FULL, *any* IPI sent to an isolated CPU is game over=
,
> you interrupt the userspace task and you eat the full meal that is
> NOHZ_FULL kernel entry. Pretty much any such IPI will show up when
> evaluating your setup with rteval/rlta/whatever, so having an event at
> IPI reception is redundant.
>=20
> IIUC Leonardo's looking at a setup with isolcpus but not necessarily
> NOHZ_FULL, so he wants to look at *which* IPIs (if any) are pushing the
> isolated task over its deadline/period. I would argue any IPI received
> there is at risk of doing that, so it's the same fight as with NOHZ_FULL.
>=20
> With that said, I suppose this could still be helpful for e.g. osnoise to
> hook into and point the finger at which CPU/context sent the problematic
> IPI. Or more generally, as Leonardo suggested, to measure CSD IPI deliver=
y
> times.
>=20
> One thing though is that trace_ipi_send_cpu*() is not used solely for
> CSD's, cf. irq_work_raise() or smp_send_reschedule(). We might want to
> split that into e.g. trace_csd_queue_cpu*() + trace_ipi_send*().
>=20
> Something like so...
>=20
> ---
> diff --git a/include/trace/events/smp.h b/include/trace/events/smp.h
> new file mode 100644
> index 0000000000000..8fc725a2b45b9
> --- /dev/null
> +++ b/include/trace/events/smp.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM smp
> +
> +#if !defined(_TRACE_SMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SMP_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(csd_queue_cpu,
> +
> +=09TP_PROTO(const unsigned int cpu,
> +=09=09 unsigned long callsite,
> +=09=09 smp_call_func_t func,
> +=09=09 call_single_data_t *csd),
> +
> +=09TP_ARGS(cpu, callsite, func, csd),
> +
> +=09TP_STRUCT__entry(
> +=09=09__field(unsigned int, cpu)
> +=09=09__field(void *, callsite)
> +=09=09__field(void *, func)
> +=09=09__field(void *, csd)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__entry->cpu =3D cpu;
> +=09=09__entry->callsite =3D (void *)callsite;
> +=09=09__entry->func =3D func;
> +=09=09__entry->csd  =3D csd;
> +=09),
> +
> +=09TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
> +=09=09  __entry->cpu, __entry->callsite, __entry->func, __entry->csd)
> +);

This is for the caller side, right?

> +
> +DECLARE_EVENT_CLASS(csd_function,
> +
> +=09TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> +
> +=09TP_ARGS(func, csd),
> +
> +=09TP_STRUCT__entry(
> +=09=09__field(void *,=09func)
> +=09=09__field(void *,=09csd)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__entry->func=09=3D func;
> +=09=09__entry->csd=09=3D csd;
> +=09),
> +
> +=09TP_printk("func=3D%pS csd=3D%p", __entry->func, __entry->csd)
> +);
> +
> +DEFINE_EVENT(csd_function, csd_function_entry,
> +=09TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> +=09TP_ARGS(func, csd)
> +);
> +
> +DEFINE_EVENT(csd_function, csd_function_exit,
> +=09TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> +=09TP_ARGS(func, csd)
> +);

Oh, this is what event_class is for. Thanks for the example :)

> +
> +#endif /* _TRACE_SMP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/smp.c b/kernel/smp.c
> index ab3e5dad6cfe9..7d28db303e9bc 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -27,6 +27,9 @@
>  #include <linux/jump_label.h>
> =20
>  #include <trace/events/ipi.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/smp.h>
> +#undef CREATE_TRACE_POINTS
> =20
>  #include "smpboot.h"
>  #include "sched/smp.h"
> @@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
>  =09arch_send_call_function_ipi_mask(mask);
>  }
> =20
> +static __always_inline void
> +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
> +{
> +=09trace_csd_function_entry(func, csd);
> +=09func(info);
> +=09trace_csd_function_exit(func, csd);
> +}
> +

Good one, a helper to avoid calling those traces everywhere.=20

Honest question:=C2=A0
Since info =3D=3D csd->info and func =3D=3D csd->func, we could just pass c=
sd, right?
I suppose the suggestion on the 3-argument version is to use the values alr=
eady
fetched from memory instead of fetching them again. Is that correct?

>  #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> =20
>  static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlo=
ck_debug_enabled);
> @@ -329,7 +340,7 @@ void __smp_call_single_queue(int cpu, struct llist_no=
de *node)
>  =09 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
>  =09 * executes migration_cpu_stop() on the remote CPU).
>  =09 */
> -=09if (trace_ipi_send_cpu_enabled()) {
> +=09if (trace_csd_queue_cpu_enabled()) {
>  =09=09call_single_data_t *csd;
>  =09=09smp_call_func_t func;
> =20
> @@ -337,7 +348,7 @@ void __smp_call_single_queue(int cpu, struct llist_no=
de *node)
>  =09=09func =3D CSD_TYPE(csd) =3D=3D CSD_TYPE_TTWU ?
>  =09=09=09sched_ttwu_pending : csd->func;
> =20
> -=09=09trace_ipi_send_cpu(cpu, _RET_IP_, func);
> +=09=09trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
>  =09}
> =20
>  =09/*
> @@ -375,7 +386,7 @@ static int generic_exec_single(int cpu, struct __call=
_single_data *csd)
>  =09=09csd_lock_record(csd);
>  =09=09csd_unlock(csd);
>  =09=09local_irq_save(flags);
> -=09=09func(info);
> +=09=09csd_do_func(func, info, NULL);
>  =09=09csd_lock_record(NULL);
>  =09=09local_irq_restore(flags);
>  =09=09return 0;
> @@ -477,7 +488,7 @@ static void __flush_smp_call_function_queue(bool warn=
_cpu_offline)
>  =09=09=09}
> =20
>  =09=09=09csd_lock_record(csd);
> -=09=09=09func(info);
> +=09=09=09csd_do_func(func, info, csd);
>  =09=09=09csd_unlock(csd);
>  =09=09=09csd_lock_record(NULL);
>  =09=09} else {
> @@ -508,7 +519,7 @@ static void __flush_smp_call_function_queue(bool warn=
_cpu_offline)
> =20
>  =09=09=09=09csd_lock_record(csd);
>  =09=09=09=09csd_unlock(csd);
> -=09=09=09=09func(info);
> +=09=09=09=09csd_do_func(func, info, csd);
>  =09=09=09=09csd_lock_record(NULL);
>  =09=09=09} else if (type =3D=3D CSD_TYPE_IRQ_WORK) {
>  =09=09=09=09irq_work_single(csd);
> @@ -522,8 +533,10 @@ static void __flush_smp_call_function_queue(bool war=
n_cpu_offline)
>  =09/*
>  =09 * Third; only CSD_TYPE_TTWU is left, issue those.
>  =09 */
> -=09if (entry)
> -=09=09sched_ttwu_pending(entry);
> +=09if (entry) {
> +=09=09csd =3D llist_entry(entry, typeof(*csd), node.llist);
> +=09=09csd_do_func(sched_ttwu_pending, entry, csd);
> +=09}
>  }
> =20
> =20
> @@ -624,7 +637,7 @@ EXPORT_SYMBOL(smp_call_function_single);
> =20
>  /**
>   * smp_call_function_single_async() - Run an asynchronous function on a
> - * =09=09=09         specific CPU.
> + *=09=09=09=09 specific CPU.
>   * @cpu: The CPU to run on.
>   * @csd: Pre-allocated and setup data structure
>   *
> @@ -728,7 +741,7 @@ static void smp_call_function_many_cond(const struct =
cpumask *mask,
>  =09int cpu, last_cpu, this_cpu =3D smp_processor_id();
>  =09struct call_function_data *cfd;
>  =09bool wait =3D scf_flags & SCF_WAIT;
> -=09int nr_cpus =3D 0, nr_queued =3D 0;
> +=09int nr_cpus =3D 0;
>  =09bool run_remote =3D false;
>  =09bool run_local =3D false;
> =20
> @@ -786,21 +799,16 @@ static void smp_call_function_many_cond(const struc=
t cpumask *mask,
>  =09=09=09csd->node.src =3D smp_processor_id();
>  =09=09=09csd->node.dst =3D cpu;
>  #endif
> +
> +=09=09=09trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
> +
>  =09=09=09if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu=
))) {
>  =09=09=09=09__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
>  =09=09=09=09nr_cpus++;
>  =09=09=09=09last_cpu =3D cpu;
>  =09=09=09}
> -=09=09=09nr_queued++;
>  =09=09}
> =20
> -=09=09/*
> -=09=09 * Trace each smp_function_call_*() as an IPI, actual IPIs
> -=09=09 * will be traced with func=3D=3Dgeneric_smp_call_function_single_=
ipi().
> -=09=09 */
> -=09=09if (nr_queued)
> -=09=09=09trace_ipi_send_cpumask(cfd->cpumask, _RET_IP_, func);
> -
>  =09=09/*
>  =09=09 * Choose the most efficient way to send an IPI. Note that the
>  =09=09 * number of CPUs might be zero due to concurrent changes to the
> @@ -816,7 +824,7 @@ static void smp_call_function_many_cond(const struct =
cpumask *mask,
>  =09=09unsigned long flags;
> =20
>  =09=09local_irq_save(flags);
> -=09=09func(info);
> +=09=09csd_do_func(func, info, NULL);
>  =09=09local_irq_restore(flags);
>  =09}
> =20
>=20

I will rebase my patch on top of tip/smp/core and apply the suggested chang=
es.
A v2 will be send shortly.

Thank you all for reviewing!
Leo


