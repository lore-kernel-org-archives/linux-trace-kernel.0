Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2335B37269E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787519; cv=none; b=XSxRd0qYoavFIBWFsUyodLRGOMNYCHqVoqwtUsXjyaPeS1I0PYQwYkiiL6UxNLBCnY/ASD3N9VLqYZVWmnTrX0kZGeA4KxETcj30yiridVsg7kThhFKsrgH2fTC04x0YgLwAx54V+EKJ2uDQFVrgBiJfLulurOglruiEw+Q6fSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787519; c=relaxed/simple;
	bh=vK8EujEDrexBUyE9onbr5QObsp5hmCBAQnIt5+CgiI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DW+25IEw3Dad7I8XgDOrXCreHYXbTpj4snedR8ux0HGX0BUWs6GDUp4/E/iCKw1OeRw2kglVAe83Odx+LfBLwVX3XsTK4ZE9QNGa5YfQrv6Qu8eiuYaDp7lxIxhRqaNtLLm6no+mfvfen4YaVqEpx2tmgiX5berhmpMQ/ouHwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZPOUVtB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZPOUVtB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772787515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vK8EujEDrexBUyE9onbr5QObsp5hmCBAQnIt5+CgiI8=;
	b=bZPOUVtBHGeUi/+iWV3VKteHtlctYE0gsVXeO/87rdDS0s0QzBN6RuNGhvVY+11qERGJpc
	tWf1P7Nb/Nz5kIyJ5/FkRjZANLAdogkZZ74tvivyDcmccOrnodPDbd4vMqg7aoeSa+BPP6
	NvatOAoP6zMQ7KeCEhK++RgfeJEC0Lc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-aA2SOTLHPU63ClfqdO5rtA-1; Fri, 06 Mar 2026 03:58:33 -0500
X-MC-Unique: aA2SOTLHPU63ClfqdO5rtA-1
X-Mimecast-MFC-AGG-ID: aA2SOTLHPU63ClfqdO5rtA_1772787512
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483a24db6ecso112739465e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 00:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772787512; x=1773392312;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxrEfYB+045MQE9+euU6LuOafMviwFOmlDaX4FfzPLE=;
        b=IOMAmt8BBGOrAmBB98VvOdcIU4qOR5FNTF44Kws4ChddKpKFIFHq1bx3TRsZNf2Zwe
         gMyNP53aO0cn1kaNZnCQ3FKgAJ/bgUEG5D41fpj6PDsYFm/j0hzRWtHOlfS4pS6lfXoE
         WXmPuow+aHIji5PUaZE2NAATbWMRDS2cWWv233X5iARxXzDIVUBE+eoO6XKVphi3YICP
         Dm3IwJ2ZFc8ob7jgO7cpqinacy2lu520e/ErzfEjKvMOF2/ZKVm+5Bl1hArl3A/1FZGv
         w0PtnH5xCMp0eNH3uDVFR0TNKExZXhd6udEImkuP+1IO8Y6SgwQMX5vrOwBeZyNSa4UI
         FMIw==
X-Forwarded-Encrypted: i=1; AJvYcCU4O/P7JlYtghC0odu8TNWOKCPIX00cebyz41jEX2Up9SVcvrQ3CrVGF13+78jCOgbqPSoHatN1BBTrpVBh+SoUrFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKStY6hEnap2qJ7D68tzBeBpYSnGK2Cg2lfIYOJED4DTRdQiEd
	g4p3JxHtgo9b4uCkHFBc6B+5lTez/eRFdhoNtWryKRK9yDPJh6wB6sDiCJuS9tF4wW/MX4SBmVq
	+T8OS04z7gj1CWAyG7BnmgYBSfvtJCPJDTuK2Z5ceF3gG59VuT9703J4a7VeH9uD8GeDjl4eTLA
	==
X-Gm-Gg: ATEYQzwB8r6OV5pWHwtRRxXgGokyz88mrk5nk6bOkQOVN2RMZl6PuSJZzdpABsPw8yd
	UUOqtgZMfld018HqVFLuEYZH0Rm+ywfa6dJzfHuFWFak025TLT30zfQLgMO+C4aw4c+ZtWex/oR
	Ba18K6EWrNI5bSMj+1GplAXrssYapM2a8hv8y1PZX0YxBlWcFvYer0S3Zkn5EmJyTP3QclE5TKk
	JWGZ7aN93rpYZydAHwbM5mlw6z/B1kV63kbyGl+ca59QqLa/HJOREbUuM5iKz0LURAxpxc5pS+x
	20vcOXCR89nzB8CqGCMk6BUDJXA9cGnZF9itGvRTHmiU1DtwVrp0kL6HINXAcLNBMIOrQ5yOjSe
	uOtbaeCOCGxMr075v9tsHEOw6Rr9Xd6RIprtZxG6bcfiSSzpLgO14q/Vgl6IzJs13ZlwwuSugo1
	JOCr34RN4WFG+3PJ8=
X-Received: by 2002:a05:600c:8b83:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-48526957be7mr22259855e9.17.1772787512146;
        Fri, 06 Mar 2026 00:58:32 -0800 (PST)
X-Received: by 2002:a05:600c:8b83:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-48526957be7mr22259435e9.17.1772787511731;
        Fri, 06 Mar 2026 00:58:31 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681e3fsm19678165e9.6.2026.03.06.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 00:58:31 -0800 (PST)
Message-ID: <8eb489498632b4e73ce116b59ce7d649453620ef.camel@redhat.com>
Subject: Re: [PATCH v6 08/16] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, K Prateek
 Nayak	 <kprateek.nayak@amd.com>, linux-trace-kernel@vger.kernel.org
Date: Fri, 06 Mar 2026 09:58:29 +0100
In-Reply-To: <20260225095122.80683-9-gmonaco@redhat.com>
References: <20260225095122.80683-1-gmonaco@redhat.com>
	 <20260225095122.80683-9-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zGTU6S6oHIPZylrYLEtD3CveCANOEGIygUOEDg_4d_4_1772787512
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, 2026-02-25 at 10:51 +0100, Gabriele Monaco wrote:
> From: Nam Cao <namcao@linutronix.de>
>=20
> Add trace points into enqueue_task() and dequeue_task().
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Co-developed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>


Could I get your Ack to this?

Thanks,
Gabriele

> ---
>=20
> Notes:
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
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
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
> index 759777694c78..4ca79ff58fca 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -122,6 +122,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp)=
;
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
> +=09if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_DELAYED))
> +=09=09trace_sched_enqueue_tp(p, rq->cpu);
> +
> =C2=A0=09if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0=09=09update_rq_clock(rq);
> =C2=A0
> @@ -2120,6 +2125,8 @@ void enqueue_task(struct rq *rq, struct task_struct=
 *p,
> int flags)
> =C2=A0 */
> =C2=A0inline bool dequeue_task(struct rq *rq, struct task_struct *p, int =
flags)
> =C2=A0{
> +=09int ret;
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
> +=09if (trace_sched_dequeue_tp_enabled() && !(flags & DEQUEUE_SLEEP))
> +=09=09trace_sched_dequeue_tp(p, rq->cpu);
> +=09return ret;
> =C2=A0}
> =C2=A0
> =C2=A0void activate_task(struct rq *rq, struct task_struct *p, int flags)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b82fb70a9d54..a83177742603 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2944,6 +2944,8 @@ static inline void sub_nr_running(struct rq *rq,
> unsigned count)
> =C2=A0
> =C2=A0static inline void __block_task(struct rq *rq, struct task_struct *=
p)
> =C2=A0{
> +=09trace_sched_dequeue_tp(p, rq->cpu);
> +
> =C2=A0=09if (p->sched_contributes_to_load)
> =C2=A0=09=09rq->nr_uninterruptible++;
> =C2=A0

