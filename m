Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098871;
	b=nbg2pTqK+X1rGcCYjvGFOFXFhuIXQQvmHn6p2wJ6BzkOYEAV3MIqTZQ1lXCfYavtigxb
	 f+kMHdWpL8A2DTdH21bR1MXiInG6LlVXzPRnoop3D4GkjsOm+4Too2X9PaqY9DDjItpt5
	 QRJ8nrVw6zoP+905O7Ysps1WUwYNzvvxAUms9SNVfSXHP84Zn09ezjfAnWhkbHNMMlIcD
	 dbeeCTrSpI8zT++b1/ZgA32NMDE83GOwaRjSIZ2op5xH/EuqJpLJPqLBxDndWm8kZyuxM
	 cXDmvitbpftEEEWYZu5sMkxoCNE9wZQ599cFQgBuNdw3+seKfS0c6KNumQ4V4hS2Clw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098871;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=pRSb81b3SBt/FIt43Arxg2bmJQWR+BvxXkEGFDTOslw=;
	b=MgCuVgfs4ZaBTuf2MhP2atNhMiY58xaqgjZeZn6+00nc3EwQrlLSOikRwnd5PswbYlLU
	 DDhSyZNk5mO5CBDRhYOQtZ+oa+HW94VPyN+s05OgxuSlTr9X127Du081Be3CXIOsvGNY8
	 Z5gFLHtQXPTa2XyNmx9cX6jWibMdPPAuBClcKX73MGLDXsA/ZU1NIQATNZogPR7kWXLxs
	 5O2uiL0E6BnkBoSLU1J0rj09GZR0I9CFvRdGIJ+LIHppq2KLYuWmEEdQV0TIiC0Q1FBuC
	 tfJxj0dLkFC7VWB7uaEOphl+LmXpjzV5neAf5g7ynBTNHxZIJiBzU2INDlmOWtKEJww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="DeBd/wuP";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36734606A320
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 14:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36734606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DeBd/wuP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795098870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pRSb81b3SBt/FIt43Arxg2bmJQWR+BvxXkEGFDTOslw=;
	b=DeBd/wuP6GFoeqiWksBJbRHUtd4jLZNQ6eeNefUnXAivZU7FZNWkZm1htBhB5/woTQwYQi
	1KkQaPEOzWVVUryJk3tO3cwhcN9iRS3wwF79xxJ/ltXGFu8YfAlX0R++X9v8OzTfoNOoOi
	UiU84bCJIiReE6FCyRsIam7LstTA1Vw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-eQuGNH2AO0qDpFuWPhNPZA-1; Thu, 19 Nov 2026 14:34:28 +0000
X-MC-Unique: eQuGNH2AO0qDpFuWPhNPZA-1
X-Mimecast-MFC-AGG-ID: eQuGNH2AO0qDpFuWPhNPZA_1795098867
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4ba01393800so15128955e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 06:34:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098867; x=1795703667;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pRSb81b3SBt/FIt43Arxg2bmJQWR+BvxXkEGFDTOslw=;
        b=dTxbpAxgwABXKTKBBUM/9m4FggB5gRE8Fcn2awJu0mKBd5jypLoSTj2fYVKEUzC0Go
         K5KP4jV72wt+d8iwq/xj1uSdPqeIHPFEt5xr+v1mZIefGB/CROvvbAPCP2uQwvDiwUsR
         Lkj8F0t3QHXeD0AIih9DSel0mbIlynVqdg+4gmG9PeYWUmcT4EnjDQqPQIQb4hOOAkod
         U1qC2wX6nY/BldV9AE1hRKqQ6EwMstVh7z/B+2/GITzjF/i989bFInDEDFAULzcZNNbH
         Y18IffgjLYJG5RBM/JvdDhfCktK80C48OByoV8NeNkApikYt/ZmybkmuihOR7xvkZDJT
         iXkg==
X-Forwarded-Encrypted: i=1; AL+hErEPAlR1gp7fDPaP7S4GqYHOdPwTttADe0/VFKK4MzMlwZr3KmyjNhp93dNYuv2FVJ4HCgfbA8jjaEdkP9oopiVCWlg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3hyrH8DCbO2NLfWdr9ogAhvzmNXqKzfZ5h+5dA2aP9qaSWf4K
	VhOOoAp42Lh1uT/cfYJXNC6I/FFzIqw3E8zPbFQkUn0hNYalAtTaJPuuCybxL5GeCeUFgpgOqSr
	G7VV4zciLFQL+xhlKDEzfFA3Lz846HpmTMA2HWVU2trrbmpW8qAago+j42OUxqLq/g04gMuKPpA
	==
X-Gm-Gg: AYBFou3bN+EMmSRFCaBAzAQZutg9+KrVGfXRlyGzCBTE+fghZ/kyOTjdQS4Ln5ySn8h
	ao1rJxf0A4be1LBuyiLfDRsMNbO0UCycvmXJ+hTACF5D4jx6F2iYAHPTmiWYkREgU9mgD5jnWsN
	lxMGzK+42+wtN4R02XTDMFnLbKOImYGcIwiJEotAAOKEoJZEIkL8vygGxcVS3fbxMtNTy8k9igG
	C2aGGbUkk4PtH/jtbw7UPcX3bp8520jIuROZeg8eTLTvNHFXSQ4JikvNEOFM/UyHqgnC4eIrP/v
	Xi4ol9mKTkGezfE4n1qQJp2thJRjYJDMBsHq7HU2RF4tbJzKOBNqDzlSIT1Vo2+j8ExNb7Fqap8
	dIdK+HLEoomAh9a4Xdx209WFKOKt+l9GSrDGb1JrTnunILwemLcIvb5SH5q7MaJt1CLfME5596G
	li
X-Received: by 2002:a05:600c:19d2:b0:4bb:647d:dabe with SMTP id 5b1f17b1804b1-4bb7d5d65ffmr131047155e9.3.1795098866816;
        Thu, 19 Nov 2026 06:34:26 -0800 (PST)
X-Received: by 2002:a05:600c:19d2:b0:4bb:647d:dabe with SMTP id 5b1f17b1804b1-4bb7d5d65ffmr131046695e9.3.1795098866415;
        Thu, 19 Nov 2026 06:34:26 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm52062595e9.0.2026.11.19.06.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:34:25 -0800 (PST)
Message-ID: <825843fdfe962bc03b360d686773ca82f2502d60.camel@redhat.com>
Subject: Re: [PATCH v8 02/14] rv: Fix ha_monitor timer and invariant
 underflow
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 19 Nov 2026 15:34:23 +0100
In-Reply-To: <f373c9fd1652b4c5789fddd83a18b9e6e350c588.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
	 <f373c9fd1652b4c5789fddd83a18b9e6e350c588.1793900349.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1hXZNcjskNAEMGzI_XKGKBf90vR-EUNwVa46q-BZA7A_1795098867
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-06 at 01:49 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> ha_start_timer_ns() and ha_start_timer_jiffy() compute the remaining
> budget as expire - passed.=C2=A0 Once the elapsed time passed exceeds the
> budget expire (e.g. a state transition after the invariant should have
> fired, before the timer callback ran), the unsigned subtraction
> underflows to a huge value and the timer is scheduled far into the
> future instead of expiring immediately, so the monitor stops enforcing
> the budget.
>=20
> ha_check_invariant_ns() computes store >=3D time_ns - expire_ns, which
> underflows when the system uptime is still below expire_ns (a monitor
> armed early in boot with a large budget), reporting a false violation.
>=20
> Clamp the timer remainder to 0 (fire immediately) when passed >=3D expire=
,
> and rewrite the invariant check as store + expire_ns >=3D time_ns so
> neither side can underflow.=C2=A0 Both timer flavours (jiffy and hrtimer)=
 are
> fixed.
>=20
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Fixes: ab2900ae252b ("rv: Simplify hybrid automata monitors's clock
> variables")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

Minor nits on the comments that you added since last time, you can keep my
review tag.

> =C2=A0include/rv/ha_monitor.h | 29 ++++++++++++++++++++++++-----
> =C2=A01 file changed, 24 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 93ac99ff7f1d..ebb7f91e3447 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -351,7 +351,11 @@ static inline void ha_reset_clk_ns(struct ha_monitor
> *ha_mon, enum envs env, u64
> =C2=A0static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,=
 enum envs
> env,
> =C2=A0=09=09=09=09=09 u64 time_ns, u64 expire_ns)
> =C2=A0{
> -=09return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns - expire_ns;
> +=09/*
> +=09 * Compare as store + expire >=3D time to avoid underflow when the
> +=09 * system uptime is still below expire_ns (early boot, large budget).
> +=09 */

This comment isn't necessary, please instruct your LLMs not to mention how =
the
code use to look before they touched it. There are commit messages for that=
. And
I wouldn't get too technical on the code there, the diff speaks clearly eno=
ugh.

> +=09return READ_ONCE(ha_mon->env_store[env]) + expire_ns >=3D time_ns;
> =C2=A0}

Why don't you do the same in ha_check_invariant_jiffy() ?

> =C2=A0/*
> =C2=A0 * ha_invariant_passed_ns - prepare the invariant and return the ti=
me since
> reset
> @@ -410,6 +414,17 @@ static inline void ha_inv_to_guard(struct ha_monitor
> *ha_mon, enum envs env,
> =C2=A0=09WRITE_ONCE(ha_mon->env_store[env], READ_ONCE(ha_mon->env_store[e=
nv])
> - value);
> =C2=A0}
> =C2=A0
> +/*
> + * ha_time_left - time left before expire, 0 once it already passed
> + *
> + * A plain expire - passed underflows and would arm the timer far in the
> + * future.=C2=A0 Unit-agnostic: callers pass ns or jiffies consistently.

This second paragraph is also redundant. It's clear what you aim to do and =
I'd
say the fact it doesn't have a unit in the name means it doesn't require on=
e
(from the code it's fairly obvious anyway).

Thanks,
Gabriele

> + */
> +static inline u64 ha_time_left(u64 passed, u64 expire)
> +{
> +=09return passed < expire ? expire - passed : 0;
> +}
> +
> =C2=A0#if HA_TIMER_TYPE =3D=3D HA_TIMER_WHEEL
> =C2=A0/*
> =C2=A0 * Helper functions to handle the monitor timer.
> @@ -439,15 +454,17 @@ static inline void ha_start_timer_jiffy(struct
> ha_monitor *ha_mon, enum envs env
> =C2=A0{
> =C2=A0=09u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, time_ns);
> =C2=A0
> -=09mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
> +=09mod_timer(&ha_mon->timer,
> +=09=09=C2=A0 get_jiffies_64() + ha_time_left(passed, expire));
> =C2=A0}
> =C2=A0static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enu=
m envs
> env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire, u64 time_ns)
> =C2=A0{
> =C2=A0=09u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);
> +=09u64 delay =3D ha_time_left(passed, expire);
> =C2=A0
> =C2=A0=09ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
> -=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 nsecs_to_jiffies(expire - passed + TIC=
K_NSEC -
> 1), time_ns);
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 nsecs_to_jiffies(delay + TICK_NSEC - 1=
),
> time_ns);
> =C2=A0}
> =C2=A0/*
> =C2=A0 * ha_cancel_timer - Cancel the timer
> @@ -494,7 +511,8 @@ static inline void ha_start_timer_ns(struct ha_monito=
r
> *ha_mon, enum envs env,
> =C2=A0
> =C2=A0=09if (RV_MON_TYPE =3D=3D RV_MON_PER_CPU)
> =C2=A0=09=09mode |=3D HRTIMER_MODE_PINNED;
> -=09hrtimer_start(&ha_mon->hrtimer, ns_to_ktime(expire - passed), mode);
> +=09hrtimer_start(&ha_mon->hrtimer,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ns_to_ktime(ha_time_left(passed, ex=
pire)), mode);
> =C2=A0}
> =C2=A0static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, =
enum envs
> env,
> =C2=A0=09=09=09=09=09u64 expire, u64 time_ns)
> @@ -502,7 +520,8 @@ static inline void ha_start_timer_jiffy(struct ha_mon=
itor
> *ha_mon, enum envs env
> =C2=A0=09u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, time_ns);
> =C2=A0
> =C2=A0=09ha_start_timer_ns(ha_mon, ENV_MAX_STORED,
> -=09=09=09=C2=A0 jiffies_to_nsecs(expire - passed), time_ns);
> +=09=09=09=C2=A0 jiffies_to_nsecs(ha_time_left(passed, expire)),
> +=09=09=09=C2=A0 time_ns);
> =C2=A0}
> =C2=A0/*
> =C2=A0 * ha_cancel_timer - Cancel the timer

