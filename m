Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0C63A0B1A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895313; cv=none; b=ZkHS/H6jTm8XaQ+nIDyxgk4YqsrE4uJnJgNPS/Br2Dsbs3GU/sXpfp5nED7E62gwJku0xBJh9QiW05NM/J4ifHFbPr821Z4rF2frg7a/+QCshczgcxwnbhES7pmqYhUV2FBlEAJXCfWSHjwuo7Ew4WzP1M02QY6RWvoZbgQ95fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895313; c=relaxed/simple;
	bh=Dl2oWfBwtiPo7WzVz9Y3r/pgOLtbYy6Lx+/AgLj3Y70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2Sd8BcRI7coVC9IWRTiu1RsGlpBCZMSRKABZKoI5ixTieWblDW1J3oLHSx4jDBnAp5hSMnOosw2S9RJE0DB6UKD6vN8xK4HMCiZDaEbz8of/UKbILs2cnM2zD9bjrlLCZsHE60rDlwh/Slg14/cbvaj8f/bM2w7emkAaWIhMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATqqHmyy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATqqHmyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768895310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Dl2oWfBwtiPo7WzVz9Y3r/pgOLtbYy6Lx+/AgLj3Y70=;
	b=ATqqHmyy1NTs7k1Qxay/o8myZsQ89rtyC68/yPuOVo8oGFM/TM2wQA9X2vnbH1i7odMi/J
	eTsA+VUPVEYjXuDvXIUX7H7fPIkCCkYqn5pqi4Le4AbCC8YY2V8LeH9XdrDjg/8D2kizh6
	cqC86oyi0QXI5Yl1CtgR9gYLZCBiLFI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-b7NAgrmwOi6oyC7eBvjRSg-1; Tue, 20 Jan 2026 02:48:28 -0500
X-MC-Unique: b7NAgrmwOi6oyC7eBvjRSg-1
X-Mimecast-MFC-AGG-ID: b7NAgrmwOi6oyC7eBvjRSg_1768895308
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ed980309aso27925905e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768895307; x=1769500107;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl2oWfBwtiPo7WzVz9Y3r/pgOLtbYy6Lx+/AgLj3Y70=;
        b=NzykO8RCYDNounaqsc5e30gELTCPryD6eLGPjmJ8FgluzqCESCDXWMqe9OmJKAewCu
         GX2OF1/+SNb+2gnD99SddPDDpVuFMsbBffBmh9/W0FvFgV7lVLOpSi6b6xt8cn7P2G7M
         i0Wh2jP/4cVwoTiI5BMhOh5oO98gCTEiC/UwNe7gjLU8RxXY47NUgvIjApalWFWDaFTJ
         EcA8NLyKPh+YE1xQ8hnP+RBOLb/WJN4neu9eURm3UfHbCa/fbdw9G/4ADRBDcIEz1gnv
         xzsGYd+p/TJYRA6piIpyVcUemMQe8duJwrZ8tBi4+nHP6BGegjbkKlIv75stJjMZdIy0
         OZFg==
X-Forwarded-Encrypted: i=1; AJvYcCU59NDszKdpaN8+m6IgOaNR8EHG9guKk3TtKwRnH6y/GIl6Q175dRjCqHSGXpGkMGRKUd3QwsmWRNGiMyZCo+d1zfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/fWIXlStYDYRGPd7msfXX8bMOIyYPzT9FUDdigPtd4nE+vgv
	sr6JMo4sKmbhg9P+qiZZEDXSQH2RqgYeq59nK7mYsEhVGRQSuyQo37tvcowbf64wLZFY5DrgfVq
	gBAasGi6EcQaBl0BjwZ5m9/fnhlHfSXqKZvNjIkdW2YuSdKtlB6vaY88wGGYOLbuFPpoTCSzkmQ
	==
X-Gm-Gg: AY/fxX62Jeh9S9jy591vgM2ISumSzZ6G/evy9tZt1FfDi/p6hPOb8/wIP0GKLu4roHV
	m/8HNdAvsUgsJEAmfLpAw+tqRPxmiREnH4qhELzuBORwFyc/P3hibqq5oepARU5mikz1NTPYR+K
	wEt/sM69zf35e7PMsXUCsjiI8TBU0jsHIDzh68EdU01qkss9TKMcOXYDgQC5/n65fFQ49imSR9+
	RdsTBrJkg3dOMLbwhu+AbXqnsHgfw90oHA3smnfS5JbiYQikVi7J4PUZTDKHQzoDPHtAsFsjAFo
	92ErHVnlspq0jSk9DNVUuCIlKUoFDFIO24ucsjA60dyih2DyyebZY15lsPdD2ckFnepsgtk6ryo
	isn8cj8I7VXSz/StQNUNNDMGEKuKUMmG/13TC3Yqm8+Um6i17tgASXTsx5sp+I/EvSKMWFA48MK
	IJSzLsE7hK
X-Received: by 2002:a05:600c:300b:b0:47e:e452:ec12 with SMTP id 5b1f17b1804b1-47f429033bdmr130927335e9.15.1768895307525;
        Mon, 19 Jan 2026 23:48:27 -0800 (PST)
X-Received: by 2002:a05:600c:300b:b0:47e:e452:ec12 with SMTP id 5b1f17b1804b1-47f429033bdmr130927205e9.15.1768895307114;
        Mon, 19 Jan 2026 23:48:27 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992c6f2sm27197638f8f.19.2026.01.19.23.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:48:26 -0800 (PST)
Message-ID: <223e99ae6c154a189a372bb51875d3998c1f9a50.camel@redhat.com>
Subject: Re: [PATCH 08/26] rv/rvgen: simplify boolean comparison
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 08:48:25 +0100
In-Reply-To: <20260119205601.105821-9-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-9-wander@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yijQpRLiwh76EZ-_eSqptODt020mGy5ponfyc0lDsJE_1768895308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Replace explicit boolean comparison with truthiness test in the dot2c
> module. The previous implementation used the redundant pattern of
> comparing a boolean variable directly to False, which is not idiomatic
> Python and adds unnecessary verbosity to the code.
>=20
> Python's truthiness allows for more concise and readable boolean
> checks. The expression "if not first" is clearer and more Pythonic
> than "if first =3D=3D False" while maintaining identical semantics. This
> pattern is preferred in PEP 8 and is the standard approach in the
> Python community.
>=20
> This change continues the ongoing code quality improvements to align
> the codebase with modern Python best practices.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

I'm starting to wonder if those simple cleanup patches with a tiny change a=
nd 3
paragraph of commit message aren't a bit too noisy. We may put at least the
simple ones together.

Other than that:

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> ---
> =C2=A0tools/verification/rvgen/rvgen/dot2c.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/dot2c.py
> b/tools/verification/rvgen/rvgen/dot2c.py
> index c97bb9466af6d..fa9e9ae16640f 100644
> --- a/tools/verification/rvgen/rvgen/dot2c.py
> +++ b/tools/verification/rvgen/rvgen/dot2c.py
> @@ -202,7 +202,7 @@ class Dot2c(Automata):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line =3D ""
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first =3D True
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for state in self.states=
:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if fi=
rst =3D=3D False:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if no=
t first:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 line =3D line + ', '
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 first =3D False

