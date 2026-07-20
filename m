Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B460B3EDE7D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549621; cv=none; b=Go5De0akZ/9+cjnbTSOuR5QiweveKz080j0uiA/ghK65cEhHVZbUtMIcz0DBHJXXCED8QtI4yFIayxktM46/GxktCtzLf+97a1JY/V/O3IndNJh/LINdVS0Jn9A8o6LelTBAeHxB894w6oi/gawukaYUnDCcohyJzhIdpgpR3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549621; c=relaxed/simple;
	bh=0aZkK4o+ctY+fKZKmabXGUgJz6EwYQkX5lL2wIIdAJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCFfOwfk6OEiQZeUHAAD19zAGJTGAQfI0RU4bFwn6eu8idnvJtj3o5Ch55fBUJdDpPo3ZYcOCkUas0IyfMCE69GOtaAYxQ03wuroG3LG/hVNMaHC+R+y4oRAVAwN4Q8JPfj9M1UQzpPwZLcWSVjRJcjp4/2Q8yW/wk+cBkQ+1xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEPe7ojV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEPe7ojV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784549618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0aZkK4o+ctY+fKZKmabXGUgJz6EwYQkX5lL2wIIdAJE=;
	b=PEPe7ojV0AQ1S2HLxUdKQSG6iETL95yuEQUbie0zkjbTBd1VrL2cRrXrPT1a4BvKh1Gw8V
	z5QT0fJi45aBkiRy1RkcSJhnE8YybiL1uKNzr3DSqvSfy4nGi/NgR4ZTeqHo0GAYen4CNq
	Ioyo9SkFGW4qXYzmW6udA8qLKOkiFZo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-qY07JQMUNV6akNBUug5Ssg-1; Mon, 20 Jul 2026 08:13:37 -0400
X-MC-Unique: qY07JQMUNV6akNBUug5Ssg-1
X-Mimecast-MFC-AGG-ID: qY07JQMUNV6akNBUug5Ssg_1784549616
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15d84e3572so599246666b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 05:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784549616; x=1785154416;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0aZkK4o+ctY+fKZKmabXGUgJz6EwYQkX5lL2wIIdAJE=;
        b=FGBLqN9ZlwBK2gUhbJLZnkYvRqhx0lMoIEI5rAwgqUjnjnxV7Xvy5wQWwaP+K8JGUO
         VEHmEQtBGP3hGFmj24dg+FKJHcOyh0gCWuuWjn80gc6bt5vRAsE748x4SYQm+KkYcK4C
         GQXLkICUjqC401RyZ+0YDSWAt91YfSUSsBsmaIQ4KAK/ElckIJtdFoMn/Dq86Jq2Nmsq
         1f+HM4MXBCfR6zYMxIE2qRFUY9s35pISVjrC4TmLTmkDxK47EL2IlOORA6otxDzXxKy4
         /KTpUUbODTDZhlt0yWyfIWAaSVC4QtT6mr3YA9NQQckgvwKnriYGJdpuouH1Df2kOrHw
         pLTg==
X-Forwarded-Encrypted: i=1; AHgh+RozBp8LnNrb54UDvdzjDO2/9b68yCo9bA3nVP3T3prqokViV2JPWCM5ojGqhifTJVgTZ6Ay5vqt6UvxHKuniH1YmNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/LbI7yVkM7C3JbqmZ5yNCUWZ8WzO29+VLyLeMmZM4OZAmN6O
	hMaEO8yWP6A/R2c/VWodBRY8a9o4nPu8MGgIZ85OY4DiZTqx+xI2b+lBoab21GueXXAJpu66kYq
	p7LGbxccmYy3MJGUItLQAgVcHgnxjk+y29Redjw7GaaT7sFM5WqXr+J2RAFlrQH4yGJIe+rdBKA
	==
X-Gm-Gg: AfdE7ckqk/AfXGfFQ/jZAnbZbyo4QNlFu70/h4RDUAfcp9G1NNtLYq/w+fQsrKZxpOM
	LokxTSp4VAdPMWeiLXZF26blrUesutYZMsnyi2fGVLFR8ox4+TS2gN0+YGvRTv2O3kHcy8iYGCt
	A4sbG9cmqunOP8da0akuBPG2gI9uZvVPjmEtfDcGHyyFzQfsBQnbNCs3aP/9Zfq9LZZKRxdQRUw
	bRwISYpz3Fq5VU0FZhbup+OKz8m5GhiGGox9Rf0Uco+aMz7S/zCQ+B/kEIVvoYn21hsa5NCznEv
	SP3DAP2s6MMreMY/BQOjcdYUXmLoS53OvIipqVFryg0BvJOvx6X7MEtIbtYO90iHozOT7ThGHtT
	8xnWTVIGFHG0WpGbP9ufOQnYVndCzTzprWGTd2e9GC3d11jhLJXJS1O7/2aWJZBx/h3FKiQ==
X-Received: by 2002:a17:906:4fc4:b0:c12:b2dc:4834 with SMTP id a640c23a62f3a-c16b48c0309mr590111866b.57.1784549615977;
        Mon, 20 Jul 2026 05:13:35 -0700 (PDT)
X-Received: by 2002:a17:906:4fc4:b0:c12:b2dc:4834 with SMTP id a640c23a62f3a-c16b48c0309mr590109866b.57.1784549615541;
        Mon, 20 Jul 2026 05:13:35 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1724f50ab7sm455491066b.50.2026.07.20.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 05:13:35 -0700 (PDT)
Message-ID: <2b19681b46b6bb5b64f1686c1ffa642a7bcef2a0.camel@redhat.com>
Subject: Re: [PATCH v4 09/13] verification/rvgen: Delete __parse_constraint()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 14:13:33 +0200
In-Reply-To: <87ik69evgy.fsf@yellow.woof>
References: <cover.1781847583.git.namcao@linutronix.de>
	 <b22a5a3822fe53afb8e2cf1df623a0e4c9ed5f49.1781847583.git.namcao@linutronix.de>
	 <5bd5c857c5130dd7b122112c69baf793bcf45090.camel@redhat.com>
	 <87ik69evgy.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: YQW0GSdHePF8bdCAHY9DN7Yke9BdebGgEm6V_1tVMlY_1784549616
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-07-20 at 13:44 +0200, Nam Cao wrote:
> Hi Gabriele,
>=20
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > The series looks ready for inclusion to me, thanks!
>=20
> For patches that you have applied, can you push them to your tree? I
> think that is
> https://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git/=C2=A0?
>=20
> I would like to have a base for my other patches, to identify conflicts.

Right good point, this is the branch I'm going to use to to send a pull req=
uest
to Steve:

https://web.git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git/commi=
t/?h=3Dfor-steve

> It is also useful to include them in linux-next to get some more
> testing.

I don't have direct access to linux-next and I was planning to wait for my
testing series to avoid sending Steve 2 pull requests in about a week. Unle=
ss
there's something terribly wrong in that series, I think it's not going to =
take
too long until they all land on next.

What do you think?

Gabriele

