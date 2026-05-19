Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605D23392E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195493; cv=none; b=OUK2BHt7tUzeK/C1UWuhzDd6fPrLNXeNv63R6ShDsj+o+xaTrsv0SxTSIP94KpoiVs1sKoWcHuIHRaTqGceIxMAY4x98iZ8iHv9YRmGYjayCZqayXbTwUD/gxKyWIBP1f1Z5nRNZHVJV3XvzIQoKIKwy4FMDMzCx9ZTu4s/+2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195493; c=relaxed/simple;
	bh=lrx1GX5SXOU32ySfIGC2lILN839jekHK9j2Fum6L/l8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJSewrI4mYnUjhuLkHEkmqMaoPK6U8GfqJeaBn8nkZ1wrwiTj9+DoJmaAJTGP6aIfxSmJCnlddjxVE8Fn+I09zvT4+Jwep+Jp9QyiV/8FaCgxVeF6n8ecKdDF3nUyk5z6QqkmUkKmNGI04pV3mkRQrYiUKPsKSyFsbKObbw/6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vmh096WB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vmh096WB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779195490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lrx1GX5SXOU32ySfIGC2lILN839jekHK9j2Fum6L/l8=;
	b=Vmh096WBxN7SiqupfeBMMBahhpRon6lzgq+TdDpaP9d9CB3/oU5GJJRfSn9L+EVAFiugBd
	Dvw1SktfQXdrucaQd6GZt5ZasxGD7152rpX3kyXMP+sIwhM9EZohb5X37gMkrXpkiFgd0q
	wQsBkKDgtAaAUsaVeVgxPJvfPZvBDrE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-a1JTy1LZMlyVa_K90znePA-1; Tue, 19 May 2026 08:58:09 -0400
X-MC-Unique: a1JTy1LZMlyVa_K90znePA-1
X-Mimecast-MFC-AGG-ID: a1JTy1LZMlyVa_K90znePA_1779195488
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-67ff00a6997so3323520a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 05:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195488; x=1779800288;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RU31FpX0lvZwHpAUR7pLSx9bMohAu0sEBHOkXaeR8yw=;
        b=C4DXz5BKkFiNRhXhgZGv90WCdL3mraVmF2ioV0RYYuOazEYa06+aihOSOsoYqRAWRv
         EVieh93xTEMnHLUry9j28my5zSq6jUGASD6f8f5LADSldjiFKtI/Vxcz7fgOpaTAn4Sr
         ldhkhWUgvyGRjoTplUODss/E0u6QTW5j3Z0JO7kJdMoxA5F/svctDCuVhu0ty8s1n2F/
         EUsskg0DPb7SE4q7rllbBsBmPHX5LH8bwnvK0Bm0zLZgF/lbcHf1Om8Lit7e2TjaBE4N
         0aHxaPDT7v+Obl6nokS0xN6rA79YdDEwREv121c6L9rgJhPxtg1viiQCnHyKOOVRZOyC
         jN7w==
X-Forwarded-Encrypted: i=1; AFNElJ/W/RdbZ77IJ0ra0MQF9KTp+Kbh2mfl5JGGiDkxcYv61XGf3Hr+AYDPNF9oQETaMZr6G92AV0RZzyRouxasZIO1L5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym8F+2ZJCT2wcZVpKlNXyHSGKfVIogAmRUyk/iXwPoonimsseN
	Nnb37nub3dyVuFXaCUgEKog+spSz3e/WrlBB89nrWyk/v4n0ldTuQ6weS5tNCulvzYDt/vo7EJ9
	I17xp3+VaOY4aoayxWFFNszzeXqRPS3SckocY+OMN0aqPg04PVM4stWDBCyQfjjwkB0gxbP0IqA
	FYA49OKi8C
X-Gm-Gg: Acq92OH/kvmZufuSPpoUhYjVhitD7FD+bzm8Ikot1+QeNF+KfnWjR+x9GTzdkSRuwGl
	9WYNGzjwhDFyWa4y38cFAd/RC5ku9W1fpfo8FgSExfXBAnNxRlJ9YkfjKrvhq29J0HO2bjnoFzt
	7SRl6/wOzEIPQGyRw+3nN4aClSDPEPYT3AfJpPXkCl/EiUBr9lJoOakoZxVUlbkcWIors2ld9HR
	/CXMZ1Qq7TdnbZ1JyUTg25ym2tCIsJopsvrY07Aa/4o3XSaJnqhIkWcHCUKIWwwUTfMGzSpixZR
	5k2gU3IxezrO3CRBmrtO697a1P4Nktkwzml2OQvt8qSosovMGUeWEOVWTzXhMGYPshcHoCpkD5q
	KCUb/d/N051QqtvwXBw/ia7QxYI6WehcJX20iOSvDYMT4/XZIW5aGTu5DfgJFi6NcoUEYbzifxD
	GyT+vHuXoDqV6fVZw=
X-Received: by 2002:aa7:c4e7:0:b0:670:8b38:5717 with SMTP id 4fb4d7f45d1cf-683bd581a49mr7272448a12.24.1779195487940;
        Tue, 19 May 2026 05:58:07 -0700 (PDT)
X-Received: by 2002:aa7:c4e7:0:b0:670:8b38:5717 with SMTP id 4fb4d7f45d1cf-683bd581a49mr7272428a12.24.1779195487409;
        Tue, 19 May 2026 05:58:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6831197bf00sm6537667a12.31.2026.05.19.05.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:58:07 -0700 (PDT)
Message-ID: <5af6afbfa32ede2db7f21412c8c21831f0eefd04.camel@redhat.com>
Subject: Re: [PATCH 2/3] rv/rtapp/sleep: Update nanosleep rule
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Tue, 19 May 2026 14:58:05 +0200
In-Reply-To: <a2175a6647bb88797ad8275eddb4b20b749474ec.1779176466.git.namcao@linutronix.de>
References: <cover.1779176466.git.namcao@linutronix.de>
	 <a2175a6647bb88797ad8275eddb4b20b749474ec.1779176466.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 4Kmh1f8qgGuH6tE0m2w6hALOl8rEB3JjmHy68Dox7o8_1779195488
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-19 at 09:49 +0200, Nam Cao wrote:
> CLOCK_REALTIME is the only clock that often is misused in real-time
> applications. The other clocks either are safe for real-time uses
> (CLOCK_TAI, CLOCK_MONOTONIC, CLOCK_BOOTTIME) or are unlikely to be misuse=
d
> (CLOCK_AUX, CLOCK_PROCESS_CPUTIME_ID).
>=20
> The rtapp monitor's purpose is warning people about common mistakes with
> real-time design. However, warning about all clock types generates too mu=
ch
> false positives.

I'm fine with the change, but are those really false positives?

From what I understand before this change we would report any non-rt-friend=
ly
clock type, now only realtime.
What we are skipping would still be true positives, just so uncommon not to
justify the extra complexity, right?

Or do you mean an RT task using CLOCK_AUX is a false positive because likel=
y the
users weren't even trying to do real-time?

Thanks,
Gabriele

>=20
> Update the monitor to only warn about CLOCK_REALTIME.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0 | 10 ++---
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.h=C2=A0=C2=A0=C2=A0 | 52 +++++=
++++++------------
> =C2=A0tools/verification/models/rtapp/sleep.ltl |=C2=A0 2 +-
> =C2=A03 files changed, 28 insertions(+), 36 deletions(-)
>=20
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index 0a36f5519e6b..e01ac56b3f4a 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -43,9 +43,7 @@ static void ltl_atoms_init(struct task_struct *task, st=
ruct
> ltl_monitor *mon, bo
> =C2=A0=09ltl_atom_set(mon, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, false);
> =C2=A0
> =C2=A0=09if (task_creation) {
> -=09=09ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> +=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> @@ -136,8 +134,7 @@ static void handle_sys_enter(void *data, struct pt_re=
gs
> *regs, long id)
> =C2=A0=09case __NR_clock_nanosleep_time64:
> =C2=A0#endif
> =C2=A0=09=09syscall_get_arguments(current, regs, args);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, args[0] =3D=3D
> CLOCK_MONOTONIC);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, args[0] =3D=3D
> CLOCK_TAI);
> +=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, args[0] =3D=3D
> CLOCK_REALTIME);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, args[1] =3D=3D
> TIMER_ABSTIME);
> =C2=A0=09=09ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
> =C2=A0=09=09break;
> @@ -178,8 +175,7 @@ static void handle_sys_exit(void *data, struct pt_reg=
s
> *regs, long ret)
> =C2=A0
> =C2=A0=09ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
> =C2=A0=09ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> -=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
> -=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> +=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
> =C2=A0=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
> =C2=A0=09ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.h
> b/kernel/trace/rv/monitors/sleep/sleep.h
> index 95dc2727c059..ed1ac7ad008e 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.h
> +++ b/kernel/trace/rv/monitors/sleep/sleep.h
> @@ -20,8 +20,7 @@ enum ltl_atom {
> =C2=A0=09LTL_FUTEX_WAIT,
> =C2=A0=09LTL_KERNEL_THREAD,
> =C2=A0=09LTL_KTHREAD_SHOULD_STOP,
> -=09LTL_NANOSLEEP_CLOCK_MONOTONIC,
> -=09LTL_NANOSLEEP_CLOCK_TAI,
> +=09LTL_NANOSLEEP_CLOCK_REALTIME,
> =C2=A0=09LTL_NANOSLEEP_TIMER_ABSTIME,
> =C2=A0=09LTL_RT,
> =C2=A0=09LTL_SLEEP,
> @@ -46,8 +45,7 @@ static const char *ltl_atom_str(enum ltl_atom atom)
> =C2=A0=09=09"fu_wa",
> =C2=A0=09=09"ker_th",
> =C2=A0=09=09"kth_sh_st",
> -=09=09"na_cl_mo",
> -=09=09"na_cl_ta",
> +=09=09"na_cl_re",
> =C2=A0=09=09"na_ti_ab",
> =C2=A0=09=09"rt",
> =C2=A0=09=09"sl",
> @@ -87,8 +85,7 @@ static void ltl_start(struct task_struct *task, struct
> ltl_monitor *mon)
> =C2=A0=09bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> =C2=A0=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> =C2=A0=09bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_AB=
STIME,
> mon->atoms);
> -=09bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon-
> >atoms);
> -=09bool nanosleep_clock_monotonic =3D
> test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
> +=09bool nanosleep_clock_realtime =3D
> test_bit(LTL_NANOSLEEP_CLOCK_REALTIME, mon->atoms);
> =C2=A0=09bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, m=
on-
> >atoms);
> =C2=A0=09bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
> =C2=A0=09bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
> @@ -97,17 +94,17 @@ static void ltl_start(struct task_struct *task, struc=
t
> ltl_monitor *mon)
> =C2=A0=09bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atom=
s);
> =C2=A0=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->=
atoms);
> =C2=A0=09bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> -=09bool val42 =3D task_is_rcu || task_is_migration;
> -=09bool val43 =3D futex_lock_pi || val42;
> -=09bool val5 =3D block_on_rt_mutex || val43;
> -=09bool val34 =3D abort_sleep || kthread_should_stop;
> -=09bool val35 =3D woken_by_nmi || val34;
> -=09bool val36 =3D woken_by_hardirq || val35;
> -=09bool val14 =3D woken_by_equal_or_higher_prio || val36;
> +=09bool val41 =3D task_is_rcu || task_is_migration;
> +=09bool val42 =3D futex_lock_pi || val41;
> +=09bool val5 =3D block_on_rt_mutex || val42;
> +=09bool val33 =3D abort_sleep || kthread_should_stop;
> +=09bool val34 =3D woken_by_nmi || val33;
> +=09bool val35 =3D woken_by_hardirq || val34;
> +=09bool val14 =3D woken_by_equal_or_higher_prio || val35;
> =C2=A0=09bool val13 =3D !wake;
> -=09bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
> -=09bool val27 =3D nanosleep_timer_abstime && val26;
> -=09bool val18 =3D clock_nanosleep && val27;
> +=09bool val25 =3D !nanosleep_clock_realtime;
> +=09bool val26 =3D nanosleep_timer_abstime && val25;
> +=09bool val18 =3D clock_nanosleep && val26;
> =C2=A0=09bool val20 =3D val18 || epoll_wait;
> =C2=A0=09bool val9 =3D futex_wait || val20;
> =C2=A0=09bool val11 =3D val9 || kernel_thread;
> @@ -138,8 +135,7 @@ ltl_possible_next_states(struct ltl_monitor *mon, uns=
igned
> int state, unsigned l
> =C2=A0=09bool sleep =3D test_bit(LTL_SLEEP, mon->atoms);
> =C2=A0=09bool rt =3D test_bit(LTL_RT, mon->atoms);
> =C2=A0=09bool nanosleep_timer_abstime =3D test_bit(LTL_NANOSLEEP_TIMER_AB=
STIME,
> mon->atoms);
> -=09bool nanosleep_clock_tai =3D test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon-
> >atoms);
> -=09bool nanosleep_clock_monotonic =3D
> test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
> +=09bool nanosleep_clock_realtime =3D
> test_bit(LTL_NANOSLEEP_CLOCK_REALTIME, mon->atoms);
> =C2=A0=09bool kthread_should_stop =3D test_bit(LTL_KTHREAD_SHOULD_STOP, m=
on-
> >atoms);
> =C2=A0=09bool kernel_thread =3D test_bit(LTL_KERNEL_THREAD, mon->atoms);
> =C2=A0=09bool futex_wait =3D test_bit(LTL_FUTEX_WAIT, mon->atoms);
> @@ -148,17 +144,17 @@ ltl_possible_next_states(struct ltl_monitor *mon,
> unsigned int state, unsigned l
> =C2=A0=09bool clock_nanosleep =3D test_bit(LTL_CLOCK_NANOSLEEP, mon->atom=
s);
> =C2=A0=09bool block_on_rt_mutex =3D test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->=
atoms);
> =C2=A0=09bool abort_sleep =3D test_bit(LTL_ABORT_SLEEP, mon->atoms);
> -=09bool val42 =3D task_is_rcu || task_is_migration;
> -=09bool val43 =3D futex_lock_pi || val42;
> -=09bool val5 =3D block_on_rt_mutex || val43;
> -=09bool val34 =3D abort_sleep || kthread_should_stop;
> -=09bool val35 =3D woken_by_nmi || val34;
> -=09bool val36 =3D woken_by_hardirq || val35;
> -=09bool val14 =3D woken_by_equal_or_higher_prio || val36;
> +=09bool val41 =3D task_is_rcu || task_is_migration;
> +=09bool val42 =3D futex_lock_pi || val41;
> +=09bool val5 =3D block_on_rt_mutex || val42;
> +=09bool val33 =3D abort_sleep || kthread_should_stop;
> +=09bool val34 =3D woken_by_nmi || val33;
> +=09bool val35 =3D woken_by_hardirq || val34;
> +=09bool val14 =3D woken_by_equal_or_higher_prio || val35;
> =C2=A0=09bool val13 =3D !wake;
> -=09bool val26 =3D nanosleep_clock_monotonic || nanosleep_clock_tai;
> -=09bool val27 =3D nanosleep_timer_abstime && val26;
> -=09bool val18 =3D clock_nanosleep && val27;
> +=09bool val25 =3D !nanosleep_clock_realtime;
> +=09bool val26 =3D nanosleep_timer_abstime && val25;
> +=09bool val18 =3D clock_nanosleep && val26;
> =C2=A0=09bool val20 =3D val18 || epoll_wait;
> =C2=A0=09bool val9 =3D futex_wait || val20;
> =C2=A0=09bool val11 =3D val9 || kernel_thread;
> diff --git a/tools/verification/models/rtapp/sleep.ltl
> b/tools/verification/models/rtapp/sleep.ltl
> index 6f26c4810f78..2637bc48a620 100644
> --- a/tools/verification/models/rtapp/sleep.ltl
> +++ b/tools/verification/models/rtapp/sleep.ltl
> @@ -9,7 +9,7 @@ RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
> =C2=A0
> =C2=A0RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and NANOSLEEP_TIMER_ABSTIM=
E
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and (NANOSLEEP_CLOCK_MONOTONIC o=
r NANOSLEEP_CLOCK_TAI)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and not NANOSLEEP_CLOCK_REALTIME
> =C2=A0
> =C2=A0RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 or WOKEN_BY_HARDIRQ

