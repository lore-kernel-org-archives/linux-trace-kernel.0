Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A08FEB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 15 Jun 2023 16:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjFOQoZ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 15 Jun 2023 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjFOQn4 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB7295C
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686847370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HZM2vtH55xi0S4vEAkx6S6svO24oEkr7PlvNJlkl05c=;
        b=NzozyBtubHOH/ggngcr8iL0KlhMXlZSYTBos2RQKwhIA+X18J2v8Oi+E43ZjzgOcEsmu0K
        hTSEYnWvKA7tT2MZ70WuRGBlFJvJt+ej6H4QHPtcgPSP9/WCt+Z3K/MqjcnLaceugsJwB3
        y4ER7AgjbNp/kHKlfjsfy4Yz8KMgXBI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-XfnM7CKMN4q-0OANumDzIw-1; Thu, 15 Jun 2023 12:42:49 -0400
X-MC-Unique: XfnM7CKMN4q-0OANumDzIw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f61f59c230so6883539e87.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686847368; x=1689439368;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZM2vtH55xi0S4vEAkx6S6svO24oEkr7PlvNJlkl05c=;
        b=FNTIw/VbXd8ChFihR7rSor+7ndWA97jhNBF8BVSMr8GMFU9XqtxAMrAoQ5yom02dPI
         WGosq3X1zKKFHuH3cKFTwDC9cMEdOXsnIFzcPa+QfJPJT4BmNWS2wS+yO/Ktm49lEHps
         Mu/Jfe1blg7E4jXUCdwCKTVILN4/JgRSmJLOvh1M67EJVog1yKnb2F0/VOYbrbw8Oors
         Tqxm9GSc+blvL2vO7Bi9Xi6AJLcB6qJdBIi1mJjgYaMYNgIw6+PaPjog3SfjagaT3K/+
         nXj1+aJfTsq60CXKRBfV58jjC71Y47r/QJGD+m5GkmoO79v3noFjbfueEizqz0VAl8dx
         xv4A==
X-Gm-Message-State: AC+VfDxSKCJ68aIg6i47Q8NxORdqOvWGcuE3yo4DDp5Zv0PEN6uaEVvC
        9Hqy2c539m1MCs9fDc14m2bl4GQwUV5IpXk/QvPGLDAtxBEnjQyQWJjJyMGY23bmYXCtGPfDsML
        Se3/l7gAm2jBwL+nC/zlDIgUyMiH4um7aiaZEN+959GKJiyIIE8y1vJXOpqkUGDwj/aWqwzn777
        Ocfs2aw4fYYk4G8G6b
X-Received: by 2002:a05:6512:550:b0:4f8:4980:d006 with SMTP id h16-20020a056512055000b004f84980d006mr490833lfl.60.1686847367776;
        Thu, 15 Jun 2023 09:42:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6c1Dq0etvLoNH9774/Prm7CcFtZu8Y3f+rKibODYz7gbUeA1dNQmjfP9L4AqYhVkPPVSHUgA==
X-Received: by 2002:a05:6512:550:b0:4f8:4980:d006 with SMTP id h16-20020a056512055000b004f84980d006mr490814lfl.60.1686847367344;
        Thu, 15 Jun 2023 09:42:47 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm21512116wrv.108.2023.06.15.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 09:42:46 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 2/2] trace,smp: Add tracepoints for scheduling
 remotelly called functions
In-Reply-To: <20230615065944.188876-7-leobras@redhat.com>
References: <20230615065944.188876-3-leobras@redhat.com>
 <20230615065944.188876-7-leobras@redhat.com>
Date:   Thu, 15 Jun 2023 17:42:46 +0100
Message-ID: <xhsmh4jn8y8vt.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 15/06/23 03:59, Leonardo Bras wrote:
> Add a tracepoint for when a CSD is queued to a remote CPU's
> call_single_queue. This allows finding exactly which CPU queued a given CSD
> when looking at a csd_function_{entry,exit} event, and also enables us to
> accurately measure IPI delivery time with e.g. a synthetic event:
>
>   $ echo 'hist:keys=cpu,csd.hex:ts=common_timestamp.usecs' >\
>       /sys/kernel/tracing/events/smp/csd_queue_cpu/trigger
>   $ echo 'csd_latency unsigned int dst_cpu; unsigned long csd; u64 time' >\
>       /sys/kernel/tracing/synthetic_events
>   $ echo \
>   'hist:keys=common_cpu,csd.hex:'\
>   'time=common_timestamp.usecs-$ts:'\
>   'onmatch(smp.csd_queue_cpu).trace(csd_latency,common_cpu,csd,$time)' >\
>       /sys/kernel/tracing/events/smp/csd_function_entry/trigger
>
>   $ trace-cmd record -e 'synthetic:csd_latency' hackbench
>   $ trace-cmd report
>   <...>-467   [001]    21.824263: csd_queue_cpu:        cpu=0 callsite=try_to_wake_up+0x2ea func=sched_ttwu_pending csd=0xffff8880076148b8
>   <...>-467   [001]    21.824280: ipi_send_cpu:         cpu=0 callsite=try_to_wake_up+0x2ea callback=generic_smp_call_function_single_interrupt+0x0
>   <...>-489   [000]    21.824299: csd_function_entry:   func=sched_ttwu_pending csd=0xffff8880076148b8
>   <...>-489   [000]    21.824320: csd_latency:          dst_cpu=0, csd=18446612682193848504, time=36
>

Nit: these commands now need a s/smp/csd/.

I played with those a little more and found out how to record the src CPU,
so feel free to update the changelog with this:

  $ echo 'hist:keys=cpu,csd.hex:ts=common_timestamp.usecs:src=common_cpu' >\
       /sys/kernel/tracing/events/csd/csd_queue_cpu/trigger
  $ echo 'csd_latency unsigned int src_cpu; '\
       'unsigned int dst_cpu; '\
       'unsigned long csd; u64 time' >\
       /sys/kernel/tracing/synthetic_events

  $ echo 'hist:keys=common_cpu,csd.hex:
  time=common_timestamp.usecs-$ts:
  onmatch(csd.csd_queue_cpu).trace(csd_latency,$src,common_cpu,csd,$time)' >\
       /sys/kernel/tracing/events/csd/csd_function_entry/trigger

  $ trace-cmd record -e 'synthetic:csd_latency' hackbench
  $ trace-cmd report
  <idle>-0     [001]   115.236810: csd_latency:          src_cpu=7, dst_cpu=1, csd=18446612682588476192, time=134
  <idle>-0     [000]   115.240676: csd_latency:          src_cpu=7, dst_cpu=0, csd=18446612682588214048, time=103
  <idle>-0     [009]   115.241320: csd_latency:          src_cpu=7, dst_cpu=9, csd=18446612682143963384, time=83
  <idle>-0     [007]   115.242817: csd_latency:          src_cpu=8, dst_cpu=7, csd=18446612682150759032, time=93
  <idle>-0     [005]   115.247802: csd_latency:          src_cpu=7, dst_cpu=5, csd=18446612682144441144, time=114
  <idle>-0     [005]   115.271775: csd_latency:          src_cpu=7, dst_cpu=5, csd=18446612682144441144, time=151
  <idle>-0     [000]   115.279620: csd_latency:          src_cpu=7, dst_cpu=0, csd=18446612682588214048, time=87
  <idle>-0     [000]   115.281727: csd_latency:          src_cpu=7, dst_cpu=0, csd=18446612682588214048, time=101

> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Other than that:

Tested-and-reviewed-by: Valentin Schneider <vschneid@redhat.com>

