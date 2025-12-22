Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0082F744F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766389972; cv=none; b=Vkq8UL+8St+W3JkWZ4rETp9BHD4DZxVxkflpVNQqL+HrBSU1G7kvBB57ZMXyj0mldC/bIlvV+7ChcnOh8bjytemxi0bIWUZld8xH60J3oX+s62DAQuzoKcZ2pG188t35IYxZnS8U/rLBquEBeDKzaQT20ImY0UCh525et3G/gVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766389972; c=relaxed/simple;
	bh=KWrBlIDpTr99OtYf8Ztvf+/3qEtDd8v2nx6llZncLNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0avnUYzgP998PK8p9oJXKDespr2cQcV9fnUqO9h/wNU+xgm/IjXqR/tESkcH4dMLIIr6sy/CjmLzTsG91wgaZM+z9KK3y8HiRly25INsSs6R6JoXXmQn2krcfsHAK0AZC/qGYtlRGw7lvNlNE0DIdSnHRKMiILy+C4JPf/y5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLQu1Vi6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLQu1Vi6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766389969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KWrBlIDpTr99OtYf8Ztvf+/3qEtDd8v2nx6llZncLNY=;
	b=YLQu1Vi6xAissfYXpjZaEebOYUTGIR8VUG74tSyqjTjtERww6k1cEafEkpY/o6QNjni20s
	skXzYPGCfYxUzOVzhtBhSTLQjg0C03FoE9ztc9WXCqi1rpi5AtFlQdN2xSmCd8rO+uk1lj
	0YVLU5snoS2iyb6iWnUziK3Slb9MJSo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-ZBNIFeEeO1yyfZdyCcpqUQ-1; Mon, 22 Dec 2025 02:52:48 -0500
X-MC-Unique: ZBNIFeEeO1yyfZdyCcpqUQ-1
X-Mimecast-MFC-AGG-ID: ZBNIFeEeO1yyfZdyCcpqUQ_1766389967
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42fd46385c0so1886754f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Dec 2025 23:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766389967; x=1766994767;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWrBlIDpTr99OtYf8Ztvf+/3qEtDd8v2nx6llZncLNY=;
        b=Q90dsyKKBJKsLm+pEUmW2ZFVomPAf3Ok93p7a/Af3LF2J6d+YNdTohGh81wHIf/jgP
         fyLaAsajV7DHSKyaMRNdJAK8olZWK3+hajz1lW+r3cobq2c/34UJEFC0o72mg9/ujslq
         v+oXR1n6+1HEaluB2P7Yz6sbZKlxz1/yO+LZWaT7JwuOha5Dr+AM2eJqK+CyWzl0kE/4
         qzMq91yHmFO2fJk+zXa7V9CYw26QKvtEcdA5j4ubaQXS7bid1hQLI3oeZR9VINeJ/NYh
         o0qmnKaCQYUEfNiOdDNjqTG+oPlxxEKzEEp9yALQj8PMmjWVx2OD4HlgaifL551kKYnN
         9Sww==
X-Gm-Message-State: AOJu0Ywb+3WlU9ubOij3FsK101y/KHvN4aAR7UWhGmTZmkQRrJz89r7m
	Y5XWyspW+BqPbzSrw80tFBTVJ7wluzKpSjm6Omk8dFrN/QH2JR3COPjr9SlHoBfakuwN3xtZy+v
	v4cjU7aFgFnlUJNcPYs0GQOeZLmGYNMkzEBO0WR4rUNHGIxKOT0i3ZAdcVQ1x0Lc3Ug1+TQCnOw
	==
X-Gm-Gg: AY/fxX6nMsTzErQCpt9jeYVL42cURlQGgJqVK0q0REhaN2yneSl9B9qmNJwZs01qEmC
	gTWcd6mAgGl8mksoahzUAq2ghUJ4URydjSKLSMtZezGSLQAWsVrr+WYMvfl//77FaQLQmIbI2ft
	B6lCuLM0gORJtco1Qo0rmKN2XPN7mMVjfRqg6LeNXHTPtIC5ay7/jPyBJWM6CrYnZKQC3TnuEvO
	Y+LaovpFHTOmoPHOC0Zq7RL1Q2gdypB7dNNwiCyHSkR1Br5xtY8v3QyshrkoI4Wj7c5gBgXRjmT
	a8xm+yPut6m8mxXGfpwmUEYylb7E6PpNdYFzZHYeG3Ic9aAFfQvp0+aqVgUtJkYL3xK5kQIOQRW
	HCvKfl6HAysJ5/KiV0BMlCJLUwkn++iSYhPalAgXWmdLpjIutSv2p/cA0Qb2ssD+pRAfp3fW7tI
	C3udGSDuvD
X-Received: by 2002:a05:6000:1868:b0:430:fc0f:8fb9 with SMTP id ffacd0b85a97d-4324e4f9458mr9727718f8f.36.1766389967276;
        Sun, 21 Dec 2025 23:52:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdRyZaH5NyazJIzGIgujh9ZiDgegytMll793wZq0nANDAxOD8wtZ+LeBEsdzSayRP40mZAbA==
X-Received: by 2002:a05:6000:1868:b0:430:fc0f:8fb9 with SMTP id ffacd0b85a97d-4324e4f9458mr9727700f8f.36.1766389966879;
        Sun, 21 Dec 2025 23:52:46 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm20209193f8f.0.2025.12.21.23.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 23:52:46 -0800 (PST)
Message-ID: <34300119044891194a18084f6572bb7a44a37973.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix documentation reference in da_monitor.h
From: Gabriele Monaco <gmonaco@redhat.com>
To: Shubham Sharma <slopixelz@gmail.com>, rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Dec 2025 08:52:45 +0100
In-Reply-To: <20251207205546.73946-1-slopixelz@gmail.com>
References: <20251207205546.73946-1-slopixelz@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 6mmQE1Sn8IgJE7QWeBHMUNA75viBDZsByfHCB9c5RbE_1766389967
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-08 at 02:25 +0530, Shubham Sharma wrote:
> Update documentation reference to reflect the file rename.
> Monitor synthesis documentation was renamed in commit f40a7c060207
> (\"Documentation/rv: Prepare monitor synthesis document for LTL inclusion=
\")
> from da_monitor_synthesis.rst to monitor_synthesis.rst.
>=20
> Signed-off-by: Shubham Sharma <slopixelz@gmail.com>

Hi Shubham,

thanks for catching this! I see the same problem is visible in the rvgen
comments (tools/verification/rvgen/{__main__.py,rvgen/dot2k.py}) but that's=
 a
separate thing to fix.

The backslashes before the quotes are not required in the commit message, w=
ould
you mind removing them:

> commit f40a7c060207
> ("Documentation/rv: Prepare monitor synthesis document for LTL inclusion"=
)

Other than that it looks good.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,

Gabriele

> ---
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

