Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844017;
	b=DEsCpgXFW3JmsAnpAsHcu8Lm7X5jWqoVKEAmSuRJ6CUy20xqNE8ZEKBVnBvaDVCan36s
	 x22OmIYEHHYrkfBKz2X0oH+D4qdRrXwwsc1ZRPHdr39I/658JWJC9FoB5YhGyBui2ADi5
	 vT1bAv3lDRFhrX1nVsQIBE0yTdaA+ifpXFJGAIj4Zqu+NXYYNZ8qOjKx8EzLCQgS4b94P
	 dFKHKhe2zYMudA0wzxA9fp7d2M/NfhCEBhSKGO5EoS4NfWBqAlu58h0rTd9Jim/55YwU2
	 wyXUkFLCfl9K+BJ3jmYMz8LeOHG9M70yvvHfDniRFRcjAeI/YxWT5qyAE9Zt2A0Edkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844017;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=UhqDzvylCUClPcAmFlf4zscztq4m0z25fogi1NkYGug=;
	b=S+OXDCmfQCahOAp87dGouTxjfue0cQBh09qV3ir5DQPTq0cpzGMqHAlmpx7vII1ytWei
	 nXW8xgR5RDV+BCwche45znX5qTFXZTW/asmPD19A/mdcJ2kOY96SwhmXslERm9VJh+L1V
	 DDjGu7TfBVI6nvesZ8xx0jKV3cx7wT4jM31ZzJJHYZzS/8kdQGga1RrxM5eCXL+7n07KR
	 rypHUOi7rExBMrlNbOs+DttXyUOByQdgxDZ2hkcaq7ARvUjqq0QPuo4WIBUZrCxpDp2Rl
	 ABqjnN0dbRqPUrGxwEmEOK5+b6l7DS55RSLtXVB+Rovi1xu2CfitBlO58c0KRR53jBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fUnje73F;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BF606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 12:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A23BF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fUnje73F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792844015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UhqDzvylCUClPcAmFlf4zscztq4m0z25fogi1NkYGug=;
	b=fUnje73FvRLfi7lIAOdjFrQXz9xIZgFwKWMU93lsI3net4ybQAvJcZBMVKvRuUKvGlmUPE
	UMm6FK3qqhI3N9Ml+Tdk+XxOVoLCPeQc5EnXH+9bE5ptm7Orj4SUgcaF0ZvkJSGmFBTifK
	H8wq/HBk+01HzF5FvIbKAvxjHqKyaEQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-otdY659xPzaujfHev_Zyhg-1; Sat, 24 Oct 2026 08:13:32 -0400
X-MC-Unique: otdY659xPzaujfHev_Zyhg-1
X-Mimecast-MFC-AGG-ID: otdY659xPzaujfHev_Zyhg_1792844011
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c41f85ee4a3so158213666b.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 05:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844011; x=1793448811;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4C00/XzUMl81Cb9nPtDyYxb7VozrfQ6cNr56bWwPUU=;
        b=CYYTptON6lo70+hA39jAeUqYq0NNAYn8s+z/xN0XPDJpPkQyIEjv8/meSGqECHiyzJ
         Zx6A584x/EVUF7ANaW+sM4yhfdCfkKczNDSA6jPKvCn36LrCNamXYM1A2rt3ypEz2+Wn
         mcs2BNGD+7nv246kDM5hqKGEeA7IqZ+7sjBvbPr+RcY5WjOEDxIiK4WHEM3P3Q6tj1z2
         f7Rl5JF0lLOiGynN8b4uBjm2mnXegBt6WKZ0sdwlZQ9SbFctv/zKHo53+W4F3ITgm7AO
         k+Uf4KKSxb56xbn1KFQ/HL3tTgSzVSIRnJG2S/bn3rANN8i+0d8Flc7Bw77A5ymibYX6
         Hx4A==
X-Forwarded-Encrypted: i=1; AKwUvBwv77LTtGmr7CG2eAFvXqyOaLs3w42/PcWTDZ/vuAIvmPnKBKNZcu1Jvd92VzYZDFwAMe1hbUgbLCTrDtVoJQ6/OLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlFmRKG+RiGNWkwB+aoSWGm0RPqzM2K6UZvvy0PIbPHGazjUOK
	L6muv0AzGYWSjtLeaEF6deMnmxMkIrxVo8hQNhjE44vSXagAur1jYOXT3CV7B8mqJc2iK/xJc+n
	dNraNmlcI532zBkuiApl+GattkCXUAzdabq0JyW6/5nzDZBKVvTxFqm9heGbQTQj0dwGLj3g70A
	==
X-Gm-Gg: AYBFou3frQMQ2ftrIZ84WaWMtUsQrA0b77VZL3wzW+OEOsLUEpDTJjpJhmhXL7gJBOB
	kGSQZC78FM47Rn/B58AzDkvbsXfwkq1++/ZRKvMjEEKmMtAeR4Qgy1cLP4LzSwl2dkiH0S+Q8si
	LZ2bkIxhooX+SVukULXMHWL5piUv9nH8yJmjwaO3K+lThWgl4ACY78L3UAka0JU3OUFR1yM/wbG
	w4T1xJbE3ww61K5b4kbAXC3f95alaPOQ43RbRZ1+nS3yDsZdd7yFcfnqXupy3VD6sLg84JoflV1
	ETvC/44ap089w07vG2hL2Gfana83PZhY4ARUBdIZj8wGNLaNK4Py9LxMBDxOddM=
X-Received: by 2002:a17:907:803:b0:c45:60ec:32c8 with SMTP id a640c23a62f3a-c46bde93f0amr177897366b.38.1792844010993;
        Sat, 24 Oct 2026 05:13:30 -0700 (PDT)
X-Received: by 2002:a17:907:803:b0:c45:60ec:32c8 with SMTP id a640c23a62f3a-c46bde93f0amr177894266b.38.1792844010612;
        Sat, 24 Oct 2026 05:13:30 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:7c80:0:3a4::13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4ea39fsm83877966b.29.2026.10.24.05.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 05:13:30 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:13:26 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] rv: Verify generic IRQ context transitions
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
Message-ID: <FACA54EC-F846-4051-9ADD-DB46E7665FAD@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MzdZ6vR1eSCVkMyMXXB-mWqX4JUQudY7GkLfIOuzzLw_1792844011
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 22 ottobre 2026 05:07:03 UTC, Karl Mehltretter <kmehltretter@gmail.com> =
ha scritto:
>I would especially appreciate feedback on:
>
>  1. Should the context boundaries be trace events or private RV
>     instrumentation?

There aren't any RV-specific instrumentation sites. Now you used trace even=
ts, for these you usually need a broad acceptance because they are visible =
to user space. Have a look at tracepoints (the last ones added to events/sc=
hed.h are good examples).

Otherwise you may have a look at my BPF series and use other BPF-specific p=
robes (fentry/fexit), these won't need any kernel addition. Just mind that =
the series in an early stage. [1]

>  2. Are dedicated scheduler events the right way to follow
>     preempt_schedule_irq() across task switches and migration?
>  3. Should irqstate and irqexit remain separate monitors?

Feel free to merge them unless you see a use case where one would launch th=
em separately and allow violations from one but not the other.

Also the irqentry collection with an irqexit monitor is mildly confusing na=
me-wise.

Gabriele

[1] - https://lore.kernel.org/lkml/20261001152042.124445-1-gmonaco@redhat.c=
om



>  4. Is the KUnit-only hook for an empty ksoftirqd invocation acceptable?
>     Outside a KUnit run, its worker checks take a disabled static-key
>     path.
>
>Patches 1-5 add the events, monitors, and documentation. Patches 6-9 add
>KUnit coverage.
>
>This series is based on v7.3 (c03c1a14507d) and depends on the following
>accepted change, which is not included:
>
>  softirq: Preserve interrupt context on return from interrupt
>  https://lore.kernel.org/r/20261011060742.30584-1-kmehltretter@gmail.com
>
>A pre-existing issue can make rv_test_dummy intermittently report a
>false-positive invalid-wait-context warning under lockdep. Wen Yang has
>posted a fix:
>
>  https://lore.kernel.org/lkml/5586dd00789a0f904cc299cd8889744b8c6f8dc9.17=
89412799.git.wen.yang@linux.dev/
>
>This series does not include that fix.
>
>Karl Mehltretter (9):
>  tracing/irq: Add generic IRQ context boundary events
>  tracing/sched: Add IRQ preemption lifecycle events
>  rv: Add a monitor for generic IRQ context transitions
>  rv: Add a monitor for IRQ-exit scheduling ownership
>  docs/rv: Document the IRQ-entry monitors
>  rv: Add KUnit coverage for IRQ context transitions
>  rv: Add KUnit coverage for IRQ-exit scheduling
>  rv: Test empty PREEMPT_RT softirq worker intervals
>  rv: Test IRQ-exit softirq provenance and handoff
>
> Documentation/trace/rv/index.rst              |    1 +
> Documentation/trace/rv/monitor_irqentry.rst   |  398 ++++
> include/linux/interrupt.h                     |    7 +
> include/rv/kunit.h                            |   34 +-
> include/trace/events/irq.h                    |   70 +
> include/trace/events/sched.h                  |   51 +
> kernel/sched/core.c                           |    6 +
> kernel/softirq.c                              |  308 ++-
> kernel/trace/rv/Kconfig                       |    5 +
> kernel/trace/rv/Makefile                      |    3 +
> kernel/trace/rv/monitors/irqentry/Kconfig     |   13 +
> kernel/trace/rv/monitors/irqentry/irqentry.c  |   35 +
> kernel/trace/rv/monitors/irqentry/irqentry.h  |    3 +
> kernel/trace/rv/monitors/irqexit/Kconfig      |   14 +
> kernel/trace/rv/monitors/irqexit/irqexit.c    |  172 ++
> kernel/trace/rv/monitors/irqexit/irqexit.h    |   85 +
> .../trace/rv/monitors/irqexit/irqexit_kunit.c |  537 +++++
> .../trace/rv/monitors/irqexit/irqexit_kunit.h |   21 +
> .../trace/rv/monitors/irqexit/irqexit_trace.h |   19 +
> kernel/trace/rv/monitors/irqstate/Kconfig     |   14 +
> kernel/trace/rv/monitors/irqstate/irqstate.c  |  289 +++
> kernel/trace/rv/monitors/irqstate/irqstate.h  |  139 ++
> .../rv/monitors/irqstate/irqstate_kunit.c     | 2062 +++++++++++++++++
> .../rv/monitors/irqstate/irqstate_kunit.h     |   25 +
> .../rv/monitors/irqstate/irqstate_trace.h     |   15 +
> kernel/trace/rv/rv_monitors_test.c            |   29 +
> kernel/trace/rv/rv_trace.h                    |    2 +
> .../verification/models/irqentry/irqexit.dot  |   21 +
> .../verification/models/irqentry/irqstate.dot |   32 +
> 29 files changed, 4397 insertions(+), 13 deletions(-)
> create mode 100644 Documentation/trace/rv/monitor_irqentry.rst
> create mode 100644 kernel/trace/rv/monitors/irqentry/Kconfig
> create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.c
> create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.h
> create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
> create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
> create mode 100644 kernel/trace/rv/monitors/irqstate/Kconfig
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.c
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.h
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.h
> create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_trace.h
> create mode 100644 tools/verification/models/irqentry/irqexit.dot
> create mode 100644 tools/verification/models/irqentry/irqstate.dot
>
>base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
>prerequisite-patch-id: 6ac7167f0aa7c5319dac78bf5b06a989fd7dfac5

