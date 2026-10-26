Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006514;
	b=5Sv2zopcyrfB1vJBXb2TOr6XHsd1IH3P2QTAsWm+5uDCprrEyAvafpvCmCP2hO6CbaDJ
	 ICWYDqegGpd53przhKnLkHkkuUwm7MonCtgrzoVI+mCb8V3RZQW26SphNlMiQzjcbioK7
	 jxT+dKAAirSKDR20YWrpULs3qkw+d6iDEOfvUKZmdwRy2v/cbE94S4iFaRWlu8uTYbH/K
	 sPZAVjzcG3Cbaa8FdJm94QQXT88TmqK91YoKSkQpuKWwSvg9c8Yq6ucHsh3Wmx4sP0k55
	 gNjPTrW1aSHxnzHpEXY41qFyaGhO2yjjJk2gt38MAPkLD/T3QviGFeEWKRoHY30Hg8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006514;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=f2hZubVSVToKrvNU0WEn8C5vjBU/5qQNAuGo0HcbDUg=;
	b=EhnjRog7nG1IniPirDLAMuLk0GlOnvs3INAdALQ9sgDhaEUTp7EoShoI3dTJt1FptP/P
	 SPC1HS+kfiZ8w8mBR8QzMd1FVnxMKYJHtlDwNFZaSb9JzukSVVxhRZrFjwYz0ZdC+KDCO
	 5mNFD3A+MGZqIOCofyacgu2PM9oq4aiQpwCMkvjvZb2Nvbhxk9Py5nZbdFus2QSo+EQOq
	 HaEYxR/tw6ayCJtsvX0RUA9dr/0TCXXdEfGia7ShcDp5FikSF7ocGqRCNj+ys9rhduYzu
	 02y287k/dJYeW5QnQTRcF4RIJDHr2f+uOoyZ+Hq2lpFiuEV/3cfyVfhwljemmeTci1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L1jBoYbF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50690606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 09:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50690606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L1jBoYbF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793006513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f2hZubVSVToKrvNU0WEn8C5vjBU/5qQNAuGo0HcbDUg=;
	b=L1jBoYbFyfi23GrKt4nmwF92Q06Sx9qOqbTZqFxCmTFRGFfzCxQNbmLEu3ir8ocVwAvk9/
	AXsjCc5+yThloGOerpDQQPcUHOyheWlZTrApMOQ06G2NEGYkpqAlsOuN/74KlVk4dnIlgS
	ghyu9A7J45yBQebseQjRgQu5TM+xfFg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-fot6DA9lMTuVYTc1DO7Xig-1; Mon, 26 Oct 2026 05:21:51 -0400
X-MC-Unique: fot6DA9lMTuVYTc1DO7Xig-1
X-Mimecast-MFC-AGG-ID: fot6DA9lMTuVYTc1DO7Xig_1793006511
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2065a2ef9so27388705e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 02:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006510; x=1793611310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g5iKcSbReiRguiVrpq8yN+qtpwVfnJUnZ33li2p+vFY=;
        b=xjUFIrb/pctu0TDUsPpaunxHHPcgaWntoYyXOsSxfXA2ND4v2e9SknDP9+CKEtuxrp
         fFgb/2702kfI6Ny5cjHJqS5gU1oSyc5hHB8TDZkF3TqSlQH72KPic/pliakXoMsR7+gr
         CN9/yeUkfTh6Tbt7/LZPidKI5UBDZ5r1z98pdopCkmFdnMR6pUwRJCBFAqS1ou7i9cAT
         4alXSjPCDiNvTZ3afU710UCe07w9Mr2zLwSYKLyBP1RFMufyItFdBj/Y67S7rWK/+qUq
         Io5z0obrfitR9p/LU3QSmhaL02HNMzTBDKeI2k8zgg5xiZu8R+cjCP8Avojz7vJWsdJi
         v3rw==
X-Forwarded-Encrypted: i=1; AKwUvBw93mlAwW7EX4SY2Cyoj3H7Usc1mBXcrxyS0IxoNuCKlFXO+oQqQFsyorGaP+d6G1+8dFmzBnqtq0oQmDsac5Uk6uY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAhOI43XcsF6MPukWneZ387pVjglumP8TSM7LcnR+7thQ2YFys
	EjTEPeTpSMJNBZu0zHJqHYJugCy1XscEucI1XrUs+xjG7JS2jkbx3Ho/ZuvBMtVUAyvXFi48b0q
	fyuFHPCYeNENsv2WYMnRqUx3LZz+FGnFR9cIfLcy1p6htlcTISndoxA4JYdx33cbZlEhvZgSVsw
	==
X-Gm-Gg: AYBFou0j54pJbA0bQ85NHI3AsXbtBwyTBDBbLTZ1JtOWTjkkPkrhG7akLIQAXqnqDvy
	hQFLS50P7+HRxXKf1DxqmxkDjInU+T/d68Xfpjo7QmN0Qi9PKMqAXn5O/yyksrJQkpXYd2/LH/3
	cuSYnzVsWeZbxL/tdbUPTDWIhdbPAyaV+0CayrcQLgcXEdDniUtz4iAfN1RNypOakiFBWpaPXlv
	6OyRFmyW9Sacq4uZp3Z1NtphpNiOBX40I6HqPY6jSLxLflhnGhKRWrl2V9ZXgQkg6lqHgznw/LF
	/uBX2wYJfP9/mhZIJM/CxojMADt5L4epfCB4lp9/IJ4vj3y6W2rvbImvWy8vLsKkYff+cnZafC2
	z/xM/1SYdDR4qLJsrz8PbJ6Tvjap7
X-Received: by 2002:a05:600c:4704:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4a35acbd575mr120747145e9.16.1793006510547;
        Mon, 26 Oct 2026 02:21:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4704:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4a35acbd575mr120746615e9.16.1793006510118;
        Mon, 26 Oct 2026 02:21:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a00e1b0sm144534585e9.3.2026.10.26.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:21:49 -0700 (PDT)
Message-ID: <b7a037a62858e6ad7017cf05c3ccaba06e7a8671.camel@redhat.com>
Subject: Re: [PATCH v7 02/14] rv: Fix ha_monitor timer and invariant
 underflow
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 10:21:48 +0100
In-Reply-To: <2ab5a814ce453e282c5d90b7285ee6fea8a674b6.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
	 <2ab5a814ce453e282c5d90b7285ee6fea8a674b6.1791745088.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
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
X-Mimecast-MFC-PROC-ID: JI7wPt_i9Rmr-srQxyIEYgUDPL9qznjMSCWx1wRoOu4_1793006511
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-12 at 03:39 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> ha_start_timer_ns() and ha_start_timer_jiffy() compute the remaining
> budget as expire - passed.=C2=A0 Once the elapsed time passed exceeds the
> budget expire (e.g. a state transition after the invariant should have
> fired, before the timer callback ran), the unsigned subtraction
> underflows to a huge value and the timer is scheduled far into the
> future instead of expiring immediately.
>=20
> ha_check_invariant_ns() computes store >=3D time_ns - expire_ns, which
> underflows when the system uptime is still below expire_ns (a monitor
> armed early in boot with a large budget), reporting a false violation.
>=20
> Clamp the timer remainder to 0 (fire immediately) when passed >=3D expire=
,
> and replace the invariant check as store + expire_ns >=3D time_ns so
> neither side can underflow.
>=20
> Fixes: f5587d1b6ec9 ("rv: Add Hybrid Automata monitor type")
> Fixes: ab2900ae252b ("rv: Simplify hybrid automata monitors's clock
> variables")
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

Looks good, thanks

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0include/rv/ha_monitor.h | 19 ++++++++++++++-----
> =C2=A01 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 93ac99ff7f1d..499ce60779f9 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -351,7 +351,7 @@ static inline void ha_reset_clk_ns(struct ha_monitor
> *ha_mon, enum envs env, u64
> =C2=A0static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,=
 enum envs
> env,
> =C2=A0=09=09=09=09=09 u64 time_ns, u64 expire_ns)
> =C2=A0{
> -=09return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns - expire_ns;
> +=09return READ_ONCE(ha_mon->env_store[env]) + expire_ns >=3D time_ns;
> =C2=A0}
> =C2=A0/*
> =C2=A0 * ha_invariant_passed_ns - prepare the invariant and return the ti=
me since
> reset
> @@ -410,6 +410,11 @@ static inline void ha_inv_to_guard(struct ha_monitor
> *ha_mon, enum envs env,
> =C2=A0=09WRITE_ONCE(ha_mon->env_store[env], READ_ONCE(ha_mon->env_store[e=
nv])
> - value);
> =C2=A0}
> =C2=A0
> +static inline u64 ha_time_left(u64 passed, u64 expire)
> +{
> +=09return passed < expire ? expire - passed : 0;
> +}
> +
> =C2=A0#if HA_TIMER_TYPE =3D=3D HA_TIMER_WHEEL
> =C2=A0/*
> =C2=A0 * Helper functions to handle the monitor timer.
> @@ -439,15 +444,17 @@ static inline void ha_start_timer_jiffy(struct
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
> @@ -494,7 +501,8 @@ static inline void ha_start_timer_ns(struct ha_monito=
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
> @@ -502,7 +510,8 @@ static inline void ha_start_timer_jiffy(struct ha_mon=
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

