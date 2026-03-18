Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C33115B5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848691; cv=none; b=m0NjU6BOVtddQrycDskPoge8wDVela7RQ7Ern35YfUNlpom3OMPJexWx/tZzY8RBNdeiaQMOuzX3zCMYzY30vgckg4eNvidmSaASAV99Zn19on7PLDrnSY0G0HzhGGAMsjw29CrD+woRHLOax0RXfHt0PF8Cll5bUT5l9EAkCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848691; c=relaxed/simple;
	bh=Qx2NWVA3JwCE/09nWFhvh47FrgRRk1QpCN3BdUvxx50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKi2jXAYOMTipi9HGYdpC94gU9tecLhFlPIoLru7l6QBCoZ0cweQqmo0o3ZghAIY729XL5xwtSBB/6oz5c5fSMVaTWpx/Pb3voENdh1Dws7V7aXW9YiG9EK5KUycd8QIv5nP1lCfxAK8INaq909u7eLY0iT8iQrwj3/bwudNUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPHDJTt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPHDJTt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773848686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx2NWVA3JwCE/09nWFhvh47FrgRRk1QpCN3BdUvxx50=;
	b=IPHDJTt1MmYucjLp9WAaptr9tHzLtam3xAwMcqInOUh5r2EMmleb8L3JM5xui8uwSp5h21
	lyYqn2VkJQVM9sXm7TvrM9xhUiT4c4IwmQw3G0aPbcGagyH3XrLuDNlMDVoeKAWldgM0I0
	BXC6REWPHhObt3SCMLs7jUuBxVO2Jyc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-LbRE5MbHMQmxVC8xVk-EzQ-1; Wed, 18 Mar 2026 11:44:39 -0400
X-MC-Unique: LbRE5MbHMQmxVC8xVk-EzQ-1
X-Mimecast-MFC-AGG-ID: LbRE5MbHMQmxVC8xVk-EzQ_1773848678
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b46b2b161so3291974f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 08:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773848678; x=1774453478;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LESUGcaG78coVQnZtnSJQ6wL5uHkv7Ld/Kg5l704lIY=;
        b=sVB7SFHuReGvwi3AjJxiED2vvtPE2pbkX92utWH5cjgSLkazKTdqU71433O/IMv3ev
         kDEVpio+E4sr+XXx6KQqcxYCqdYGVXxMPXLxCJsk1nDVUCg63rVJkSfh6mpvbVTeklqq
         R2vDX1/HhJyfl1MQRXdyaaVLH6SIeQkS6gF9PTqcRAtpsuMYskr4AKN4O9BDVQ/nEw4g
         m5P1XceVs+uy9NZGSDLaGsVxES0xjF/wOCmL9pBhSLdXgfiXlScOnE1jJ7MSW2eaAi1H
         gchYk9Z7A8UoUox19uuWFceJMmMM8fFyAb2No8GVK1sxOkz9V0cergQQ2PnkR7sd1/zR
         LUmw==
X-Forwarded-Encrypted: i=1; AJvYcCV4PyOuiSTFlQUbmnKGSBzw1rzuHoP7GD3pKcUerRyz8pEl02X57smRJJKZckBSh41cBydo2hZ/dWwUtdle8MRtXtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJ2gjeyWRPM54kCD09wu0xuZ4V73Qgw0i+7BwHrswQp5gfNfk
	dY3z0aRuTCjeQoUiE3iJtZPeKQqBN770VL+m4Mc+H4qzJ6Z9ukvdzMxcILpWzzUz8WtizSTerbI
	uYh3Z72CTNXpPW4vyC26c7DZXIjLIg/WU55cmgR6PvCoBWksqtO1+SLjd9n+xTklw6hGUJb6slA
	==
X-Gm-Gg: ATEYQzxI3vU5+m0RMc1n6fgW5Afd0AXsw5UggRtCYgj6b9zee3DaHGbIH4Z4Pfg0Lyf
	gqp5uRk+mXG8eqPJp/mcBhUmg2RG4bcXqogr9QOuCqhT3wevQ8N9cX3u8CNPLnqdM2fbd+fsrQk
	PgIWKEH5GdQOVj6KyU53drXZx/CeJ+v22lf9D3toTLxrJSMgdS6H7hLBpj7YpgWqKTpk0sXFXaC
	jJcchCTG6KoSfErrsvoOr1q7V15olgUaG9adKdxoMSeFg9ZRwXmwyreI7KitM7qcoBYCxUw59qJ
	1OvlIS2BlLdsLorqJQ9T+0qiu2re6Gklli/fy7VIG0YHveVtXwJaR78gEqDiEk/fLe0TSakA8Kp
	ux7bJ5l1r71JimuoyQ4eBflJnTQ==
X-Received: by 2002:a05:6000:2dc5:b0:43b:433f:95c9 with SMTP id ffacd0b85a97d-43b527c4e15mr6772128f8f.35.1773848677995;
        Wed, 18 Mar 2026 08:44:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc5:b0:43b:433f:95c9 with SMTP id ffacd0b85a97d-43b527c4e15mr6772075f8f.35.1773848677496;
        Wed, 18 Mar 2026 08:44:37 -0700 (PDT)
Received: from [192.168.1.166] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5184961csm9522411f8f.6.2026.03.18.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:44:36 -0700 (PDT)
Message-ID: <93326862189ea258b17edfd2a272be82834092fa.camel@redhat.com>
Subject: Re: [PATCH v7 08/15] sched: Add task enqueue/dequeue trace points
From: gmonaco@redhat.com
To: Peter Zijlstra <peterz@infradead.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 Juri Lelli <jlelli@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,  K Prateek Nayak <kprateek.nayak@amd.com>,
 Tomas Glozar <tglozar@redhat.com>, Clark Williams <williams@redhat.com>, 
 John Kacur <jkacur@redhat.com>
Date: Wed, 18 Mar 2026 16:44:34 +0100
In-Reply-To: <20260310105627.332044-9-gmonaco@redhat.com>
References: <20260310105627.332044-1-gmonaco@redhat.com>
	 <20260310105627.332044-9-gmonaco@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z6lVCAcyBjRzCfJ6Ft1Ohv78EDBjUM6ejbP8_DO-MP4_1773848678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, 2026-03-10 at 11:56 +0100, Gabriele Monaco wrote:
> From: Nam Cao <namcao@linutronix.de>
>=20
> Add trace points into enqueue_task() and dequeue_task().
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Co-developed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

Could I get an Ack for this?

Thanks,
Gabriele

>=20
> Notes:
> =C2=A0=C2=A0=C2=A0 V7:
> =C2=A0=C2=A0=C2=A0 * Use cpu_of(rq) helper in tracepoint calls
> =C2=A0=C2=A0=C2=A0 V5:
> =C2=A0=C2=A0=C2=A0 * Do not fire enqueue tracepoint for delayed enqueues
>=20
> =C2=A0include/trace/events/sched.h |=C2=A0 8 ++++++++
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 12 +++++++++++-
> =C2=A0kernel/sched/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> =C2=A03 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/trace/events/sched.h
> b/include/trace/events/sched.h
> index 7b2645b50e78..5844147ec5fd 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -896,6 +896,14 @@ DECLARE_TRACE(sched_set_need_resched,
> =C2=A0=09TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> =C2=A0=09TP_ARGS(tsk, cpu, tif));
> =C2=A0
> +DECLARE_TRACE(sched_enqueue,
> +=09TP_PROTO(struct task_struct *tsk, int cpu),
> +=09TP_ARGS(tsk, cpu));
> +
> +DECLARE_TRACE(sched_dequeue,
> +=09TP_PROTO(struct task_struct *tsk, int cpu),
> +=09TP_ARGS(tsk, cpu));
> +
> =C2=A0#endif /* _TRACE_SCHED_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b7f77c165a6e..c9ca1e048612 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -122,6 +122,8 @@
> EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(sched_entry_tp);
> =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
> =C2=A0EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_enqueue_tp);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_dequeue_tp);
> =C2=A0
> =C2=A0DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> =C2=A0DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
> @@ -2094,6 +2096,9 @@ unsigned long get_wchan(struct task_struct *p)
> =C2=A0
> =C2=A0void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> =C2=A0{
> +=09if (trace_sched_enqueue_tp_enabled() && !(flags &
> ENQUEUE_DELAYED))
> +=09=09trace_sched_enqueue_tp(p, cpu_of(rq));
> +
> =C2=A0=09if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0=09=09update_rq_clock(rq);
> =C2=A0
> @@ -2120,6 +2125,8 @@ void enqueue_task(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0 */
> =C2=A0inline bool dequeue_task(struct rq *rq, struct task_struct *p, int
> flags)
> =C2=A0{
> +=09bool ret;
> +
> =C2=A0=09if (sched_core_enabled(rq))
> =C2=A0=09=09sched_core_dequeue(rq, p, flags);
> =C2=A0
> @@ -2136,7 +2143,10 @@ inline bool dequeue_task(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0=09 * and mark the task ->sched_delayed.
> =C2=A0=09 */
> =C2=A0=09uclamp_rq_dec(rq, p);
> -=09return p->sched_class->dequeue_task(rq, p, flags);
> +=09ret =3D p->sched_class->dequeue_task(rq, p, flags);
> +=09if (trace_sched_dequeue_tp_enabled() && !(flags &
> DEQUEUE_SLEEP))
> +=09=09trace_sched_dequeue_tp(p, cpu_of(rq));
> +=09return ret;
> =C2=A0}
> =C2=A0
> =C2=A0void activate_task(struct rq *rq, struct task_struct *p, int flags)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 43bbf0693cca..d7ab0aa58a70 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2955,6 +2955,8 @@ static inline void sub_nr_running(struct rq
> *rq, unsigned count)
> =C2=A0
> =C2=A0static inline void __block_task(struct rq *rq, struct task_struct
> *p)
> =C2=A0{
> +=09trace_sched_dequeue_tp(p, cpu_of(rq));
> +
> =C2=A0=09if (p->sched_contributes_to_load)
> =C2=A0=09=09rq->nr_uninterruptible++;
> =C2=A0

