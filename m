Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194152;
	b=XNvBttafDYJP0Md1JCBxmHVabadhhq/k2+qH9B7+24VtejlKFHO5pigMi2mTic++Do57
	 hpoXkGTVesW5HM7ia1MrFI8XS4Adn1GHsTZBqti6lN0ux9kdNM1Wjl8wXIiGtmjpr2nhZ
	 Bk80eUvWOnj94kn8Cu94Jks9QeM7hlxStGt226Yy6q0Xe7NP1PpIbLy9lelQuPibWmcxr
	 d4kf6R0TyDvbw7lbTTfG/I7TShgH2A2IpX9uVSd/wHrK2HThPTDLb/4FB4GnHdDKTFoUw
	 Zd4sOp1YU37HSIcK+sUgB5zW+28Lmtuw1kH9W9CidozIQUoGK3cDd/DtrzH9EKzvUsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194152;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=6zTKNqmPWf0Vj/jpuR4Gw2ubEjlUG16M4BFYNokv6fw=;
	b=fn9GHLqaT5plACrbb+G/QDQpoqAxwNzmk9A4m9ZpKKPnZLOsyc8WY6N6wXZtWq+be8AS
	 Bj8XvGefxFdC0rwOINqKGYefb3lguIgwAMQoYVYCtCKgUZVWRwbIUjd+AlR46r4sagxyO
	 cKwrC2tW4IZsbz/ZzFOhR83yBUyI0qs1F95CMBkcnfykuUiyvlG2KwHiSbZOoshRf0K1V
	 DNjNd3Rytyt360dIBk3xl9/rmf65Mp1oMuRBmRP4dl26Gd0DLmzvu1f9kAnsC4HZtuuG8
	 HhhgE5v/RiGWNENPLAQ8Pes4DgrwBZuNY5euN0xRflnTSylQI0cGu4qVEE9GFMRxH0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Ma/UD7Wd";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9C60A2616
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 17:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC9C60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ma/UD7Wd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795194151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6zTKNqmPWf0Vj/jpuR4Gw2ubEjlUG16M4BFYNokv6fw=;
	b=Ma/UD7WdoAW68KfAtka/pm/pMlJxjBs+VlzcvGo9D3fjF7s8e7IpRPFCzi1pKUFpnYX9C7
	x7bc1hBSVh94sGsFMbk9RCv7/NTKVFjLscUkI0TEwMY995hrE6ltnkb3pzMaOZWF+mAaxA
	84bqSu4B892fINAqsYh2zsfGiIy2mbU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-o-ThlRiCP6SpWNHGKiLZkA-1; Fri, 20 Nov 2026 17:02:26 +0000
X-MC-Unique: o-ThlRiCP6SpWNHGKiLZkA-1
X-Mimecast-MFC-AGG-ID: o-ThlRiCP6SpWNHGKiLZkA_1795194145
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c40aa03ded8so125337866b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 09:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194145; x=1795798945;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6zTKNqmPWf0Vj/jpuR4Gw2ubEjlUG16M4BFYNokv6fw=;
        b=uu+RFVqRie5bl9whLKHXOwcGWTdUF3/UVoSm1AhjAzEvFrATxq4iHd0pdgDj6PR57p
         rttqks1fkqlA150ANmQmDPC6gncjA/SEVeGHQ8XoFBffi+hUrEhxRx0dIzSSAaKEPS2i
         PlYgeEk+Ying71JD+IS8zGsbMHnGgoZ9s6rPlnxJUwX+spnMcED1WPtwY2N6P/Mr0LgA
         nchFJxf4VqtQvWk+7VJ+1RvkG9eR3QD8lNwtCpLjiTYKodDFTkkAAMOmhW/VSqKSkUYu
         lHmG7b7boZJptPP/HJ25J/eJcz7RlNQt3+ksrm+JXroxKPNWjPsyqmCfS3cIIQwt6w+L
         As6g==
X-Forwarded-Encrypted: i=1; AL+hErEnYDGJgJcScht4pv+9/teSG13CpQyDnUuDuwR1r66kGtxfVqKQy8MiJwITkG7uvWoQ1nK5sZZ6c0hQgVBwAoj+LCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W3nit7L0z1HlcyQAkAd9pxlv30t0Km0TmLosO+gg/eKJz52C0
	r6nSQ1b+yrHRPqrEaQF8YvLe4rwA99EzjiwPjOo0BcVgehNqqQZaX8ZEZw7JQNn4phpdLZMLSyq
	BVUCpb+DiaGmqROKcjWmrVgS/aOns2LnO0sm47Ad2F3e/SAl3Y6Bq9+aDawNXvSEYue/vdcMSBg
	==
X-Gm-Gg: AZFdTZcvIASviNJ/epgb8I1WP/qkegFQ3Wt8b5mwf6DgQiSVaXtyoXfpufoir5Aad64
	9lGF6T05Z3gruorTXZAlpiFL5O+TkrwITiVU3C/YvyayLtJ0JA0dD0hfF4+z27jUlRsluvJYvvL
	9uEUhVrQSbkrRbGiUrSYkvMLlGOQ5cLcRBZ7KC4hmkoqhnpoO+anYU8YiP0kTZ91+kcQzx8M23e
	kYS0xUJsKnyUtAIXyglVJfrycr8bqr5+H7smHKMywPFXGRV7My/gWNCxPOg58RpJ7wIhq36gU36
	gZX1rYtpkNMEavJzkCDMq/wnAx+WVpfExfG+Lm993oJdeEJH0pXuFc0pO1t4GkmcU8mgc5Jzk0p
	e3ZZr6eJHSrq3QXQDoaooONaIHYMHh229jIIh52w1KF69W7I6WpzrglkjYd61IyIMXev96K+EmZ
	MU
X-Received: by 2002:a17:906:f59d:b0:c31:5bb8:4b3b with SMTP id a640c23a62f3a-c513a47d551mr393854766b.2.1795194145234;
        Fri, 20 Nov 2026 09:02:25 -0800 (PST)
X-Received: by 2002:a17:906:f59d:b0:c31:5bb8:4b3b with SMTP id a640c23a62f3a-c513a47d551mr393848666b.2.1795194144836;
        Fri, 20 Nov 2026 09:02:24 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afeb9bfsm112182566b.74.2026.11.20.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:02:24 -0800 (PST)
Message-ID: <5cb05c823110358e588c651778c981cb278335e9.camel@redhat.com>
Subject: Re: [PATCH v8 05/14] rv: Add a KUnit test for the storage free path
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 20 Nov 2026 18:02:23 +0100
In-Reply-To: <a00e4d311cbb9da36a621177f8b2c420bd532c7f.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
	 <a00e4d311cbb9da36a621177f8b2c420bd532c7f.1793900349.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: D5YKdytH951DnNKH8WcwkvSXwiUbLa3GdMR3-ipvVCc_1795194145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-06 at 01:49 +0800, wen.yang@linux.dev wrote:
> +static void rv_test_rvtest_arm_after_destroy(struct kunit *test)
> +{
> +=09const int id =3D 4242;
> +=09struct da_monitor *stale;
> +
> +=09atomic_set(&rvtest_expired, 0);
> +=09da_monitor_init();
> +=09rv_this.enabled =3D 1;
> +
> +=09da_handle_start_run_event(id, NULL, start_rvtest);
> +
> +=09scoped_guard(rcu)=09=09=09/* resolve before the unlink
> */
> +=09=09stale =3D da_get_monitor(id, NULL);
> +=09KUNIT_ASSERT_NOT_NULL(test, stale);
> +
> +=09da_destroy_storage(id);=09=09=09/* cancel, unlink,
> call_rcu */
> +=09ha_start_timer_ns(to_ha_monitor(stale), clk_rvtest,
> +=09=09=09=C2=A0 RVTEST_BUDGET_NS, ha_get_ns());

Like sashiko suggested, you aren't really supposed to use stale outside the=
 same
RCU window, the scoped guard should probably come up to here.

> +
> +=09rcu_barrier();
> +
> +=09/* A timer the free path missed expires here. */
> +=09msleep(600);

This feels like a magic number, are you trying to say something like wait f=
or
twice the budget?
Something more explicit would probably be better.

Thanks,
Gabriele

> +=09KUNIT_EXPECT_EQ(test, atomic_read(&rvtest_expired), 0);
> +=09da_monitor_destroy();
> +=09rv_this.enabled =3D 0;
> +}
> +
> =C2=A0static struct kunit_case rv_ha_kunit_cases[] =3D {
> =C2=A0=09KUNIT_CASE(rv_test_rvtest_underflow),
> +=09KUNIT_CASE(rv_test_rvtest_arm_after_destroy),
> =C2=A0=09{}
> =C2=A0};
> =C2=A0

