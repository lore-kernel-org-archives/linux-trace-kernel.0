Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1347ECD6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911298; cv=none; b=X1SPtNLaHb5WbNg3oOMcxgbktgexuTJNq5G+L1zn7NHNscAdeUlGLZ1ON3hentmt957ytBsny/reoq/Row9ObxS/3x5K2aCOk2NmCyzqynx1kwoiM1zRTp+Q+r8+OPR7sKBdBxIyXjZ+u554CqJP9A/Nliwj9DzMhBwP/VQYXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911298; c=relaxed/simple;
	bh=NpxjZFCL99G/W+LNb6vA0Dk0q9JCC8VQ1VpUAujZ0VM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/ZaJsb+sOVKOJoTBNebiYSupI+Ch6GBFFLg/NCjhEktHjCOUEgzRI7YzubgXmL6z8VKZoyt1uN8hItvwA/S3ynnOzoV7qMCxjgZb2ZJT2Xtm8E3FV5yNfZSgsGAjs8geCCFPFpQsbn4EBg1UWgHiLXoY7H+Usb+lNnOL0U9l40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJvJmhJS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJvJmhJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782911295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NpxjZFCL99G/W+LNb6vA0Dk0q9JCC8VQ1VpUAujZ0VM=;
	b=eJvJmhJSV7v1baRR1HgjXA39giPgb3VK7XbUEMBtlKbw1K7jvhfpJQgWXVzf94r62cz0gE
	42yJAmHTcgwlqmCXaibYq9xdyBoZyS9FuKU+TLus7cBLJXE5zuZ9A4OQgDry7Fyb7YfMXW
	CtWi9pfYQmtOcrs7McxOvHwH80K7gWw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-rchIPy0xNs2gcHICcThoDA-1; Wed, 01 Jul 2026 09:08:14 -0400
X-MC-Unique: rchIPy0xNs2gcHICcThoDA-1
X-Mimecast-MFC-AGG-ID: rchIPy0xNs2gcHICcThoDA_1782911293
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5aa932535b9so240978e87.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 06:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911293; x=1783516093;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uj8p9mOEpi1le29BugzJguH2/jwVpQA6SuiY+Jzqfpk=;
        b=BR43178CEALm0jSiENCs0IHoszwsIdT94EKdfVaqObutbImVjW4y5UnTtwFaEaPRkl
         wpZxJZS3T/dzGgdMLlr28ngNlOmprkoByMfJQBdrd+8x2HZxY3D621ozEVjN2qekKzuW
         6HF0BoQ4mLOaTM+FbmgPVfKVgZU3LUzzFNgtwmPCug2Z9yJqCkAmOEgVHZ7hFDy+J5eZ
         UGezCNDkKIEs4tDzYOBv2SGu9A5CtNZwvr1xZPtc84t6klhn9g8odmagt0s0qomuj6da
         nPDbDkPULRjiIqIT8yGEogAVY1pcxTTZaNQEwc8ktCrQiv1t2pIgbA4WozeQhu5rf7cW
         JYhg==
X-Forwarded-Encrypted: i=1; AHgh+Roz7ln18cR+EkBFmWMROh4w71x17xeuPRb4HMy3qQ7xOKruzVdRJJL+/1rQv8QzUBiasHVfI2XwEclOzT16pcpNawc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKzeusrhdsAr5b1EYcM6vHz3EaUQNS9tMjeDTRlOjaxvulwgb
	/44bpgj7t/LCK2zJNpl5ImQ3h11hCvszoe5SAEb4vQSUYRyI4OR6tKmv4f/p8AkbW4m5eo78nOr
	JtsuPI291yqTECCLxGVT7dGWH1o32Z8O0DoL45Ql0Z+2m+zraw2l5ajC69TjA6r6f+KaClIAPHj
	aHl71DAkjs
X-Gm-Gg: AfdE7ckAe21QFbj8PvHimYGxqpWJvmLM3tazK+oODMnSjWa+M6oik0vz4WejnABbykh
	d8yN+nhRjAKQC6kwFURp/TKyh1Wldm1TxUKOIFkgoz1rMHtjtA72fyZOg3jQVn8hYBhyYS+riUI
	OORGdVv15kC1Wvi6aj4gYz/Gg+FU6TD8Vohv7hCfvbrk5aDzgjNqu8aNv6ltGjgi64ppjGZZfsh
	tylILL97esVTwwMBfOAqe6o2Bte6k7hgNVRi1IGI9FO5w4kAnuo14dwX/EVByj1OlCIsNeJhLky
	qkH61daDCN2PbLbMpfn6gRhq31ekuTv0UKCGe6FFKiPsaUcQUn3GhMJvnAuERZTJRq3VlEuoOWm
	re7Fc65wtyjTZtu9AsqJj1yPWCm3bmSW9GlQgqZ5CZZ4ASAIVRXb2cHUJJayEcVzuDxCpWRctlH
	3ZE05o
X-Received: by 2002:a05:6512:681c:b0:5a8:8db6:b3d with SMTP id 2adb3069b0e04-5aec67ac634mr408867e87.24.1782911292712;
        Wed, 01 Jul 2026 06:08:12 -0700 (PDT)
X-Received: by 2002:a05:600c:34d4:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-493c2b3a709mr26824805e9.2.1782910956927;
        Wed, 01 Jul 2026 06:02:36 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm70747835e9.9.2026.07.01.06.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:02:36 -0700 (PDT)
Message-ID: <23cc72600e6ce9161f8fa375996dd572b4631552.camel@redhat.com>
Subject: Re: [PATCH v2 3/4] rv/rtapp/sleep: Stop monitoring kernel threads
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Date: Wed, 01 Jul 2026 15:02:34 +0200
In-Reply-To: <eec2ca5224bcdacc45b8e1eb2f0e68109e1cae7a.1781852967.git.namcao@linutronix.de>
References: <cover.1781852967.git.namcao@linutronix.de>
	 <eec2ca5224bcdacc45b8e1eb2f0e68109e1cae7a.1781852967.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KKxEx73taW0wF9G001OzfWjyCOh1IKcKlOLFcM8wl5E_1782911293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-19 at 09:21 +0200, Nam Cao wrote:
> The rtapp/sleep monitor's primary purpose is detecting common mistakes
> with user-space real-time design. Monitoring real-time issues with
> kernel threads is a bonus.
>=20
> However, accomodating kernel threads complicates the monitor due to
> the edge cases which is seen by the monitor as lower-priority task
> waking higher-priority task:
>=20
> =C2=A0 - kthread_stop() wakes up the task in order to stop it.
>=20
> =C2=A0 - The rcu thread and migration thread can be woken by any task.
>=20
> =C2=A0 - The ktimerd thread is woken near the end of irq_exit_rcu(), wher=
e
> =C2=A0=C2=A0=C2=A0 the preempt counter is "broken" and falsely says this =
is task
> =C2=A0=C2=A0=C2=A0 context. This requires the monitor to use the hardirq_=
context flag
> =C2=A0=C2=A0=C2=A0 instead of the preempt counter.
>=20
> Beside complicating the monitor, the final case also requires enabling
> CONFIG_TRACE_IRQFLAGS (so that "hardirq_context" can be used). This
> adds overhead to the kernel even when the monitor is not active. This
> may be an obstacle to enabling this monitor in distros' kernels.

Very good especially for this!

> Furthermore, kernel threads usually are started before the monitor is
> enabled. Consequently, the threads' states (i.o.w. the monitor's
> atomic propositions for the threads) are not fully known to the
> monitor. As a result, the kernel threads mostly cannot be monitored.
>=20
> Overall, the downsides of accomodating kernel threads outweights the
> benefits. Thus, exclude kernel threads to simplify the monitor.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> ---
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> =C2=A0Documentation/trace/rv/monitor_rtapp.rst=C2=A0 |=C2=A0 22 ++---
> =C2=A0kernel/trace/rv/monitors/sleep/Kconfig=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 -
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0 |=C2=A0 39=
 +-------
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.h=C2=A0=C2=A0=C2=A0 | 104 ++++=
+++++-------------
> =C2=A0tools/verification/models/rtapp/sleep.ltl |=C2=A0=C2=A0 7 +-
> =C2=A05 files changed, 54 insertions(+), 119 deletions(-)
>=20
> diff --git a/Documentation/trace/rv/monitor_rtapp.rst
> b/Documentation/trace/rv/monitor_rtapp.rst
> index 570be67a8f3b..502d3ea412eb 100644
> --- a/Documentation/trace/rv/monitor_rtapp.rst
> +++ b/Documentation/trace/rv/monitor_rtapp.rst
> @@ -93,9 +93,9 @@ assessment.
> =C2=A0
> =C2=A0The monitor's specification is::
> =C2=A0
> -=C2=A0 RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOW=
LIST))
> +=C2=A0 RULE =3D always ((RT and SLEEP and USER_THREAD) imply (RT_FRIENDL=
Y_SLEEP or
> ALLOWLIST))
> =C2=A0
> -=C2=A0 RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
> +=C2=A0 RT_FRIENDLY_SLEEP =3D RT_VALID_SLEEP_REASON
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and ((not SCHEDULE_IN) until RT_FRIEND=
LY_WAKE)
> =C2=A0
> =C2=A0=C2=A0 RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
> @@ -110,23 +110,13 @@ The monitor's specification is::
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or WOKEN_BY_HARDIRQ
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or WOKEN_BY_NMI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or ABORT_SLEEP
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or KTHREAD_SHOULD_STOP
> =C2=A0
> =C2=A0=C2=A0 ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or FUT=
EX_LOCK_PI
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or TASK_IS_=
RCU
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or TASK_IS_=
MIGRATION
> -
> -Beside the scenarios described above, this specification also handle som=
e
> -special cases:
> -
> -=C2=A0 - `KERNEL_THREAD`: kernel tasks do not have any pattern that can =
be
> recognized
> -=C2=A0=C2=A0=C2=A0 as valid real-time sleeping reasons. Therefore sleepi=
ng reason is not
> -=C2=A0=C2=A0=C2=A0 checked for kernel tasks.
> -=C2=A0 - `KTHREAD_SHOULD_STOP`: a non-real-time thread may stop a real-t=
ime kernel
> -=C2=A0=C2=A0=C2=A0 thread by waking it and waiting for it to exit (`kthr=
ead_stop()`). This
> -=C2=A0=C2=A0=C2=A0 wakeup is safe for real-time.
> -=C2=A0 - `ALLOWLIST`: to handle known false positives with the kernel.
> +
> +Beside the scenarios described above, this specification also defines an
> allow list
> +to handle some special cases:
> +
> =C2=A0=C2=A0 - `BLOCK_ON_RT_MUTEX` is included in the allowlist due to it=
s
> implementation.
> =C2=A0=C2=A0=C2=A0=C2=A0 In the release path of rt_mutex, a boosted task =
is de-boosted before
> waking
> =C2=A0=C2=A0=C2=A0=C2=A0 the rt_mutex's waiter. Consequently, the monitor=
 may see a real-time-
> unsafe
> diff --git a/kernel/trace/rv/monitors/sleep/Kconfig
> b/kernel/trace/rv/monitors/sleep/Kconfig
> index 6b7a122e7b47..d6ec3e9a91b6 100644
> --- a/kernel/trace/rv/monitors/sleep/Kconfig
> +++ b/kernel/trace/rv/monitors/sleep/Kconfig
> @@ -5,7 +5,6 @@ config RV_MON_SLEEP
> =C2=A0=09select RV_LTL_MONITOR
> =C2=A0=09depends on HAVE_SYSCALL_TRACEPOINTS
> =C2=A0=09depends on RV_MON_RTAPP
> -=09select TRACE_IRQFLAGS
> =C2=A0=09default y
> =C2=A0=09select LTL_MON_EVENTS_ID
> =C2=A0=09bool "sleep monitor"
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index 638be7d8747f..aa5a984853b5 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -43,7 +43,6 @@ static void ltl_atoms_init(struct task_struct *task, st=
ruct
> ltl_monitor *mon, bo
> =C2=A0=09ltl_atom_set(mon, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, false);
> =C2=A0
> =C2=A0=09if (task_creation) {
> -=09=09ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
> @@ -53,33 +52,7 @@ static void ltl_atoms_init(struct task_struct *task, s=
truct
> ltl_monitor *mon, bo
> =C2=A0=09=09ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
> =C2=A0=09}
> =C2=A0
> -=09if (task->flags & PF_KTHREAD) {
> -=09=09ltl_atom_set(mon, LTL_KERNEL_THREAD, true);
> -
> -=09=09/* kernel tasks do not do syscall */
> -=09=09ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> -=09=09ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> -=09=09ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
> -=09=09ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
> -
> -=09=09if (strstarts(task->comm, "migration/"))
> -=09=09=09ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, true);
> -=09=09else
> -=09=09=09ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, false);
> -
> -=09=09if (strstarts(task->comm, "rcu"))
> -=09=09=09ltl_atom_set(mon, LTL_TASK_IS_RCU, true);
> -=09=09else
> -=09=09=09ltl_atom_set(mon, LTL_TASK_IS_RCU, false);
> -=09} else {
> -=09=09ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
> -=09=09ltl_atom_set(mon, LTL_KERNEL_THREAD, false);
> -=09=09ltl_atom_set(mon, LTL_TASK_IS_RCU, false);
> -=09=09ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, false);
> -=09}
> -
> +=09ltl_atom_set(mon, LTL_USER_THREAD, !(task->flags & PF_KTHREAD));
> =C2=A0}
> =C2=A0
> =C2=A0static void handle_sched_set_state(void *data, struct task_struct *=
task, int
> state)
> @@ -97,7 +70,7 @@ static void handle_sched_exit(void *data, bool is_switc=
h)
> =C2=A0
> =C2=A0static void handle_sched_waking(void *data, struct task_struct *tas=
k)
> =C2=A0{
> -=09if (this_cpu_read(hardirq_context)) {
> +=09if (in_hardirq()) {
> =C2=A0=09=09ltl_atom_pulse(task, LTL_WOKEN_BY_HARDIRQ, true);
> =C2=A0=09} else if (in_task()) {
> =C2=A0=09=09if (current->prio <=3D task->prio)
> @@ -181,12 +154,6 @@ static void handle_sys_exit(void *data, struct pt_re=
gs
> *regs, long ret)
> =C2=A0=09ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
> =C2=A0}
> =C2=A0
> -static void handle_kthread_stop(void *data, struct task_struct *task)
> -{
> -=09/* FIXME: this could race with other tracepoint handlers */
> -=09ltl_atom_update(task, LTL_KTHREAD_SHOULD_STOP, true);
> -}
> -
> =C2=A0static int enable_sleep(void)
> =C2=A0{
> =C2=A0=09int retval;
> @@ -200,7 +167,6 @@ static int enable_sleep(void)
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", sched_set_state_tp,
> handle_sched_set_state);
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", contention_begin,
> handle_contention_begin);
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", contention_end,
> handle_contention_end);
> -=09rv_attach_trace_probe("rtapp_sleep", sched_kthread_stop,
> handle_kthread_stop);
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", sys_enter, handle_sys_enter=
);
> =C2=A0=09rv_attach_trace_probe("rtapp_sleep", sys_exit, handle_sys_exit);
> =C2=A0=09return 0;
> @@ -213,7 +179,6 @@ static void disable_sleep(void)
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", sched_set_state_tp,
> handle_sched_set_state);
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", contention_begin,
> handle_contention_begin);
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", contention_end,
> handle_contention_end);
> -=09rv_detach_trace_probe("rtapp_sleep", sched_kthread_stop,
> handle_kthread_stop);
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", sys_enter, handle_sys_enter=
);
> =C2=A0=09rv_detach_trace_probe("rtapp_sleep", sys_exit, handle_sys_exit);
> =C2=A0
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.h
> b/kernel/trace/rv/monitors/sleep/sleep.h
> index 2fe2ec7edae8..44e593f41e6a 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.h
> +++ b/kernel/trace/rv/monitors/sleep/sleep.h
> @@ -18,15 +18,12 @@ enum ltl_atom {
> =C2=A0=09LTL_EPOLL_WAIT,
> =C2=A0=09LTL_FUTEX_LOCK_PI,
> =C2=A0=09LTL_FUTEX_WAIT,
> -=09LTL_KERNEL_THREAD,
> -=09LTL_KTHREAD_SHOULD_STOP,
> =C2=A0=09LTL_NANOSLEEP_CLOCK_REALTIME,
> =C2=A0=09LTL_NANOSLEEP_TIMER_ABSTIME,
> =C2=A0=09LTL_RT,
> =C2=A0=09LTL_SCHEDULE_IN,
> =C2=A0=09LTL_SLEEP,
> -=09LTL_TASK_IS_MIGRATION,
> -=09LTL_TASK_IS_RCU,
> +=09LTL_USER_THREAD,
> =C2=A0=09LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
> =C2=A0=09LTL_WOKEN_BY_HARDIRQ,
> =C2=A0=09LTL_WOKEN_BY_NMI,
> @@ -43,15 +40,12 @@ static const char *ltl_atom_str(enum ltl_atom atom)
> =C2=A0=09=09"ep_wa",
> =C2=A0=09=09"fu_lo_pi",
> =C2=A0=09=09"fu_wa",
> -=09=09"ker_th",
> -=09=09"kth_sh_st",
> =C2=A0=09=09"na_cl_re",
> =C2=A0=09=09"na_ti_ab",
> =C2=A0=09=09"rt",
> =C2=A0=09=09"sch_in",
> =C2=A0=09=09"sle",
> -=09=09"ta_mi",
> -=09=09"ta_rc",
> +=09=09"us_th",
> =C2=A0=09=09"wo_eq_hi_pr",
> =C2=A0=09=09"wo_ha",
> =C2=A0=09=09"wo_nm",
> @@ -79,46 +73,41 @@ static void ltl_start(struct task_struct *task, struc=
t
> ltl_monitor *mon)
> =C2=A0=09bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->at=
oms);
> =C2=A0=09bool woken_by_equal_or_higher_prio =3D
> test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
> =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0 mon->atoms);
> -=09bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
> -=09bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms=
);
> +=09bool user_thread =3D test_bit(LTL_USER_THREAD, mon->atoms);
> =C2=A0=09bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> =C2=A0=09bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
> =C2=A0=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> =C2=A0=09bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_AB=
STIME,
> mon->atoms);
> =C2=A0=09bool nanosleep_clock_realtime =3D
> test_bit(LTL_NANOSLEEP_CLOCK_REALTIME, mon->atoms);
> -=09bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon-
> >atoms);
> -=09bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
> =C2=A0=09bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
> =C2=A0=09bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> =C2=A0=09bool epoll_wait =3D test_bit(LTL_EPOLL_WAIT, mon->atoms);
> =C2=A0=09bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atom=
s);
> =C2=A0=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->=
atoms);
> =C2=A0=09bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> -=09bool val41 =3D task_is_rcu || task_is_migration;
> -=09bool val42 =3D futex_lock_pi || val41;
> -=09bool val5 =3D block_on_rt_mutex || val42;
> -=09bool val33 =3D abort_sleep || kthread_should_stop;
> -=09bool val34 =3D woken_by_nmi || val33;
> -=09bool val35 =3D woken_by_hardirq || val34;
> -=09bool val14 =3D woken_by_equal_or_higher_prio || val35;
> +=09bool val7 =3D block_on_rt_mutex || futex_lock_pi;
> +=09bool val32 =3D woken_by_nmi || abort_sleep;
> +=09bool val33 =3D woken_by_hardirq || val32;
> +=09bool val14 =3D woken_by_equal_or_higher_prio || val33;
> =C2=A0=09bool val13 =3D !schedule_in;
> =C2=A0=09bool val25 =3D !nanosleep_clock_realtime;
> =C2=A0=09bool val26 =3D nanosleep_timer_abstime && val25;
> =C2=A0=09bool val18 =3D clock_nanosleep && val26;
> =C2=A0=09bool val20 =3D val18 || epoll_wait;
> -=09bool val9 =3D futex_wait || val20;
> -=09bool val11 =3D val9 || kernel_thread;
> +=09bool val11 =3D futex_wait || val20;
> +=09bool val3 =3D !user_thread;
> =C2=A0=09bool val2 =3D !sleep;
> +=09bool val4 =3D val2 || val3;
> =C2=A0=09bool val1 =3D !rt;
> -=09bool val3 =3D val1 || val2;
> +=09bool val5 =3D val1 || val4;
> =C2=A0
> -=09if (val3)
> +=09if (val5)
> =C2=A0=09=09__set_bit(S0, mon->states);
> =C2=A0=09if (val11 && val13)
> =C2=A0=09=09__set_bit(S1, mon->states);
> =C2=A0=09if (val11 && val14)
> =C2=A0=09=09__set_bit(S4, mon->states);
> -=09if (val5)
> +=09if (val7)
> =C2=A0=09=09__set_bit(S5, mon->states);
> =C2=A0}
> =C2=A0
> @@ -129,130 +118,125 @@ ltl_possible_next_states(struct ltl_monitor *mon,
> unsigned int state, unsigned l
> =C2=A0=09bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->at=
oms);
> =C2=A0=09bool woken_by_equal_or_higher_prio =3D
> test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
> =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0 mon->atoms);
> -=09bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
> -=09bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms=
);
> +=09bool user_thread =3D test_bit(LTL_USER_THREAD, mon->atoms);
> =C2=A0=09bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> =C2=A0=09bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
> =C2=A0=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> =C2=A0=09bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_AB=
STIME,
> mon->atoms);
> =C2=A0=09bool nanosleep_clock_realtime =3D
> test_bit(LTL_NANOSLEEP_CLOCK_REALTIME, mon->atoms);
> -=09bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon-
> >atoms);
> -=09bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
> =C2=A0=09bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
> =C2=A0=09bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> =C2=A0=09bool epoll_wait =3D test_bit(LTL_EPOLL_WAIT, mon->atoms);
> =C2=A0=09bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atom=
s);
> =C2=A0=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->=
atoms);
> =C2=A0=09bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> -=09bool val41 =3D task_is_rcu || task_is_migration;
> -=09bool val42 =3D futex_lock_pi || val41;
> -=09bool val5 =3D block_on_rt_mutex || val42;
> -=09bool val33 =3D abort_sleep || kthread_should_stop;
> -=09bool val34 =3D woken_by_nmi || val33;
> -=09bool val35 =3D woken_by_hardirq || val34;
> -=09bool val14 =3D woken_by_equal_or_higher_prio || val35;
> +=09bool val7 =3D block_on_rt_mutex || futex_lock_pi;
> +=09bool val32 =3D woken_by_nmi || abort_sleep;
> +=09bool val33 =3D woken_by_hardirq || val32;
> +=09bool val14 =3D woken_by_equal_or_higher_prio || val33;
> =C2=A0=09bool val13 =3D !schedule_in;
> =C2=A0=09bool val25 =3D !nanosleep_clock_realtime;
> =C2=A0=09bool val26 =3D nanosleep_timer_abstime && val25;
> =C2=A0=09bool val18 =3D clock_nanosleep && val26;
> =C2=A0=09bool val20 =3D val18 || epoll_wait;
> -=09bool val9 =3D futex_wait || val20;
> -=09bool val11 =3D val9 || kernel_thread;
> +=09bool val11 =3D futex_wait || val20;
> +=09bool val3 =3D !user_thread;
> =C2=A0=09bool val2 =3D !sleep;
> +=09bool val4 =3D val2 || val3;
> =C2=A0=09bool val1 =3D !rt;
> -=09bool val3 =3D val1 || val2;
> +=09bool val5 =3D val1 || val4;
> =C2=A0
> =C2=A0=09switch (state) {
> =C2=A0=09case S0:
> -=09=09if (val3)
> +=09=09if (val5)
> =C2=A0=09=09=09__set_bit(S0, next);
> =C2=A0=09=09if (val11 && val13)
> =C2=A0=09=09=09__set_bit(S1, next);
> =C2=A0=09=09if (val11 && val14)
> =C2=A0=09=09=09__set_bit(S4, next);
> -=09=09if (val5)
> +=09=09if (val7)
> =C2=A0=09=09=09__set_bit(S5, next);
> =C2=A0=09=09break;
> =C2=A0=09case S1:
> =C2=A0=09=09if (val11 && val13)
> =C2=A0=09=09=09__set_bit(S1, next);
> -=09=09if (val13 && val3)
> +=09=09if (val13 && val5)
> =C2=A0=09=09=09__set_bit(S2, next);
> -=09=09if (val14 && val3)
> +=09=09if (val14 && val5)
> =C2=A0=09=09=09__set_bit(S3, next);
> =C2=A0=09=09if (val11 && val14)
> =C2=A0=09=09=09__set_bit(S4, next);
> -=09=09if (val13 && val5)
> +=09=09if (val13 && val7)
> =C2=A0=09=09=09__set_bit(S6, next);
> -=09=09if (val14 && val5)
> +=09=09if (val14 && val7)
> =C2=A0=09=09=09__set_bit(S7, next);
> =C2=A0=09=09break;
> =C2=A0=09case S2:
> =C2=A0=09=09if (val11 && val13)
> =C2=A0=09=09=09__set_bit(S1, next);
> -=09=09if (val13 && val3)
> +=09=09if (val13 && val5)
> =C2=A0=09=09=09__set_bit(S2, next);
> -=09=09if (val14 && val3)
> +=09=09if (val14 && val5)
> =C2=A0=09=09=09__set_bit(S3, next);
> =C2=A0=09=09if (val11 && val14)
> =C2=A0=09=09=09__set_bit(S4, next);
> -=09=09if (val13 && val5)
> +=09=09if (val13 && val7)
> =C2=A0=09=09=09__set_bit(S6, next);
> -=09=09if (val14 && val5)
> +=09=09if (val14 && val7)
> =C2=A0=09=09=09__set_bit(S7, next);
> =C2=A0=09=09break;
> =C2=A0=09case S3:
> -=09=09if (val3)
> +=09=09if (val5)
> =C2=A0=09=09=09__set_bit(S0, next);
> =C2=A0=09=09if (val11 && val13)
> =C2=A0=09=09=09__set_bit(S1, next);
> =C2=A0=09=09if (val11 && val14)
> =C2=A0=09=09=09__set_bit(S4, next);
> -=09=09if (val5)
> +=09=09if (val7)
> =C2=A0=09=09=09__set_bit(S5, next);
> =C2=A0=09=09break;
> =C2=A0=09case S4:
> -=09=09if (val3)
> +=09=09if (val5)
> =C2=A0=09=09=09__set_bit(S0, next);
> =C2=A0=09=09if (val11 && val13)
> =C2=A0=09=09=09__set_bit(S1, next);
> =C2=A0=09=09if (val11 && val14)
> =C2=A0=09=09=09__set_bit(S4, next);
> -=09=09if (val5)
> +=09=09if (val7)
> =C2=A0=09=09=09__set_bit(S5, next);
> =C2=A0=09=09break;
> =C2=A0=09case S5:
> -=09=09if (val3)
> +=09=09if (val5)
> =C2=A0=09=09=09__set_bit(S0, next);
> =C2=A0=09=09if (val11 && val13)
> =C2=A0=09=09=09__set_bit(S1, next);
> =C2=A0=09=09if (val11 && val14)
> =C2=A0=09=09=09__set_bit(S4, next);
> -=09=09if (val5)
> +=09=09if (val7)
> =C2=A0=09=09=09__set_bit(S5, next);
> =C2=A0=09=09break;
> =C2=A0=09case S6:
> =C2=A0=09=09if (val11 && val13)
> =C2=A0=09=09=09__set_bit(S1, next);
> -=09=09if (val13 && val3)
> +=09=09if (val13 && val5)
> =C2=A0=09=09=09__set_bit(S2, next);
> -=09=09if (val14 && val3)
> +=09=09if (val14 && val5)
> =C2=A0=09=09=09__set_bit(S3, next);
> =C2=A0=09=09if (val11 && val14)
> =C2=A0=09=09=09__set_bit(S4, next);
> -=09=09if (val13 && val5)
> +=09=09if (val13 && val7)
> =C2=A0=09=09=09__set_bit(S6, next);
> -=09=09if (val14 && val5)
> +=09=09if (val14 && val7)
> =C2=A0=09=09=09__set_bit(S7, next);
> =C2=A0=09=09break;
> =C2=A0=09case S7:
> -=09=09if (val3)
> +=09=09if (val5)
> =C2=A0=09=09=09__set_bit(S0, next);
> =C2=A0=09=09if (val11 && val13)
> =C2=A0=09=09=09__set_bit(S1, next);
> =C2=A0=09=09if (val11 && val14)
> =C2=A0=09=09=09__set_bit(S4, next);
> -=09=09if (val5)
> +=09=09if (val7)
> =C2=A0=09=09=09__set_bit(S5, next);
> =C2=A0=09=09break;
> =C2=A0=09}
> diff --git a/tools/verification/models/rtapp/sleep.ltl
> b/tools/verification/models/rtapp/sleep.ltl
> index 5923e58d7810..4d78fdd204c0 100644
> --- a/tools/verification/models/rtapp/sleep.ltl
> +++ b/tools/verification/models/rtapp/sleep.ltl
> @@ -1,6 +1,6 @@
> -RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
> +RULE =3D always ((RT and SLEEP and USER_THREAD) imply (RT_FRIENDLY_SLEEP=
 or
> ALLOWLIST))
> =C2=A0
> -RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
> +RT_FRIENDLY_SLEEP =3D RT_VALID_SLEEP_REASON
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 and ((not SCHEDULE_IN) until RT_FRIENDLY_WAKE)
> =C2=A0
> =C2=A0RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
> @@ -15,9 +15,6 @@ RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 or WOKEN_BY_HARDIRQ
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 or WOKEN_BY_NMI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 or ABORT_SLEEP
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or KTHREAD_SHOULD_STOP
> =C2=A0
> =C2=A0ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or FUTEX_LOCK_PI
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or TASK_IS_RCU
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or TASK_IS_MIGRATION

