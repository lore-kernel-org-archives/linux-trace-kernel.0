Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3F30BB80
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Oct 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540589; cv=none; b=iv7rAeGDAeYKJvErx62vb9GV5lOz1JmS285pdgvrLzc8SXoVaa5AgQI3plqU7Bfl/hxKT3F/WvwTNXg7gwR5YomBaYT4ovmcRdmAZdqF2/bmgnSbGTnN27R1vNGVMPlG6bMpdGjxAtypHXpT4OjFYEPGNte536qELYiERi2yvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540589; c=relaxed/simple;
	bh=DIYzQ1EPfmvk0HXDvk5SB0xtF59iHApk08ybYe83kU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR8v31Zlo64+DSPuorvt0AHmrNZ3U8JDVe8QaO5UuqOvB/dH8Y/cWIT38OZY4iugc8l/9J4UNw/ive3u5i/lbWz/N5fDlOX/aJxbSKfOFkRPKrrX4/q8ujpXiz5RPvJbwc+/6vZgNpHpdzI0HfE5bjEY+YmsBAWwP82Htre3bPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVzwNGdi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVzwNGdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791540586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DIYzQ1EPfmvk0HXDvk5SB0xtF59iHApk08ybYe83kU0=;
	b=DVzwNGdi8HW1hz5CfOBYEeP2H/jU8cEsFuoTpvcqxNM93il69fs+guER8MG5GoIchKhBYo
	q4aod5p2QZe4VjRxHdmo5HGB+CNGEuYAEuQgJVgPQtgXIeDOXoDDfaluK8vst20EkIGzxC
	CXU7jxYr9UOlTUVR5mNbw4rIPb/NnGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-m16SIhyFOKGW5FoUpzhSSw-1; Fri, 9 Oct 2026 10:09:45 +0000
X-MC-Unique: m16SIhyFOKGW5FoUpzhSSw-1
X-Mimecast-MFC-AGG-ID: m16SIhyFOKGW5FoUpzhSSw_1791540584
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b008137d8so1050209f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 03:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540584; x=1792145384;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DIYzQ1EPfmvk0HXDvk5SB0xtF59iHApk08ybYe83kU0=;
        b=KB6UuNQR2vA/76WGSTV3N+Bn6KRiB+NqFC6Yugay+B90pZkv3bpFSUr/tiebBIDjDY
         G9PDsuuLg9Tp8BL3aycMVpbPmSusPDQ3ePAliA6DqGMsuZqfxRsu6kLvGuPr/fapbhvi
         QOGUV61L4wcegFGNWEQHipvJFm29FemdSq2uy+MpNf/CilvmLF3U37Cgg/N10ErabdF2
         t1781FzXenRhYkbsDZnisEuVqCECLRRqBwSWkOp904f46mg2JT1nde6YVx28CmaDC7MY
         OWzoH1ZlXruWrGGrFAFHeKbqwmR8hCEaa6JBRTNuBVfBJ6+F4icHQFZhSM1qzRBO/ifK
         WaEQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwamX8nnLSEkiN9fRlCO3FHfpPHV0U2M+f6QG8RBip9FjaYJj5F3qFvDTbzQPf1vfWxMciutHBiEmHP5kFS/5MnO8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyn0AceBb2/fv3f2+P0dnH+07t/UqtZ1PeYizkXE7cwl7BoGf/
	dMfuS9QGxch7eHeYwila0DOcbG1kCqQJLLSHjKhoIkFty0tgrQvlXHUoE9J99Nv9O4/raXTfOfV
	0QgYs7YckWNcNEXI8KDL3x8fFLEaiYCV67XI/05VRAnKfjNj4oYYQbnBm/CYKcZvXBJkX0OWFKg
	==
X-Gm-Gg: AYBFou3EpcmCltm3wcRDBn8klvetVOgv4Ak5uZHIj+v+3iec+1egNxrms1i1pGDUsnR
	G1EuTavMU/Idmf+A2ZO3DMHctfubXv7/gOdB9s6rhVlwB1FOQSUrLInzJwdMG3dhM2BI23e+jf8
	4X/7dfeYJQu9qH9bx703K1umNskK2NJ/PJ9dSPStDN/7Y8JpG8+CuWuoyAiNNWWdbIUx9llxW7E
	vWjNiadJMuIgMkslBOqd3QW1aDQZEOUOBufJTshvWzoKdOgvq52B7K7RtSmb80b37ZLfvkggDfa
	Dx45J1vcwcuPSGFQHnCdUHxGRx5Mw6XSLytacorrlz+/VcIPsHXezjfYCPqM/TxMqrninTAkV7V
	DrKJCruBHwbw2f0tEbbI/pVWM5eA=
X-Received: by 2002:a05:6000:4683:b0:487:146f:7c88 with SMTP id ffacd0b85a97d-48dba9e6381mr1934015f8f.4.1791540584332;
        Fri, 09 Oct 2026 03:09:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4683:b0:487:146f:7c88 with SMTP id ffacd0b85a97d-48dba9e6381mr1933990f8f.4.1791540584008;
        Fri, 09 Oct 2026 03:09:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ada3edsm3163180f8f.53.2026.10.09.03.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:09:43 -0700 (PDT)
Message-ID: <76753c2dd66792ec6eb94d00741e61366df426cb.camel@redhat.com>
Subject: Re: [PATCH v2 09/15] tools/rv: Copy stripped bpf_atomic.h from
 libarena
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Fri, 09 Oct 2026 12:09:42 +0200
In-Reply-To: <87fqygl9we.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-10-gmonaco@redhat.com> <87ld89wtrx.fsf@yellow.woof>
	 <4F009BB7-58C2-4AB1-8FEF-61FA4B5281A2@redhat.com>
	 <87fqygl9we.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: ya3158xJ8_Wybl6ARxB8ufcBNXYWoTaymEnE1BV_8y8_1791540584
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-10-08 at 13:16 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Mmh, I'm not too familiar with them, but they wouldn't be drop-in
> > replacements as far as I understand. I'd need to use C11 atomic types
> > and that would diverge further from the kernel implementation.
>=20
> I am thinking we should migrate to BPF entirely. Keeping both in-kernel
> and BPF will be a bit painful.

Yeah that's a valid point, though I'm considering it more like a longer ter=
m
goal. I'd rather avoid rushing the migration until we're sure BPF is perfec=
tly
capable to handle absolutely everything and we can cover every usecase.

There's a common belief considering BPF a prototyping playground, where "re=
al"
things should eventually end up in the kernel.
Now, I don't agree with it (look at the many sched_ext policies used in
production), but I'd want to assess if dropping kernel support could drive =
users
away (e.g. industry/automotive which keeps popping out) and understand the
various not purely technical reasons.

Gabriele

