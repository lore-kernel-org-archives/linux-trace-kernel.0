Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8B402456
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970155; cv=none; b=G/y3CmDS7cndDhvbmzCgr+d8dZA3XTKEuJCgi60cNTCwVxxB8wevdWXe7J0cDjyoZRhjf3NDSBqKPSSUqSTuHsG3sOPRCiqwY8HLNv3Stx9LthfJCc5oxVkvV85NNxlOfnbc1FPj7gPtO24kvy+PmqE3hjkbMzElgAEOSpeA/Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970155; c=relaxed/simple;
	bh=9zeiqNRproIH1heAPULMwVbTeH5Vxu4OcJkVCJWXX50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaDOp0Aup53SaBRTJ3Tv8dbJGtXmrllQ2WZMa6C/bG/nRX/wiTiXx+8jaFOWCzyur8yhuuC6iamh8JdXYxkdBgKsNlqUXr5c/507jRZlQSIOR46hwyMJjE1JbCfwPSK0bxvNkDauSnfou2r6+jnKW8YAVSQ/0a50COsYi+42xYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfB6EaAd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfB6EaAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774970152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9zeiqNRproIH1heAPULMwVbTeH5Vxu4OcJkVCJWXX50=;
	b=gfB6EaAd/LRcv6ANtcZ504vX9Yfx1w0RDNCjU6XVnYS8hGW9VbUQn9QVQxi9vCGOPh6OKb
	N2diylHc0MRV0FXLbjlRs/yw+h2W7TeAySUn7bU9d/boh8oSnj0GKIj4qlhBHuN0clqaK2
	YkO8BFXNVk1ScNoUhcJWyG4ir7tgqLQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-DQKdWLvzN0SaEMrdCO_Fgw-1; Tue, 31 Mar 2026 11:15:51 -0400
X-MC-Unique: DQKdWLvzN0SaEMrdCO_Fgw-1
X-Mimecast-MFC-AGG-ID: DQKdWLvzN0SaEMrdCO_Fgw_1774970150
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b96365ea8so5849110f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 08:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970150; x=1775574950;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4HBFcbwsNQHeyAGmb9vmgKKSJ3ZRBIob7SULZD2l2Q=;
        b=eqdk/0TAn7hPhL2dUnwJGR8e+sD1oOjjLMxevvDOSYdGUQb+cEjpG0PQAwKr3yatPX
         mJ+/317sgrbR1z2P8TQ7PnFucfBwVTnN3bNYs3OHfyn4dhZMJviIJjRbvCOPjLI9hFS2
         6RbNNYc3gWitF+OTUXH/HontJ7eGyb3kP9Cs/mJAAQbmg4gHjTNNvnBs2daUZrUaMS4b
         KKgdPn2UqIZDQBsOgY8myM5KhMMccViDh3PPwDday3I9IjOyuHikSLIUJNuF/WBAIyKl
         ZPWQ5BlOgU5BGr1dg4OdjNiZBDdFzw7IWPRt6OoLBJGUdG7Xz9DnnpLZ+sByfDuyJn2/
         jsUA==
X-Forwarded-Encrypted: i=1; AJvYcCVfx+YUZjv1OG7P8SL/7t2YA1IFcHn7Rb5+vD9sAUDbugtSrCuBVYsm+nC0pnsOP+jK+AY5JtmT10r1Bi5E08mAG/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza1VAfE9Wjy6iKNdK/8moF1G/joCcggg4cKT6ygXrt1oxjKtuV
	5eSPphF1/dVi4yPV7K89cqyxyMYiUbguejU5LD6Ah2o/VTucx3DumtGMaFxrSslWu0TO7yTLxHa
	BUKXxyMIrEh0JiZs97m8pLTOxCdnxpAC1wCpMBNPkIXd9dDVI/nWOJQ705RIRmzg5CI1Upfsv+Q
	==
X-Gm-Gg: ATEYQzyrfhePBWZ/TY1fwQlMiHVzU7YwKvmT91qOin1BEw2DprPrAk6Mki78lMzxxe3
	YHiORmI/v7osxkEfSBvYnOMsJZ3f/8IazUjxTpMFy99KMpZeMJk0V0u1l8xEAYYCXZXqM7Kdg+W
	QtFzlXSDNAsOdQsbWeycUacbDC/SxwSuEbomKx5GTAIZrgd1GhaFp9fbqbifVgLG5CbafBpGg+A
	YrLWFN8Axxz5mlBULE1mZQjMD+d/3qIZ9Acqze11urHFumFRkeai262pZjVIxKWYLm1gGRe3BsI
	uFGAbI1ePzexYTkkz3EzLROQaoSCrSqfYzwT9Q3raviZQvrCWCfW7QykLVrybFG1zblCqgSRPt2
	d5WvF9PFtSXq+n/bOiN1ulA7htjUKZU/SYoVo5rR/RKrfQk+SworVyNrd3UCx9ILpY41r1P30qd
	AsNO01tGnEC3MohUk=
X-Received: by 2002:a05:6000:2dc2:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-43d021a9c17mr12757619f8f.32.1774970149893;
        Tue, 31 Mar 2026 08:15:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc2:b0:43d:21a:9a3e with SMTP id ffacd0b85a97d-43d021a9c17mr12757495f8f.32.1774970148986;
        Tue, 31 Mar 2026 08:15:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm29228480f8f.1.2026.03.31.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:15:48 -0700 (PDT)
Message-ID: <58674d7f10c260369f5cb78599ba6ecb3804358f.camel@redhat.com>
Subject: Re: [PATCH] rv: Allow epoll in rtapp-sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 31 Mar 2026 17:15:47 +0200
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
X-Mimecast-MFC-PROC-ID: DdhWas6_B3f-G_Qjq8J_yyNyZMdyBqRO4ysb1T50ZZQ_1774970150
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Tue, 2026-03-31 at 12:49 +0200, Nam Cao wrote:
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index c1347da69e9d..59091863c17c 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
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

Sashiko (the AI bot) wonders why this isn't ltl_atom_update() like other th=
ings
around here. Is that intentional?

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

