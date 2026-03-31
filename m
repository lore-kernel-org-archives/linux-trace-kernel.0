Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C403E315B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961440; cv=none; b=AKAmsA96DG0mXx35Bm/iMwZrYzPQp5/9HNqqrq0Og7z8m0RYMzQ9f4cmwLTQikhR0ljshDtJdQXaNpuOt/hFutIJIPF7coH/pkNfGVmqkotbKWUbGMIN4cDQQr6KRyreJqQ1j+QxCfGaxmmknb9et+bAXtI+sCl9YWzDmtp/4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961440; c=relaxed/simple;
	bh=6MI0m9MnlifO3YE9wzy9orBuktn5+2A062TFjKIiP8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM/68wNYbZ74Gd4CwFhkN2Bn6kEVGBIKcP95T3WQtQbCi4Cz8oJTTLmoCc46Jaew3cWLr5S5GWP1EsHvop50PvUDvcJm2czQwaREWn+99zuO7xDJhjC7+nmlSkxaRAiR8V3w9GFNIDYia+9ZlYY6Az3W/8IOdP511rFdt+FNtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnCzC9Uf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnCzC9Uf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774961436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6MI0m9MnlifO3YE9wzy9orBuktn5+2A062TFjKIiP8g=;
	b=bnCzC9Ufu/NV3iAWilcEgABk1p6larW6GtC1hfapUC5PsU82Dwgb8tv5uvczZkicQdXZNV
	ulmehLTBv9i34rzSr0zLjPL9ejN6ke5dOKV75IJPy+JE8mlhj9gfsHA5k1Vmcmyi+9I0DG
	N8zgzcq2MguoSW1KzmTq7n+0KIcGpOI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-mvAX_21KNBG3xZXM3ljlug-1; Tue, 31 Mar 2026 08:50:35 -0400
X-MC-Unique: mvAX_21KNBG3xZXM3ljlug-1
X-Mimecast-MFC-AGG-ID: mvAX_21KNBG3xZXM3ljlug_1774961434
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486f830f4e4so40665585e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 05:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774961434; x=1775566234;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9y6Pp67Aaa0+fVvvmnBLOk5CQ+FAK7BRxrMXRyEnlcM=;
        b=sMwSOPOSMOLgsvqAWPXWt/bTWEaCm4OP5cJpth+fX4NGL7Hgw1jnJ1Z03EiRcWZ+RT
         3ANj/bY1p9XpBedEfE6ZNiHJdLE3awcCogr4dS3bUR30xNgsVl/U/UncVItfaD3V1sG7
         AYkFGSy8LWKflmW2HjzvJ7fVI+vabEKTXBglojvOdnglDPcr6ldcEsHeKDNChaSdWeT+
         ARFnqqxz8nF4qRewAxyUeMhglPHmU1UbNCR53JEk2duf9r3If8tigC2kR4uLL7BNrdnu
         SrZ53Egn7zb4AVv43/OExYPhWBP412GpKQynNSV85d6qsduYJZd6aPFHNuVvWBIobL87
         gKMA==
X-Forwarded-Encrypted: i=1; AJvYcCU7+wLgUinMylbckAMBG6jVNmo2tLJcyuQz5XeahH1jPCPMkyPe3tCzGCo71SHH8nK8U7ZDILhhXPapmif0oKjknZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lbQOrkM70OtSUD0meHDRl/Dld8oNl7YZpWnWrfaiJ55dzSH3
	2ExW6bMq0spJYlVklta+CKQ916fgn67gZXDEAJFkAC2BUy0YE153pzzYI+E5LAWNBRhBM4MhM/9
	QxhXvWWm4GQ9gKZFJF4IGFWh/v+AW67aVVv+lgNw1BYymbfviDgX4QCJugvRefFynUZh/4pKO/A
	==
X-Gm-Gg: ATEYQzw2jjMBOtajojbGfKwhXjcBqYbnZhZW5OjiKABiALbOjMlZB1oMEw8IkG43uQR
	gP9boMVjLJ3UadiLjRBcS2J+yV4dlwtHomHh2xQex4UumkEw63djEHTNJbu4VsWkuk257ZxbJNH
	M7lLHsVuEqz4fkp/vyKDLCNGvcAVAisRq8ujtMH7MpvXU2WR0/ZrW4LI0XiDywGFMVN3jI9XFXB
	bd214TJleDVcQcVM1WlpTD6DeljrEExeWRMiZDOhnE3EgiYEPrihJ2efON8ijUQfsU5Rx8K1STM
	y3w3E1Lw7OzIBixdoq7DVOWp/x+W+YobpVSurKwyX/SUqLIBJjRGQoMSHNqGakHB1Pclu7uKw4q
	ePREMhx20krEDLupXlu11lZ7uO+vfHMR64/oB0ix1L/WC2RMv55PHDrC+M3/r8lS7EAzUXcmf8/
	GXtIMSCM/QEiNZWSk=
X-Received: by 2002:a05:600c:4e08:b0:487:1fb4:7b3 with SMTP id 5b1f17b1804b1-48727ef0cc2mr304053735e9.23.1774961434108;
        Tue, 31 Mar 2026 05:50:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4e08:b0:487:1fb4:7b3 with SMTP id 5b1f17b1804b1-48727ef0cc2mr304053325e9.23.1774961433638;
        Tue, 31 Mar 2026 05:50:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e81a2cesm38045435e9.8.2026.03.31.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:50:33 -0700 (PDT)
Message-ID: <4b47d5e7e9dde0c76beb1a9383a13553c2455d92.camel@redhat.com>
Subject: Re: [PATCH] rv: Allow epoll in rtapp-sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 31 Mar 2026 14:50:31 +0200
In-Reply-To: <20260331104918.2710853-1-namcao@linutronix.de>
References: <20260331104918.2710853-1-namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: t1tV-Z8QXCqebx1BQhSgVTtmYRcsBHqpICgJ410lLBQ_1774961434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-03-31 at 12:49 +0200, Nam Cao wrote:
> Since commit 0c43094f8cc9 ("eventpoll: Replace rwlock with spinlock"),
> epoll_wait is real-time-safe syscall for sleeping.
>=20
> Add epoll_wait to the list of rt-safe sleeping APIs.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Thanks for the patch, looks reasonable.
I tried re-generating the header (sleep.h) with rvgen based on the new
specification and I'm getting a different order.

Is what you're committing the result of rvgen on your computer?
We probably still have some unpredictable result in the rvgen's output if t=
hat's
the case (no big deal then, though it triggers me a bit).

I would still like to run some tests on this, how urgently would you like t=
his
patch through? I was really about to send Steve a PR with the other changes=
 so
this might need to wait for the next merge window.

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 =
++
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.h=C2=A0=C2=A0=C2=A0 | 98 +++++=
+++++++-----------
> =C2=A0tools/verification/models/rtapp/sleep.ltl |=C2=A0 1 +
> =C2=A03 files changed, 61 insertions(+), 46 deletions(-)
>=20
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index c1347da69e9d..59091863c17c 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -49,6 +49,7 @@ static void ltl_atoms_init(struct task_struct *task, st=
ruct
> ltl_monitor *mon, bo
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> +=09=09ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
> =C2=A0=09}
> @@ -63,6 +64,7 @@ static void ltl_atoms_init(struct task_struct *task, st=
ruct
> ltl_monitor *mon, bo
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
> +=09=09ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
> =C2=A0
> =C2=A0=09=09if (strstarts(task->comm, "migration/"))
> =C2=A0=09=09=09ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, true);
> @@ -162,6 +164,11 @@ static void handle_sys_enter(void *data, struct pt_r=
egs
> *regs, long id)
> =C2=A0=09=09=09break;
> =C2=A0=09=09}
> =C2=A0=09=09break;
> +#ifdef __NR_epoll_wait
> +=09case __NR_epoll_wait:
> +=09=09ltl_atom_set(mon, LTL_EPOLL_WAIT, true);
> +=09=09break;
> +#endif
> =C2=A0=09}
> =C2=A0}
> =C2=A0
> @@ -174,6 +181,7 @@ static void handle_sys_exit(void *data, struct pt_reg=
s
> *regs, long ret)
> =C2=A0=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
> =C2=A0=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> =C2=A0=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> +=09ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
> =C2=A0=09ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
> =C2=A0}
> =C2=A0
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.h
> b/kernel/trace/rv/monitors/sleep/sleep.h
> index 2ab46fd218d2..95dc2727c059 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.h
> +++ b/kernel/trace/rv/monitors/sleep/sleep.h
> @@ -15,6 +15,7 @@ enum ltl_atom {
> =C2=A0=09LTL_ABORT_SLEEP,
> =C2=A0=09LTL_BLOCK_ON_RT_MUTEX,
> =C2=A0=09LTL_CLOCK_NANOSLEEP,
> +=09LTL_EPOLL_WAIT,
> =C2=A0=09LTL_FUTEX_LOCK_PI,
> =C2=A0=09LTL_FUTEX_WAIT,
> =C2=A0=09LTL_KERNEL_THREAD,
> @@ -40,6 +41,7 @@ static const char *ltl_atom_str(enum ltl_atom atom)
> =C2=A0=09=09"ab_sl",
> =C2=A0=09=09"bl_on_rt_mu",
> =C2=A0=09=09"cl_na",
> +=09=09"ep_wa",
> =C2=A0=09=09"fu_lo_pi",
> =C2=A0=09=09"fu_wa",
> =C2=A0=09=09"ker_th",
> @@ -75,39 +77,41 @@ static_assert(RV_NUM_BA_STATES <=3D RV_MAX_BA_STATES)=
;
> =C2=A0
> =C2=A0static void ltl_start(struct task_struct *task, struct ltl_monitor =
*mon)
> =C2=A0{
> -=09bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms=
);
> -=09bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
> -=09bool val40 =3D task_is_rcu || task_is_migration;
> -=09bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> -=09bool val41 =3D futex_lock_pi || val40;
> -=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms=
);
> -=09bool val5 =3D block_on_rt_mutex || val41;
> -=09bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon-
> >atoms);
> -=09bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> -=09bool val32 =3D abort_sleep || kthread_should_stop;
> =C2=A0=09bool woken_by_nmi =3D test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
> -=09bool val33 =3D woken_by_nmi || val32;
> =C2=A0=09bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->at=
oms);
> -=09bool val34 =3D woken_by_hardirq || val33;
> =C2=A0=09bool woken_by_equal_or_higher_prio =3D
> test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
> =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0 mon->atoms);
> -=09bool val14 =3D woken_by_equal_or_higher_prio || val34;
> =C2=A0=09bool wake =3D test_bit(LTL_WAKE, mon->atoms);
> -=09bool val13 =3D !wake;
> -=09bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
> +=09bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
> +=09bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms=
);
> +=09bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> +=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> +=09bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME=
,
> mon->atoms);
> =C2=A0=09bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, m=
on-
> >atoms);
> =C2=A0=09bool nanosleep_clock_monotonic =3D
> test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
> -=09bool val24 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
> -=09bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME=
,
> mon->atoms);
> -=09bool val25 =3D nanosleep_timer_abstime && val24;
> -=09bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
> -=09bool val18 =3D clock_nanosleep && val25;
> +=09bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon-
> >atoms);
> +=09bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
> =C2=A0=09bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
> -=09bool val9 =3D futex_wait || val18;
> +=09bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> +=09bool epoll_wait =3D test_bit(LTL_EPOLL_WAIT, mon->atoms);
> +=09bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
> +=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms=
);
> +=09bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> +=09bool val42 =3D task_is_rcu || task_is_migration;
> +=09bool val43 =3D futex_lock_pi || val42;
> +=09bool val5 =3D block_on_rt_mutex || val43;
> +=09bool val34 =3D abort_sleep || kthread_should_stop;
> +=09bool val35 =3D woken_by_nmi || val34;
> +=09bool val36 =3D woken_by_hardirq || val35;
> +=09bool val14 =3D woken_by_equal_or_higher_prio || val36;
> +=09bool val13 =3D !wake;
> +=09bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
> +=09bool val27 =3D nanosleep_timer_abstime && val26;
> +=09bool val18 =3D clock_nanosleep && val27;
> +=09bool val20 =3D val18 || epoll_wait;
> +=09bool val9 =3D futex_wait || val20;
> =C2=A0=09bool val11 =3D val9 || kernel_thread;
> -=09bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> =C2=A0=09bool val2 =3D !sleep;
> -=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> =C2=A0=09bool val1 =3D !rt;
> =C2=A0=09bool val3 =3D val1 || val2;
> =C2=A0
> @@ -124,39 +128,41 @@ static void ltl_start(struct task_struct *task, str=
uct
> ltl_monitor *mon)
> =C2=A0static void
> =C2=A0ltl_possible_next_states(struct ltl_monitor *mon, unsigned int stat=
e,
> unsigned long *next)
> =C2=A0{
> -=09bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms=
);
> -=09bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
> -=09bool val40 =3D task_is_rcu || task_is_migration;
> -=09bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> -=09bool val41 =3D futex_lock_pi || val40;
> -=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms=
);
> -=09bool val5 =3D block_on_rt_mutex || val41;
> -=09bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon-
> >atoms);
> -=09bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> -=09bool val32 =3D abort_sleep || kthread_should_stop;
> =C2=A0=09bool woken_by_nmi =3D test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
> -=09bool val33 =3D woken_by_nmi || val32;
> =C2=A0=09bool woken_by_hardirq =3D test_bit(LTL_WOKEN_BY_HARDIRQ, mon->at=
oms);
> -=09bool val34 =3D woken_by_hardirq || val33;
> =C2=A0=09bool woken_by_equal_or_higher_prio =3D
> test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
> =C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0 mon->atoms);
> -=09bool val14 =3D woken_by_equal_or_higher_prio || val34;
> =C2=A0=09bool wake =3D test_bit(LTL_WAKE, mon->atoms);
> -=09bool val13 =3D !wake;
> -=09bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
> +=09bool task_is_rcu =3D test_bit(LTL_TASK_IS_RCU, mon->atoms);
> +=09bool task_is_migration =3D test_bit(LTL_TASK_IS_MIGRATION, mon->atoms=
);
> +=09bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> +=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> +=09bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME=
,
> mon->atoms);
> =C2=A0=09bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, m=
on-
> >atoms);
> =C2=A0=09bool nanosleep_clock_monotonic =3D
> test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
> -=09bool val24 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
> -=09bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_ABSTIME=
,
> mon->atoms);
> -=09bool val25 =3D nanosleep_timer_abstime && val24;
> -=09bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
> -=09bool val18 =3D clock_nanosleep && val25;
> +=09bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, mon-
> >atoms);
> +=09bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
> =C2=A0=09bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
> -=09bool val9 =3D futex_wait || val18;
> +=09bool futex_lock_pi =3D test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
> +=09bool epoll_wait =3D test_bit(LTL_EPOLL_WAIT, mon->atoms);
> +=09bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
> +=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms=
);
> +=09bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> +=09bool val42 =3D task_is_rcu || task_is_migration;
> +=09bool val43 =3D futex_lock_pi || val42;
> +=09bool val5 =3D block_on_rt_mutex || val43;
> +=09bool val34 =3D abort_sleep || kthread_should_stop;
> +=09bool val35 =3D woken_by_nmi || val34;
> +=09bool val36 =3D woken_by_hardirq || val35;
> +=09bool val14 =3D woken_by_equal_or_higher_prio || val36;
> +=09bool val13 =3D !wake;
> +=09bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
> +=09bool val27 =3D nanosleep_timer_abstime && val26;
> +=09bool val18 =3D clock_nanosleep && val27;
> +=09bool val20 =3D val18 || epoll_wait;
> +=09bool val9 =3D futex_wait || val20;
> =C2=A0=09bool val11 =3D val9 || kernel_thread;
> -=09bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> =C2=A0=09bool val2 =3D !sleep;
> -=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> =C2=A0=09bool val1 =3D !rt;
> =C2=A0=09bool val3 =3D val1 || val2;
> =C2=A0
> diff --git a/tools/verification/models/rtapp/sleep.ltl
> b/tools/verification/models/rtapp/sleep.ltl
> index 6379bbeb6212..6f26c4810f78 100644
> --- a/tools/verification/models/rtapp/sleep.ltl
> +++ b/tools/verification/models/rtapp/sleep.ltl
> @@ -5,6 +5,7 @@ RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_TH=
READ)
> =C2=A0
> =C2=A0RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or RT_FRIENDLY_NANOS=
LEEP
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or EPOLL_WAIT
> =C2=A0
> =C2=A0RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and NANOSLEEP_TIMER_ABSTIM=
E

