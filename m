Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535285;
	b=pmLxG7MGmxd1O2dAsFMVF2dgyNSdq5nXUwEwbc4f/qO8wSShFxMJpZeexEOzB9C87XgI
	 39J9V3azov3rX/uEydHMF1dGWpW65/8MbP+0QLE4fZaM0YrM3EXoKSxQTlDFFCsCMO63V
	 Dbgi1WCHDn82NSnSYDFwjy6WmX0ztAup0fhiLeRMJkukpK+9eDFIz+tOOyLWD06dVlo8s
	 pjRL0msadnV/oR5T8VxGkjgLBZmOQYiVyZLq6ApP7rhnXxR0Umy4yBNihWLjYJgNbcqiR
	 ZHe+zCcVwxHjNxP+tl+y6Zx+1eaAOtIWYiRefO6zjEpR9Kjt3mijkBRipHWmRRCkZBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535285;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fc3D6ehbW3wekVZhoEUU8kizD4nD5M+uXhSXwD5k4Hk=;
	b=kPJtJnnK7TXpbeXTCD4EzNM0cZqMwiagOVUP0bpkRxv/NtSEIq1FXJ+SsF1SOnXJ6AAr
	 VNUyOVDTU1v+5BZtZQNoD3I4FhcZEK7uOajIOFok1HDbxEidQI7DdhZXb1rCMg53kqXCT
	 akM1o6I3xRVC/bIjaZsEkdivdiZp9A6jbT/pgzBTcs2pDz1kbv8SEYkhVDcZb+CFhUXXB
	 UV7bbs83Nfn46WyoNSuk+mLPi07y6hbJb8AOe/fthKfvBtV/2I3O2INyORjogSGPDvAD+
	 huk1HcDkdhrhTBSMrGPBGDgI4rSTaLP65QPqqnNG1hGXSS1TyjgilKOyPqE5vZK3KTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7Xj1rNT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF216606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7Xj1rNT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FA21F000C0;
	Tue, 24 Nov 2026 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535285;
	bh=Fc3D6ehbW3wekVZhoEUU8kizD4nD5M+uXhSXwD5k4Hk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=P7Xj1rNTrIgJohcwRlw20kVToChuUGFe2qMLDJ6S8fVXr1TWtq6m/h3XOsfyJ6r7Z
	 J2oP/tQPsuHW3jX9DjmzF5z7ZsIZyhdWEHLRucLIYipIDvHpDnrZeP5mggZ8hyMLHQ
	 5e4+DP+fyNZU5N7QYto8igOVnpaAxlla+7x2eBwMoSUerLbWXo41oZWNAKl5U5QVvO
	 h6bo4GOOO59zNk99a754B9xUYJmfWGukQgsRCCM9Dd5dGzYawO6s7vkmQDunEfQkEL
	 6XwybeBG1s8J8w+2av2J4nlsbL7T5mV8M8fFwlJUDypxjPvafKU1horJYoy1YETX+u
	 TIL9qtZKXxd1g==
Message-ID: <sashiko-outbox-231478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/21] ring-buffer: Avoid reader_lock deadlock during
 panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261124152845.2233401-13-vdonnefort@google.com>
References: <20261124152845.2233401-1-vdonnefort@google.com>
 <20261124152845.2233401-13-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 15:48:05 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] ring-buffer: deadlock on cpu_buffer->lock in
  __rb_get_reader_page() on panic
--

commit 97ff3a6b2797df28b794089f6117de52df195059
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Avoid reader_lock deadlock during panic

This commit updates rb_reader_lock() to use raw_spin_trylock() when
panic_on_this_cpu() is true, avoiding a deadlock if another CPU was
stopped by an NMI during panic while holding reader_lock.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 928fdd4718eac..42507e97291f7 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -6323,7 +6324,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_iter_peek);
> =20
>  static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
>  {
> -	if (likely(!in_nmi() && !panic_on_this_cpu())) {
> +	if (likely(!in_nmi() && !panic_on_this_cpu())) {
>  		raw_spin_lock(&cpu_buffer->reader_lock);
>  		return true;
>  	}

[Severity: Medium]
Can the panicking CPU still deadlock on cpu_buffer->lock right after
bypassing cpu_buffer->reader_lock?

When raw_spin_trylock(&cpu_buffer->reader_lock) fails in
rb_reader_lock(), it returns false and callers such as ring_buffer_peek()
and ring_buffer_consume() continue without the lock into rb_buffer_peek()
-> rb_get_reader_page() -> __rb_get_reader_page(), which unconditionally
takes cpu_buffer->lock:

kernel/trace/ring_buffer.c:__rb_get_reader_page() {
	...
	local_irq_save(flags);
	arch_spin_lock(&cpu_buffer->lock);
	...
}

Since cpu_buffer->lock is acquired inside cpu_buffer->reader_lock (for
example in __rb_get_reader_page() itself), a remote CPU stopped by a
panic NMI while holding reader_lock can also hold cpu_buffer->lock:

CPU0                              CPU1
ring_buffer_peek()
  rb_reader_lock()
    raw_spin_lock(&reader_lock)
  rb_buffer_peek()
    ...
      __rb_get_reader_page()
        arch_spin_lock(&lock)
  <NMI panic stop>
                                  panic()
                                    ftrace_dump()
                                      ...
                                        ring_buffer_consume()
                                          rb_reader_lock()
                                            raw_spin_trylock() -> fails
                                          rb_buffer_peek()
                                            ...
                                              __rb_get_reader_page()
                                                arch_spin_lock(&lock)
                                                  <-- spins forever

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124152845.2233=
401-1-vdonnefort@google.com?part=3D12
