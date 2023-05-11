Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA34C77B7F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 11 May 2023 08:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjEKIOV (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 11 May 2023 04:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEKIOU (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAE32705
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 May 2023 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683792812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NxnaW2U7B2vf0YoL0nXai/kyhAa2A2hY8ojUGp8VEo4=;
        b=G/UNMXfEF4sz6E6nFJ/yy1AnUN141B3rWX6EeOQvRekYCNlTCae1WRWVVXyYZmQB+zLRfV
        Ch0HChAn8cNKIfshwZcis3pmOBgz9/7oI03yhgSrN2xIVgDLYv/4qTkqs1vixkQMsA4uMt
        G7hR/fLgQP2XMN+d08YHZQ4EOG/H3sE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-LvfcTqlSPsaEVj9kfrnKIQ-1; Thu, 11 May 2023 04:13:31 -0400
X-MC-Unique: LvfcTqlSPsaEVj9kfrnKIQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30633990a69so2884774f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 May 2023 01:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683792810; x=1686384810;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISts0ooOqDRfuZXF0qq5A4HD7E+tCGV5ujF6/xdMaMg=;
        b=MrWHWsANfqFBgVYxhjiC3g8jRTzCxMR00QCLbHlLlKAGvtkdlQsrgSkF0gw8Kdqp4a
         605udfPsqgBeSm/X+HErUwNyeZyvP7a6GgxdRhSuOBn84TTD6HNQdX8KbdKhREXIuZrG
         cVYELsHE8Vn6duioC9jWkOT2sf6cutcYKMTl3YGeky7TB8jhXD6Pv+gtnUhTPPuWRl2n
         PrAw85FyLkY+go3ohcPQALHinid/anrik6bMQwgHLMqlBQ+vClWvqdKFYQxPaPHPwdjz
         UsKBBcQyQLm7kmRPLF4ZGRrGT8g0+YM9J0raKH/zFgWdDyh882XBdLrq5zxKiAxSreFB
         KyeA==
X-Gm-Message-State: AC+VfDwC538onu3YgU890Zra5tClKW3JXjhcOMYqKg/aLmA35cFiMO13
        4X6qZCIyNnKpwzzmOaJzDTE44tZKTUGdUbsEAZdaSeF3VGZF8Cegt37OwpUVSz7OOD9zm2HbJ0Z
        G2DYRGnadwkz3rdQfjrpWDNKI0VoNOAm3
X-Received: by 2002:a5d:6ad2:0:b0:306:3b39:9a3d with SMTP id u18-20020a5d6ad2000000b003063b399a3dmr15181725wrw.15.1683792809975;
        Thu, 11 May 2023 01:13:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wzkHxXA98ZgAI5RK3TMyhcDtRnsVdn01Y5Ujktfp0w0cSPqr08X4KOya9osApYAYUFMqmaQ==
X-Received: by 2002:a5d:6ad2:0:b0:306:3b39:9a3d with SMTP id u18-20020a5d6ad2000000b003063b399a3dmr15181702wrw.15.1683792809674;
        Thu, 11 May 2023 01:13:29 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id y12-20020adffa4c000000b00306281cfa59sm19596655wrr.47.2023.05.11.01.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 01:13:29 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo =?utf-8?Q?Br=C3=A1s?= <leobras@redhat.com>,
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
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
In-Reply-To: <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
References: <20230406075718.68672-1-leobras@redhat.com>
 <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
 <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
 <xhsmh7ctojoia.mognet@vschneid.remote.csb>
 <f96442e9166e4f73be772656a93c89093eddbb8b.camel@redhat.com>
Date:   Thu, 11 May 2023 09:13:27 +0100
Message-ID: <xhsmhv8gzi8uw.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 10/05/23 17:27, Leonardo Br=C3=A1s wrote:
> On Thu, 2023-05-04 at 12:59 +0100, Valentin Schneider wrote:
>> +TRACE_EVENT(csd_queue_cpu,
>> +
>> +=09TP_PROTO(const unsigned int cpu,
>> +=09=09 unsigned long callsite,
>> +=09=09 smp_call_func_t func,
>> +=09=09 call_single_data_t *csd),
>> +
>> +=09TP_ARGS(cpu, callsite, func, csd),
>> +
>> +=09TP_STRUCT__entry(
>> +=09=09__field(unsigned int, cpu)
>> +=09=09__field(void *, callsite)
>> +=09=09__field(void *, func)
>> +=09=09__field(void *, csd)
>> +=09),
>> +
>> +=09TP_fast_assign(
>> +=09=09__entry->cpu =3D cpu;
>> +=09=09__entry->callsite =3D (void *)callsite;
>> +=09=09__entry->func =3D func;
>> +=09=09__entry->csd  =3D csd;
>> +=09),
>> +
>> +=09TP_printk("cpu=3D%u callsite=3D%pS func=3D%pS csd=3D%p",
>> +=09=09  __entry->cpu, __entry->callsite, __entry->func, __entry->csd)
>> +);
>
> This is for the caller side, right?
>

Yep, see usage lower down.

>> +
>> +DECLARE_EVENT_CLASS(csd_function,
>> +
>> +=09TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>> +
>> +=09TP_ARGS(func, csd),
>> +
>> +=09TP_STRUCT__entry(
>> +=09=09__field(void *,=09func)
>> +=09=09__field(void *,=09csd)
>> +=09),
>> +
>> +=09TP_fast_assign(
>> +=09=09__entry->func=09=3D func;
>> +=09=09__entry->csd=09=3D csd;
>> +=09),
>> +
>> +=09TP_printk("func=3D%pS csd=3D%p", __entry->func, __entry->csd)
>> +);
>> +
>> +DEFINE_EVENT(csd_function, csd_function_entry,
>> +=09TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>> +=09TP_ARGS(func, csd)
>> +);
>> +
>> +DEFINE_EVENT(csd_function, csd_function_exit,
>> +=09TP_PROTO(smp_call_func_t func, call_single_data_t *csd),
>> +=09TP_ARGS(func, csd)
>> +);
>
> Oh, this is what event_class is for. Thanks for the example :)
>
>> +
>> +#endif /* _TRACE_SMP_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index ab3e5dad6cfe9..7d28db303e9bc 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -27,6 +27,9 @@
>>  #include <linux/jump_label.h>
>>
>>  #include <trace/events/ipi.h>
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/smp.h>
>> +#undef CREATE_TRACE_POINTS
>>
>>  #include "smpboot.h"
>>  #include "sched/smp.h"
>> @@ -121,6 +124,14 @@ send_call_function_ipi_mask(struct cpumask *mask)
>>      arch_send_call_function_ipi_mask(mask);
>>  }
>>
>> +static __always_inline void
>> +csd_do_func(smp_call_func_t func, void *info, call_single_data_t *csd)
>> +{
>> +=09trace_csd_function_entry(func, csd);
>> +=09func(info);
>> +=09trace_csd_function_exit(func, csd);
>> +}
>> +
>
> Good one, a helper to avoid calling those traces everywhere.
>
> Honest question:
> Since info =3D=3D csd->info and func =3D=3D csd->func, we could just pass=
 csd, right?
> I suppose the suggestion on the 3-argument version is to use the values a=
lready
> fetched from memory instead of fetching them again. Is that correct?
>

There's also the special case of CSD_TYPE_TTWU where there is no csd->func,
instead we have an implicit func mapping to sched_ttwu_pending). I think
it's preferable to directly feed the right things to the TP than to
duplicate the "decoding" logic against the *csd passed as TP argument.

