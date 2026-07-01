Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436E4963B3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908968; cv=none; b=K9TAhmOqC7EdKjr8g4PjZiRnVjRCGl1Wc2hlTMfwadWCly/0u9DgphXGh8QTs5FvWCjfw+pjrp4XAj4LBhk6r9gPXDG2fJTo2WON/Cr9ICeXe2EL26lZfRtgsS5RargfpAqkBeQC4j9RN4R/QHJizhWXfnMgDwQYcZWq/X8u1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908968; c=relaxed/simple;
	bh=lLteCD0qkGQc2OQHOHztYmTgYDEe6Ro841P+dTHBkpc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnDugSR3LptpKt7FAnnyg56DeuZgD29BOhw+kLRXy7A9nOPUnQ94fnPt5hWRckTk1504s1uZ85MeUAKzQu7A7peP2CoXy4DDps4UeJUbz6HsVdSlS2Wz/kBlMNmNtdGj2urIbCJZO1rjxhHLRP2KnhVS6VllS4WizsQ2W9taaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGCFZ6c4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGCFZ6c4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782908964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lLteCD0qkGQc2OQHOHztYmTgYDEe6Ro841P+dTHBkpc=;
	b=IGCFZ6c4LZnw8ruxMw6lYC610+DzqmIW/NAbzU2HCBBAaEYL5uw4a7TC+SkdyCbD3iGSyz
	N85of7TDsDyWwdwucVsGIehqLtWxAf4QCcMqsnigYOqusggo3q5w4uLQc+iC1uSwPr+oVi
	1qTvMr6l4pI8Qd/PQ/32ZfzWn+m8meM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-VqGfTgD2Mvq2JKKGwx6dHg-1; Wed, 01 Jul 2026 08:29:23 -0400
X-MC-Unique: VqGfTgD2Mvq2JKKGwx6dHg-1
X-Mimecast-MFC-AGG-ID: VqGfTgD2Mvq2JKKGwx6dHg_1782908962
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bdaf8549so7115255e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 05:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908962; x=1783513762;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QBml1wXQrKkB4Dbp2yh/EBSKR66LFRDhLUx+zmUXDw=;
        b=AIv+5RnnwiGRRIDsgyzuGzkDvU+KZIcQVm/ZGTMH9dndgUuoll5uc5bbjo55GklbEm
         l5FxYhniHANc5oMvCqcAx5a6h+R1EHuOq7GOYtsWGu812K8E+LyeqosH+iTqX3IdtruU
         84J8wbSKnQZozx1jqGMsALxyGYuyTwVF0ZiEmXg5Gpm9z2z+5WosttxL79y94qh0cYQt
         hkS0r4kSD0TyBXb0EfDsGlCCLT0RKCCO2Cz75PXfgqQlPyB93Ps/Du/v+RItov7InHVw
         dSuGyHNO8q3JVfKvspEgnHT5EXxADj4ZGN/59utAl9DMts1ZuPI9BED+GczcXWW0QEXd
         aUgA==
X-Forwarded-Encrypted: i=1; AFNElJ9wBW6VJB0W07U9lbzasIcAHavD32YQ4BP1Pd0dsPFS5Z4PMnwDaTOZFOn0Pc9JkKJdY5i6HT7Tw8ctV9itPTC/fN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dGyXmA6eHgmqhWwnRcK/HS84wt51eIvuzBdgCJ4k1fIXF1X3
	HPFaDyFg9rGrT0z60mXi5aYRIm1GF2fug2Wds0m0dGqWf8qmAOX4YBZGafbJolNclj19r+gRMmq
	CAN+jnPqiegcW3nyp0HSBMSkqB+C1BwBA76mL7GzYZbenrtZzSi3qoqGJWDDmgHzIOTGXUW0Dgv
	zEYwW7LJFq
X-Gm-Gg: AfdE7cmwMJ7f36H5H/SjWPUhkkCB8HoLa/DM768yknAMSQYPZVW+JBftMVubKvNvZyz
	AkyWPvr9HWjiR47Wi8/QvAL3xhnc64QIRdnUcdyhL/QFM3p8uE7unHni/y5+ksLLfgKRfYlmx9Q
	kRluB6jTG/oDiTt8eqkbVta0wTphIA5d+Se4S7nEWMJyAHvPY8exOXyXKW0EHlMHqCwyyXY1cMA
	etmJw7B51hDMSeyoRrGMAI92naQovCauplF2aCZw3MrZ4gRGRfC5YC9G9lHDEyiI0HldDBrdvnt
	cD1bZUzXnL+uhOhE5tQFpvT39nGKx0yk1Yue2rzErYpG3vI4GhQoqjxpK4VLYoluGoeaBUzGCPD
	cucEbrlxtZGKXf2o8VkH649kK+7DmuYwOxtKp53AjSua4UwbRjt4rdvrzI11Kt5fO9F1jilYDGD
	5UdbvJ
X-Received: by 2002:a05:600c:6792:b0:493:bd71:6084 with SMTP id 5b1f17b1804b1-493c2b96797mr22805665e9.31.1782908961646;
        Wed, 01 Jul 2026 05:29:21 -0700 (PDT)
X-Received: by 2002:a05:600c:6792:b0:493:bd71:6084 with SMTP id 5b1f17b1804b1-493c2b96797mr22805175e9.31.1782908961210;
        Wed, 01 Jul 2026 05:29:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810c02sm79547145e9.11.2026.07.01.05.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:29:20 -0700 (PDT)
Message-ID: <72909c5431d8a6564aaab10056b9c59d5750d956.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] rv/rtapp/sleep: Update nanosleep rule
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 01 Jul 2026 14:29:19 +0200
In-Reply-To: <c7ceb5c6263ee8f43a2676acae669cf486b0d903.1781852967.git.namcao@linutronix.de>
References: <cover.1781852967.git.namcao@linutronix.de>
	 <c7ceb5c6263ee8f43a2676acae669cf486b0d903.1781852967.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: QVH6Cr4y2ZaDjuQu_1N65YfsGgabZJqhb1Dd494AKEU_1782908962
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-19 at 09:21 +0200, Nam Cao wrote:
> CLOCK_REALTIME is the only clock that often is misused in real-time
> applications. The other clocks either are safe for real-time uses
> (CLOCK_TAI, CLOCK_MONOTONIC, CLOCK_BOOTTIME) or are unlikely to be misuse=
d
> (CLOCK_AUX, CLOCK_PROCESS_CPUTIME_ID).
>=20
> Update the monitor to only warn about CLOCK_REALTIME.
>=20
> While at it, update the out-of-sync documentation.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Looks good, thanks.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0Documentation/trace/rv/monitor_rtapp.rst=C2=A0 | 17 +++++---
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0 | 12 ++---=
-
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.h=C2=A0=C2=A0=C2=A0 | 52 +++++=
++++++------------
> =C2=A0tools/verification/models/rtapp/sleep.ltl |=C2=A0 2 +-
> =C2=A04 files changed, 39 insertions(+), 44 deletions(-)
>=20
> diff --git a/Documentation/trace/rv/monitor_rtapp.rst
> b/Documentation/trace/rv/monitor_rtapp.rst
> index 01656bf7080a..570be67a8f3b 100644
> --- a/Documentation/trace/rv/monitor_rtapp.rst
> +++ b/Documentation/trace/rv/monitor_rtapp.rst
> @@ -51,12 +51,13 @@ The `sleep` monitor reports real-time threads sleepin=
g in
> a manner that may
> =C2=A0cause undesirable latency. Real-time applications should only put a=
 real-time
> =C2=A0thread to sleep for one of the following reasons:
> =C2=A0
> -=C2=A0 - Cyclic work: real-time thread sleeps waiting for the next cycle=
. For this
> -=C2=A0=C2=A0=C2=A0 case, only the `clock_nanosleep` syscall should be us=
ed with
> `TIMER_ABSTIME`
> -=C2=A0=C2=A0=C2=A0 (to avoid time drift) and `CLOCK_MONOTONIC` (to avoid=
 the clock being
> -=C2=A0=C2=A0=C2=A0 changed). No other method is safe for real-time. For =
example, threads
> -=C2=A0=C2=A0=C2=A0 waiting for timerfd can be woken by softirq which pro=
vides no real-time
> -=C2=A0=C2=A0=C2=A0 guarantee.
> +=C2=A0 - Cyclic work: real-time thread sleeps waiting for the next
> +=C2=A0=C2=A0=C2=A0 cycle. For this case, only the `clock_nanosleep` sysc=
all should be
> +=C2=A0=C2=A0=C2=A0 used with `TIMER_ABSTIME` (to avoid time drift). Addi=
tionally,
> +=C2=A0=C2=A0=C2=A0 `CLOCK_REALTIME` should not be used (to avoid the clo=
ck being
> +=C2=A0=C2=A0=C2=A0 changed). No other method is safe for real-time. For =
example,
> +=C2=A0=C2=A0=C2=A0 threads waiting for timerfd can be woken by softirq w=
hich provides
> +=C2=A0=C2=A0=C2=A0 no real-time guarantee.
> =C2=A0=C2=A0 - Real-time thread waiting for something to happen (e.g. ano=
ther thread
> =C2=A0=C2=A0=C2=A0=C2=A0 releasing shared resources, or a completion sign=
al from another thread).
> In
> =C2=A0=C2=A0=C2=A0=C2=A0 this case, only futexes (FUTEX_LOCK_PI, FUTEX_LO=
CK_PI2 or one of
> @@ -99,14 +100,16 @@ The monitor's specification is::
> =C2=A0
> =C2=A0=C2=A0 RT_VALID_SLEEP_REASON =3D FUTEX_WAIT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or RT_FR=
IENDLY_NANOSLEEP
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or EPOLL_WAIT
> =C2=A0
> =C2=A0=C2=A0 RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and NANOSLEEP_=
TIMER_ABSTIME
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and NANOSLEEP_CLOCK_=
MONOTONIC
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and not NANOSLEEP_CL=
OCK_REALTIME
> =C2=A0
> =C2=A0=C2=A0 RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or WOKEN_BY_HARDIRQ
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or WOKEN_BY_NMI
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or ABORT_SLEEP
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or KTHREAD_SHOULD_STOP
> =C2=A0
> =C2=A0=C2=A0 ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index d6b677fab8f8..638be7d8747f 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -44,8 +44,7 @@ static void ltl_atoms_init(struct task_struct *task, st=
ruct
> ltl_monitor *mon, bo
> =C2=A0
> =C2=A0=09if (task_creation) {
> =C2=A0=09=09ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> +=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> @@ -60,8 +59,7 @@ static void ltl_atoms_init(struct task_struct *task, st=
ruct
> ltl_monitor *mon, bo
> =C2=A0=09=09/* kernel tasks do not do syscall */
> =C2=A0=09=09ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
> -=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
> +=09=09ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_REALTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
> =C2=A0=09=09ltl_atom_set(mon, LTL_EPOLL_WAIT, false);
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
> index 403dc2852c52..2fe2ec7edae8 100644
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
> =C2=A0=09LTL_SCHEDULE_IN,
> @@ -46,8 +45,7 @@ static const char *ltl_atom_str(enum ltl_atom atom)
> =C2=A0=09=09"fu_wa",
> =C2=A0=09=09"ker_th",
> =C2=A0=09=09"kth_sh_st",
> -=09=09"na_cl_mo",
> -=09=09"na_cl_ta",
> +=09=09"na_cl_re",
> =C2=A0=09=09"na_ti_ab",
> =C2=A0=09=09"rt",
> =C2=A0=09=09"sch_in",
> @@ -87,8 +85,7 @@ static void ltl_start(struct task_struct *task, struct
> ltl_monitor *mon)
> =C2=A0=09bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
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
> =C2=A0=09bool val13 =3D !schedule_in;
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
> =C2=A0=09bool schedule_in =3D test_bit(LTL_SCHEDULE_IN, mon->atoms);
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
> =C2=A0=09bool val13 =3D !schedule_in;
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
> index 464c84b9df87..5923e58d7810 100644
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

