Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9003C8C52
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139384; cv=none; b=EoLSOzv2CIfAgE90VFbYZl7RYdZhistvh7kpoxdCt3o1eXn0lHNXTVczhYBZVXLpxV9gRCv/vCuGL72yxIcLvbmnF5slkPEvGyUUn/wnwYJB7cPGhqhYNAMfUM2yZ29Xc/1EbCGEc36b786B61fxf6AWbhRTyGINZXlEXCZtEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139384; c=relaxed/simple;
	bh=8wKfA7PX1+MB12wp2/EVuDghcFS8msMlGjp+YhLI9XU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CrftsmQPzKynXKOdjKhE5PvceJ8N+/dvMqstdaHRbKoCvAj3Yxu2chto8o4QOILNI9t5oa6zaotXUbuADpm+6qwXpnd3tZrCR0/TzGWLa+2rL4mMi+K9WYZwEN+nxnDIvD9mKzVsjPRAI5IAyHO7Z1bgHn0W2/YXBS5U1vRi0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TunQZs1z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TunQZs1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C921F000C4;
	Fri, 16 Oct 2026 08:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792139383;
	bh=1CS1MbrltBzJ43ftSHHMKEO91sWrbdWs2cWcE6CrDYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TunQZs1zGwK6F+GGvDWPkX6PA1Nn8L1ZBEjLFikM8WvMrVqyUs32bqGUZOchAJjHg
	 008yPuNRe2yUlJ/FodX1Ao7Furp6c3KVZfDRRf9xIWR/le+oG0Ee8VzDJc1hlUxolh
	 UiEdfbwVfs5KCl9hXswqO170lN2WQlkGwKZWl0cFHxdYZQdQhOy4H3cHa50ukmgCSR
	 YY8alBeAcmIZZ+nov45rsHu9F4+ucJ1R4694JesTwWEJIEeKfpyl40qBXX6fm02GDI
	 424oFXqhtLyvNnNrELg79o1oyKrKPE/XLyQca7i70aCRYbEXcXyBLQjVJYqS8UcpNz
	 hicGDgKom34XA==
Message-ID: <sashiko-outbox-174019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] riscv: kprobes: reject probes inside LR/SC
 sequences
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaofeng Yuan" <yuanxiaofeng@eswincomputing.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261016081706.1085-2-yuanxiaofeng@eswincomputing.com>
References: <20261016081706.1085-1-yuanxiaofeng@eswincomputing.com>
 <20261016081706.1085-2-yuanxiaofeng@eswincomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 08:29:42 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] riscv: kprobes: unsafe 32-bit read in riscv_probe_decode_insn can =
page fault
--

commit 6f940578d2f096970e9abd6cc2894de008e29f6f
Author: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>

    riscv: kprobes: reject probes inside LR/SC sequences

This patch rejects kprobes placed inside LR/SC sequences or on the LR/SC
instructions themselves to avoid livelock. It updates riscv_probe_decode_in=
sn()
to reject the instructions and adds instruction walking logic in
arch_check_kprobe() to reject addresses within a sequence.

[ ... ]

> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/p=
robes/decode-insn.c
> index 433d9035b8882..e6a8894677b10 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -23,6 +23,8 @@ riscv_probe_decode_insn(probe_opcode_t *addr, struct ar=
ch_probe_insn *api)
>  	 */
>  	RISCV_INSN_REJECTED(system,		insn);
>  	RISCV_INSN_REJECTED(fence,		insn);
> +	RISCV_INSN_REJECTED(lr,			insn);
> +	RISCV_INSN_REJECTED(sc,			insn);

[Severity: High]
Does evaluating these macros rely on the insn variable, which is read
unconditionally as a native 32-bit integer earlier in the function?

arch/riscv/kernel/probes/decode-insn.c:riscv_probe_decode_insn() {
	probe_opcode_t insn =3D *addr;
	...

If addr is 2-byte aligned, will this native 32-bit dereference perform
an unaligned memory access, potentially oopsing on RISC-V hardware that
lacks kernel-mode unaligned access support?

Furthermore, if addr points to a 16-bit compressed instruction at the
end of a mapped page and the next page is an unmapped vmalloc guard
page, could this 32-bit read cross the page boundary into unmapped
memory?

Would this trigger a kernel page fault and panic when tracing tools
register a kprobe at such an address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016081706.1085=
-1-yuanxiaofeng@eswincomputing.com?part=3D1
