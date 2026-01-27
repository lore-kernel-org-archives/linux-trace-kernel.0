Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BCF3321BD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769505055; cv=none; b=j89BrPaBKHL+SVW+lCqfm+sngQ8witFwcB7b35L1mRy2HWsuoBxgSZBZktaQv1bSdAeyBA3YmJlB/EYN2X5+3njWHivGvqseP95onWxjGJyq3CfJ9MEWI2moY25qid2MVDR6YF4K6O+JU9wgSm95qHVtjd/r2Z8CVYvpJiIcrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769505055; c=relaxed/simple;
	bh=nprMtoBitz0qgu7CW1diLpb1nj2p8+ocsVeD4MsMVJg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ALhdlJRVQQ80YQvq22uNfKdVuOPlL3ztv/J4e79jyGQba+yrhBNNgJfLmKa9UTgFLnb+NsDvXdfEOUHyxNkXE4sVpWGZ4zmGU6HKWNUSqQU/EZ7eqkqxuXP8PVGmknIlaYcBzoKL30uNh6yXVhqaxb3yrefJaPiUKbPpelCW8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMEGqepf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMEGqepf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769505052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nprMtoBitz0qgu7CW1diLpb1nj2p8+ocsVeD4MsMVJg=;
	b=AMEGqepfeu6MzsDIjF1DYrXFlUe06Kc6PFBMgrS7m3OG07V0lgz3LxGPs85bsCv6NKdNvx
	ueVq4zYagpiGPWsz3jbpDcYDtClB7IVx/YMmz3N1ncza17Dm9gSFzrGfo6Tik3ZO4bzYFd
	lrMeFH6nRe9leFFQrXecO1Hxu/xJuqs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-yFcGU-TcPrqU1PRVSWWGrw-1; Tue, 27 Jan 2026 04:10:51 -0500
X-MC-Unique: yFcGU-TcPrqU1PRVSWWGrw-1
X-Mimecast-MFC-AGG-ID: yFcGU-TcPrqU1PRVSWWGrw_1769505050
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4801e9e7159so43847645e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 01:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769505050; x=1770109850;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nprMtoBitz0qgu7CW1diLpb1nj2p8+ocsVeD4MsMVJg=;
        b=JiM3WHcBec64UUMcaBaVxSi4EnGGysa/AqYEEu0UtGGjfVIUPHB9vJ1dOkifpSQNEq
         YCuXF7iRTHLB2Ldr8jTSHQYcpct05vuEHIGGuHXyWVk2b5uJSbv3C8RcofN9uPYWKT3j
         PMZV5pzEkDBH+SdsZtPRYtfTvs8wtVRlBARVJvCTTBJMFs06PAOjbUp/hmOCJuZPVjop
         uem0bGuOBFXLmmelefIGfDEIfA+jLfwEbYRKv1U/9VF8TGHskqNQJJ10/HOgo/UhGMt3
         VbJwtvfdhs29KVlD0rmFWfuQAgb42zIVAVcNs7XVWVPQOp/1vM6ScfEOHAQmliR607Vz
         fesg==
X-Forwarded-Encrypted: i=1; AJvYcCW+5/IoFv+J3As0sbQ4ijPnXkXMmdL2i1VcV6PlcCWyrVFT7kaaDI9JTLtbnvhOWBq2+emIUPPXlua7SmUiINnfcQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJ3Y2TQB0FDMxXEhGvGUCKF3Qgf/6IL8oRGk53R2fPYxyLVgt
	+EzmRy9zk+eESbfHnEAfxkOGQDsTQBJ30JqWOZJ+NRaZ1Nq5w8E5PysIGGXTNTSkux0R+4mtEch
	20X4EjeOryLmF52N81qUqOQ15EekbxinEc1a3p8IDgxnNEMo93632/T0OAZMn3YdYy78J9bMMsA
	==
X-Gm-Gg: AZuq6aKVNDxYqxD3MzWNZnusKvlCY5TyU1YOG99m+ZkTgDaVzd+tAwZZesEGHnkDuU4
	XCTwnX9ZXG8dfNBw7Q5yBGKPSy7RWd8d+vFUr4ojrovAVen6ZqR8HxPIKyfpUf63L7QztkF+4BU
	sFzOJ1VPIYfrSmHu+de5OzCmcZqSJlxPoQsBd2xvfdDcNX6XsbhibwfiVpXvSZJ05ECttBmsd/u
	x2046BYUBgiDq4VRwFLjgMXPoB5fRzBoGoTvwA2UXF/5GzNskwokY6NFPCB9DpI7dHL2xEdFfx5
	DL8cL2bjW7oRhwDZH7qbZD1kFMtSWyjqietkkLc8dou0/EJXtBlGROJT3HHX7vpKIGhqsyT3ZJo
	3rdgH
X-Received: by 2002:a05:600c:190a:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48069c6993amr13622455e9.24.1769505049893;
        Tue, 27 Jan 2026 01:10:49 -0800 (PST)
X-Received: by 2002:a05:600c:190a:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48069c6993amr13622075e9.24.1769505049474;
        Tue, 27 Jan 2026 01:10:49 -0800 (PST)
Received: from [127.0.0.1] ([176.33.57.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804db63817sm129522665e9.3.2026.01.27.01.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 01:10:48 -0800 (PST)
Date: Tue, 27 Jan 2026 09:10:46 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <jlelli@redhat.com>
Message-ID: <8883042e-49b4-4cba-b0f8-d12e4cfa3d6c@redhat.com>
In-Reply-To: <20260122155500.362683-10-gmonaco@redhat.com>
References: <20260122155500.362683-1-gmonaco@redhat.com> <20260122155500.362683-10-gmonaco@redhat.com>
Subject: Re: [PATCH v5 09/15] sched: Add task enqueue/dequeue trace points
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <8883042e-49b4-4cba-b0f8-d12e4cfa3d6c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6KDNg6EiF8KCVOuLRHqzUZEHIdVFXXoTkO5FpC3paxc_1769505050
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2026-01-22T15:56:08Z Gabriele Monaco <gmonaco@redhat.com>:

> From: Nam Cao <namcao@linutronix.de>
>
> Add trace points into enqueue_task() and dequeue_task().
>

Peter,

can I have your Ack on this?

(Apologies for the spam, I sent it as HTML by mistake)

Thanks,
Gabriele

> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>
> Notes:
> =C2=A0=C2=A0=C2=A0 V5:
> =C2=A0=C2=A0=C2=A0 * Do not fire enqueue tracepoint for delayed enqueues
>
> include/trace/events/sched.h | 13 +++++++++++++
> kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 10 +++++++++-
> kernel/sched/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 ++
> 3 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 366b2e8ec40c..f4e1d3554e3e 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -912,6 +912,19 @@ DECLARE_TRACE(sched_dl_server_stop,
> =C2=A0=C2=A0=C2=A0 TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
> =C2=A0=C2=A0=C2=A0 TP_ARGS(dl_se, cpu));
>
> +/*
> + * The two trace points below may not work as expected for fair tasks du=
e
> + * to delayed dequeue. See:
> + * https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd=
.com/
> + */
> +DECLARE_TRACE(sched_enqueue,
> +=C2=A0=C2=A0 TP_PROTO(struct task_struct *tsk, int cpu),
> +=C2=A0=C2=A0 TP_ARGS(tsk, cpu));
> +
> +DECLARE_TRACE(sched_dequeue,
> +=C2=A0=C2=A0 TP_PROTO(struct task_struct *tsk, int cpu),
> +=C2=A0=C2=A0 TP_ARGS(tsk, cpu));
> +
> #endif /* _TRACE_SCHED_H */
>
> /* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f6293fa02fb7..c885d7885172 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2087,6 +2087,9 @@ unsigned long get_wchan(struct task_struct *p)
>
> void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> {
> +=C2=A0=C2=A0 if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_D=
ELAYED))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_sched_enqueue_tp(p, rq->cpu);
> +
> =C2=A0=C2=A0=C2=A0 if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_rq_clock(rq);
>
> @@ -2114,6 +2117,8 @@ void enqueue_task(struct rq *rq, struct task_struct=
 *p, int flags)
> =C2=A0 */
> inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> {
> +=C2=A0=C2=A0 int ret;
> +
> =C2=A0=C2=A0=C2=A0 if (sched_core_enabled(rq))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_core_dequeue(rq, p, flag=
s);
>
> @@ -2131,7 +2136,10 @@ inline bool dequeue_task(struct rq *rq, struct tas=
k_struct *p, int flags)
> =C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0 uclamp_rq_dec(rq, p);
> =C2=A0=C2=A0=C2=A0 rq->queue_mask |=3D p->sched_class->queue_mask;
> -=C2=A0=C2=A0 return p->sched_class->dequeue_task(rq, p, flags);
> +=C2=A0=C2=A0 ret =3D p->sched_class->dequeue_task(rq, p, flags);
> +=C2=A0=C2=A0 if (trace_sched_dequeue_tp_enabled() && !(flags & DEQUEUE_S=
LEEP))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_sched_dequeue_tp(p, rq->cpu);
> +=C2=A0=C2=A0 return ret;
> }
>
> void activate_task(struct rq *rq, struct task_struct *p, int flags)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e885a935b716..8465472b40fa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2918,6 +2918,8 @@ static inline void sub_nr_running(struct rq *rq, un=
signed count)
>
> static inline void __block_task(struct rq *rq, struct task_struct *p)
> {
> +=C2=A0=C2=A0 trace_sched_dequeue_tp(p, rq->cpu);
> +
> =C2=A0=C2=A0=C2=A0 if (p->sched_contributes_to_load)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rq->nr_uninterruptible++;
>
> --
> 2.52.0

