Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D4D135A43
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991522; cv=none; b=HVyvqbNMxjYCI+viVz+Gu4T/L5sFRCcSy+WtRXt9ztgRUFrGJw8Afv0QlD7qKmzm2rfcWf8jGPU9dVbZYA0FUn758lSF6QFMIeFK37sUTnV4ighjdkvDG5nctqaym34jmrsTNdPacaG6BoABs3MuxN4699Hru+qLUkTnmBVLXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991522; c=relaxed/simple;
	bh=8lUSqlHGMqI8I1r1rpRBEXkwRpZ7oqe4M8MCNf1etHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdwFaAn5sET2UmSuwGSGTdyBQwtnI4DIZS1WzHLkH8yGWg9M87h3z1+X2eYzHtDnHiwnKUJRnQ7zaaaPcBoNX0piKA8ubDLhZYXek9foBEE0+ShI0beaub26MaMMPA5Egovf2aokp8iJESbwzjrsqwYmG3Z7vDcnTpRxXO0Y238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=B6X5dYA3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="B6X5dYA3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc09556599so32090035ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708991520; x=1709596320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyh7mdFRyjlmJV4fW69ox7tTTJCxGb5XPOBSz1bCTds=;
        b=B6X5dYA3THgOp6st2c8F6tAXMRD1omasU5NmLQgv59huRvDdk544qAzWwMS1+dkokV
         Z2aMZgwNAjX5NbwbNDjudPSys5kedeAn67NLAm8AUCM0jrckZ0l+qbSYUvrUy7EgkDc1
         TOKRoMdkJnZ1nULU19ChI3FxdQ1yCIvUUIjc9Sf9zqvpPqeKueHG6Msr1BgA/TDROXK+
         FpHCdJ4F8Fx36Zghr07QNGX+lIWpX4s2DX60dJ6guEdzK0K4MOXFdjTEn5Z6SMjGKwKE
         qtyQGv0gfJTnxbKY2JsIWQEu9aOSaYfXP5mcPPCh0JL2M0ddPbNtTS8wPMyZnqeGaCaU
         Hj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991520; x=1709596320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyh7mdFRyjlmJV4fW69ox7tTTJCxGb5XPOBSz1bCTds=;
        b=USOA/wECHj2d34sZV4Q26BRi3Aut/ClBGQa8Nd+BMBnLZM8x8a6yYG9usNM8gzkO8B
         bul8g5IvBKEQKIzxmVpvsEjTa6fIZaAII0RRRfeO9VkZdxiVYcRzIIcckhdgl2sIsUv+
         xElBJn1UnybzLjv9FnJnQBWuXhr7qiIJ6zF7M0ZX+FQe2vcjZL1WRCvZ/kB+Viddvljw
         gE+ZKHVgl31RFIApAD4VI1ivhAU7ZaVhw34439c25s6TMfnHD9mBMB/ujdhL9YAllXm4
         ABJ9wQyp0C0XCN6dV6alvY8q/oT9MMtsun0ebEhK4Mca922FZNCunnejXhD68+4EOl56
         F1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4wTgKoYR5h1v6IvxWBdw3Vob/gLVf9abCjNjjgnL55S8lpDjs+kJkXC+7IGxncnatTDaPQVBUXMamR7KiqKR21/W3ALZnHQoEBWhbW5xt4QXy
X-Gm-Message-State: AOJu0Yw8tbyhJaHSZPpIVobQjgpemZp6tqai+ox7xsJpL8yKvdAhcxA6
	f0Ul/OYJOGhRKhYYlUZNmnbaRJT4fR4wIjavC4abOxghWC/Yk38EMZIc3tRUuzHWIJjQzN3xXvy
	GesUzrOTyvIf4ilYEYs7OQB4EHpnMv6jktxk6
X-Google-Smtp-Source: AGHT+IGcY9ko42XXIFbh54WiWMk6NMI+6vNUAaXKGgq93/tZ3zK1OHEtzgeAGptztw3FB17mOtXCnI7Z0xkxwMG3Vu8=
X-Received: by 2002:a17:902:ebc6:b0:1dc:83b3:99a6 with SMTP id
 p6-20020a170902ebc600b001dc83b399a6mr9032283plg.41.1708991520569; Mon, 26 Feb
 2024 15:52:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
 <20240224-tcp-ao-tracepoints-v1-3-15f31b7f30a7@arista.com> <20240226204142.GJ13129@kernel.org>
In-Reply-To: <20240226204142.GJ13129@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Mon, 26 Feb 2024 23:51:49 +0000
Message-ID: <CAGrbwDTDfkwf40cTkXh6QgQwPpsAVVLWENYH=_eko5tHCKC5VQ@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] net/tcp: Move tcp_inbound_hash() from headers
To: Simon Horman <horms@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 8:43=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Sat, Feb 24, 2024 at 09:04:11AM +0000, Dmitry Safonov wrote:
[..]
> > +     if (req) {
> > +             if (tcp_rsk_used_ao(req) !=3D !!aoh) {
> > +                     u8 keyid, rnext, maclen;
> > +
> > +                     if (aoh) {
> > +                             keyid =3D aoh->keyid;
> > +                             rnext =3D aoh->rnext_keyid;
> > +                             maclen =3D tcp_ao_hdr_maclen(aoh);
> > +                     } else {
> > +                             keyid =3D rnext =3D maclen =3D 0;
> > +                     }
>
> Hi Dmitry,
>
> it looks like keyid is set but otherwise unused.
>
> Flagged by W=3D1 builds with gcc-13 and clang-17.

Hi Simon,

Yeah, I think I didn't notice it when I was splitting the WIP patch.
It should be in the very next patch that uses them:
+                       trace_tcp_ao_handshake_failure(sk, skb, keyid,
rnext, maclen);

Thanks for the report, going to fix in v2,
             Dmitry
