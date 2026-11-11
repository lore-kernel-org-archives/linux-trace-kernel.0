Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417240;
	b=BG48ZDNP+2Mvlo6V6W51YX6MDmeBUJSEWryUzTviKBfJO/OCTEfkQmx7Q4hyzUrI/SUt
	 ffFRXJSCkZUwu/gKiJC1/e/0bg54QeiyljUMAdDu63Qxhet+QDYPyBqvVyRocxMSggPM5
	 84gfQmldt9oYGrcolCMM0aI24Yhe2/a7me7Ohmq8NyPED6lCzsl45RrYIZGlWplHFJFKN
	 MOWDxuk/xDbONjwQ3uB+6au/q2Cy8qc/30KZ8gh+ku18MAH1oHypXzO2mo3m7wh7AUxe0
	 +oFYrsf78FpfqqsIIDxtTSktIMABYhimb9MWWm5bZ+gJKtPoph5WomIPDyo/3qBJxrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U5Zb1d/Ex3W49ziUOqwHlKuWdeXOTNNnTSTBdn5AuY0=;
	b=3YPE3e9C+JPOlahNpQqEz//KyJ7vwdlJaiwm4llTwvyAXj++N74zCcm1z0p67EZsWMQS
	 mdA2h0N23SexHie5qSbmNkcTfGYX1hV5qHDz877qj2lbHwmqU+RH/FdewDC1X2i7OlKGL
	 F4pa8P09781//EYfxidEPvyx9u/hp6qjLcsB6LAQpX32vCAwf+VlW/MXJId177MKpNZv3
	 sItbHOQUxklGuXPw9tHE9/VeRduT8BkuKBGvF+LG2fvZGcVyHUQaU6sYKAU6QT+dzxK5h
	 /qJPuIkDhoimGLVO5LeQnotmqIMO7nyE7Sul4CDmOAecREymPHE/Lm57wg4dD3vOMwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ig3LezBU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99E606A31C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ig3LezBU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA4B1F00A06;
	Wed, 11 Nov 2026 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417239;
	bh=U5Zb1d/Ex3W49ziUOqwHlKuWdeXOTNNnTSTBdn5AuY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ig3LezBU/29U/x5JUpOa3aZj6G/8sIT5Yksx+SSlxMePEQXqnlW/WlXhuigypGROv
	 fb9qdqIW4K4yEHhyyC7Lxa3iUPWO3nyvgCf9wZ4wsjWYfuqfmJqvak9t7em8F5drsc
	 1EnP5A84zu1910dZIdoLO7zfbe06/DUvsnaSRmyndp3vrZ6VRck4O5IkJV2YFoF5Da
	 HYWTkEzlQvHkuli5Oye/+mg85V7rq+m2wAAQD5rl/MyGJijPtFnALlBClNFUMAvzKH
	 88rNcX5FWJ+/2NxDqsN6ahHyhSihKO9THA/sx9w/fPMJmxwfgTvdpXjXOYVMZTgei5
	 GhgwCHo91n2uQ==
Message-ID: <sashiko-outbox-209391@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] riscv: kprobes: fix out-of-bounds read in
 riscv_probe_decode_insn
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261111-probes-in-lrsc-v2-1-b2525b7e1e8e@mobileye.com>
References: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
 <20261111-probes-in-lrsc-v2-1-b2525b7e1e8e@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:13:59 +0000
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
- [Low] riscv: kprobes: missing Fixes trailer for arch_prepare_kprobe()
  bug fix
--

commit 64462f82d964034abd78681cc277f651a87b8780
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

> riscv: kprobes: fix out-of-bounds read in riscv_probe_decode_insn
>
> riscv_probe_decode_insn() can trigger an out-of-bounds page fault
> when probing a 16-bit compressed instruction at the end of a page.
>
> arch_prepare_kprobe() safely reads 16-bit parcels into p->opcode, but then
> passes p->addr to riscv_probe_decode_insn(), which unconditionally
> dereferences *addr as a 32-bit probe_opcode_t
>
> If a 16-bit instruction sits in the last two bytes of a mapped page next
> to an unmapped page, the 32-bit read of *addr crosses the page boundary
> and faults.
>
> Passing &p->opcode instead of p->addr to riscv_probe_decode_insn()
> (as arch_uprobe_analyze_insn() already does) avoid reading past the
> instruction.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-812af091-20d1-4915-97a6-741f51e07=
022
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

[Severity: Low]
Should this bug fix include a Fixes tag for the commit that introduced
the unguarded p->addr dereference in arch_prepare_kprobe()?

  Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-probes-in-=
lrsc-v2-0-b2525b7e1e8e@mobileye.com?part=3D1
