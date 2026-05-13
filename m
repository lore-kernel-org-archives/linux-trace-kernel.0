Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764C265606
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680893; cv=none; b=FVytIvr1ohkYe27886dty6OKCCmvvrVPWTNL9nwM7nYMBESpsYoGQZO7sYxpalrfsvy4uTo1VOaZsF4x36dAmrfYloOFK79FJHjZnXw21WXO71uWlolcX0Q2s1rdotB8iP8BELOHbLgCNpMG6krYTW9bWRvGAB7GUyKupciJ7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680893; c=relaxed/simple;
	bh=l+tuulB0riY0GRYdM2IVFsbqdJVV/50LHxLUoHAzydo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3AbIiJAkhn14JpiAfEZ6O56t4coumzjj4O3QhXxvLOKRyGqqtI6opGjtkRPoKg7iXTFsem6JOJpd3/XmfnNSpbRHJxIIkhaoOYKqrMcHhHrlUzdnTgAn2A1Lv9Bce6LYl3lD+a525kEE4VGpMbAK15ebq2GNwKtaCFySTrlnQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2Jm8kOH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2Jm8kOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778680891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2vp6YnCveJQi0MdMwxVG/KOX/sGbUHTBE2nWoNMMuKo=;
	b=D2Jm8kOHijI+GnwBy5xbkSNRrWwLS4Qz0QUV8+W8Urhqkl4BAIC4a+Zf+V1QhX4cRiete1
	8Sqai1Fe0MkUyi1lqnse8giu65WR5VLFxpx0U/NaDSKMbe9zIB3GXJlxTcH4avYTx+OW3P
	Z34jXNn5KqzbShehz7AfwbeYxhovJFQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-wM20oAx1NsKwgwkrdllZcg-1; Wed, 13 May 2026 10:01:30 -0400
X-MC-Unique: wM20oAx1NsKwgwkrdllZcg-1
X-Mimecast-MFC-AGG-ID: wM20oAx1NsKwgwkrdllZcg_1778680889
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-bcf2a3ac5a5so17340966b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 07:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680889; x=1779285689;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vp6YnCveJQi0MdMwxVG/KOX/sGbUHTBE2nWoNMMuKo=;
        b=Wpyb+dOG+BsddGCgCnzJ8soW1Mae4a1xkrkVLb+UZBA4i1S1wMamfwssAFzXiUBwE2
         JDK1Ou19vY/BBW40e6H3McctpXrNwyalKgMH6NPnj5T0d93yzX99SK2IY/7igCWCLhfP
         rICD9rWpFiv8tLMaUGtcNuPatiPQR4/MPrduMbxADxk0sacDNES+QLiePvmhPFieYt1q
         wKwfnNOkFih64IhpTlbC9ze/l6yv01/mRyJD9GgAVbiUnQhkqaG0WRyWGuk4+rW5w3cP
         tcnQsiXj+19BC0CxbkRugPrbIpeJSQvSWBWE1Z3wMoBkgnock6rWjf1EJedGFjjese1f
         iq9A==
X-Gm-Message-State: AOJu0Yx1fAGLQHyHGzny1gAVhr04qZncM26RD+qT54vTfiQmtZymVfZd
	yAv5qTyCpRpt6mSswES2BfPztwK07Rn+RhdRfQq8SligG5Qd4BE+E1Wq65Mwj8ewhlCxdYDYqTi
	4FqCdFVsbbmmdxo2NfKX6osHq7p3B/y/cfQw/aFfj+mDbp+yaFhrOhj7iPDK2qpO9e7ZmvYJWxg
	==
X-Gm-Gg: Acq92OHnE20CTXD6h8vWoVN3cKXS8U1ElzWZspTKHdT90gurwChvPG6568sWEViCqAG
	/IOs8M/JdJTRAAphQL3RzzPSwbiVMMYp+X6LMkfHECL08BfAPpECNzP4RpsdUXbjH9atruiN52D
	Qmmj5YmJHLDTkeFz3FWkAb5nmvO3bOMKcsiFVknDYDfEleYt+cqaPp0F9/y8JnpGwOZh88PeKno
	NqNLiG3iHKWsx//rfvicVhMBz98z9I6ZGJ/WRJCuD92VndCAyVmdg6Oe4Ef4AteV42eI2bRMwBY
	IqgS6sTySObUji26FqKEJXlbgZg2KqFQwmiZCI/G+NohK6Duqcl1BiDkzUL7V3DBU7FLr/d3XkD
	RjUNN8gxmwgpMAlgGbV8x2ukDMGF9x3ThQp7UPltAT+x7Uo+7OCYzok6Ionesc3GSOfzp9I9vTC
	E06dgCJw82qRHCukw=
X-Received: by 2002:a17:907:6b0e:b0:bc6:1c2:ee46 with SMTP id a640c23a62f3a-bd3bfa81b7cmr249322866b.11.1778680888652;
        Wed, 13 May 2026 07:01:28 -0700 (PDT)
X-Received: by 2002:a17:907:6b0e:b0:bc6:1c2:ee46 with SMTP id a640c23a62f3a-bd3bfa81b7cmr249314266b.11.1778680887804;
        Wed, 13 May 2026 07:01:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca383asm39761892f8f.28.2026.05.13.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:01:27 -0700 (PDT)
Message-ID: <668f83581c58644a84cab5e6736864a439bb8e28.camel@redhat.com>
Subject: Re: [RFC PATCH v2 04/10] rv/da: add pre-allocated storage pool for
 per-object monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Wed, 13 May 2026 16:01:25 +0200
In-Reply-To: <2774332570ee823be60cfe84ba85e9573b4df478.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
		 <2774332570ee823be60cfe84ba85e9573b4df478.1778522945.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: 11ez0vz0y6J6orvTr1wPmYUDTNBRQSszvdzhtKvFOpU_1778680889
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Sorry for the spam, I accidentally mapped ctrl+Enter to send without
confirmation and can't teach my fingers not to press it instead of ctrl+del=
ete..

> That's definitely a good addition, kmalloc_nolock was not that good alrea=
dy so
> I tried some way have a preallocation, though I realise it isn't really
> flexible.
>=20
> Since you're using spinlocks, isn't that going to sleep on PREEMPT_RT?
>=20
> Isn't this similar to what you'd do with a kmem_cache. That was my origin=
al
> idea although that uses spinlocks too.
>=20
> I quickly tried an implementation like yours using
> mempool_create_slab_pool(prealloc_count) and mempool_alloc_preallocated()=
 and
> it still explodes with my monitors, but perhaps now that tracepoints no l=
onger
> disable preemption it could play well with some monitors.
>=20
> The selftests with tlob seem to work just the same with this kmem_cache (=
up to
> the unrelated RCU stall). To be fair since you only allocate from the upr=
obe
> handler, you'd probably be just fine with kmalloc_nolock, but let's conti=
nue
> with the preallocation logic.
>=20
>=20
> The API is starting to get complex (well, not that it wasn't already).
> We have essentially 3 ways to allocate:
>  * fully automatic with kmalloc_nolock
>  * semi-automatic with pool preallocation
>  * manual with direct storage preallocation
>=20
> We can have a macro DA_MON_ALLOCATION_STRATEGY =3D {DA_ALLOC_AUTO,
> DA_ALLOC_POOL, DA_ALLOC_MANUAL} where DA_MON_POOL also requires
> DA_MON_POOL_SIZE to be define (force that with an #error).

Anyway, this way you probably wouldn't need to define a different init func=
tion
and let everything handled more transparently.

Also you don't need to call da_create_or_get() explicitly,
da_handle_start_event() should do it for you.

The only manual step required is da_create_storage() when you explicitly ca=
nnot
lock when calling da_handle_start_event() (that would be DA_ALLOC_MANUAL, y=
ou
don't need that).

Hope I didn't create too much confusion.

Thanks,
Gabriele

