Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D373195EF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058951; cv=none; b=bmLFtyQ8NXCR2g+s6J9I+4EGLKQDZqHRGvmnxzjXqYCcUwhIrFv/MBM8yfUA3DHQLUyjtwuio81xfbdwcrgayBJUniS1InUi9l6tj/eP7YKVHvNvh9xFaIF6rOxzQXjRo2SLmq0cdhaORitwVscBQXT+ZsJOPwHWYihb8gNUAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058951; c=relaxed/simple;
	bh=Xb3Q2qoctAzoQrDhNauxUdB6g0keQImcQCFjSMPM+7I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYE6VkJ5mjFNZOjQf9F+h1oixELFmlaNAtJCa0at/QM9RsMLNXPo0fgieOZ4mGi0QP5WxP+ZYPWJ2co2URyr+dFoGQ/+g/jOefWRsrssgXuncHUb3E4FWef7SiAlUOlGvp3MrwiFBxZVpkHF1RI94lGHqeRu+bsTxFfaimvz56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZX0nc0Nr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX0nc0Nr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778058948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xb3Q2qoctAzoQrDhNauxUdB6g0keQImcQCFjSMPM+7I=;
	b=ZX0nc0Nr0gL0OFG9EWcFQ9gb8inOcg2c1ixb7kXqbkpHI4KAqfxYhfAa0KgwlnDv15CPNq
	1oVfYdGL9ez1PVx/Z3uq1lElNCq+9DBYGf5sKU0lgMdLLbgn72mcImxOGRmwBGjQz+L4U1
	YOEIRi+s2DLXay67ov4hqQ26ksOFZtU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-rWvmiChNO2eG-k-nmy2joQ-1; Wed, 06 May 2026 05:15:46 -0400
X-MC-Unique: rWvmiChNO2eG-k-nmy2joQ-1
X-Mimecast-MFC-AGG-ID: rWvmiChNO2eG-k-nmy2joQ_1778058946
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449dcfe8005so5061319f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 02:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778058945; x=1778663745;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dq+JGz4V08p8nKU3E4HLFSqfbQ99SUY39uyH5WjpxQY=;
        b=bA6HV5xgmTf6LI0g5Ju0SD1C9Wobpvi4kcP8nvqm8X7NCi3/HOe6EAD42O4Ei+zqHx
         zVtup34sse35GgH0rORnm7ZrBNT9w3lSKK4l/Pp40i5bxfZbzRh2WD2l7Edhq40O34m/
         kDBAR9ZKh0puISmPwbFo0D269GNFpmmweJ+W5gSECbhPGQP/J2NSgijNNYlrAF673oC+
         8vI3wrAA4/hUUnk8l5CIBlLviBevT298rL3QSWYmzQpauki0Naqdp9t2DH1ANQykUBQG
         UWXf2Rv+d4aTxRIFkeXMulAPnC/uPa3TEcxm/38yJiNFnIqyubjQ9VVwNRUMb1nzN/Z1
         NNSw==
X-Forwarded-Encrypted: i=1; AFNElJ/qmvI++dANqUKbV1UEijeDeUt4K+v9ooKsdKhyHelCZpxompjmb3GBJmzrnIL9l+yw+bfx37Sku5daVDxrfGLoyZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMuZckdTuGfwKKVBGgjfWWpH/qJVxGoTZOvsLh3QI0BhPmkY0
	/Hw4H8/USZzvAflGvhHwnFxGz77/wsq41LGafDv+mA+Q8TKTB3XIsoJY2yQpQvikakOVYwvOFrQ
	RSBNjWiNQsl5woFGNOSd+7+O08ToHE92/tBR1Anxm55qowWKXRjLtVvKl5X+AbG8IskuJEM2nFf
	He9wB6LHbY
X-Gm-Gg: AeBDiev/QzZD2zaCPqIJa5UYLRjLgTUCWESyuu0ucDOGQSVFzWpPV8eaAtUqqzs/zMa
	mXXa0yNcFMmA2iECo+zSNhwhQFTA3L6+lpsTLyfJfRTbNzwYaIhsx+qAvDINXvRaADtR/Cieue6
	cJFTFf7fXn77zTYMJHhg27qRQUt0Rkm2aEhtgWt4uLWPWTu9gJIEBnPXrf1uIMS76t0uHljb3D8
	Zxs0Op4qZrKlzCI36f+/drosmgeEYtjE45xKoNJveRzDZIFQDEUABYhVZGLN+sKskAQlKCDi4Ge
	niv8gecOGDAxplHL8RDrxM5XcrQ4ELr162Efkvv9o9Voi0dbAKNsZE86J6rs2fnYCW9lHg0Vlfl
	Y+Q0bMPPR5j2rmyVpqElYeVPmY4+6KtAfNRDWmJqYK8Bh+LsCTBgpFpM/f/Nj5rq5XRfWUwLMbF
	cwQa1Y08ZBeHhQo6Szu+PQY/fFww==
X-Received: by 2002:a5d:64e7:0:b0:44a:9b52:8891 with SMTP id ffacd0b85a97d-4515b42fbc4mr4176672f8f.11.1778058945503;
        Wed, 06 May 2026 02:15:45 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:44a:9b52:8891 with SMTP id ffacd0b85a97d-4515b42fbc4mr4176615f8f.11.1778058944972;
        Wed, 06 May 2026 02:15:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48911sm11193626f8f.11.2026.05.06.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:15:44 -0700 (PDT)
Message-ID: <967f1cd8cd6e27aaa65d68194487306bc312caa0.camel@redhat.com>
Subject: Re: [PATCH 07/13] rv: Simply hybrid automata monitors's clock
 variables
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 06 May 2026 11:15:43 +0200
In-Reply-To: <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
	 <a779af6dc89721179e0dbab08623e42aa0191275.1777962130.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: pN9EVPihinJ93Y4f_gNZcxdEk4ixnWFaKATzZgkSkUs_1778058946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-05 at 08:59 +0200, Nam Cao wrote:
> Hybrid automata monitors's clock variables have two different
> representations:
>=20
> =C2=A0 - The invariant representation, which is the timestamp when the in=
variant
> =C2=A0=C2=A0=C2=A0 expires
>=20
> =C2=A0 - The guard representation, which is the timestamp when the clock =
is last
> =C2=A0=C2=A0=C2=A0 reset
>=20
> This dual representation makes the logic quite difficult to follow (well,
> at least for me). It also complicates the monitors and the generation too=
l,
> as it requires conversion back and forth between the representation.
>=20
> Simplify by using the clock variables for a single purpose: storing the
> time stamp since the clock is last reset.
>=20
> This also allows simplifying rvgen, which will be done in a follow-up
> commit.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Well, this is roughly what we discussed in [1].
Now, I didn't submit the throttle monitor yet because it depends on unacked
tracepoints.

In short, this works with the assumption that the expires value you pass to
ha_check_invariant() is the same you used to arm the timer.

That's true for constant values only (the deadline) but not for something l=
ike
the runtime. I couldn't think of a way to rearrange that model not to requi=
re
the runtime left field.


Otherwise.. We could read the remaining time in the timer, but we wouldn't =
be
able to simulate ns precision when using the timer wheel.

Now if we really wanted to go down that path, we are using a union to alloc=
ate
either timer or hrtimer, the latter is larger, so we /could/ add a u64 expi=
re_ns
field to the ha_monitor struct without needing additional memory.

If that doesn't sound too wild to you, I may try and sketch something up to=
 see
if that's viable. Then this patch could go through as is and I would add th=
e
extension together with the submission of throttle.

What do you think?

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/0c61c0bbbdc2002efb638dccda1f0a18c51d29df.camel=
@redhat.com

> ---
> =C2=A0include/rv/ha_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 60 ++++++---=
---------------
> =C2=A0kernel/trace/rv/monitors/nomiss/nomiss.c | 18 +------
> =C2=A0kernel/trace/rv/monitors/stall/stall.c=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A03 files changed, 17 insertions(+), 63 deletions(-)
>=20
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index d59507e8cb30..1ce3fd324d2c 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -253,19 +253,8 @@ static inline void __ha_monitor_timer_callback(struc=
t
> ha_monitor *ha_mon)
> =C2=A0}
> =C2=A0
> =C2=A0/*
> - * The clock variables have 2 different representations in the env_store=
:
> - * - The guard representation is the timestamp of the last reset
> - * - The invariant representation is the timestamp when the invariant ex=
pires
> - * As the representations are incompatible, care must be taken when swit=
ching
> - * between them: the invariant representation can only be used when star=
ting
> a
> - * timer when the previous representation was guard (e.g. no other invar=
iant
> - * started since the last reset operation).
> - * Likewise, switching from invariant to guard representation without a =
reset
> - * can be done only by subtracting the exact value used to start the
> invariant.
> - *
> - * Reading the environment variable (ha_get_clk) also reflects this
> difference
> - * any reads in states that have an invariant return the (possibly negat=
ive)
> - * time since expiration, other reads return the time since last reset.
> + * The clock variables store the time epoch - the timestamp when the clo=
ck
> was last reset.
> + * They are read by subtracting the time epoch from the current time.
> =C2=A0 */
> =C2=A0
> =C2=A0/*
> @@ -279,31 +268,21 @@ static inline void ha_reset_clk_ns(struct ha_monito=
r
> *ha_mon, enum envs env, u64
> =C2=A0{
> =C2=A0=09WRITE_ONCE(ha_mon->env_store[env], time_ns);
> =C2=A0}
> -static inline void ha_set_invariant_ns(struct ha_monitor *ha_mon, enum e=
nvs
> env,
> -=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 value, u64 time_ns)
> -{
> -=09WRITE_ONCE(ha_mon->env_store[env], time_ns + value);
> -}
> -static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,
> -=09=09=09=09=09 enum envs env, u64 time_ns)
> +static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon, enum=
 envs
> env,
> +=09=09=09=09=09 u64 time_ns, u64 expire_ns)
> =C2=A0{
> -=09return READ_ONCE(ha_mon->env_store[env]) >=3D time_ns;
> +=09return time_ns - READ_ONCE(ha_mon->env_store[env]) <=3D expire_ns;
> =C2=A0}
> =C2=A0/*
> =C2=A0 * ha_invariant_passed_ns - prepare the invariant and return the ti=
me since
> reset
> =C2=A0 */
> -static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum=
 envs
> env,
> -=09=09=09=09=C2=A0=C2=A0 u64 expire, u64 time_ns)
> +static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum=
 envs
> env, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D 0;
> -
> =C2=A0=09if (env < 0 || env >=3D ENV_MAX_STORED)
> =C2=A0=09=09return 0;
> =C2=A0=09if (ha_monitor_env_invalid(ha_mon, env))
> =C2=A0=09=09return 0;
> -=09passed =3D ha_get_env(ha_mon, env, time_ns);
> -=09ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
> -=09return passed;
> +=09return ha_get_env(ha_mon, env, time_ns);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -317,32 +296,21 @@ static inline void ha_reset_clk_jiffy(struct ha_mon=
itor
> *ha_mon, enum envs env)
> =C2=A0{
> =C2=A0=09WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64());
> =C2=A0}
> -static inline void ha_set_invariant_jiffy(struct ha_monitor *ha_mon,
> -=09=09=09=09=09=C2=A0 enum envs env, u64 value)
> -{
> -=09WRITE_ONCE(ha_mon->env_store[env], get_jiffies_64() + value);
> -}
> -static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon,
> -=09=09=09=09=09=C2=A0=C2=A0=C2=A0 enum envs env, u64 time_ns)
> +static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon, e=
num
> envs env,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 u64 time_ns, u64 expire_jiffy)
> =C2=A0{
> -=09return time_after64(READ_ONCE(ha_mon->env_store[env]),
> get_jiffies_64());
> -
> +=09return time_after64(READ_ONCE(ha_mon->env_store[env]) + expire_jiffy,
> get_jiffies_64());
> =C2=A0}
> =C2=A0/*
> =C2=A0 * ha_invariant_passed_jiffy - prepare the invariant and return the=
 time
> since reset
> =C2=A0 */
> -static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, e=
num
> envs env,
> -=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire, u64 time_ns)
> +static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, e=
num
> envs env, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D 0;
> -
> =C2=A0=09if (env < 0 || env >=3D ENV_MAX_STORED)
> =C2=A0=09=09return 0;
> =C2=A0=09if (ha_monitor_env_invalid(ha_mon, env))
> =C2=A0=09=09return 0;
> -=09passed =3D ha_get_env(ha_mon, env, time_ns);
> -=09ha_set_invariant_jiffy(ha_mon, env, expire - passed);
> -=09return passed;
> +=09return ha_get_env(ha_mon, env, time_ns);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -389,14 +357,14 @@ static inline void ha_setup_timer(struct ha_monitor
> *ha_mon)
> =C2=A0static inline void ha_start_timer_jiffy(struct ha_monitor *ha_mon, =
enum envs
> env,
> =C2=A0=09=09=09=09=09u64 expire, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, expire, time_ns=
);
> +=09u64 passed =3D ha_invariant_passed_jiffy(ha_mon, env, time_ns);
> =C2=A0
> =C2=A0=09mod_timer(&ha_mon->timer, get_jiffies_64() + expire - passed);
> =C2=A0}
> =C2=A0static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enu=
m envs
> env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D ha_invariant_passed_ns(ha_mon, env, expire, time_ns);
> +=09u64 passed =3D ha_invariant_passed_ns(ha_mon, env, time_ns);
> =C2=A0
> =C2=A0=09ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 nsecs_to_jiffies(expire - passed =
+ TICK_NSEC -
> 1), time_ns);
> diff --git a/kernel/trace/rv/monitors/nomiss/nomiss.c
> b/kernel/trace/rv/monitors/nomiss/nomiss.c
> index 31f90f3638d8..6b3f93866d56 100644
> --- a/kernel/trace/rv/monitors/nomiss/nomiss.c
> +++ b/kernel/trace/rv/monitors/nomiss/nomiss.c
> @@ -57,24 +57,12 @@ static inline bool ha_verify_invariants(struct ha_mon=
itor
> *ha_mon,
> =C2=A0=09=09=09=09=09enum states next_state, u64 time_ns)
> =C2=A0{
> =C2=A0=09if (curr_state =3D=3D ready_nomiss)
> -=09=09return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns);
> +=09=09return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns,
> DEADLINE_NS(ha_mon));
> =C2=A0=09else if (curr_state =3D=3D running_nomiss)
> -=09=09return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns);
> +=09=09return ha_check_invariant_ns(ha_mon, clk_nomiss, time_ns,
> DEADLINE_NS(ha_mon));
> =C2=A0=09return true;
> =C2=A0}
> =C2=A0
> -static inline void ha_convert_inv_guard(struct ha_monitor *ha_mon,
> -=09=09=09=09=09enum states curr_state, enum events
> event,
> -=09=09=09=09=09enum states next_state, u64 time_ns)
> -{
> -=09if (curr_state =3D=3D next_state)
> -=09=09return;
> -=09if (curr_state =3D=3D ready_nomiss)
> -=09=09ha_inv_to_guard(ha_mon, clk_nomiss, DEADLINE_NS(ha_mon),
> time_ns);
> -=09else if (curr_state =3D=3D running_nomiss)
> -=09=09ha_inv_to_guard(ha_mon, clk_nomiss, DEADLINE_NS(ha_mon),
> time_ns);
> -}
> -
> =C2=A0static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states curr_state, enum events
> event,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 enum states next_state, u64 time_ns)
> @@ -122,8 +110,6 @@ static bool ha_verify_constraint(struct ha_monitor
> *ha_mon,
> =C2=A0=09if (!ha_verify_invariants(ha_mon, curr_state, event, next_state,
> time_ns))
> =C2=A0=09=09return false;
> =C2=A0
> -=09ha_convert_inv_guard(ha_mon, curr_state, event, next_state, time_ns);
> -
> =C2=A0=09if (!ha_verify_guards(ha_mon, curr_state, event, next_state,
> time_ns))
> =C2=A0=09=09return false;
> =C2=A0
> diff --git a/kernel/trace/rv/monitors/stall/stall.c
> b/kernel/trace/rv/monitors/stall/stall.c
> index 9ccfda6b0e73..1aa65d7e690d 100644
> --- a/kernel/trace/rv/monitors/stall/stall.c
> +++ b/kernel/trace/rv/monitors/stall/stall.c
> @@ -38,7 +38,7 @@ static inline bool ha_verify_invariants(struct ha_monit=
or
> *ha_mon,
> =C2=A0=09=09=09=09=09enum states next_state, u64 time_ns)
> =C2=A0{
> =C2=A0=09if (curr_state =3D=3D enqueued_stall)
> -=09=09return ha_check_invariant_jiffy(ha_mon, clk_stall, time_ns);
> +=09=09return ha_check_invariant_jiffy(ha_mon, clk_stall, time_ns,
> threshold_jiffies);
> =C2=A0=09return true;
> =C2=A0}
> =C2=A0

