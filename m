Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E7428495
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234483; cv=none; b=BEwYoLIHifku8Vjj4tJM0G8ZWV9LUiUMRNtv4pLbwplL8WNhHZGtXaXYor07897tBcQmvPCNpxwmhd2+nxuBhEX1f6CWliqDNFMfdoJNtRVs4jkrN4BnOfEG1Fxen8gYlQOoWlqJTER2KBI6H5W01OAIye5dKpx4PpRNdQEQyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234483; c=relaxed/simple;
	bh=Rno6WcHWIxTFeM5lncgZi8YCnKEnzjZnXBPQHM69PgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnUxOXjFDk7q1VuyuUFWzK84MqmXQwDo9herFeWmJ50XiztdGfJZWxl2qolwMayAJW4O/VioP2jUo5hp2CY1uODoTjzVoeGqVnW3bsBrd+CXS7m+CRksnXStX81aZzhIGY2rBZ6h0t+CGzaoL5yYLNjy6WxrwsQ7auY+axzUMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3y46EUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3y46EUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790234478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rno6WcHWIxTFeM5lncgZi8YCnKEnzjZnXBPQHM69PgM=;
	b=g3y46EUb5EL0evsB5TMGYz8L907dXh9Kb6NhbTp9grqZ/1e53dGxasc2TFepnop8LkKzpA
	gliPR+0qzwJJDPL39UcZZWZcis40bjxvN+kbNMkefszc1Z/fJH8mfJ3QPKhfSCMO/eRc78
	+oV2orzZn3JKXwKaXwh2DAbnKtd7gww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-Ecd2XFl0PuWsQIXz6yHJjg-1; Thu, 24 Sep 2026 03:21:17 -0400
X-MC-Unique: Ecd2XFl0PuWsQIXz6yHJjg-1
X-Mimecast-MFC-AGG-ID: Ecd2XFl0PuWsQIXz6yHJjg_1790234476
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-485866e0066so778816f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 00:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790234476; x=1790839276;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Lx/SD0ZEJ5dzEY+xl1QncqAhTw6A7MTbtLbXSvv8KOE=;
        b=cMvbUdh6i3c2BdSpzymq5x77tPjcyboPylFrp35GrESYs6PnkFtsaKQGp8O4CoqkTa
         DXeKLiWwUmntsDL8dV3uU9jZLIB8d4c87Trd9VuHulOmG5RBXwB8DMWRYSSt/CT8/MIQ
         MpL8U8gbm0cZ1HDMc46S+nyCa1MKztRU9pm8l+FiA1aQjYliFJcK9VFmyCkHg4IkQIBI
         HbMfbG/w+g9W7sowVXGIOtbtWpJ1AYeLjOmKBe02vAn7V6+dlFp2qzaM5sa0TlwvSaF+
         j8/zplj8NTsD4qJ2oLapEeKHBlSJStCY609YV02h8Nk1Vl1UgcFmW7RnGtvGMC5+Ri2r
         UdGw==
X-Forwarded-Encrypted: i=1; AKwUvByiOiHA3dveOuovSgEQSy8KYEZ9/JErWF+BX42WKyQPA2w4qk5I609sS+iZzHOQ0EsEDlAgPTsNIuXjQs/17f13OXg=@vger.kernel.org
X-Gm-Message-State: AFuF++nxRU7G0mQN2ciJG2Xp9IZ2lP30ZpsUn59pPvEVbzdWb6SywLaA
	oWLjiCuYV89FMiQcq7PjQRxmBUM9UZgN68JfdeH0n4YOKD6ZrKFkiRxM2Nrd5nU2c+6HrC/vL8x
	7VlhLdVN1gh2ajdMR4GbLNUHHuI1BAv0zQ+ekcFRoAVMEJ1CgA1lH6QlFnrvkiAO+4XXN3WnZ6A
	==
X-Gm-Gg: AYBFou26yHbRWy6zH4u5GMCVvp9rHVf7/FCCWcqAOVCUNve1bUjdsXW1g8DjnsrYlSq
	KheDQdVtugV2JNdsPNZCvz9RfgmueyN3FMJn+wQm0lDXPZUGtkGqL7tfRpBl0CqUeAmg75SWac7
	mY9mnNRx5n5RrTHwGfqxD5ooGlRcHROqM3bYhDNIfN4M88M9E6cJbCZ2BrOqRdIg8y2bRambPwH
	OzYRsbpQfKl2FWTBikEkpUqlg1O5gqP/sFKBO/FoUzK4ney0SFo1t0XBgPdC1ZoVnkSunv5duNW
	DuyzvzOzaZeUrdjV5XVZx3cfY/tP/mSocnYycbBQVd+UDrYO5iDUT1djwJJgJBrCYpshnrHYNF0
	hsyC7ogKI4U3OCvU8YETu7NfSk1hU
X-Received: by 2002:a05:6000:4711:b0:487:35c:b61 with SMTP id ffacd0b85a97d-4887167c4e0mr2257087f8f.24.1790234475995;
        Thu, 24 Sep 2026 00:21:15 -0700 (PDT)
X-Received: by 2002:a05:6000:4711:b0:487:35c:b61 with SMTP id ffacd0b85a97d-4887167c4e0mr2257059f8f.24.1790234475601;
        Thu, 24 Sep 2026 00:21:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684863fbsm11337269f8f.11.2026.09.24.00.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:21:15 -0700 (PDT)
Message-ID: <b771379679b8f94573382d3c2534fdae77b9fe48.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] rv: add per-edge dwell-time statistics primitive
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, 	jan.kiszka@siemens.com
Date: Thu, 24 Sep 2026 09:21:13 +0200
In-Reply-To: <20260911123439.463052-2-tobias.schaffner@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
	 <20260911123439.463052-2-tobias.schaffner@siemens.com>
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
X-Mimecast-MFC-PROC-ID: f0TvcWOjXKBz4U8X0aPKPSvg586IDPavnvrOMaidUQo_1790234476
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-09-11 at 14:34 +0200, Tobias Schaffner wrote:
> Add a small primitive that records, per automaton edge, how long the
> monitor dwelled before taking it with a count, a sum and a maximum.
>=20
> The counters are per-CPU and lock-free, so a monitor's hot path can
> update them without disabling interrupts and without perturbing the laten=
cy
> being measured. Keep the state and its entry timestamp in one word so
> nested transitions cannot charge a dwell to the wrong edge.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
> =C2=A0include/rv/edge_stat.h | 69 +++++++++++++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 69 insertions(+)
> =C2=A0create mode 100644 include/rv/edge_stat.h
>=20
> diff --git a/include/rv/edge_stat.h b/include/rv/edge_stat.h

...
> +#define RV_STATE_BITS=09=098
> +#define RV_STATE_MASK=09=09GENMASK(RV_STATE_BITS - 1, 0)
> +#define RV_TS_MASK=09=09GENMASK(BITS_PER_LONG - RV_STATE_BITS - 1, 0)
> +
> +#define da_state_of(w)=09=09((unsigned int)((w) & RV_STATE_MASK))
> +#define da_ts_of(w)=09=09((u64)(w) >> RV_STATE_BITS)
> +#define da_state_pack(s, ts)=09(((((da_state_t)(ts)) & RV_TS_MASK) <<
> RV_STATE_BITS) | \
> +=09=09=09=09 ((da_state_t)(s) & RV_STATE_MASK))

These are barely readable and error prone, can you use FIELD_GET()/FIELD_PR=
EP()?

Thanks,
Gabriele

> +
> +static __always_inline
> +void rv_edge_stat_account(struct rv_edge_stat *s, u64 dwell_ns)
> +{
> +=09s64 max;
> +=09int i;
> +
> +=09local64_inc(&s->count);
> +=09local64_add(dwell_ns, &s->sum_ns);
> +
> +=09/* Keep the largest dwell; bound retries if a nested update races us.
> */
> +=09max =3D local64_read(&s->max_ns);
> +=09for (i =3D 0; dwell_ns > (u64)max; i++) {
> +=09=09if (i =3D=3D MAX_DA_RETRY_RACING_EVENTS) {
> +=09=09=09WARN_ONCE(1, "rv: edge-stat max update exceeded %d
> retries\n",
> +=09=09=09=09=C2=A0 MAX_DA_RETRY_RACING_EVENTS);
> +=09=09=09break;
> +=09=09}
> +=09=09if (local64_try_cmpxchg(&s->max_ns, &max, dwell_ns))
> +=09=09=09break;
> +=09}
> +}
> +
> +#endif /* CONFIG_RV_EDGE_STAT */
> +
> +#endif /* _RV_EDGE_STAT_H */

