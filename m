Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8E2D879A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883604; cv=none; b=GDW6FVps0Myx/tZEJ7jJn/zkGPesnPjBCPFUSm8zo91saiMhkjM1xV42c993k2QB7TCwifqtf08zr+VtvRI5M3hB6T70kld5ISopNRNBxxA5uvBkshEQU4AItjU8MAfffzD2F1BZi3j8umo4wP2nJQ28fOLbHboUhgRMlUhm65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883604; c=relaxed/simple;
	bh=wLwI8LqQkl0a8WpihQgf2W/kfgc7P0TfONGUqLvhwPs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvEnIr0ZQNsaD8BWh28D4p3VhT4wSdW2i6eQOQuTbzN/9g7sdSHOizr7C6rmGYMTjRDqSHJDtfEbagd+s48oF301Dt2JSSUqpDXTXbsxdNzAz/gs/oZ504fzwWI/VGpcXqKSxjk5njz1n+S3tTxY35L3d46VZQ9VELie3sOxiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZ+XYBkA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZ+XYBkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753883602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wLwI8LqQkl0a8WpihQgf2W/kfgc7P0TfONGUqLvhwPs=;
	b=VZ+XYBkAZbq1GIHPCgYCs52LY7t1U6uoHo7gTpLdUaLNpfQYTHcqymjDR1xadcymahc616
	/fcBGzypVUj3EIUet/deqBdnfAW4T+/rsMRg6JnH652IDsHkwnOypYu2i6sqplKZqjjNOw
	NxYyGquyIOvi2m/+cD1bgODWHV9XWz4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-dEhMvucvO2qoXzjmuxcxMg-1; Wed, 30 Jul 2025 09:53:18 -0400
X-MC-Unique: dEhMvucvO2qoXzjmuxcxMg-1
X-Mimecast-MFC-AGG-ID: dEhMvucvO2qoXzjmuxcxMg_1753883598
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b783265641so3313218f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753883598; x=1754488398;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5VhBNCPpXfQ0FMhPUPtPbpUbYNgD0vDQAOO3ufsUTQ=;
        b=ZV2juycjoDV7MQ/N7t7KCurtg/9pqQTdNoAqdhxK/10iHg5o7za9DHF1OKuGoqOv73
         7a//5pgw55YzKXAU+IfkSYePuJ/crOdJsa/Lo6cKPaaRwlLvaqrAC8xrBjGJyIlECD9G
         6BkaXZN7gqeeoo7vlw0kGB6foYELHjsvTLXYaiyVffL9YwdcDl926ErsckszWpQKcTcZ
         hIuQTfQRvZt9FUjWvbBh+J79G4POseNMHSug9S/XcwaojVv13tuw81GkZg8+qzAieNZQ
         BHQcrW1Zfx638QH0Q13EnGG39VfyHNS8qAxhMXDhu1Hjku/BRsKc0Q7LPu+1tb/0ZoMR
         nFUw==
X-Forwarded-Encrypted: i=1; AJvYcCUT83GwzfbhRNfsHxYCM6pI7gkSieqEip7KJvu8Ebi327ozQgW7XIHL5uLR4zWdXvFcB2bgApDY/lwWp/sWd4zFYsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyVv599g6DNizT/pEFpg5CLJV7d7R2VsGnXcGcT9VyhnpAMUVl
	G2XpXO8q8jMgpQVsjTTYf7GKAq70kfLMFLawUHuCEk3Sl3k4+DApZlTcHfz5Lh3sc+kRFnkhTwO
	coyzrSCFtMc6wHl9mVe+Ns0yWXQ8K2T1aLnnDvXt3oXPMmWwgHjLf63kYLTSnFdHtOQwnjPA4Ho
	4y409ZvgkU
X-Gm-Gg: ASbGncuA1Lz5BC9Bsv0In/nDs9bozHTyr3mfKMng7hgto5O3PlkrIPYsY7GiTEoYMj2
	PCrmSE+0PIZxMUQNfrUUUC9pC6n7xAOLt00/lGyDR2Ks6H6eSSMurX04A2oNQXxLX9TX0SCsZdP
	sdvD+Z4pv5vo1sqd43S8t7krM6ietJ9C8FcpRK0DGYH7avjXJNY+NZcHwAxB/DWbnYtP1ZzHeKs
	Hd4F6TNcVwyuljPBFvNJnOJTyBpi6zhmzhSkkNYhWDYZjtRTBV1Gsj0tvU0mX+M3ucSSIC6s8ie
	+5WIdP68/ZqOcoJgiB/femY4acq5cEDiahI2Tjlt7QT7rdB8LrJPxfmef2b4oT/S3A==
X-Received: by 2002:adf:a297:0:b0:3b7:970d:a565 with SMTP id ffacd0b85a97d-3b7970da81bmr1347977f8f.46.1753883597563;
        Wed, 30 Jul 2025 06:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbFEhzWYMwwTRQo1bdOhOzFaDIgbxaeTPnywGw4nVO9bfEoPrUNrdganQQ/iWkVZcrnq5VNw==
X-Received: by 2002:adf:a297:0:b0:3b7:970d:a565 with SMTP id ffacd0b85a97d-3b7970da81bmr1347953f8f.46.1753883597005;
        Wed, 30 Jul 2025 06:53:17 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b794a9d6a1sm3589006f8f.16.2025.07.30.06.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:53:16 -0700 (PDT)
Message-ID: <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>
Date: Wed, 30 Jul 2025 15:53:14 +0200
In-Reply-To: <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: mglIJ_anQjiqLtl5B8FfTU4lp9O8Jmi6DXsfYhFgRpI_1753883598
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> Add trace points into enqueue_task_rt() and dequeue_task_rt(). They
> are useful to implement RV monitor which validates RT scheduling.
>=20

I get it's much simpler this way, but is it that different to follow
the task's existing tracepoints?

* task going to sleep (switch:prev_state !=3D RUNNING) is dequeued
* task waking up is enqueued
* changing the tasks's policy (setpolicy and setattr syscalls) should
enqueue/dequeue as well

This is more thinking out loud, but I'm doing right now something
rather similar with the deadline tasks and this seems reasonable, at
least on paper.

What do you think?

Thanks,
Gabriele

> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
> =C2=A0include/trace/events/sched.h | 8 ++++++++
> =C2=A0kernel/sched/rt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 4 ++++
> =C2=A02 files changed, 12 insertions(+)
>=20
> diff --git a/include/trace/events/sched.h
> b/include/trace/events/sched.h
> index c08893bde255..c38f12f7f903 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -898,6 +898,14 @@ DECLARE_TRACE(sched_set_need_resched,
> =C2=A0=09TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> =C2=A0=09TP_ARGS(tsk, cpu, tif));
> =C2=A0
> +DECLARE_TRACE(enqueue_task_rt,
> +=09TP_PROTO(int cpu, struct task_struct *task),
> +=09TP_ARGS(cpu, task));
> +
> +DECLARE_TRACE(dequeue_task_rt,
> +=09TP_PROTO(int cpu, struct task_struct *task),
> +=09TP_ARGS(cpu, task));
> +
> =C2=A0#endif /* _TRACE_SCHED_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index e40422c37033..f4d3f5e7fbec 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1480,6 +1480,8 @@ enqueue_task_rt(struct rq *rq, struct
> task_struct *p, int flags)
> =C2=A0{
> =C2=A0=09struct sched_rt_entity *rt_se =3D &p->rt;
> =C2=A0
> +=09trace_enqueue_task_rt_tp(rq->cpu, p);
> +
> =C2=A0=09if (flags & ENQUEUE_WAKEUP)
> =C2=A0=09=09rt_se->timeout =3D 0;
> =C2=A0
> @@ -1501,6 +1503,8 @@ static bool dequeue_task_rt(struct rq *rq,
> struct task_struct *p, int flags)
> =C2=A0
> =C2=A0=09dequeue_pushable_task(rq, p);
> =C2=A0
> +=09trace_dequeue_task_rt_tp(rq->cpu, p);
> +
> =C2=A0=09return true;
> =C2=A0}
> =C2=A0

