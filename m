Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13533AFCFE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203286; cv=none; b=dRUulTCJWwWnX7TTsX7QdBJTdmBcTEoq7+zucbWzwqD2nnz2kwJYDPd0XCmQZPNyRNE9cJoNP4qqXubZLt7M/JRgsLzS94o0atZbi8IL/zXwtAJR8wVp67B6WIOdZ1YpA16vScz1ZyzR25oZgibtqJN2nv+1LbMHaBm+hYoE04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203286; c=relaxed/simple;
	bh=ojWO1BqAWecc4i9OmGGgJ1Z4AQn9aj/KsnplV/TNj8U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUZqaCmO5+4mZ3NKflSidSIGozBsWbE0HcAuCHCuJ3lw0Qo4U4pVyjaDJTyRterNkoO1/PbZwIsrNxcVzxz3uM8qBvj6D3Lwn8TDbC0ZlqCYtxJrm5JeCo59SLuMV8LT7QsqaH4DlZidRzo36dmId3BKQm2O5naMf5BDKpltbyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQgQGf4F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQgQGf4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779203284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ojWO1BqAWecc4i9OmGGgJ1Z4AQn9aj/KsnplV/TNj8U=;
	b=GQgQGf4FrXrZ6dHf9mL0VgJx5t1TwcvITa/6LetvrevCsSl4ifDEOnOR/0rupEYEtEfVZy
	kT8Uah6hOi5V3hbP07K+FKjDz7+SWyWQWKRhzDp9UlOE8DLGOpvQIsTdkHb4ljf5aoMiSS
	9deO+kjApULcJkMIU2qIvokxLCh+Ktg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-65FOHIrVMzuMH5w4z485gQ-1; Tue, 19 May 2026 11:08:02 -0400
X-MC-Unique: 65FOHIrVMzuMH5w4z485gQ-1
X-Mimecast-MFC-AGG-ID: 65FOHIrVMzuMH5w4z485gQ_1779203282
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48feb0298d7so31092635e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 08:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203281; x=1779808081;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSZiOlkDlGIKq/TICCQi9MAGkxXR/eUQ6KbBGR/Dyl0=;
        b=geRKw7/1sBW0RrfRelyW7I26S3fY5EUCFzJ1622PoiCMtITNGAATuYAoDjzIUuxIR4
         HDJKOkC0p3rmLx7o2kqo7g/T4oJj3fmJ+iTS+mf/mcvrcYDZcUomZaixQS5nyrQBhamC
         TYuVAdJHEqjoQayKY0sx8qgHuJd2gBl/ai9Z3lTy45Pw3DT0a+GtRWTIZui85jWxeZQR
         UZdGLvUWcBLfAII4LtOGumZZfrzwAxU7DHsH6PzTgyDDv933qSyjEGZAC3FiX+iR5d58
         g0cHDRnUqAgAMYKSAoScvwPoV5did0H9Ytj+rxLt5cJQLb6neONnzClJ3PuNM69yjhoI
         ikGw==
X-Forwarded-Encrypted: i=1; AFNElJ9lqwt/tNwKZ7czT4Kf7iW5ca6rbgSAtFvkbD+GqD1QAhMrsK9Cl/ON6HHn2UA2/aBMasLyLFrLKyK+tCbguTNyvVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPA/J5QLHSyApv7mVV5vR+qzbpUpZzjEP+UIC6xTOZBCwtIqVL
	E6d60ChLG0MEb894cwH+b0PkLVK2wIgw9bjIL+/I9LYAAQ4uttz/fkHLKr2t3saebml/IhKhlIb
	/th444/9MGRCbrGrePAhCs0AWoxuwz2PET2fZ5StX8U6PhGjQMGJnqPUPfU966MSySmtdTPbLqA
	==
X-Gm-Gg: Acq92OHtzxUPLpEo92KWVMV4dVrbA4fGVMoUJCXYa9zNihBpHS1lz4q+IfuT7ZFwK4z
	23db9c1F6qD6ubgDTpVQOdiGbS3v2pzmaqwq0eai84ER+f84S7rsYIeYcXzfmuZkP2vIdzttidt
	e+cDdn6kPIWfLG+7P3MO4V9Nu1QbLxrTvBHinx0zxVUaa3cdxWA04i4SY0JMvaUBxQccZjjK5Xh
	kvvHE4l/KU5pHUzksEW9J6iQODN8tWFA479dvE2pNruzXLKhFva+o5t0fw3Hz047+odjoHYQcZg
	V4QGuw+Jw9vB6I7WkhrjwmwUEaysxnahwHQApguFLvpeilMkbkmPYD8eSVkfsiLz6CxZQJg84W9
	oauUDO2jOCFR1Xx8YB/4Cl+ab1e+2fUSnqyzEGhOz8WUFGlKLbPcaqeqUGPWuK86mYyndgk72/v
	XUj10Ob65ul5blq90ABHeza8MPZw==
X-Received: by 2002:a05:600c:4e53:b0:490:1640:8269 with SMTP id 5b1f17b1804b1-490164089c7mr118530945e9.18.1779203281575;
        Tue, 19 May 2026 08:08:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4e53:b0:490:1640:8269 with SMTP id 5b1f17b1804b1-490164089c7mr118530395e9.18.1779203281120;
        Tue, 19 May 2026 08:08:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm46762871f8f.8.2026.05.19.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:08:00 -0700 (PDT)
Message-ID: <19cffa1267c6538e6310b0149b0367807af76ac0.camel@redhat.com>
Subject: Re: [PATCH 1/3] rv/rtapp/sleep: Make the error more informative for
 user
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Tue, 19 May 2026 17:07:59 +0200
In-Reply-To: <14242f444f7d2396c0c5a345f0099665d09a0ec5.1779176466.git.namcao@linutronix.de>
References: <cover.1779176466.git.namcao@linutronix.de>
	 <14242f444f7d2396c0c5a345f0099665d09a0ec5.1779176466.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fLQbxQEsqozj0XyWtkHvO_lCxCbaryZh8omyX4QSkeM_1779203282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-19 at 09:49 +0200, Nam Cao wrote:
> The rtapp/sleep monitor detects real-time tasks which go to sleep in an
> real-time-unsafe manner. If this happen, the monitor triggers a trace eve=
nt
> in the sched_wakeup tracepoint's handler.
>=20

Ok so here WAKE is no longer tied to the wakeup event but to the end of the=
 task
switch.

So what happens if a task was not sleeping but just got preempted? Wouldn't=
 that
trigger WAKE (though that isn't a real wakeup) without RT_FRIENDLY_WAKE ?

Thanks,
Gabriele

> However, the invoking context of that trace event is not the most
> informative, because of the stack trace of that event is the wakeup's cod=
e
> path which is not very helpful:
>=20
> 74.669317: rv:error_sleep: condvar[254]: violation detected
> =C2=A0=C2=A0=C2=A0 ltl_validate+0x345 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 handle_sched_wakeup+0x34 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 ttwu_do_activate+0xff ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 sched_ttwu_pending+0x104 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 __flush_smp_call_function_queue+0x15b ([kernel.kallsym=
s])
> =C2=A0=C2=A0=C2=A0 __sysvec_call_function_single+0x18 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 sysvec_call_function_single+0x66 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 asm_sysvec_call_function_single+0x1a ([kernel.kallsyms=
])
> =C2=A0=C2=A0=C2=A0 pv_native_safe_halt+0xf ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 default_idle+0x9 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 default_idle_call+0x33 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 do_idle+0x234 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 cpu_startup_entry+0x24 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 start_secondary+0xf8 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 common_startup_64+0x13e ([kernel.kallsyms])
>=20
> What would be much more valuable is the stack trace of the task itself.
>=20
> Change the update of WAKEUP from being in sched_wakeup trace point's
> handler to sched_exit trace point's handler. This makes the event happen =
in
> the task's context, making the stack trace far more informative for user:
>=20
> rv:error_sleep: condvar[254]: violation detected
> =C2=A0=C2=A0=C2=A0 ltl_validate+0x345 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 handle_sched_exit+0x39 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 __schedule+0x80f ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 schedule+0x22 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 futex_do_wait+0x33 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 __futex_wait+0x8c ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 futex_wait+0x73 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 do_futex+0xc6 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 __x64_sys_futex+0x121 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 do_syscall_64+0xf3 ([kernel.kallsyms])
> =C2=A0=C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77 ([kernel.kallsyms]=
)
> =C2=A0=C2=A0=C2=A0 __futex_abstimed_wait_common64+0xc6 (inlined)
> =C2=A0=C2=A0=C2=A0 __futex_abstimed_wait_common+0xc6 (/usr/lib/x86_64-lin=
ux-gnu/libc.so.6)
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index 8dfe5ec13e19..0a36f5519e6b 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -92,9 +92,9 @@ static void handle_sched_set_state(void *data, struct
> task_struct *task, int sta
> =C2=A0=09=09ltl_atom_pulse(task, LTL_ABORT_SLEEP, true);
> =C2=A0}
> =C2=A0
> -static void handle_sched_wakeup(void *data, struct task_struct *task)
> +static void handle_sched_exit(void *data, bool is_switch)
> =C2=A0{
> -=09ltl_atom_pulse(task, LTL_WAKE, true);
> +=09ltl_atom_pulse(current, LTL_WAKE, true);
> =C2=A0}
> =C2=A0
> =C2=A0static void handle_sched_waking(void *data, struct task_struct *tas=
k)
> @@ -200,7 +200,7 @@ static int enable_sleep(void)
> =C2=A0=09=09return retval;
> =C2=A0
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", sched_waking,
> handle_sched_waking);
> -=09rv_attach_trace_probe("rtapp_sleep", sched_wakeup,
> handle_sched_wakeup);
> +=09rv_attach_trace_probe("rtapp_sleep", sched_exit_tp,
> handle_sched_exit);
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", sched_set_state_tp,
> handle_sched_set_state);
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", contention_begin,
> handle_contention_begin);
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", contention_end,
> handle_contention_end);
> @@ -213,7 +213,7 @@ static int enable_sleep(void)
> =C2=A0static void disable_sleep(void)
> =C2=A0{
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", sched_waking,
> handle_sched_waking);
> -=09rv_detach_trace_probe("rtapp_sleep", sched_wakeup,
> handle_sched_wakeup);
> +=09rv_detach_trace_probe("rtapp_sleep", sched_exit_tp,
> handle_sched_exit);
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", sched_set_state_tp,
> handle_sched_set_state);
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", contention_begin,
> handle_contention_begin);
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", contention_end,
> handle_contention_end);

