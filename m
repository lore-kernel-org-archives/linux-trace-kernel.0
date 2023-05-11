Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA359C77B7F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 11 May 2023 09:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjEKJ1T (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 11 May 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjEKJ0o (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E36E9D
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 May 2023 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683797140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nv3K94+E4w0eulJx7qgnISp/XkLo7GNu+tDWDqLNLbc=;
        b=DNwTlFtwf4Q8enSNP1A4QmWP8kSsnrR7cX9F1/9b9m02C+Yof3HQk+X+eb1yaL4YFbevsj
        eNbe8uQTHX2AAYPNMeXjti/cSVHrxKUk0ToqIjL+NvhQHYIv9gip596M7ajRQgv69mm9QC
        KuYrYXs1gIh/tvgJAkZ9dD1C/LocJMo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-YGVboHTOORywZiLBXOszGg-1; Thu, 11 May 2023 05:25:39 -0400
X-MC-Unique: YGVboHTOORywZiLBXOszGg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-757987559c7so392408985a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 May 2023 02:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797139; x=1686389139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv3K94+E4w0eulJx7qgnISp/XkLo7GNu+tDWDqLNLbc=;
        b=WXyGY4uaSifoP+XYN0rZ6A2ZyMxb/YVGE2kMlQ4WQifMnmaP1P+pxo2tYW0rNUI4DN
         hhqSmRi1fkS7g/sgT2ZqFF8SK01bDfdKdjcd7MQtgPrO6M/wkZevyL/z2G0tsnjNsEvv
         xB7lOTPkSewLTrkm/gjy5DzJtTeipQif5GQT/h4wpODmaiAIK6TV151Gcwez590nF0rK
         rOTXIuPIZ96DAEnie+gtYJRW6Z1k0IHTmfYt0+lt0brW+VKqk+JI5tiDMw6vYx05Y7lN
         qW9EaowbqP+S5EfAMrCRGiPIkBEvt1u7pDfo3C7RySlGMHOhTUodUG/GjMbO3xsCE72y
         29og==
X-Gm-Message-State: AC+VfDxQvVdFs+sFOQr7yZUqF2XgZOXzZJSBiDc4g1qo4QCX9aBJ5twl
        k14LZ0VPY8mgOSTXB1UmI6BJ3FExYoN/yt2XhxMvi2W71IJK27eRq4GPGy9dJp9C0opWuo2/J41
        o3oBOgbCW/zqG3fqUkwA2h9w9lJovyCNYhGTLY2CYrA/iRe67
X-Received: by 2002:ac8:5b50:0:b0:3d9:45a4:e7b9 with SMTP id n16-20020ac85b50000000b003d945a4e7b9mr29625325qtw.45.1683797139036;
        Thu, 11 May 2023 02:25:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6CfC+bzRY7It1UM9llGJVITAqGcpFflzAfkOiFZXTD0kgT1jc1DuCUQIWmLykpBNhVTPaWN1QFNLpoEV2gonE=
X-Received: by 2002:ac8:5b50:0:b0:3d9:45a4:e7b9 with SMTP id
 n16-20020ac85b50000000b003d945a4e7b9mr29625303qtw.45.1683797138774; Thu, 11
 May 2023 02:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230406075718.68672-1-leobras@redhat.com> <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
 <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
 <xhsmh7ctojoia.mognet@vschneid.remote.csb> <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
 <xhsmhv8gzi8uw.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhv8gzi8uw.mognet@vschneid.remote.csb>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Thu, 11 May 2023 06:25:27 -0300
Message-ID: <CAJ6HWG4g+KgqbJR+AsAKGG9vPViJpwXO-8bMSPzMZzYKXD_rWg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with smp_call_function*()
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, May 11, 2023 at 5:13=E2=80=AFAM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> On 10/05/23 17:27, Leonardo Br=C3=A1s wrote:
> > On Thu, 2023-05-04 at 12:59 +0100, Valentin Schneider wrote:
> >> +TRACE_EVENT(csd_queue_cpu,
> >> +
> >> +    TP_PROTO(const unsigned int cpu,
> >> +             unsigned long callsite,
> >> +             smp_call_func_t func,
> >> +             call_single_data_t *csd),
> >> +
> >> +    TP_ARGS(cpu, callsite, func, csd),
> >> +
> >> +    TP_STRUCT__entry(
> >> +            __field(unsigned int, cpu)
> >> +            __field(void *, callsite)
> >> +            __field(void *, func)
> >> +            __field(void *, csd)
> >> +    ),
> >> +
> >> +    TP_fast_assign(
> >> +            __entry->cpu =3D cpu;
> >> +            __entry->callsite =3D (void *)callsite;
> >> +            __entry->func =3D func;
> >> +            __entry->csd  =3D csd;
> >> +    ),
> >> +
> >> +    TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
> >> +              __entry->cpu, __entry->callsite, __entry->func, __entry=
->csd)
> >> +);
> >
> > This is for the caller side, right?
> >
>
> Yep, see usage lower down.
>
> >> +
> >> +DECLARE_EVENT_CLASS(csd_function,
> >> +
> >> +    TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >> +
> >> +    TP_ARGS(func, csd),
> >> +
> >> +    TP_STRUCT__entry(
> >> +            __field(void *, func)
> >> +            __field(void *, csd)
> >> +    ),
> >> +
> >> +    TP_fast_assign(
> >> +            __entry->func   =3D func;
> >> +            __entry->csd    =3D csd;
> >> +    ),
> >> +
> >> +    TP_printk("func=3D%pS csd=3D%p", __entry->func, __entry->csd)
> >> +);
> >> +
> >> +DEFINE_EVENT(csd_function, csd_function_entry,
> >> +    TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >> +    TP_ARGS(func, csd)
> >> +);
> >> +
> >> +DEFINE_EVENT(csd_function, csd_function_exit,
> >> +    TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
> >> +    TP_ARGS(func, csd)
> >> +);
> >
> > Oh, this is what event_class is for. Thanks for the example :)
> >
> >> +
> >> +#endif /* _TRACE_SMP_H */
> >> +
> >> +/* This part must be outside protection */
> >> +#include <trace/define_trace.h>
> >> diff --git a/kernel/smp.c b/kernel/smp.c
> >> index ab3e5dad6cfe9..7d28db303e9bc 100644
> >> --- a/kernel/smp.c
> >> +++ b/kernel/smp.c
> >> @@ -27,6 +27,9 @@
> >>  #include <linux/jump_label.h>
> >>
> >>  #include <trace/events/ipi.h>
> >> +#define CREATE_TRACE_POINTS
> >> +#include <trace/events/smp.h>
> >> +#undef CREATE_TRACE_POINTS
> >>
> >>  #include "smpboot.h"
> >>  #include "sched/smp.h"
> >> @@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
> >>      arch_send_call_function_ipi_mask(mask);
> >>  }
> >>
> >> +static __always_inline void
> >> +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd=
)
> >> +{
> >> +    trace_csd_function_entry(func, csd);
> >> +    func(info);
> >> +    trace_csd_function_exit(func, csd);
> >> +}
> >> +
> >
> > Good one, a helper to avoid calling those traces everywhere.
> >
> > Honest question:
> > Since info =3D=3D csd->info and func =3D=3D csd->func, we could just pa=
ss csd, right?
> > I suppose the suggestion on the 3-argument version is to use the values=
 already
> > fetched from memory instead of fetching them again. Is that correct?
> >
>
> There's also the special case of CSD_TYPE_TTWU where there is no csd->fun=
c,
> instead we have an implicit func mapping to sched_ttwu_pending). I think
> it's preferable to directly feed the right things to the TP than to
> duplicate the "decoding" logic against the *csd passed as TP argument.
>

Quite interesting, thank you for sharing!

I sent a v3 which got a warning from the kernel testing robot. I
already solved the warning, so please provide feedback on the rest of
the patch.

About the warning:
It is an alignment error between 'struct __call_single_data' from
generic_exec_single() and 'call_single_data_t' from csd_do_func(): the
first is 8-byte aligned, and the second is 32-byte aligned according
to the typedef.

My first idea was to convert my patches' parameters from
call_single_data_t to 'struct __call_single_data', but then I found
out the 'struct' option allows splitting csd between 2 cachelines,
which is usually bad.
Then I decided to send a patchset [1] fixing generic_exec_single() and
its callers. If it's accepted, the warning will go away, and v3 will
merge cleanly.

If not, I will send a v4 changing the parameters.

Thanks for reviewing,
Leo


1. https://lore.kernel.org/lkml/20230511085836.579679-1-leobras@redhat.com

