Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B322DF146
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230635; cv=none; b=mhtq/sUrPre9BBcB+nUX7rO/1ciFU7wNTwH1VCpiPHQXSzibQ922lK1f++omo8TAFXCKglnAmRDhylsg3g/PpqpWPtC4FmDNrG333ttccWfwCEaeH1IHBYlTLArGKvzVMYjp2wvi4WT+eJ68HpVtdrn9v1PWPgNhKABUBxA36/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230635; c=relaxed/simple;
	bh=9NUqM5b21sxF1PziYILnoCort1qm2uhWw1f7uLYHvso=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U1mvsSfRXcL82n88uK/RpEptEa3SltByT+dWdOLL8bDXjZA4ANjIAqm9+fnnq7nBpeMsP9xyNYjwEPUvwxiS4UUAaos376ucgKOvGCzCQhFWYByidD6Y1Ec79OXrSQhJvwM6RPZUvKfretgJ7XNuVsOLum2YiNqf9nXPdx0cf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1AvpeGY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1AvpeGY"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso80704495e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768230632; x=1768835432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vhih4XJnELjtkgQ3duMqEwlwKDdojSV9tRqodltB+mQ=;
        b=G1AvpeGYVq1v08Zz4biGtTE5FtyT02CUHGSP4YGCz5htvdZw4RjvCAxtmwOqYFJcLH
         s0931VlE3OIkPBWPUyEYZthUUF90yPeGzT7YVYJEXSoyLSEeYPgVkP1npqUyZgz0OOvq
         0q7HOhmof+SdutJ/TlfAQBAEPW4QPQlCsITtiefLD5cT3aRtU5T3DkD6e9PfgkEiRqI0
         DFJv9y0eciMXlPh1uEEJdHp9f9Z3odlAndk0Z7D+xrhgkNDl7g+9jGL/gfRlerKlTiVI
         9e+K8xbXrzNvdw5sytleOtNkv6+ra/LSl//StrUm/Xz7ont8mP6AaGCPzwgd1wMbxv+T
         PCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230632; x=1768835432;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vhih4XJnELjtkgQ3duMqEwlwKDdojSV9tRqodltB+mQ=;
        b=OSshai8Yo/joPSA4os4LLp+fPo/Q64z0llqJIZEkmk4F46R9/zLBEkChauE/Vs/Yf9
         AJ4zY2vklVoPYeyhjgpRtH/IUIsFmjftbLGQioc/g41I3Yup6oJJPWjRl62XUVwVVCIw
         B8GikVkGwDTw/UMU7PqvqdfcgjREpoxv1BV29lZHXQ4hPU6DengU4M59CUGeB3YSeGs6
         S4jO1dqTo7k3rYUEkiMzwrO2FaFHFSVRFtB+GPz8TGf8HOOPAa/FSHdctyjeyvM00igk
         /5vLMC4kNKtAq9ICxsnpKFPvdvV68Q4CHDg1d6odW/C6KmCka4WuDJrcmpm/wpw1t7ay
         cS5g==
X-Forwarded-Encrypted: i=1; AJvYcCUDDo7AWwPa9/cXOvwN+C/3YmPPJIdcQrRHDc15LZtC54ALHmGe0TVMtC21XrTrGGtgjwwN1LRHfax8RF9k0ZN61WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTk4sozM5t09+eoPxHzaTIhKd+G1rZDAfQ7nWYM3JYtTSUluvN
	TCbHlX+EawvogaUh2MpdX2wy1BM9xzFicjN98RLP5FSlUp6PXxmR/Qb9cnf4I13yA6QgSQ6A5IF
	qk0D+LXpdv888BQ/Luw==
X-Google-Smtp-Source: AGHT+IGeZoNL0yQiMZ90U5o8lcflOypSTwRZPpqtxftd3sSEDJ85xDSVUTdnNYjYjqTY9tScqpn36+QQnDatLZo=
X-Received: from wmjs4.prod.google.com ([2002:a7b:c384:0:b0:477:9945:466d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f13:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-47d84b3baaemr180870045e9.18.1768230632137;
 Mon, 12 Jan 2026 07:10:32 -0800 (PST)
Date: Mon, 12 Jan 2026 15:10:31 +0000
In-Reply-To: <20260112100006.7db6d31d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
 <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com> <20260112100006.7db6d31d@gandalf.local.home>
Message-ID: <aWUO59edshSRit-Y@google.com>
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:00:06AM -0500, Steven Rostedt wrote:
> On Sun, 11 Jan 2026 19:36:29 +0100
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> > On Wed, Jan 7, 2026 at 1:32=E2=80=AFPM Alice Ryhl <aliceryhl@google.com=
> wrote:
> > >
> > > I'm proposing to include them under the existing entries, as that see=
ms
> > > like the most obvious place to include them. However, there are multi=
ple
> > > ways to do this. If you prefer to have them elsewhere, I would also b=
e
> > > happy to create a new entry with me as maintaining them, or I'm also
> > > willing to be listed as R: under the entry. Regardless of how we list
> > > them in MAINTAINERS, I will be around if anything comes up. Let me kn=
ow
> > > what you all prefer. =20
> >=20
> > I think this was meant to go after the `---`?
> >=20
> > Whatever Steven et al. are happy with, this looks fine, thanks!
> >=20
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >=20
>=20
> I guess the question is are those with expertise on the list of people to
> Cc?

I would be on cc either way as RUST includes F: rust/.

> I think it may be better to have a separate section for RUST so that the
> rust maintainers can be included in the M: part too. Perhaps:
>=20
> STATIC BRANCH/CALL (RUST)
>=20
>   and
>=20
> TRACING (RUST)
>=20
> And have the M of the other sections be R here?

Sure, we can do that.

Are you still willing to pick up the patches? I think that is simpler in
case there are any series that touch both the C and Rust parts. (Such as
the initial tracepoint series did.)

Alice
