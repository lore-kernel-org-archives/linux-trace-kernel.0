Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A09397699
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547080; cv=none; b=ksQVT3j8yiIpN4cPrdpWRrgyMRTQA0h4C8kAKBScw5pXUOx+SIXz1B+4UKxp1LxLjvBoTUmZyDNbUuZthfMyt2k1sgSFnxDjHSGILaT3AcNsREEjMkBCXciAodjYhKlrxIWsP9Rr00QPV2cXa3mrTxLlnDRslzDaqoiI8ZgwDIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547080; c=relaxed/simple;
	bh=3xXtwn8EDTq0oKqjXI0AKu4smTn7mhx4kV+AyPrVphw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e52eaN3QMa86/fwxfjXQU9SkoDn2abs6Vp1iQyhiJ0RifwW3vGVa6q0ZQ9ckd6cwsugBY3s6XitRbdHViSPNQzUlaIF6qALYSasgyTkKzxfDpPkaSD5q/5JS+VC+39SFNA9FsMk7e07Z/6k6QQym3lF17ODk3dM16g6/1qQruHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPOsX1Kv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPOsX1Kv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784547078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3xXtwn8EDTq0oKqjXI0AKu4smTn7mhx4kV+AyPrVphw=;
	b=ZPOsX1KvTUHH5kZcoV25l/qsLq5dE3X7rRmme1l4LXOG+0LLqFgJtk4OOjM6pL72fk5+h1
	a6TQTADy2O7GG6ZpSn7cjIxOEY4dMdnArdnCdyEMqiyF1zLBAft018UhtVePoS+qUWagWj
	p9KD7xGGsOQ75GC5hwg3E2aCp3FpInc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-LkEdO-6OMlSWSRIQkj3SLw-1; Mon, 20 Jul 2026 07:31:15 -0400
X-MC-Unique: LkEdO-6OMlSWSRIQkj3SLw-1
X-Mimecast-MFC-AGG-ID: LkEdO-6OMlSWSRIQkj3SLw_1784547074
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69e984607e7so2047162a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 04:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547074; x=1785151874;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ngia2IWrtrwxveKhYtY6GWjBabJZjK51gxqV7R56nIA=;
        b=q+H5DknUVsA1PE7tMNKbESrUwptTIAypzgW7Ki7MMLUbmAj7urWdtcsXgWGDuE1bkV
         c5UXPVwX7HbLh0lYvNzfQpPduvkcH99aChygd6RaG18oQ0L0cUadmNMLZZHnUC/BY9IT
         7TrO33HZyNZxFQLtqIHJlbt+iXGgFqcfbtgzCDazdnN1mdX8xZuRlAFLU5gaVn8SvRHq
         xg7xxlut8nm5CLMC/PcM6JpOROysrnQummEWQ896FfmCrJihIJ6s8a/rnSOw7Vjh9LWm
         hXhP/UwUnnX4t9SJ3DijWGWNIImFj8UUekZh1/jvrKh7lPSUTfzqeg/+6tYq8mpRYFVL
         a06g==
X-Forwarded-Encrypted: i=1; AHgh+RrnzwhGb0bqGC5VtMeqOJN37xQ8sCjOW/BS8EOa1BQ3XKttwGqX1wfEu86JyznkCsGYktunmQTUXlo2oSZVyeBm2Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5A78euOWtH4I4y/MTmKEjPbQXL5XBBY1XvgFH3FU+4NS/lZ3J
	78x8C4Ux3+xK9zTuRqpr82qOQ5sSm8XTvA3utla2TXyspjaZ+QFG0QvXj5AuWg20V9qJGK2Flsn
	2aPxS/NWUEwipBUVx8YwypuL/1tQ0G/VEFk6vLZms0f9mme3kxuQsQ1oxfDcFJFPY8DOgB7huEQ
	==
X-Gm-Gg: AfdE7ck3e3TEUp0UUAui3K5QiUthcTz9NnddYlH6Qwxn0UgJBPWytUOYXqbrW1Z/CsB
	WeJaoSIC6cmfz1ALc+sGuJ0fWnypBUBETZnn6VT/iuSAK7pxnG7Ore5l8eoryuKUyocxqFqEx6o
	urlN+XuPPbpTZHh1vHio8clEFTPC6wsFuTtDpWsLUbamLDxeDme6IHroyr8yXHvcMGLx01lSr78
	UcsEWfPibgY8YV6zPSI72gaxTO96VlssSn02uirXKCl6wRbpfZvmocvIVrNi0LtB4OJTDpkqT7y
	UiV62/7MwTV6zusr6hrBFxmd2l4ri5YFoptW/sbH381a9PZl3px9xe1wE9QPt2YtKZ8+2IXffP2
	T+PYkiNAypZolXS8FOexwVLADCp8ICKW5V4eVa0Mg7dM4e8o8GQxD5ygva1zWwUcOk7sZNg==
X-Received: by 2002:a05:6402:a0ca:b0:699:6415:750a with SMTP id 4fb4d7f45d1cf-69e652ddf67mr4596350a12.23.1784547073657;
        Mon, 20 Jul 2026 04:31:13 -0700 (PDT)
X-Received: by 2002:a05:6402:a0ca:b0:699:6415:750a with SMTP id 4fb4d7f45d1cf-69e652ddf67mr4596338a12.23.1784547073243;
        Mon, 20 Jul 2026 04:31:13 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffd0eeesm4510736a12.20.2026.07.20.04.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:31:12 -0700 (PDT)
Message-ID: <00f7a7c20cf8d29aa650bf7b2c5a392c15345989.camel@redhat.com>
Subject: Re: [PATCH v4 4/8] rv/ha: fix ha_invariant_passed_ns silent bypass
 of invariant check
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 13:31:11 +0200
In-Reply-To: <d83c7bff76922ba464d328758ec24b7bf41d4824.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
	 <d83c7bff76922ba464d328758ec24b7bf41d4824.1783524627.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: xA9O1ZSnHGRo52ba3SwzZUHWXG-PhtNnvDeRoEnG72s_1784547074
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> When env_store is U64_MAX (its initial sentinel value),
> ha_invariant_passed_ns() returns 0 immediately without initializing
> env_store to the current clock.=C2=A0 Subsequent calls to
> ha_check_invariant_ns() then find env_store still at U64_MAX, causing
> the elapsed comparison to wrap and always report the invariant as
> satisfied, silently masking any violations.
>=20
> Fix by calling ha_reset_clk_ns() to establish the guard on the first
> invocation instead of returning early.=C2=A0 Apply the same fix to
> ha_invariant_passed_jiffy().
>=20
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

While this looks alright, I have something else in mind for the env variabl=
es
lifecycle. After [1] is merged, I'd like to merge [2] which is basically
inspired on your idea of resetting variables on start, just it's embedded i=
n the
framework (and requires [1] to get rid of the double representation for env
variables).
This is probably going to happen after the next merge window.

I believe you can keep this patch for now and your model wouldn't need chan=
ge
after adding [2] instead.

Thoughts?

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/c0f600dcbf3d8b487c944406851a39146f4d91fa.17818=
47583.git.namcao@linutronix.de/
[2] -
https://web.git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git/commi=
t/?h=3Drv_hybrid_automata_enq_lark&id=3Dd7c5c40c81d9b928aa9f86c4115429bffd2=
23a8c

> ---
> =C2=A0include/rv/ha_monitor.h | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
> index 83199f90afe8..dddf5694bcc8 100644
> --- a/include/rv/ha_monitor.h
> +++ b/include/rv/ha_monitor.h
> @@ -375,12 +375,12 @@ static inline bool ha_check_invariant_ns(struct
> ha_monitor *ha_mon,
> =C2=A0static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon,=
 enum envs
> env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0 u64 expire, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D 0;
> +=09u64 passed;
> =C2=A0
> =C2=A0=09if (env < 0 || env >=3D ENV_MAX_STORED)
> =C2=A0=09=09return 0;
> =C2=A0=09if (ha_monitor_env_invalid(ha_mon, env))
> -=09=09return 0;
> +=09=09ha_reset_clk_ns(ha_mon, env, time_ns);
> =C2=A0=09passed =3D ha_get_env(ha_mon, env, time_ns);
> =C2=A0=09ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
> =C2=A0=09return passed;
> @@ -414,12 +414,12 @@ static inline bool ha_check_invariant_jiffy(struct
> ha_monitor *ha_mon,
> =C2=A0static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_m=
on, enum
> envs env,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 expire, u64 time_ns)
> =C2=A0{
> -=09u64 passed =3D 0;
> +=09u64 passed;
> =C2=A0
> =C2=A0=09if (env < 0 || env >=3D ENV_MAX_STORED)
> =C2=A0=09=09return 0;
> =C2=A0=09if (ha_monitor_env_invalid(ha_mon, env))
> -=09=09return 0;
> +=09=09ha_reset_clk_jiffy(ha_mon, env);
> =C2=A0=09passed =3D ha_get_env(ha_mon, env, time_ns);
> =C2=A0=09ha_set_invariant_jiffy(ha_mon, env, expire - passed);
> =C2=A0=09return passed;

