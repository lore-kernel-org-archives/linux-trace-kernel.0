Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C3729CB32
	for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951174; cv=none; b=tNrIBlBU1LY0x3tsoBF08q5dTv8S0I9S5D42CwMf7oiOsliLdppvz+Dp1v/rVOCinfjkj0tN965mxLSucKSij8FkhBcMIyMlpoP93bOn115AWmMQTFTvtBQ74TX6q2yyuHjPB/qCBydtfGW4YyNjecviqMxziFTJjcdFagvNJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951174; c=relaxed/simple;
	bh=ScqaWIT05BcQ0HPRFwowC3ovmEJYqJ2vz0WF+Z0uITE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcB46UlAxX2c3b4MPs2XpLKE7Lr4FGRQ6XdwIDwhJlpJ8iC5cekIyHHVTfovqrVNNXUIzSMk3bwYcaZ2s7Si1JNZuhNpsyArTgIpLkvGKcALgirKkd4H3G57ksKbMLRt2XR8tKXEwmyzCp8nVo4wkGnnB0DYoUbjihh3orSzqnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCaIRez/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCaIRez/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753951171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ScqaWIT05BcQ0HPRFwowC3ovmEJYqJ2vz0WF+Z0uITE=;
	b=eCaIRez/SPbt9M2v20wO2NVY96rt1QA3S885ba4j1xYYUv5BNc+RVQww0z26nHVsoqUcfm
	h0pYAJMBzQ1Z4wCCftdzkTo6M+3MbUHuMzIXZJ00SB5JRWbSKe4jJ9hQfpNhz0ByP3nj8+
	el8+8//BeRyiYPPfrO5irnobmf2v1gg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-c6kC-JkTPeyI-s7d8s5Lnw-1; Thu, 31 Jul 2025 04:39:29 -0400
X-MC-Unique: c6kC-JkTPeyI-s7d8s5Lnw-1
X-Mimecast-MFC-AGG-ID: c6kC-JkTPeyI-s7d8s5Lnw_1753951168
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b788d00e26so276828f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753951168; x=1754555968;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7yP0szGzNbiy8cyqFmK1DSuaFl+Rz6XKugDUijkRpE=;
        b=apQQ3DIXhPRJzTPhHck3+Y6eJAdJ4L3o9FvbWHiCeINB2RftC/J2GL+gNrfEAmFT2H
         8B/km3CIYQTlYFvRk9+TkZllVQFBrsGT5efnBcrwAziMIpYs7XlEFmwKy+hkUigbz+hD
         +xm3dgwiMXhprMZO21XotQtHKuzhtILgQ8vPUu5LzCTXt55hjitEJ7qlpIb6f/Wa0cLv
         G83uM8wT5pZyQ1IXJgv/qaxL8xpPa7xBOOH+kT7hjn/xRfiGj9LN2CTMujIcQOMFrXeX
         pAcrCc4kSLXzRPaQq6Gbku9oz7bSgZLOql4sC/eGlnep13BxeNAq3PhMQtb7oChOBtaZ
         pUJw==
X-Forwarded-Encrypted: i=1; AJvYcCVPRsh+Pti+eCJU+h0+4t3sXtBogSg8XHAMgum53rv6jVmaYgwp2FcAnc0faX6cRJZrWc1d1WOuR4JbUn/5mKlkppE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLOKMr3mvHA2qnAJ/cJP5fzvHLNyh8hkxjv/bnnNq75dWJ/YtB
	PeBlQjgpY7MajINKQimQ12pS+t43qtl/x8WjvTk5m6Vtx9zGcYXwAGcWoeFfwvcZNSq0R3rmJYh
	mWfvbTvC2fhu2e4vTEfEecI5JMRVP9RNDatsQiLmrLp59PBU6nvJiqKkX2tVnsG09UqFHZSOLdg
	==
X-Gm-Gg: ASbGnctl0h6UJ3GXZcwU6G6qTFUDXijnp5Dx4apQujAyxNPnRhnbyfj9eB6lAxZFH4r
	S9Sy7/B3O/CWsZww851vMkfxQ/e2HkylmSLgQ7D4J4HeWVU3db1Mt9IVvi3O5W1VkuPjlt2Mw5Y
	qhSnA7FDBGfxg/TVPU37bUt++GgL7678+fLbwbpTSuL846ve5y4W1l2csVizKfHuMBCffDthewr
	fFVNn9W+3N/vchh1FQv5q/3sroBFYsaD+1Mm+08iUlLEhS3JBnhnJxqHFc4eRPDVXuGRT3x3wSd
	wKetMqyBIkYJzLhcXJ9c2oZ+gxSDG8zR7WDK7XLWAqzob4kWj7LiT2bzleqpXK/qkg==
X-Received: by 2002:adf:8b59:0:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3b79501e606mr3553006f8f.33.1753951168406;
        Thu, 31 Jul 2025 01:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlb7Q8yPGsqPrhTD0Y5orBknXFGcVgXJ65AHafvMuaqJXp4tRD1gmzSipBYjnC3cMeTlLrew==
X-Received: by 2002:adf:8b59:0:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3b79501e606mr3552988f8f.33.1753951167972;
        Thu, 31 Jul 2025 01:39:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9c7dsm1589327f8f.26.2025.07.31.01.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 01:39:27 -0700 (PDT)
Message-ID: <5a7c492bbad7d56f347ee629734fdbab275d6333.camel@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,  Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall	 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider	 <vschneid@redhat.com>
Date: Thu, 31 Jul 2025 10:39:25 +0200
In-Reply-To: <20250731073520.ktIOaGts@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
	 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
	 <20250730151818.7RemAREO@linutronix.de>
	 <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>
	 <20250731073520.ktIOaGts@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: hvGVWajqEO0DlffRT5AwEyFcMIPvOBxyLhAyMjFAI3s_1753951168
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-07-31 at 09:35 +0200, Nam Cao wrote:
> On Wed, Jul 30, 2025 at 06:18:45PM +0200, Gabriele Monaco wrote:
> > Well, thinking about it again, these tracepoints might simplify
> > things
> > considerably when tasks change policy..
> >=20
> > Syscalls may fail, for that you could register to sys_exit and
> > check
> > the return value, but at that point the policy changed already, so
> > you
> > cannot tell if it's a relevant event or not (e.g. same policy).
> > Also sched_setscheduler_nocheck would be out of the picture here,
> > not
> > sure how recurrent that is though (and might not matter if you only
> > focus on userspace tasks).
> >=20
> > If you go down the route of adding tracepoints, why not have other
> > classes benefit too? I believe calling them from the enqueue_task /
> > dequeue_task in sched/core.c would allow you to easily filter out
> > by
> > policy anyway (haven't tested).
>=20
> Something like the untested patch below?
>=20
> Will you have a use case for it too? Then I will try to accommodate
> your use case, otherwise I will do just enough for my case.

Well, I'm still defining the best set of tracepoints I need, if you see
it cleaner go ahead the way you're currently doing, then.
Unless anyone else complains let's keep it like this.

Thanks,
Gabriele

>=20
> Nam
>=20
> diff --git a/include/trace/events/sched.h
> b/include/trace/events/sched.h
> index c38f12f7f903..b50668052f99 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -906,6 +906,14 @@ DECLARE_TRACE(dequeue_task_rt,
> =C2=A0=09TP_PROTO(int cpu, struct task_struct *task),
> =C2=A0=09TP_ARGS(cpu, task));
> =C2=A0
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
> index b485e0639616..2af90532982a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2077,6 +2077,8 @@ unsigned long get_wchan(struct task_struct *p)
> =C2=A0
> =C2=A0void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> =C2=A0{
> +=09trace_enqueue_task_tp(rq->cpu, p);
> +
> =C2=A0=09if (!(flags & ENQUEUE_NOCLOCK))
> =C2=A0=09=09update_rq_clock(rq);
> =C2=A0
> @@ -2103,6 +2105,8 @@ void enqueue_task(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0 */
> =C2=A0inline bool dequeue_task(struct rq *rq, struct task_struct *p, int
> flags)
> =C2=A0{
> +=09trace_dequeue_task_tp(rq->cpu, p);
> +
> =C2=A0=09if (sched_core_enabled(rq))
> =C2=A0=09=09sched_core_dequeue(rq, p, flags);
> =C2=A0

