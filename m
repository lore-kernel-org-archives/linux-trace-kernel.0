Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362EF314A64
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Feb 2026 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116815; cv=none; b=IV29DGJDpWChdXyuk9BlmIUwkgCkdKL5IMlgFva3eRze/Ps8p33EN/2Sb5AFv12++3yZS2Zv7GqMr7B1WJ3bXSOfWyvX5RcBFOgMA0lyGLTsip8zTy7EPQBfHqDFeMSH+IPvgldoVP2Acj/TubBKS7yvfhrRbSc5d+I3Vwww4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116815; c=relaxed/simple;
	bh=pDhlWexMYaHd6yl6my1Zl7TgbEf6uCNTyqHK3sePJq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFJwA/h8dzFqmgAyxr4Tbd43fY23tPhQYMymLv4RcvNnbdeXMMRCI7pDWxmiNq4YCpU970j4bcnsuRA26LsTKgvZ3PpDIDkOM/WNtSoqRoC4/x58GG0JGgSOj9qn5p3AK98ZGPM7e7Wq8zThTSjMT+BnvMj0EtzqQSIdZ3NDkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+fnQy/b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+fnQy/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770116813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pDhlWexMYaHd6yl6my1Zl7TgbEf6uCNTyqHK3sePJq4=;
	b=a+fnQy/bXOqJeyVE9ceYGhjetvwE558GYOQ+KmVnduJOQYcqMKkRjdEMItBlawmDQvkgbW
	xYHZyQN+2PUYE3lb613u0nT48l4g6oSfhYq3nA9X2YKB4/mgCbZ8G2Is4VCWu565rvW7Bl
	1T31croN4knymil18hh9KIIpclwlqvc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-lwku9qsFOO-XUhkrYBfbyQ-1; Tue, 03 Feb 2026 06:06:52 -0500
X-MC-Unique: lwku9qsFOO-XUhkrYBfbyQ-1
X-Mimecast-MFC-AGG-ID: lwku9qsFOO-XUhkrYBfbyQ_1770116811
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435add03f12so3574887f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Feb 2026 03:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116811; x=1770721611;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EnBfBF6ncrVF3ITSzGDAM65zKqLHl8wgFMMouqTe84=;
        b=F9RDTbtfxwduHtqOt/U3XyrCm+ohty1xIT7Wb9E+E2KlUXHaWFezrd/3OvyPCbO1he
         0Zrl3UzW5WcXDm5Vm3NADl4RkjStgOJ2VbJhtl7EIyAFsh6qKrQ/WQxtvovDhzQAuORw
         228Kvri8BtDx5S6Ch4kBQ1VyoV1Ce0lzQbCzrrQj45egJArkfc/3aFLVJYOS5PrtFsmP
         dq4TS1Cda4SYBy4EwSL/3WUJy+7LW3L0gO4hgdZUvLgpFlFNcHa4cwyJZYdF+2VDwUFp
         iCbgFdB2AnqwMqktwiwXcPcSbF0LzeFgYU63RoDh6j5UuQ2pPFoGMQneYMS2U/EfKZJu
         mMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeYCFIcOI0VMoU4iD10W4NQv0qmtkjctPa8cOQLOCyD2Rw1uLh4dG6zajwBBvSMt0DSH4CzKS2sE2XdUYRgwi0evU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBVHYAOjPMy3ezE5O6dbqICyT4s4RJ5zz8o6fz3aOwhqn4Nu3
	JxOkLcrSdEqeVbkBo8USguB0SE300jpPj4HW4Ct45dliw/KIsA0sSRsL+DEJiHCKb7USYOi5Tta
	171gtpYF5ziKzM0oYmwXiiMxb7vK4L/TbCPMI8eVEVoYdHTI80rXOCoQnNAJdrrltdzw/a5nzdQ
	==
X-Gm-Gg: AZuq6aJrUuIyLxOQrVJp3iojelnHN3rSp+W/s2de9zl4u73WK33wj2Eu+sOljk8DW3m
	H/giiZqFuuOHqiwTupmNQQrCwj/ujjoVkH8o8IyJQVlJ5/5Vm120lUNR5Zle1TT8fec5X1bEBhv
	DBb87CWqwSK3+6vFi0hsc5C/xj6DCrZt8EKbiRxJHYXDtTpRjbTQ3wnc6rOLhDi+QLDgnS9PGCS
	Rc8/Hb5tjSwo4Sy1vl0ZDsbTkxYUfLcC8iYyCJQqee2kZtG5+PLkI6RSLb655ZDwng28Q5wmDUO
	C+5B5H2DpTi2che0xVvgDay1Bn6EUAFBXALIcnftOV417+2RaFsFAuMIErBFG/G0MhmVbO6IXyW
	q3JGu2tcASJONtG++CNTWUDMNB9OJn1KKpVjtJ+LOz79vZbdwoVXE2hkWv/SM5Hdg8zAwxhN+Q5
	T80nWD1aqN
X-Received: by 2002:a5d:5f82:0:b0:431:266:d134 with SMTP id ffacd0b85a97d-435f3ab2f8bmr24609439f8f.53.1770116810806;
        Tue, 03 Feb 2026 03:06:50 -0800 (PST)
X-Received: by 2002:a5d:5f82:0:b0:431:266:d134 with SMTP id ffacd0b85a97d-435f3ab2f8bmr24609405f8f.53.1770116810370;
        Tue, 03 Feb 2026 03:06:50 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e135422csm53330238f8f.40.2026.02.03.03.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 03:06:49 -0800 (PST)
Message-ID: <b348f7ade8b028e3affe911da287b15640f012fe.camel@redhat.com>
Subject: Re: [PATCH v5 09/15] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Tomas Glozar
 <tglozar@redhat.com>,  Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>, linux-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, Juri Lelli
 <jlelli@redhat.com>,  Ingo Molnar <mingo@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Date: Tue, 03 Feb 2026 12:06:48 +0100
In-Reply-To: <20260122155500.362683-10-gmonaco@redhat.com>
References: <20260122155500.362683-1-gmonaco@redhat.com>
	 <20260122155500.362683-10-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dG9IZaYD1WHXIlVtZiJk5Zm-q7PiqSG8g1FaOu0_LtY_1770116811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Thu, 2026-01-22 at 16:54 +0100, Gabriele Monaco wrote:
> From: Nam Cao <namcao@linutronix.de>
>=20
> Add trace points into enqueue_task() and dequeue_task().

Can I have an Ack for these tracepoints?

Thanks,
Gabriele

>=20
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>=20
> Notes:
> =C2=A0=C2=A0=C2=A0 V5:
> =C2=A0=C2=A0=C2=A0 * Do not fire enqueue tracepoint for delayed enqueues
>=20
> =C2=A0include/trace/events/sched.h | 13 +++++++++++++
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 10 +++++++++-
> =C2=A0kernel/sched/sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 ++
> =C2=A03 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 366b2e8ec40c..f4e1d3554e3e 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -912,6 +912,19 @@ DECLARE_TRACE(sched_dl_server_stop,
> =C2=A0=09TP_PROTO(struct sched_dl_entity *dl_se, int cpu),
> =C2=A0=09TP_ARGS(dl_se, cpu));
> =C2=A0
> +/*
> + * The two trace points below may not work as expected for fair tasks du=
e
> + * to delayed dequeue. See:
> + * https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd=
.com/
> + */
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
> index f6293fa02fb7..c885d7885172 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2087,6 +2087,9 @@ unsigned long get_wchan(struct task_struct *p)
> =C2=A0
> =C2=A0void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> =C2=A0{
> +=09if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_DELAYED))
> +=09=09trace_sched_enqueue_tp(p, rq->cpu);
> +
> =C2=A0=09if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0=09=09update_rq_clock(rq);
> =C2=A0
> @@ -2114,6 +2117,8 @@ void enqueue_task(struct rq *rq, struct task_struct=
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
> @@ -2131,7 +2136,10 @@ inline bool dequeue_task(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0=09 */
> =C2=A0=09uclamp_rq_dec(rq, p);
> =C2=A0=09rq->queue_mask |=3D p->sched_class->queue_mask;
> -=09return p->sched_class->dequeue_task(rq, p, flags);
> +=09ret =3D p->sched_class->dequeue_task(rq, p, flags);
> +=09if (trace_sched_dequeue_tp_enabled() && !(flags & DEQUEUE_SLEEP))
> +=09=09trace_sched_dequeue_tp(p, rq->cpu);
> +=09return ret;
> =C2=A0}
> =C2=A0
> =C2=A0void activate_task(struct rq *rq, struct task_struct *p, int flags)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e885a935b716..8465472b40fa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2918,6 +2918,8 @@ static inline void sub_nr_running(struct rq *rq,
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

