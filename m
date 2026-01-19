Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C2313551
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768822519; cv=none; b=Tw9ujFXSYv+xzy/FQEy07yaJf1Hc5fLUdXhIac1HYa078bgVM+vf2fHYdJ4atkUvlOq1K0TNfElunZht9TTFBsLdDmmL745QFBedTxjpQUV/rr9eMsS1yHEWDRPNbrNUWdpFvZE74pPUhGNM6FSg1ZO25f4sZALu+BikCtE46vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768822519; c=relaxed/simple;
	bh=wcMNmsz8MIooQoKQs33DRCmEYgTeBEbRNqSTQQHd1c4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqQ7Rj1m4SWY0jRf1Obp5GWMy8Eh5C1eq4/4jET2hA5oaUY4/4SxaCBgLc9/OfINnvoYFvIufcCTfrQOebk3u3DVt5eSGf4DMeoB3vzkVilqa2wxsi0gYvHr7RXSQPR3YUqQVMpGv6+i+WydmhGWRcSdEyOMB+oJt9Kp8neFg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQaeYGBw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQaeYGBw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768822515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wcMNmsz8MIooQoKQs33DRCmEYgTeBEbRNqSTQQHd1c4=;
	b=LQaeYGBwr0Qg1jg93Ur7MbwQz9+POgYfcFqpZLt+hCO1yyGyvqc9kDVJ7iRvorluIWEDfb
	S/k2i1bz4qOAB7wmRf7AO/diHTclJDGQwHyuC5k+j4Xia7sTxrmORGn+d8E/ltv/RX5diY
	4rwnOrDoN6Bf9o7azohFLj5ZlagV+KA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-a1dwPdlDNSOmvzspSGQkGw-1; Mon, 19 Jan 2026 06:35:14 -0500
X-MC-Unique: a1dwPdlDNSOmvzspSGQkGw-1
X-Mimecast-MFC-AGG-ID: a1dwPdlDNSOmvzspSGQkGw_1768822513
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcfe4494so4383750f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 03:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768822513; x=1769427313;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcMNmsz8MIooQoKQs33DRCmEYgTeBEbRNqSTQQHd1c4=;
        b=eRpP/1gDQ+qrFGfylnEjgZJoyfmJDEaxbU0Y7P5OUk3A/uowlLexY5Vvz50GeW2HG3
         IcV6RQJ7QjuSOKIcgVCbHmQj15ppxstx0L8uRMDB9CXpnEwPZbK9oKkHZunCpOjF7ooq
         66VVz99j+kkRm+bmNRMUYoTnKjlu8prz7qAeMSvm//BOrV7zRSSeWkq05yi+eoJTXYHg
         JbhMQb3rTfd/OzMu8rzQ8ezYnmkKtenH9E8MaPAsZsYA8ZHqv8caPppwvWZMhV+cZF6Z
         /2RlSFXvdGN22+eWpfprg+vBQ34w9gj7uJS1c6sax/2+ZQIsTCBxDS0atWpRzm60EedX
         Y0oA==
X-Forwarded-Encrypted: i=1; AJvYcCX9x1Uogpfafxp3/q20YNiA95ZfYWih+93XKjRMtQGeyVohRhWFkxx39h4dz9KUpTOj4mxsiBFVdJsoJqz07LafIqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHw3H0DBqu7NygBVud2Ph65QfbK+bDxr9cF6QYRlvDf7atxSJd
	6Bs16wTVv+ZTzhWbHVIzJfMo77VoQP0UISDFTvfukQa3Ph0bcmHzeFa0TlWLTqaHvTSB0Kkh+aA
	w94pwu4Qd75MhF0lCqAfnLDjZatyFG8xVj7rR8mJbWwRetfnR6DHmhBPXZGJ/Xw2PamRH46C4fQ
	==
X-Gm-Gg: AZuq6aIWaQbgZRoadhHTX+6/4J7MHhW4+rjN/8hr03EQWF9A6rlYXzY5dSlfIJcWlac
	2ZLwXlnKSaVaYJu8DiIF7Dt7NrFBY7Ql2OmcgHx3rHl0SVp7C0uXbJxBzULTie8Tzn6vJ8Jabdt
	pyjYOpIdhKa0q/4aBYno3cAARuKFe4aF/l2p2vkvcZcdXrDTfZ7UkUpJ3YfW0be6nbfmjqpKZlI
	L8p98me9f7TM2KSoKmA6fjcUP7SOEAlyyEUmaMP7OutkOmMLQi2FEntb8kCLh0zPztg8BQX1Sy6
	D7GH0EQzoH5PH5z8Xdb9YYvW02GwcmYE6M8jSfolc2tqoXodDDHQrYqtVwuUdk8nehG9GmLzWR4
	lXyghb8HYcwbCbdHQUqsEiuADrWUZ+3VqVXbGt+cGLIOo3c6NMN5WR2Hw8aTW7+D88qJ70+wNSZ
	tntU7IzMxh
X-Received: by 2002:a05:6000:2f8a:b0:431:701:4a2a with SMTP id ffacd0b85a97d-4356a089804mr11261075f8f.59.1768822513307;
        Mon, 19 Jan 2026 03:35:13 -0800 (PST)
X-Received: by 2002:a05:6000:2f8a:b0:431:701:4a2a with SMTP id ffacd0b85a97d-4356a089804mr11261032f8f.59.1768822512887;
        Mon, 19 Jan 2026 03:35:12 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997eb0bsm22352413f8f.34.2026.01.19.03.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:35:12 -0800 (PST)
Message-ID: <5df16facba05b84857ad09cee12df0c19a551285.camel@redhat.com>
Subject: Re: [PATCH v4 14/15] rv: Add deadline monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>, Jonathan
 Corbet	 <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Peter
 Zijlstra	 <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 19 Jan 2026 12:35:10 +0100
In-Reply-To: <aW4PvcDxBJnDLJFq@jlelli-thinkpadt14gen4.remote.csb>
References: <20260116123911.130300-1-gmonaco@redhat.com>
	 <20260116123911.130300-15-gmonaco@redhat.com>
	 <aW4PvcDxBJnDLJFq@jlelli-thinkpadt14gen4.remote.csb>
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
X-Mimecast-MFC-PROC-ID: ObrQoZoPmY3WPfbvJ9oAsr-0kg5l1XJpxBrApamyk-A_1768822513
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 12:04 +0100, Juri Lelli wrote:
> Why use pi_of() in above cases?
>=20
> For the first, in case the macro is called while the task is actually
> boosted, we then might continue to use that even after such task gets
> deboosted?

Mmh, yeah thinking about it again it doesn't make much sense considering we=
 are
not tracking when a task is deboosted, unless that always corresponds to a
replenish. Thought that doesn't seem the case..

> For the second, current PI implementation (even if admittedly not ideal)
> uses donor's static dl_runtime to replenish boosted task runtime, but
> then accounting is performed again the task dynamic runtime, not the
> donor's (this all will hopefully change soon with proxy exec..)?

At this point I should probably just ignore the pi_of() right?
I'm assuming the original (non-boosted) parameters are more conservative an=
yway
so it shouldn't be a problem for the model.

Thanks,
Gabriele

