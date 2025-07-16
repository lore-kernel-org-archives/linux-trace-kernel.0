Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FD1A239A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673221; cv=none; b=KVNarqv9Rwc/5qIXbLegrPbE9OMitzodHfAxtKKnrrp+jsw2XM14tHyD9CV3f6Eeoos+J4PhS36UoDz6guEs+APclgl7g97mwLBFeEaR5WDPT8idfZ9SClsrK4OlmLVDsiyki3BoqasCLZznxw6Q12G19iZCCcjq9vI/joIJJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673221; c=relaxed/simple;
	bh=hDo0oZp/RvF9+zt4WAB3z6hq7La8avejZPb1jhvzIqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqtWrJMnDiyimbYDFxshHAZAg9+WlcpZJOZxbuLr5+wI8DCCmIsURpBQAiX85iU4/6b9SD53+M1gturX3pPO8Oi8qELWGobI86mv+0yli8LBuCbGlGeuWWqs4ZIfiwZmqiYsLRNvjWeFYeBT5UmtPSWEE2XsSwQLJPVDSbliQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ba9+9Du4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba9+9Du4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hDo0oZp/RvF9+zt4WAB3z6hq7La8avejZPb1jhvzIqo=;
	b=Ba9+9Du4eOiwwlThWfk0jWnMcITldTls8pYiHi9ZKZyiN+gFv3CrqlK3BrUSgSRXX8nRMq
	iHSW2kETwbY7qL0jLbICyGoXSjSR9cFhiYoD8r8h0+qhomKuP0GCbCKYlpA1ml2Dk+nMLO
	eejuBiKbUXXqQo0UdYjdXR8vXTgxn1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Jfr3cH4LPheVzicTej7UXQ-1; Wed, 16 Jul 2025 09:40:17 -0400
X-MC-Unique: Jfr3cH4LPheVzicTej7UXQ-1
X-Mimecast-MFC-AGG-ID: Jfr3cH4LPheVzicTej7UXQ_1752673216
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45359bfe631so38492925e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673216; x=1753278016;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xcsjq/dO2PUW1+oxW2qeKYxLQBhQLnckvL4DMbD0J8=;
        b=QLrIIrMY2yRmJ+cnskx86KFpdfZhZX3dh4MlsuITmUAIegyUaWwtwXwnE7faVeReDQ
         Y0IeifG9idBHLARPRmfttOireuylASN6Nj9k3NziE7z8Rct+FFSritHINcKlEcrGXN2u
         BvUP+dsn1a2XpH/ChVKHoqE/yEAEyK0ATVkJqVRJ6bhE3b+NHkuH1plEzQ07MP+p90Td
         S5fmUz/TjnZfSRKMaJWPvPq2STxzQFCDaO38qZEdCmgry6RTZIANofAZO+YuYSpmTMng
         /1YviGimpEs0ULiAZRhg7m4xq4Wh09b5eZazKdZSzOGWJRT5DBD2TV2s8l/P7/4UpYJn
         hktw==
X-Forwarded-Encrypted: i=1; AJvYcCUv2MSnvUBbhg6Ve5OCAoE/sqJEpYmdBOryt8XJJKzT951sMjPLP/n/TQmIp5TCYLNY6c09EK7Hn+V7/zEy04Iui3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfpUzJ7zieuv7yNUNXVmBStMOjRAISCZ4/iMOQSjf1QsfXc6W
	ofOI2FT/Y/U0yOMTqOx89IHjtIeyewZO5Ljc3HqzPHKMR5wML0yYXJp7MoAlGGVqFexcpZ3haaS
	C1vKWyq/aKVWwoOM4diMMW+jQrH5GV7srMJN1UadwdHto+7uyFv06V2rqHqoutY7hILlPjoQ0o2
	4QtY3e9uDv
X-Gm-Gg: ASbGncveInxwFVbUZAAUv9uLaSmrYrSIQwODcUHzOc49/sPC/tfSAbF2I73FyiLQoRW
	z9rKeLDLnILNlc3nEOyoHIUB6jsIqO7wRetaE2NCPfsRvOujmC9smQdfmI/CVP7I1oVyI9qzoLS
	NzE3Pj3cAoX3nJ4dzuL1qF/JkYvD+RKM3b9L3p6Q4hOJaH7iSJv6moNrowq9tUzjWoHWVCqUrjd
	PmzZcpxTphdIUp/dvTZIrVj6oU4sDVGfQGigt5ty/9mMOoBh9B8FDFk+VkXLia8sUpl11yt++mE
	nJVfu1pJYAkz+xXr4fYNe9GRF6ksF5fXScZL84qgHs7x2PiKL9nQ126KqLbCAxy0Dg==
X-Received: by 2002:a05:600c:4590:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4562dfe7998mr35600155e9.12.1752673216021;
        Wed, 16 Jul 2025 06:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmL4ysrFH4w0DELpct967Iu0YF4NtKCmmoy2wzP/5le1HZ4rifdgWb0k5u+DI9u9En6Wo/hg==
X-Received: by 2002:a05:600c:4590:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-4562dfe7998mr35599565e9.12.1752673215500;
        Wed, 16 Jul 2025 06:40:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm18042152f8f.71.2025.07.16.06.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:40:15 -0700 (PDT)
Message-ID: <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 15:40:13 +0200
In-Reply-To: <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: T2XlYTH8hF4fXp5WokW48mH8hH3DWqAdY727iNf8wus_1752673216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-16 at 14:38 +0200, Peter Zijlstra wrote:
> On Tue, Jul 15, 2025 at 09:14:29AM +0200, Gabriele Monaco wrote:
> > Add the following tracepoints:
> > * sched_set_need_resched(tsk, cpu, tif)
> > =C2=A0=C2=A0=C2=A0 Called when a task is set the need resched [lazy] fl=
ag
> > * sched_switch_vain(preempt, tsk, tsk_state)
> > =C2=A0=C2=A0=C2=A0 Called when a task is selected again during __schedu=
le
> > =C2=A0=C2=A0=C2=A0 i.e. prev =3D=3D next =3D=3D tsk : no real context s=
witch
>=20
> > @@ -6592,6 +6598,7 @@ static bool try_to_block_task(struct rq *rq,
> > struct task_struct *p,
> > =C2=A0=09int flags =3D DEQUEUE_NOCLOCK;
> > =C2=A0
> > =C2=A0=09if (signal_pending_state(task_state, p)) {
> > +=09=09trace_sched_set_state_tp(p, TASK_RUNNING, true);
> > =C2=A0=09=09WRITE_ONCE(p->__state, TASK_RUNNING);
> > =C2=A0=09=09*task_state_p =3D TASK_RUNNING;
> > =C2=A0=09=09return false;
>=20
> I'm confused on the purpose of this. How does this relate to say the
> wakeup in signal_wake_up_state() ?
>=20
> > @@ -6786,6 +6793,7 @@ static void __sched notrace __schedule(int
> > sched_mode)
> > =C2=A0=09=09rq =3D context_switch(rq, prev, next, &rf);
> > =C2=A0=09} else {
> > =C2=A0=09=09rq_unpin_lock(rq, &rf);
> > +=09=09trace_sched_switch_vain_tp(preempt, prev,
> > prev_state);
> > =C2=A0=09=09__balance_callbacks(rq);
> > =C2=A0=09=09raw_spin_rq_unlock_irq(rq);
> > =C2=A0=09}
>=20
> Hurmph... don't you already have this covered by:
> trace_sched_exit_tp() ?
>=20
> Specifically, the only case where is_switch :=3D false, is this case.

Mostly, it may work in some cases, but sched_exit happens with
interrupt enabled while all types of switches (including the vain ones)
must occur with interrupt disabled.

Some assumptions don't stand without this tracepoint, but I guess I
could adapt monitors to live without this if you believe it's not worth
adding a new tracepoint there.

Thanks,
Gabriele

