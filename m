Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051982DECAA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230719; cv=none; b=uYVhnlvY5UTS3Ap5BE4yHzr3KDiCi6ry/zNC/8DMmUbHMgDXbwqxY90b+h6cCbAtAwtHASuO1T9LwlG39jJTFVoY6gwYgNvUrORRju2bVferRwtpmtkORndpvp/HCBtkkeJ0PVatz7Mo0Or/+Fnq30JZ0aDD7FuqW4vlRHmCGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230719; c=relaxed/simple;
	bh=hbVdS31AjGbxiM4REiWfB3EQ5mxh8v0ze3TE0QbCrro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvMaxPb8AAI0Ow3ov2Wuwcxx7+EGxfAEEDKPUPN78/sVgyX+RYrTyVgw7u0zQRhUHkaMITaa4O+lcbDn1wnXdGv3INKF4FqJfOhTeHMfKAtqr6bySaWhWO1DhJTVD6LnuZe46n2Dwwj01tt/rkXT/yhEsVEMlAeKQvLoH2IuhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoUzoaXB; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoUzoaXB"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b446aa37a2so4889eec.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768230713; x=1768835513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPNUpExGPZ0eP2PL8HPQ+bLbS1S2GR59K/pZ0qOKnYA=;
        b=KoUzoaXBRYbZftvo2Qcuv9vFmxlgSd3VdHgKlsroMvRAk9dzp/X1TH7QufvLELI6wF
         H9cDObAwbTuC2Uug8RjQgRaBojeYP6g5ITal6cdJugOzN9QmeTeJ252N1BZRgl4PdOBD
         8hSVQBjrP4ohSQBz57kp9Bc6fLQQRH65HMC0KRNpp5Z93fBUqTcGy2JdH4tB5AylnNtV
         Uiib2A1Aw9Y8N9nfkHcwTnKovV6qjfestkBup6iowR77bZX2CE4r3nzYoU7N8z8cpun8
         nI12vdcv89PY9/GMiF3pR0TwbMOgvyG4gUoi5xrYqiDEhJ5hbYI5fpE7ZXsA83tBdjQu
         G+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230713; x=1768835513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPNUpExGPZ0eP2PL8HPQ+bLbS1S2GR59K/pZ0qOKnYA=;
        b=BtILHqXSOSWyltJTd5CWE11AueXVxrUhVlSQsCOFiL0pExwvMiAgJ+SKcl1B8yM/6l
         OoHTKH62erbTs/pNATKRqfFo4b4ygWpMls6aaU6aKIWG2jeRhtc0h6AmUF81Q4ehh8Y3
         7/D73GLxbq5Frdj4gwNBhLFemPMayrObXbCwr2bnnUH/52CakaacvhT8g9M0HUDdFcfW
         yZdMvboA54eT2HN/MAmEptc0MkYbGV4rUR0raqzF1YosGqGSMFZ8pC+3C9PWPIM62EEy
         OPvhYYJEwvWnRUTifyFQuK6tzObzToj/O/eE/ukOd8fsurbCd9ynlz2oRY6ew1FCnPs+
         H/8w==
X-Forwarded-Encrypted: i=1; AJvYcCVCWjWDA35ssnfIzI8n2dUcM2iI1/0krhbqrpX+dSfDDD3dAGnQtWTV0tq0hL00tFxwWEG7O/bIxRPP3iFHzDyIdBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFsEPlcPkWG3RkW919Ocw9C7e9K4lw8qjzqh3u/cjB9c8rqz+
	cthzzT5T0sF6YdEhdzYVmyrSag90KpErfjebzgEKgaGtJaNkztSIj5ZjYMmzdpCMCz/elgguBV9
	J9iuQwoll9Kfl76KxpomGAPVIAixlVQo=
X-Gm-Gg: AY/fxX6efsXDHajP7yZVYfFHSLTDQ+eYop9o2jrgyjOkmMoRv7ZqNZ6B9TtFSUCBf5C
	/GlkEP6zdkthGEEn48LEu0hEVVlowUkcbWok8EwUdiWoW+O0twRi2tC7gcEJ6rYXwgBGZZTRjOe
	INhpfT2snRO+btkHAK0UldF52r4Xjxoi2XpYF6K+zoqWd4cFlYaCszyaMmfQPHaNB+RzN+71hqB
	BLandOKRTiyP0TdCv01pjkPZ5FmbDbBTdkuQA98abB2GlCQLEOlrLcC7SO5OhnWID0jnTPv+Ev4
	bUmGx2lL5htjCW8ili6G1wbwknUlE/AblPQlMpRkxpn0sTlHRHRWeNTMQTT9AXpCVti9pifRiUJ
	p+YHn4jGxAXgT
X-Google-Smtp-Source: AGHT+IE2JSir18sRr+yPNaQngfQaMGaAN7gWIs8BQSI0z2/mMFjuJJRFlyAYimBq8J0DGl6BL9+5OvXrK6zDhUChif0=
X-Received: by 2002:a05:7300:8244:b0:2ae:5f73:1968 with SMTP id
 5a478bee46e88-2b17d24286amr6565850eec.2.1768230713100; Mon, 12 Jan 2026
 07:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
 <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com> <20260112100006.7db6d31d@gandalf.local.home>
In-Reply-To: <20260112100006.7db6d31d@gandalf.local.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Jan 2026 16:11:40 +0100
X-Gm-Features: AZwV_Qhbvsj27jGvnxGNOxIBWj7t_7rzsFvwEcJvm8EWQBeKdpII1fMvWchJec4
Message-ID: <CANiq72nY2xUj0aG4q7YOKxt0EV29Jwos_kjAPD89eE3_irsr0g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 4:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> I guess the question is are those with expertise on the list of people to
> Cc?
>
> I think it may be better to have a separate section for RUST so that the
> rust maintainers can be included in the M: part too. Perhaps:
>
> STATIC BRANCH/CALL (RUST)
>
>   and
>
> TRACING (RUST)
>
> And have the M of the other sections be R here?

There are several ways subsystems have gone about it:

  - Sometimes they may just add the people to the existing entry.

  - Sometimes they create sub-entries like you suggest (usually with
square brackets like " [RUST]" but there is also a " - RUST" used),
e.g.

        BLOCK LAYER DEVICE DRIVER API [RUST]
        MEMORY MANAGEMENT - RUST

  - Sometimes they add them into the existing entry but with an added
"(RUST)" after their names, e.g. Boqun in LOCKING PRIMITIVES:

        M:    Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)

Cheers,
Miguel
