Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D5305667
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071118; cv=none; b=btF8PjBrLyBwwxkDkEpioH+B8xO/NrrOPCJxR13ZN7/Fe3n21OUkvGMW9vZHsD767fcIFIR01OY92TQaPqjKIJIzuAbzmOECcFDZ9KxWROymoYc8IKlaMAyc3eG3QJlfOHg8/wC67aYVvbPquiNoDL4aGG0b3wUqFOiqbKElmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071118; c=relaxed/simple;
	bh=+KIU1bRrcoVVbS8IUa84eRSPGoeUTQ2rkJ36Chjo6is=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUvpB9VSZR2NYClYaSmt2Ym/b87tpj+x36bXASub8ovx5EI0Owd/fr71hQfsGe7bBifIVEleP+BLBADOTWIu/IdSj/2yPo092pul2cfZKnwoIK4Z9uckCJhMrqXakxwk7cIGsziR9C/ZLD3ypewEH3cZGNSvBHkGtu2z9/RYPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf+Z+SKU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf+Z+SKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792071115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+KIU1bRrcoVVbS8IUa84eRSPGoeUTQ2rkJ36Chjo6is=;
	b=Jf+Z+SKUqTE2tLwGJa+lIU0TOJxBAL4sUbZGOGpkGdTqhzFTRWq+nYiphXcrb/bntczpVj
	AixSIpObwI0mzKv8RruAZclmwv6uUUcIvayXJ7Np/mSRx7Q+7roc+g+hOqejoOfAxSbMAu
	udUfTq4xKlHVzfMniI3R8kxQ0J6L2sI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-bbOqdXbmORO5VaIn2WG8Ng-1; Thu, 15 Oct 2026 13:31:54 +0000
X-MC-Unique: bbOqdXbmORO5VaIn2WG8Ng-1
X-Mimecast-MFC-AGG-ID: bbOqdXbmORO5VaIn2WG8Ng_1792071113
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b1e4a24fe5so2910147a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 06:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792071113; x=1792675913;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+KIU1bRrcoVVbS8IUa84eRSPGoeUTQ2rkJ36Chjo6is=;
        b=JVp1mP3iZR5rxPbC3D2z/SNYUFj9vgzTm3LO8ZAt/LvTTEGOTwDDtktOUEAOBC611C
         Cs6Cr+jiBLcAC+/zjR55Zqy9DI0QJextXufxA3bw8ndWlV94r+v2yMHbQjhdFiBhKG8K
         0iCl8Rfqpix1g9+cvDHkkyPxD5AdzQlAVLA+vdlWr7eOLIOEeMTjxv/8z5nxbNuqQbN/
         wTuQ88TPldKxqZGqeylosVZ435lsnzD8Q3f9pWqlIe/OZbCyG/HSUgBk2kHf/WmZ6JLS
         qUhO7K6b7YTkuo2xVEbK4hWzAgaOh35BkPz8uaz5Y6rbMDty8mdOPZe240aHfHxt95YZ
         7B7w==
X-Forwarded-Encrypted: i=1; AKwUvBwhXNdesWjJT+iIZLxFoylQCM7OP948gBVWhi8LUysmUN8/qme7P3kxR6yLpB98+nnnUEJX5akU8B4lIvxMcv9OPuM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLs2AfqWKrMvQlrzqKqKPcB9sQf7VO2pCxafKBdEN+hqapv0+BR
	b8CNAcMIWPQsaLqDjCda6Tf+E7ovOB21yvjbx9XTbhZsrcGJ2Flikwwa2ZfLS3OQHSVhT0rFu5X
	J7KHZzfoYWh90WyIstrSbRrdffM3tUrqIo38kBuSsx633SZ+ILsw/JjZ4j3abU7w49fWXp2JleA
	==
X-Gm-Gg: AYBFou0Rcxvnj8CfjOsI8ZMyv3nbUD/ky9TlfOYe0px2bgagTPwVYj10BVkMpCvyHjO
	vOJ/FGPHVJPNysceS4f7NL/1hncm6cjRnUez+l5f7+lf8hMVfj+JEwtbQJGEq7suKRRI84dOykL
	qTNeAZZpc+WeQQzlaB5GW7IaW1KIMNwZy2poHDQIc9B3AEbHP6Fas3viP1ZDHOacSLd6PdccFzT
	VJj+JKlS9AlirJ63e1PrpK2OvhbY4XLf4lZlGK5jw0iisNZpjqF7Fd7my2lnN+b/iA8yDhZHKNh
	MhqbZ8qSzoIyWRf/0Jj8o5Ip8Zp62U0rkj36KPTrK/W/tHiBMOHN4kxg7Xcb/drVSktmnGcgOHP
	L9wYOfM9pbRyUIoboJkjYf0Aud3G3
X-Received: by 2002:a05:6402:2381:b0:6af:5b14:78e7 with SMTP id 4fb4d7f45d1cf-6b17c2754e6mr13047926a12.34.1792071113196;
        Thu, 15 Oct 2026 06:31:53 -0700 (PDT)
X-Received: by 2002:a05:6402:2381:b0:6af:5b14:78e7 with SMTP id 4fb4d7f45d1cf-6b17c2754e6mr13047909a12.34.1792071112780;
        Thu, 15 Oct 2026 06:31:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48df2619703sm6019856f8f.24.2026.10.15.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:31:52 -0700 (PDT)
Message-ID: <5af5de33f57fec18c8026f20c131830924438dca.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] rv: per-edge dwell-time statistics for per-cpu
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, 	jan.kiszka@siemens.com
Date: Thu, 15 Oct 2026 15:31:49 +0200
In-Reply-To: <3ac898ad-b367-449b-bb0e-841a4fc6c190@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
	 <4759c9b0dacdf1f9c0cf47158895860dbd0ec401.camel@redhat.com>
	 <cfd7123a-e83d-490d-918b-154d45aad92d@siemens.com>
	 <aa16855bc9ccc6b776ba4f513b86e3eadf889f74.camel@redhat.com>
	 <3ac898ad-b367-449b-bb0e-841a4fc6c190@siemens.com>
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
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TIxXrp7zTwgd_Stmt9mYqnMNiB0ssdTEJllQDjen1kA_1792071113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-14 at 21:27 +0200, Tobias Schaffner wrote:
> Nothing generates NMIs. But from the linux kernel's point of view any
> activity of the companion core is NMI-like, since disabling interrupts
> from the linux kernel does not stop it from running.
>=20
> Our co-kernel keeps control of the real interrupt mask, so Linux cannot
> delay it. Most of the time what Linux disables and enables is a virtual
> mask instead of the real one.
>=20
> Tracing already works inside EVL, thanks to a downstream patch [1]. It
> is mainly fixing all the points that rely on interrupt masking by
> calling the correct wrappers.
>=20
> I would expect that we have to do similar for BPF. Some of the checks
> already exist to cope with NMIs and we would just have to make it
> recognize our stage too.
>=20
> [1]=20
> https://gitlab.com/Xenomai/linux-dovetail/-/commit/2fc39d2bb5d9ca1c0e8987=
94fc0297eb04cf67d9
>=20

Nice, thanks for sharing. Yeah you probably need to do similar things here =
and
there for BPF too, but perhaps some things (e.g. tracepoints) would be reus=
ed.

> You are clearly much more into the topic than I am. I will have to take
> a closer look to better understand the BPF data structures and,
> especially, their locking mechanisms before I can answer this.
>=20
> My use case is, so far, not that strict. It is more that the bigger the
> tool gets, the harder it becomes to argue that it does not change the
> behavior of the system under test. If the tool remains simple in the end
> and I can describe its behavior as deterministic, there will be no issue.

...

> It sounds to me that you think about moving the complete RV system to
> BPF. Is this correct? In the end I will try to follow if you decide to
> go down the BPF route. Possibly after some delay but nevertheless.

Frankly, I wanted to keep both representations and I'm designing the BPF se=
ries
to share code and keep both in-kernel and BPF maintainable.

But this was mainly under the assumption that some use-cases would still re=
quire
in-kernel and/or BPF wouldn't be able to do everything we need with the sam=
e
quality/speed/determinism.

Now, I'm still assessing it but it seems BPF is good enough, at least for t=
he
use-cases I tested, this assessment is going to take time as well.

For the time being in-kernel is surely going to stay and I'd really value
external opinion bringing other points on why it should not go away. I know=
 the
industrial/automotive use-cases are the strictest and if BPF doesn't fit th=
ere,
I wouldn't drop in-kernel support.

So now it's the time to line out and validate all requirements.

> Should I wait with proposing a v3 of this patch set until you made a
> final decision or do you want to merge this in the current RV system no
> matter how this develops?

The good thing about your series is that you're using very few dependencies=
,
just like DA monitors. This makes it straightforward to use your header dir=
ectly
in BPF with minimal modifications.
I'd say, continue your work towards a v3 and in the meanwhile I'll try and =
see
how to align your changes to be easily usable in BPF.

Realistically, DA monitor support won't reach upstream before the end of th=
e
year and after that I'd need to do the same work for LTL and HA. That's goi=
ng to
be more complex.
Only then, if everything is really smooth, we're going to think if it makes
sense to migrate existing monitors and deprecate in-kernel ones.

In my opinion, your contribution stays relevant either way.

Thanks,
Gabriele

