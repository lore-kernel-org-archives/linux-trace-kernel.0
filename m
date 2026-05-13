Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF986402426
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675977; cv=none; b=N9iqAO3Q32QXF4D/vPe35SOAWWbOUy/VXl3ql1ol+4tf5ZBxgJkeb77LQo+ebsiREMtx0W3DE45tqiJ7CEB7oUqJFIUN6Gzn8Y2M7CzKwUFRqpOPEDcNdGdKhqrGiFJAlkLu7CXoJ5aiDtWT/bVsaX6UWWrT8sJc5U79//RPtck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675977; c=relaxed/simple;
	bh=BDCNA3cwkqJuWiN9yw6SYUoUj0fzjELpIBIT0dK5dWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uz5byIB+3M+pjzmE+jegLxwNnpIytFJYkHwrmaiDLDbc+z38UbV43ynfOHEywrDDIv4NzTjcgVboGvb5PqL1KiV30ZRHhmgHjrJykQiJJ37XAXy2Bj4hJh1vE7tti1Uaj3Qk45bRCT/YJfMHRB/AmHaobGyj+YHIKGrImigA3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmQ+9SHf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmQ+9SHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778675974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDCNA3cwkqJuWiN9yw6SYUoUj0fzjELpIBIT0dK5dWg=;
	b=fmQ+9SHfFgfuaZmO3zHBHcy3sHz43OB/rzQCGiCyUnPfZjsFPmPmi4iVNsZS5picJtMe+n
	dF+a7WeEMDezNXRHLivoEwPyCbpz1ECBAkkFVzmJMEL8wDSR4K/mj1Ps7NGMDdobtbPrp7
	EbTMsfKw4/4T0L6TIp0tuQtTIoig03s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-IjzvBbz1OPeaM26STl6LXA-1; Wed, 13 May 2026 08:39:33 -0400
X-MC-Unique: IjzvBbz1OPeaM26STl6LXA-1
X-Mimecast-MFC-AGG-ID: IjzvBbz1OPeaM26STl6LXA_1778675972
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so5357209f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 05:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778675972; x=1779280772;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDCNA3cwkqJuWiN9yw6SYUoUj0fzjELpIBIT0dK5dWg=;
        b=Rwkb5Zwb1KCCRvIX1o/t9pce0e5MzZdZt7EwgEd1cCxmiJHS+pkoY6xE54Zdj+f1VM
         zQZZBmplzvx+vvKmdOa39Gq+1+yze+IxAp1h2al/Tga2fbNN5lQ486ItEHcFbg7bunSI
         s4UX/TutQgLuE3U+tb2v0llGfwaspa08P54sz50k0suXff2tHRehHGZzkLqzTSILiFFZ
         8+/Zc8Vwa6SZ6LQQgZZz9o17ab6U7F8GcGUjSj+1eYB03etwYulSCwhYnNQd8quZJauS
         pdyJeTtBHwG4DlVfL02kf8DsObcaAApH0zYaQcZn1q2Z7C2R/+fHsTR2yddD/Su8gMFd
         uB7A==
X-Gm-Message-State: AOJu0YwH+GINIbpkc4mahExdrccVYeP2D6D4IVzVHhZ0XmcwlHVpUPg3
	ckg/meGd6VxGpiZN8LTOLxTv9TuPneMEmw3Gajd3cYV6PzoGMIwdor4wwAFFDZmTcpEFirW+DDG
	mrwQpEvxNJncJEVrsRmdRyMvt13blpgZeLJQLvTgiNAKCAWJRDV9gITJIZh9c78pXumR0vTWZrg
	==
X-Gm-Gg: Acq92OFZK0SO12TsUAYZZSFovMkbcioJkeLhAAj+NSA+RCMjCkIO6o3ilEHmsu18/tS
	lp2kr06+fC+MQMBwtnwQLc9Z8oLNVcSC5r+pAG4RoaRTiswiYq+aRWi1quILKgwQ7vkH3pUodte
	cx+S9NWAdTJMs1P0sRPZNhpyPMyxooUThA95GiTFwTSsEIxSQutGDLYwbHaMTi3BnoYF7Fu8KaL
	+V+7Kibalfrump8ronmaV0We3AAWN4boGMY6zPzm1Ry3fuJUAN3zuGUD34FVNRt4VGbhIM0Q5WZ
	YQ+RBj+MSfSG8uflbS6Vv1WWOR+fTmSMm0NVzqR64S6kkjGoY7Ib0gLcpVIE0gnBMXZ3fyMKhB/
	xuXDUvs3EY3DwB4Hvzf8TeC2gR9yO9ORAcf4CVnUSFEmT6BSFJV9rPvbvhZVOwyHJxwe+PDql0N
	tVTcdgFjxJO7fi2hY=
X-Received: by 2002:adf:e550:0:b0:45d:2efc:dc6e with SMTP id ffacd0b85a97d-45d2efce516mr1149475f8f.20.1778675972351;
        Wed, 13 May 2026 05:39:32 -0700 (PDT)
X-Received: by 2002:adf:e550:0:b0:45d:2efc:dc6e with SMTP id ffacd0b85a97d-45d2efce516mr1149429f8f.20.1778675971918;
        Wed, 13 May 2026 05:39:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm40592308f8f.34.2026.05.13.05.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:39:31 -0700 (PDT)
Message-ID: <22a3be4458799dfe31980142b60c1f6ed63b2a36.camel@redhat.com>
Subject: Re: [RFC PATCH v2 01/10] rv/da: fix monitor start ordering and
 memory ordering for monitoring flag
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Wed, 13 May 2026 14:39:29 +0200
In-Reply-To: <8af5ba4bd93d2acb8a546e8e47ced974a87c1eb8.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
		 <8af5ba4bd93d2acb8a546e8e47ced974a87c1eb8.1778522945.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: Lo4x5pn9ghHhvD_QfrUl_c4mAXp3gXptcufaJhdc-Dk_1778675972
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> da_monitor_start() set monitoring=3D1 before calling da_monitor_init_hook=
(),
> may racing with the sched_switch handler:
>=20
> =C2=A0 da_monitor_start()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sched_switch handler
> =C2=A0 -------------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ---------------------------------
> =C2=A0 da_mon->monitoring =3D 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (da_monitoring=
(da_mon))=C2=A0 /* true=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ha_start_timer_ns(...);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* hrtimer->base =3D=3D NULL, crash */
> =C2=A0 da_monitor_init_hook(da_mon);
> =C2=A0 /* hrtimer_setup() sets base */
>=20
> Fix the ordering and pair with release/acquire semantics:
>=20
> =C2=A0 da_monitor_init_hook(da_mon);
> =C2=A0 smp_store_release(&da_mon->monitoring, 1);=C2=A0=C2=A0=C2=A0 /* da=
_monitor_start()=C2=A0 */
> =C2=A0 return smp_load_acquire(&da_mon->monitoring); /* da_monitoring()=
=C2=A0=C2=A0=C2=A0=C2=A0 */
>=20
> On ARM64 a plain STR + LDR does not form a release-acquire pair, so
> the load can observe monitoring=3D1 while hrtimer->base is still NULL.
> The plain accesses are also data races under KCSAN.
>=20
> Use WRITE_ONCE for the monitoring=3D0 store in da_monitor_reset() to
> cover the reset path.
>=20
> Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor
> definition via C macros")
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

Thanks for the fix!

There are probably more than a few of those bugs since most monitors are
implicitly serialised because their events are serialised..

Looks good to me.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

See minor comments below:

> ---
> =C2=A0include/rv/da_monitor.h | 8 +++++---
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 39765ff6f098..00ded3d5ab3f 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -82,7 +82,7 @@ static void react(enum states curr_state, enum events e=
vent)
> =C2=A0static inline void da_monitor_reset(struct da_monitor *da_mon)
> =C2=A0{
> =C2=A0 da_monitor_reset_hook(da_mon);
> - da_mon->monitoring =3D 0;
> + WRITE_ONCE(da_mon->monitoring, 0);
> =C2=A0 da_mon->curr_state =3D model_get_initial_state();
> =C2=A0}
> =C2=A0
> @@ -95,8 +95,9 @@ static inline void da_monitor_reset(struct da_monitor
> *da_mon)
> =C2=A0static inline void da_monitor_start(struct da_monitor *da_mon)
> =C2=A0{
> =C2=A0 da_mon->curr_state =3D model_get_initial_state();
> - da_mon->monitoring =3D 1;
> =C2=A0 da_monitor_init_hook(da_mon);
> + /* Pairs with smp_load_acquire in da_monitoring(). */

I wonder if these comment are really adding value, pairing smp_load_acquire=
 /
smp_store_release is the by-the-book usage and everything is here.

But feel free to leave it if you think it's clearer.

Thanks,
Gabriele

> + smp_store_release(&da_mon->monitoring, 1);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -104,7 +105,8 @@ static inline void da_monitor_start(struct da_monitor
> *da_mon)
> =C2=A0 */
> =C2=A0static inline bool da_monitoring(struct da_monitor *da_mon)
> =C2=A0{
> - return da_mon->monitoring;
> + /* Pairs with smp_store_release in da_monitor_start(). */
> + return smp_load_acquire(&da_mon->monitoring);
> =C2=A0}
> =C2=A0
> =C2=A0/*

