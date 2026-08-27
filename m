Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9463C2775
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818970; cv=none; b=hVb7GHC5L2qrLOjHJv5C+o6PIyM53DxUcERQRDdYHyCpXr0EPRHGn5Q/fq6hS5BDipWRGRYDmcKBnsFSPPuo3icOkeLuQEj1FW7KqeAQojaHwXPt2g64yhUh6ZpApEDXgiLiy9+Mdz2yB73rpXRiJ1VHJuaYgXpFRSIUEfjA0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818970; c=relaxed/simple;
	bh=hYgWMoLU6eqUmKEL1Oy1ZTa7MRRtzrMAs4UsPycvwHM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHnCALdkj7yS4gehKPjKxb5cvN3rXd3WtA3WQ2Gt6THr7WOhTpxxyMqp05l2IXZBLvyrk7DgzGAvva2tol8Bw/WgG4hbuiGV4R6V28AQBN4KrfgccbTXUJLin6O+5kWkF6ksp966kZQUPmZ6rbl2pGnz8PU1DMJXfEVGyYJX9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdGIR7Ap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdGIR7Ap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787818968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g0msbZWUAGWITSFJgAPQcK9Sd0njMoNlLZYOOLgcLtU=;
	b=NdGIR7ApJIvJOqOvb0LQF/SCFRpSLfwXMXLVrf7GoPo78PIuFUGiYee7vXAcL0Xo5eb+yK
	HmoGB2Z6me3/wJ7A/rU+mduR3mYLcy2zkxGcVQm7zKrHCc5N7a0ZFs3/vZOAJo5LUWrlwy
	uD/YZS+hhtI35Tqpc8ckH8KKCuYw9O4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-0l1De7kQN0S9VXZ6M8pLdQ-1; Thu, 27 Aug 2026 04:22:46 -0400
X-MC-Unique: 0l1De7kQN0S9VXZ6M8pLdQ-1
X-Mimecast-MFC-AGG-ID: 0l1De7kQN0S9VXZ6M8pLdQ_1787818965
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c252a2ae8e1so161001766b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 01:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787818965; x=1788423765;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SNJwJg0S3fs0+kduUqx/6yRTxLzuM/Ks1tVa5hY73r4=;
        b=VTUTGkWhqYFLZPoFCTskk9ylRHbrGxc3ehK8+nrunQOOr9ALADGL15og1nXaeCPBdk
         EXqN/EMwUgvtNbyASUc3NoALHZQiP6xsZuDQ+qUPAD9X3pXoIE7m7A6gX3csQzTQvyOL
         hnpsdMxMNzL81HytOAlcdoNsT+OVGY+xyQJEWESMY5OOdPpMoEn0CbOq2tRfKi5DNCGx
         V0fKxyGQGa+pNmEunyBlHykZFCOHiD2qVUKB6y2XJVnUjr7I3hnTAFXBQD7Gu8GtgApl
         sgPa/rsx5pxXPDFjCy6MVmhl0LEVellQSWfOkhcOiOoqdPiiP3wQ9Q7H5aJSCDLGk1Vj
         FXKA==
X-Forwarded-Encrypted: i=1; AHgh+Rplh3hngXq0ilyX8K4q5BIqKRlJqpAct/6bCLrg7sn1uRXAnhlxqqSuKdt2+U4jfoF2vURPXhgBqXB/XgEotmmZonE=@vger.kernel.org
X-Gm-Message-State: AFuF++lyDe5dKnla1frqT2rF0lpQgeklhHtDkZYjs5jQ6PKYg33OVG8z
	ikNiJKX+2/L9KXHr1XAqcKRJ1H8nSoZFpIH8nXlUFQ7IJowOknYKoxkJHI/U2KUK8ljm15azcea
	58lFmtJ1CT8jXFnqpWo6u51y6T3BCaZggoeZwH83cElBaGUQFRLgoYRTzxCIz255BKDQ5mJUlTQ
	==
X-Gm-Gg: AR+sD12Gb0AWJXNEUKV4bu+T8ZlrPcm/HTsyzkpcqVwJtgX2aH9VHRmqF598CeUd15z
	t+3iBCYTU7WGTpVhCcKK7/tOkSC+L5TMsZBoB2+O6YN37ziy7xiFtB5vB49Xul0wq7mPgQPGywh
	5GZKA9Z73fN8n1AJWoMtpVY5CryFWVB+6z3ONoA0OW/U9xyrFyrQUxjB1zAvBy9j6jnhi208qRU
	Q5xghJ8W89PVo2iFgkl2Q/OtnuLPiri9wZ/OSex59bw/qfleFmWi7befHOJ31L0QuqvIzq5r0NX
	4EDOvYRyZHWrDhBJ9lUTvRHRjGarLwu8T0bhPeD4KZYNHZBzjIkLAI4yYpZP92jaFuj/sKVBepZ
	SWLY50wASfmEV9D4br4aDHFg1xQQ5vnPWk+drfJUDhekRRzv8liqNUgfEOL39YgLZ4ySn2g==
X-Received: by 2002:a17:907:6091:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c250c408972mr1556837866b.24.1787818965172;
        Thu, 27 Aug 2026 01:22:45 -0700 (PDT)
X-Received: by 2002:a17:907:6091:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c250c408972mr1556832966b.24.1787818964786;
        Thu, 27 Aug 2026 01:22:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25127b66e5sm711301566b.45.2026.08.27.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:22:44 -0700 (PDT)
Message-ID: <ba9a55fa6aeae4ef17873afc7373302a3fadc82d.camel@redhat.com>
Subject: Re: [RFC 1/3] rv: add per-edge dwell-time statistics primitive
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jan Kiszka	
 <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 27 Aug 2026 10:22:42 +0200
In-Reply-To: <20260827072400.45734-2-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
	 <20260827072400.45734-2-tobias.schaffner@siemens.com>
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
X-Mimecast-MFC-PROC-ID: 8UbDQXUkEyHjssy0TsA4vsay9FZptAmO1CtocXSaeVw_1787818965
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-27 at 09:23 +0200, Tobias Schaffner wrote:
> Add a small primitive that records, per automaton edge, how long the
> monitor dwelled before taking it with a count, a sum and a maximum.
>=20
> The counters are per-CPU and lock-free, so a monitor's hot path can updat=
e
> them without disabling interrupts and without perturbing the very latency
> being measured.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/linux/rv_edge_stat.h | 45 +++++++++++++++++++++++++++++++++=
+++
> =C2=A02 files changed, 46 insertions(+)
> =C2=A0create mode 100644 include/linux/rv_edge_stat.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8014b9f8253e..04589dda0873 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23654,6 +23654,7 @@ L:=09linux-trace-kernel@vger.kernel.org
> =C2=A0S:=09Maintained
> =C2=A0F:=09Documentation/trace/rv/
> =C2=A0F:=09include/linux/rv.h
> +F:=09include/linux/rv_edge_stat.h
> =C2=A0F:=09include/rv/

Any reason why you don't use include/rv/edge_stat.h ?

You wouldn't need to touch the maintainers file and could just

  #include <rv/edge_stat.h>

Thanks,
Gabriele

