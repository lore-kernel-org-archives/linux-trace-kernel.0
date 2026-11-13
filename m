Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556415;
	b=CnJXQPKYhP09hg4n57EFEdxdXcNL8REGIWwV5LUy4jVzxpfGQEPUHWnPrSHG31Dwaumc
	 PtB/H5NH70BVOeNSmvgdG0P6+YfmAfEuMok5EdMJoSmgAKnJbUVS8RXjMcFuhPj8ufOo2
	 U+ZbANKXrZP1hsndAoYmTVmSjluV8A9av6tanuFGzIzpEHRt8XlE7/tuT63MtVRRHoYb8
	 +IU8+n7uyxK3oeHvd5IQCzTI0BpK4L++DQyjYYBfalVVBqbZQ5phUMXvVn8y2TB4YAnR5
	 C1BuDLucx4hPvaUcwvHSTJe5dEHN8M5RCobN7IOLGE3zg5ZNOaYBbFb+s+9Zt3eN2DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556415;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Pbc+EvL/kolpX1ANyxGTDhTo76dtFAMfqxanhYSvQ5w=;
	b=qLAfMfSDo4cqEcp3e+6yY/wrAcoPoPchpME0hVHxEZ5sNNzdimB8Fx1WuAiHQFFv+WqT
	 yeIyYcr3BdYSDaIgh6vhEYzliVGjSXyN5YzH41XmM5NzcSoap/T+IjM8/EX2vLJ1xfYBQ
	 u5CJxoEWpyifvYw9+1foI9KRGEN+aw/7rI8WuNmdZj2R+1g0bCNJ4KR/vEGz6IMVpbHzk
	 VyEe2oxGtJAvvQDrNb6auHmMEE+sDTPpNam0cseXpwGLBn+yhLpQeB1wEtpQ37m7xm3w+
	 LQnXbAmCLGRw4/0lM7ODXRNiA3oKc/xE9L2cFJFGlzBlLVal17MUQ1x7Kwnb+y5aUJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhnsFX9I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BC606A321
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhnsFX9I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CBE1F000C7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794556415;
	bh=Pbc+EvL/kolpX1ANyxGTDhTo76dtFAMfqxanhYSvQ5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FhnsFX9IqOEqzm1fK0sNBHyJwBPNMf7/T2Q844/+KOgoLeRNe8Uvwfk9UXjYEh/YU
	 0kFmgr6oVnS1TSt8tFJ59Sjxc6VvtbE63GPPevSOCeMjYSxs43SOTb7iewSByFZ+mv
	 DGBmS55zCFniI0Ijg8MJ77/SzpPDL9UMtQ1XtJLIRf/jvOvF6C8KxR6OK2lXMktE6y
	 op/KKva/v0i1zEkZ+ynGkafR39WtxXETbErAR/lbr1w/XSzlhHTzigeWj7MDfoJleZ
	 mArTbVKENievzAd9bOUpgyIq/HDeNZ/yPdD3KcVxOl9GiTuFBfGcGTUeL/fXt5EgmS
	 Xp2Mqnwcwhtxg==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so874888f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 23:53:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEr4GjcKrPtq6qE7mroGOlENiLu7d5u9A/A6xCtXIbtVWBfaXEubCpH601lF20UX2Q4r3UZe+/Eo6MnJ+neVYRcwSI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/tN2AtvC4qicf3LGtPxW+1MBa/41sIFc+JiyOCiEe+KxBeai5
	fJAxXkZ3aZhnbl9sbF47QPneypE/frvfxFkgbcbRMYqfTVJx35dcOKlBbyms9fLHN+hOSDYow/E
	S+gpci5gYXqS5e97fRwaWs755MndXY3c=
X-Received: by 2002:a5d:5d07:0:b0:48f:e879:5890 with SMTP id
 ffacd0b85a97d-49c727d1ea8mr4317788f8f.32.1794556413956; Thu, 12 Nov 2026
 23:53:33 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-probes-in-lrsc-v3-0-a95089852a17@mobileye.com> <20261112-probes-in-lrsc-v3-1-a95089852a17@mobileye.com>
In-Reply-To: <20261112-probes-in-lrsc-v3-1-a95089852a17@mobileye.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 13 Nov 2026 15:53:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ9hBeHV_gwTgRpJTYLm4G_dNgdD3Qy6W7eJjpox=YUEw@mail.gmail.com>
X-Gm-Features: AclHuK8fCN6hKllkO0ilkI7l-Lsw-a941NZB2lA8LguINRyjsCRWTEqXNvF9Gng
Message-ID: <CAJF2gTQ9hBeHV_gwTgRpJTYLm4G_dNgdD3Qy6W7eJjpox=YUEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] riscv: kprobes: fix out-of-bounds read in riscv_probe_decode_insn
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pekka Enberg <penberg@kernel.org>, 
	=?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:02=E2=80=AFPM Vladimir Kondratiev
<vladimir.kondratiev@mobileye.com> wrote:
>
> riscv_probe_decode_insn() can trigger an out-of-bounds page fault
> when probing a 16-bit compressed instruction at the end of a page.
>
> arch_prepare_kprobe() safely reads 16-bit parcels into p->opcode, but the=
n
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
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 9e2afabf94e8..63ee5066def5 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -85,7 +85,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>                 p->opcode |=3D (kprobe_opcode_t)(*insn) << 16;
>
>         /* decode instruction */
> -       switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
> +       switch (riscv_probe_decode_insn(&p->opcode, &p->ainsn.api)) {
Yes, using &p->opcode is correct.

Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>

--=20
Best Regards
 GUO Ren
