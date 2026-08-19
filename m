Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB33D47A6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123572; cv=none; b=k3NWQ0fmgfmKkNoKnIRx0zYZ3IsE8m8jkWmKqQjCdRqf5j0gKDKSXnY2zsND5MaY5XizjfyJ0RtKTu4KYCuj6GiaZsYcbE5Sdx+wkdCaQaQRuGv8u5ET2X+LfbZNc0nMJUy4VPmc3alLK/qjMa02YCqBQ4gMQj0hU/JBQG70tos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123572; c=relaxed/simple;
	bh=abFhYMkUfAdImPk84cvzsA0w1L5kgTtwCKQLRo3mf0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfDvOhwsUX2H2VdAItBF6DIjZQYT6+5xgqmuBCeKqeArFMS6pZm9b572B3Dc/iQItBkcUavdrzHgzgV7g+TvC1kT43ymGYyB5IUlbJ5FJrVX3IxWxRjKJ5f6SVPQj82q1QAL24bGgSnQxzd+klCecERZ2WPmY238sj711wUpJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijMyJUlO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijMyJUlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787123569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=abFhYMkUfAdImPk84cvzsA0w1L5kgTtwCKQLRo3mf0I=;
	b=ijMyJUlOLGMNDFYYugqt7m2sMNRjPJk1tx4YgyRDhp9MX+qOe6GprBd6v8pCrfHUD9zo7W
	BNleyZDNVWEIE7x6RQlpTfp+hJtPl6kcIUgFfBxH4sBjA0Rn9L79e5RRHE29SBqSbqSDGw
	6rrQGIojrxtpDLS+6zysxuHv+27abTs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-2ixFlrrMNCSh5kZv0DI8fw-1; Wed, 19 Aug 2026 03:12:47 -0400
X-MC-Unique: 2ixFlrrMNCSh5kZv0DI8fw-1
X-Mimecast-MFC-AGG-ID: 2ixFlrrMNCSh5kZv0DI8fw_1787123566
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-482a5e9400eso510330f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 00:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787123566; x=1787728366;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=abFhYMkUfAdImPk84cvzsA0w1L5kgTtwCKQLRo3mf0I=;
        b=m0TShb3t236kYm6E4lvcttvxCsEaFv4UdLLEWjTBQgmPZvln7ThxBa0usq2ZHYwv91
         H2501TP628gpWRbtveUtHOyHTNR0J9ZFd8bmCuwaXB0sALUv6pxI+RaQJZnFN40YElY+
         7VpTWuLOsHkThgkQsAfYn4mLiFy4ae75BYW+CVCVjIRMxaoP70E8/P9ZA6xtZKsIXBdM
         /+kavVfUY17ruuMptCf/PHx5ThriBH2AfihmfuNP8fmQoUfpNWjvGw/Ij9Mg0l5U/sQ+
         J7i4eRPKj0LEzRNtFQIxKQzpCOpUwpQkbFaYJFLTak+QU14QoBdVpyLhcDltzg4ayhFQ
         1wcA==
X-Gm-Message-State: AOJu0Yx4fVGgu8s2q2noa7t9ixUdfi1vZ+m5kB+cdNE2NVPcrbGHIg6i
	5gkeTKZn9uq2/h1dXrhVTgEzhESYedvdydBSww6mHL6XblggfTMgxe1EiN4qtZLy3QY35RIjI5y
	IUHq2e1lnWSYNgwLLuNVCyYgByNJCiteaSnZf1dKm9bVOb31yiaCmMG9gVwbX0wfgiYgTaDbiVg
	==
X-Gm-Gg: AR+sD12Nc+yoodfevjvOm/feDGm73h/T9ZXSdnLaqTfsxTzpCt1eMT7y95h5fd55+0W
	gBQ2cLTksrR8SiAfXLbTPq0lRWwXr5ff7FidkfqTqimqJ7bIHP09F4eJj66F4nPOiNokDhj78tN
	seswoxwfJ8//1Ii2hpEfoVuXZkPn/8Y0rLIslDkRyghQ6/l6fm2+8SiVdVQU8+On0DTO4thLH8q
	2kDd0moWf4PtQFz5c8XT6aWdvy0GgesyAeHlEarYV2S2rvQFvDGZccnopmyNocsx7riaT5aaeMv
	UrXvhsu+NwVNpMT+8TAEgbdQHeeoKD5sP5V9g9yVJGxBeYo0BPvwNw+OA0I4htwHs4r3NCBkKqb
	Q4byR6+0Z7cdATpqYlgNflFUggq2rgkWuWPkUMW5fRUrlLovARqzweM+sqLN5czeNM8nY4A==
X-Received: by 2002:a05:6000:2507:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-482b1fe7f68mr3475168f8f.16.1787123566625;
        Wed, 19 Aug 2026 00:12:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2507:b0:47e:81aa:3832 with SMTP id ffacd0b85a97d-482b1fe7f68mr3475095f8f.16.1787123566243;
        Wed, 19 Aug 2026 00:12:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm3207741f8f.26.2026.08.19.00.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:12:45 -0700 (PDT)
Message-ID: <b6de8228ee3045104a03ab4754e5ecc50e67f627.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] rv/reactors: use context-sensitive lockdep wait
 type in rv_react()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Date: Wed, 19 Aug 2026 09:12:43 +0200
In-Reply-To: <87zeylnos3.fsf@yellow.woof>
References: <cover.1786294920.git.wen.yang@linux.dev>
	 <26526e555baa5118325b2383e9f7f0f8f9b6a199.1786294920.git.wen.yang@linux.dev>
	 <38decc4f7ef5b6f03b37705c7e97f22a7e40d7e2.camel@redhat.com>
	 <87zeylnos3.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: 4EhBje4OeRBD5i_zXmtkuBiaMqkTcOWPpsBO-87pL6I_1787123566
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-17 at 10:18 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>=20
> > On Mon, 2026-08-10 at 01:10 +0800, wen.yang@linux.dev=C2=A0wrote:
> > > From: Wen Yang <wen.yang@linux.dev>
> > >=20
> > > Reactors must not explicitly take locks, so they should comply with
> > > LD_WAIT_FREE.=C2=A0 However, reactor callbacks can run with preemptio=
n
> > > enabled on any kernel (not just PREEMPT_RT).=C2=A0 If a timer interru=
pt
> > > fires during the callback, the interrupt exit path schedules and
> > > acquires rq->__lock (LD_WAIT_SPIN) while the lockdep override map tha=
t
> > > declared LD_WAIT_FREE is still held, triggering a spurious
> > > "Invalid wait context" warning:
> ...
> > Anyway, I'd appreciate comments/acks from the other folks in the loop
>=20
> Sorry, I do not know enough about lockdep to comment on this.
>=20
> FWIW, I would rather just use LD_WAIT_SPIN and keep things
> simple. Context-sensitive code paths "feels wrong" to me. Spinning
> should either be allowed or forbidden. Making it dynamic "feels like" it
> will bring further complications down the road.
>=20
> But that's just my intuition.

I don't have a strong opinion on this, but since there's no one in the kern=
el
using LD_WAIT_FREE as inner type, that feels like a hint to go down the sim=
ple
route too and allow LD_WAIT_SPIN.

If a reactor ever uses spinlocks, lockdep would already complain on its own=
 if
that ends up being an issue, wouldn't it?

Gabriele

