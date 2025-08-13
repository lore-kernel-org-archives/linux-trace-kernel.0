Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20C186295
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067848; cv=none; b=rPI+Z4lZOriiG0vtFZes/yNNJQA/6TyJ8sPy9kB5WbA9CDKWdlnAkdKh5TVGxZ90jfwlnaodpoosO7LcJ8Tkqt5jIS1WamWCDZzqGfQR0b2TyPcA4pOYck0AUWyjsIh9rC0r0WipRXgTHL2V2NJXkrjD+RPzpc51TtykCDwBe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067848; c=relaxed/simple;
	bh=xxsmGfIB2l5/wPHD/WOz/w+b0MyRap57FKzcECxVCdc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGeX9QxCOcQF4n3qMS5ifI9sEy/9CFYuS4n2ymKYqNz+Oc7GYatCIbGSa+FjHcMo2UoCy2i4thugD1dFp4moB85ARzHSb+yq5cmq7it6BpAc1LPCK4CqA8Pu16efreQ+DzyW63sU3YjPD3QGeHThBtZqjQ0xCX8bKhR8PurTl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDf7A5U2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDf7A5U2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755067845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xxsmGfIB2l5/wPHD/WOz/w+b0MyRap57FKzcECxVCdc=;
	b=SDf7A5U2ar/0/37CZn5e2pMJsv+8xi/vNkiUqxWb5NZ64zk+r77+kiWbRL/LoRzKuZbp4Y
	f4NIOBJsBQ34oIjFdLonPI4XBWTmLfm4CucNnE7pNjys99vM/Mn926bTlPAeVBFQHQ7yrK
	YUN00clHnevflPeZUqRZ0jpZk512M40=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-4K0MczT-MnSdE_n1sjYuYw-1; Wed, 13 Aug 2025 02:50:44 -0400
X-MC-Unique: 4K0MczT-MnSdE_n1sjYuYw-1
X-Mimecast-MFC-AGG-ID: 4K0MczT-MnSdE_n1sjYuYw_1755067844
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c7c30d8986so2126765685a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755067844; x=1755672644;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6w5eQUyqRO+CIDf7CkJT/ZVucOGIR0B1JUL4frXMV3k=;
        b=reGxWKlO266jfFpo+6elZfSpCV8bLMu+J0tTHPnh7KifF4xTfro4x3qyu0W2uYNLmc
         8BXlelU3x34Y5bpJ0euAiuP3jbizw1zwOAQ//HtkWY6QVfQco+ZJACi8y8lDqoZlwNTn
         PLlAsd5SE+grCJqR412SPjLlIM3xJvLLd5uoBLJ7OUzUHUmwYHxrm4xUFPD76sfvyCZW
         oe/3grO9i4Y46eO15FV/6umNpWMjWsxgaplz6ImnvNuW6fxx0Oi9fAE7PKNTTf0mmNZF
         NMk/2FDllSc6FKpSILktnb009Bq3gySNefe1hI7gpGmmaME2dvUl067t4O1K44MUuiMz
         Z8pA==
X-Forwarded-Encrypted: i=1; AJvYcCV9AkWK8KLImGG/9Z3ljXveT2aHi/eu4NhqcWtM/KBmXUzdrq3/8V0rfvwN7ZSGeg1LhBbEqt9AIoAzEI+tWyHypTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpeTmzZ2/7QM8MmpAUomuuYuzsFlgBj0JsyM3F1Cd+g3sCIhA
	1NL3KD14CtSj66mqiOr6NjfRqNbTzzlJoiX+rLNS7a1ITj5R+OcQr6/z1khQ9KtqNjtJHZ1Bl8e
	dMm6osNzt/+85lzfDoEqM1OohtppbpW1dYHujn3OH8An0vB2qthf6fuUPUIQEm53w1QEY6q3XFg
	==
X-Gm-Gg: ASbGnctxi9uWrNqZmbMZG1clnkXNpruB6HczQgD/CVO3+GoEjFckEeJrYL6EQU2OQ7Q
	js5E1OHK60zsgRHOoC0JqV6UddzEuB2KOqvz0wusNy/R4gPkZK7nHtERYWehLKBVp/tsiIPnEQn
	R7hpSid8IwmI0LAu/U0KJqWknBe06IudenaxpPpyMVYsgMqI7s22DGRVjzqvPms9qnYNPFfO9SY
	ExgN6SSCL90FH1OClYDZRUrHJr3K/ghonmmHFVSNhyTu0sek0q4bzq8CQ0DMp95E+3BpFfiZEOh
	GXvkbKmfEz/Eg1NWmn3f2FGPW7HJho7cwZInbNpHpfV1ubJMuTVGU2iQyfjGgQl8PQ==
X-Received: by 2002:a05:622a:408d:b0:4b0:7f93:3cdb with SMTP id d75a77b69052e-4b0fc8c724bmr22315031cf.43.1755067844120;
        Tue, 12 Aug 2025 23:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuShnNGJ7nGbvS9Hkfc1PmPGBF5ZFOBaHg2Zh9sPeWe34ZfQ7UBXLn3E+cyFDkg+ZnNoAHvg==
X-Received: by 2002:a05:622a:408d:b0:4b0:7f93:3cdb with SMTP id d75a77b69052e-4b0fc8c724bmr22314821cf.43.1755067843757;
        Tue, 12 Aug 2025 23:50:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07611dc5asm126034001cf.42.2025.08.12.23.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:50:43 -0700 (PDT)
Message-ID: <61d904e5dc673d398c20bc4359e0f9b16ef4fde4.camel@redhat.com>
Subject: Re: [PATCH v3 4/5] sched: Add task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot	
 <vincent.guittot@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall	 <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider	 <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>
Date: Wed, 13 Aug 2025 08:50:39 +0200
In-Reply-To: <918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
References: <cover.1754900299.git.namcao@linutronix.de>
	 <918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _hiNfisTvivK4BfaVfd64_XlzSPlj_wMd41W9D874N8_1755067844
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-08-11 at 10:40 +0200, Nam Cao wrote:
> Add trace points into enqueue_task() and dequeue_task(). They are
> useful to implement RV monitor which validates RT scheduling.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

Peter, Ingo, this patch adds new tracepoints in the scheduler do agree
with the change, can we get an Ack?

Thanks,
Gabriele

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> v3: fix up build issue on !SMP
> v2: Move the tracepoints to cover all task enqueue/dequeue, not just
> RT
> ---
> =C2=A0include/trace/events/sched.h | 13 +++++++++++++
> =C2=A0kernel/sched/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 8 +++++++-
> =C2=A02 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/trace/events/sched.h
> b/include/trace/events/sched.h
> index 7b2645b50e78..696d22af5a98 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -896,6 +896,19 @@ DECLARE_TRACE(sched_set_need_resched,
> =C2=A0=09TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> =C2=A0=09TP_ARGS(tsk, cpu, tif));
> =C2=A0
> +/*
> + * The two trace points below may not work as expected for fair
> tasks due
> + * to delayed dequeue. See:
> + *
> https://lore.kernel.org/lkml/179674c6-f82a-4718-ace2-67b5e672fdee@amd.com=
/
> + */
> +DECLARE_TRACE(enqueue_task,
> +=09TP_PROTO(int cpu, struct task_struct *task),
> +=09TP_ARGS(cpu, task));
> +
> +DECLARE_TRACE(dequeue_task,
> +=09TP_PROTO(int cpu, struct task_struct *task),
> +=09TP_ARGS(cpu, task));
> +
> =C2=A0#endif /* _TRACE_SCHED_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index be00629f0ba4..6367799aa023 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
> =C2=A0
> =C2=A0void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> =C2=A0{
> +=09trace_enqueue_task_tp(cpu_of(rq), p);
> +
> =C2=A0=09if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0=09=09update_rq_clock(rq);
> =C2=A0
> @@ -2119,7 +2121,11 @@ inline bool dequeue_task(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0=09 * and mark the task ->sched_delayed.
> =C2=A0=09 */
> =C2=A0=09uclamp_rq_dec(rq, p);
> -=09return p->sched_class->dequeue_task(rq, p, flags);
> +=09if (p->sched_class->dequeue_task(rq, p, flags)) {
> +=09=09trace_dequeue_task_tp(cpu_of(rq), p);
> +=09=09return true;
> +=09}
> +=09return false;
> =C2=A0}
> =C2=A0
> =C2=A0void activate_task(struct rq *rq, struct task_struct *p, int flags)

