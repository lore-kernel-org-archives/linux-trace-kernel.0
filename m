Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84482E6CD9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Dec 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094160; cv=none; b=W3E8jaV5suSBrQTKjaWO1t9p16Rxo8r80E3oif8c25eMrLC3X7cBF0xUFdaKQNOZrU8GsCn+BilBiSPyyOMUpqhkvzC0lM3an4qWZ5CFligzTCRDdFvEN09J/qlO5lAYy50yF5DAh91SMbASMnt0YpXd12UjlxZOJ+YI3b75rtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094160; c=relaxed/simple;
	bh=O00ZI4FSKFfmFHzARhRnzhqzPgDhkFvxMgFn0UfMCrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGy5IGWq39zKVUSMuLcee+FReYQX7XZZJQ3nw95d4I8YlzrrmD4ZIkRwTRqHqWsLcgOc0mTtF8kYTnUl2+E0MXx3A8Cktg9ZreBYRUEoNA3QkiZn1yBh/NTtqrKu/q6UqP9w6gAqDwQl/7N2oSTIXiKztx722TVbImp1G1O0maA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvQ2HFo2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvQ2HFo2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767094157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O00ZI4FSKFfmFHzARhRnzhqzPgDhkFvxMgFn0UfMCrk=;
	b=XvQ2HFo2JWSM7CFO9a5Wma1kzNbIxIFxIw/2NZuvUEzsT5r8pm1zc1SrKXzM6RGn0gR9Ef
	eovRW87GR2MDmm0IPtVa/wa8gKwCSS1gZH25ob0mJDz/kv8ZXOOJPvFCzErf9RsUxoFpk4
	0kM75VbIXGgFTVi/5ij+GA2rZ33svpI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-e3ELJWswPDa4VxovE3nvTA-1; Tue, 30 Dec 2025 06:29:16 -0500
X-MC-Unique: e3ELJWswPDa4VxovE3nvTA-1
X-Mimecast-MFC-AGG-ID: e3ELJWswPDa4VxovE3nvTA_1767094155
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42fdbba545fso5985063f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Dec 2025 03:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767094155; x=1767698955;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O00ZI4FSKFfmFHzARhRnzhqzPgDhkFvxMgFn0UfMCrk=;
        b=L0Ir7We/5UFYYTSkzMg6JkFIUFQWblvbsN7xIYO8ttq+UXh5VK2gmoxI7nhP8ZeOSo
         apoIjkIEGoTesvcLb93M8P+BpKRAxfns4gb/hgKegFAlID6D343XzLVJBi67t0WM1CVU
         Y8sc6OnYyejQE0QUz70QxRm3Hen325k9n3Nl+CUTyNbxC87PBlQCLIiezRmi9agFOnXY
         6fY5BMZz+b/+nuVZx34Dl0HOXwZSbniZTWpFmzhrS1nsg7SGxnIaODdvsKYMvRfl+tax
         2K5Aa5BlINF90XgidVWRf2pSjoobcCOWwKxDn8E3tplCDQ0SOofIhShe4haF8sYCt5ql
         Qefg==
X-Gm-Message-State: AOJu0YyImX+k/wgXRqbW6Hwh/BKBeInudQ4YTaaZSjeBDQEsQGbisyqR
	moJiWVU2xpznb3i0+6GtoqQjx+1WzRjl0VPJ97l0rGtOi+UBxaztAwEjd+AmkpK6KUsi9kEYh3A
	DPiHxcTvmNWCOEMKPQ8fG+NSwd3RIewOOaUWzWt732wTlFQwRDgtXO/LO/dqEpE+jsQvk9ngzO2
	ZibvIzDfsl
X-Gm-Gg: AY/fxX5/4BaZefMTNbJxs3XtHHyP83fo1w1x1Wn+7GsRUGWrQUeGfItYli2jHeJA1i6
	RDQe3Gwt4xmDKbHH6U1PATn4BUgpU65iev0VbGjUeZQebPkxkNWAyj2pTeogTgun659ISS0ceMh
	2OwaCbPSTmqTjIq2vJBQKkEOWS7pUsg9QgXfHyD8dFGOj4/KJ9GlT7zbgkbgU6ur0mqA0vhMt2J
	1kqJPxzOb1HbxWa7XRv0CKMBG50diCtfqfC/jdcVHLo0zRDG0JIU9nReX0xd3y7Rij4Ii0hlcyv
	2R0t5RqnuplcQZe1y9IHa6wKPvSj3vMHwviSqDIr1SB0LAo0H40ducE9S1I+O1V6Y1mzOZ+xdxd
	uenHBC1JNlzlaA0DQz+lnBXG7Lq8q4F8q5Z3CUSQ1gfCBsQuBOWT4nXJeH5PH2zslZAvhSj21hp
	Kn+9tktEKx
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr43246422f8f.18.1767094155274;
        Tue, 30 Dec 2025 03:29:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfRHqLPwk9g7p4qHvFp0IOhopjCpyEPKce1VEHzqrt49HJKpbTMuKAaiiQ8+a3wvsqFQikMg==
X-Received: by 2002:a05:6000:3113:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432448b7f11mr43246403f8f.18.1767094154851;
        Tue, 30 Dec 2025 03:29:14 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227casm67401590f8f.15.2025.12.30.03.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 03:29:14 -0800 (PST)
Message-ID: <5a8b1ef45e775d4724237057f60ed49cf5432ae8.camel@redhat.com>
Subject: Re: [PATCH v2] rv: Fix documentation reference in da_monitor.h
From: Gabriele Monaco <gmonaco@redhat.com>
To: Shubham Sharma <slopixelz@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rostedt@goodmis.org
Date: Tue, 30 Dec 2025 12:29:13 +0100
In-Reply-To: <20251230075337.11993-1-slopixelz@gmail.com>
References: <20251230075337.11993-1-slopixelz@gmail.com>
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
X-Mimecast-MFC-PROC-ID: rT04L_YqtjJlP4bTgjfGl-cYIlJHEAOtyWA4k6Ohup4_1767094155
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-12-30 at 13:23 +0530, Shubham Sharma wrote:
> Update documentation reference to reflect the file rename.
> Monitor synthesis documentation was renamed in commit f40a7c060207
> ("Documentation/rv: Prepare monitor synthesis document for LTL inclusion"=
)
> from da_monitor_synthesis.rst to monitor_synthesis.rst.
>=20
> Signed-off-by: Shubham Sharma <slopixelz@gmail.com>

Looks good, thanks! I'm going to apply it to my tree.


Small note for next time, although it doesn't make a big difference with th=
is
tiny patch, when you send a new version after getting a review, try to prop=
agate
the review tag.

Simply copy:

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

(or whoever reviewed/acked) before the signoff in the commit message.
This helps when reviewing larger series and when using tools like patchwork=
.

(now you don't need to do it, most tools will pick it from this answer)

Thanks,
Gabriele

> ---
> v2: Removed backslashes as suggested by Gabriele Monaco
>=20
> =C2=A0include/rv/da_monitor.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 0cef64366538..810cfb140131 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -8,7 +8,7 @@
> =C2=A0 * The dot2k tool is available at tools/verification/dot2k/
> =C2=A0 *
> =C2=A0 * For further information, see:
> - *=C2=A0=C2=A0 Documentation/trace/rv/da_monitor_synthesis.rst
> + *=C2=A0=C2=A0 Documentation/trace/rv/monitor_synthesis.rst
> =C2=A0 */
> =C2=A0
> =C2=A0#include <rv/automata.h>

