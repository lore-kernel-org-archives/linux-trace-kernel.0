Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588FFC7EE23
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 30 May 2023 10:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjE3KhP (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 30 May 2023 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjE3KhM (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14E11D
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 May 2023 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685442983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLqwsPXYX0iDPr0qf3f1ojIJFMqD6WOSnvvW6FW4y68=;
        b=YMXXQq/JL9p5FVfSvfv1I+KqPJ64xsTqJP6JGfbOXggd6mtR6wE2JUzSe78dl7bztcP2RR
        KnxYDEjhG+gxO4RQ0s5BZoK8ZqkoQnI5cFbdcaGk7dx/GP+XPYcIMRC2ARqYUBxs334wBR
        63BTb/kFnOx9XeKYtKV8B288JwniXIA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-zJOXR47dNAqcPx9Qrm9qFA-1; Tue, 30 May 2023 06:36:22 -0400
X-MC-Unique: zJOXR47dNAqcPx9Qrm9qFA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f6f2f18ecbso14181865e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 May 2023 03:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442980; x=1688034980;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLqwsPXYX0iDPr0qf3f1ojIJFMqD6WOSnvvW6FW4y68=;
        b=kyNPzn7GM/BTQ+7wxBhk6DzQNpX94znr2dXzsvVtk2VvIH8rE/K9J/wvZmYIfGXqYj
         R8ziEmRkkUqY9X9yzivHAit29UsZWPhB8Qam2Mh72VP8V7aPU8xLBWOKqq6+d93pCF1T
         zeKGRuOBvyEMwR23ZpDEdoLIHZRuw8lgH6LhvctfjLMvybnTvILNtzQ19clJB4z8LQcx
         CchcGuPju7rCL7G5R1V6Sc0Iixv+09LeRJjGlbM/himRA4qhkT1v4gOx3almuYegYuLX
         DAdFBKjYtqjvFR/riwDi0/Z431vVULiyJIYjVSiTTQZwDmu4IgviqZt9gux8N+spJR4n
         71XA==
X-Gm-Message-State: AC+VfDxvwJvJMpkKiti8ObucD2wSfMIREbh57jIbfjGUvyewUYG+NXUo
        5kvLS3kVmAoW/Ntl+EeZQzJaweOSozcoDKrITU0MFtSpCHrYfenlkYu9XkqYGEWj9dnDwBlHotd
        7xAlg+VNlPXATJTHN2iB/U/3c4qMxEnpS7Stwqfs33hGQZ8/I6B9oul33fQDknIlE6o1Hy26s6S
        I/GpGUczdyBk/5yzJ8KLU=
X-Received: by 2002:a7b:c40a:0:b0:3f6:82a:5d1b with SMTP id k10-20020a7bc40a000000b003f6082a5d1bmr1401686wmi.34.1685442980609;
        Tue, 30 May 2023 03:36:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZpxW6peHXfHC1gcVcWekJmGV2Eu3/iAvrk2Tsb6d1qChMCTBEWj+yJqOW+Sz+rrpveCHoZw==
X-Received: by 2002:a7b:c40a:0:b0:3f6:82a:5d1b with SMTP id k10-20020a7bc40a000000b003f6082a5d1bmr1401662wmi.34.1685442980332;
        Tue, 30 May 2023 03:36:20 -0700 (PDT)
Received: from vschneid.remote.csb ([208.178.8.98])
        by smtp.gmail.com with ESMTPSA id i16-20020adfded0000000b003077f3dfcc8sm2918026wrn.32.2023.05.30.03.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:36:19 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Leonardo Bras <leobras@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/2] trace,smp: Add tracepoints for csd
In-Reply-To: <20230515183045.654199-1-leobras@redhat.com>
References: <20230515183045.654199-1-leobras@redhat.com>
Date:   Tue, 30 May 2023 11:36:18 +0100
Message-ID: <xhsmh1qiyp0m5.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 15/05/23 15:30, Leonardo Bras wrote:
> Changes since RFCv3:
> - Split the patch in 2: entry/exit and queue
> - Fix 'struct __call_single_data' & call_single_data_t alignment issue
> - Made all TP_printk follow the same pattern
>

One bikeshedding nit I have is I'd prefer to see the csd_* events in a csd
trace system, to have a sane nomenclature.

Other than that and the other comment on csd_do_func(), this LGTM.

> Changes since RFCv2:
> - Fixed some spacing issues and trace calls
>
> Changes since RFCv1:
> - Implemented trace_csd_queue_cpu() as suggested by Valentin Schneider
> - Using EVENT_CLASS in order to avoid duplication
> - Introduced new helper: csd_do_func()
> - Name change from smp_call_function_* to csd_function_*
> - Rebased on top of torvalds/master
>
> Leonardo Bras (2):
>   trace,smp: Add tracepoints around remotelly called functions
>   trace,smp: Add tracepoints for scheduling remotelly called functions
>
>  include/trace/events/smp.h | 72 ++++++++++++++++++++++++++++++++++++++
>  kernel/smp.c               | 41 +++++++++++++---------
>  2 files changed, 96 insertions(+), 17 deletions(-)
>  create mode 100644 include/trace/events/smp.h
>
> --
> 2.40.1

