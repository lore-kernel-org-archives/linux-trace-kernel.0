Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C662247DD5F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244995; cv=none; b=mfmTJqwDhlzDuAQRkyRegsLhSxuqCgGdUYys7QLC4d4i1ZrM3FCeYaHVoCEQsqkZqXxdgMAjZVxUdll4GZtuOZ0yfF2Wb8DaGIoq1TvEsOa+4duWVEa4MkxENGlsHKda50uHyalg3XKJktYv44IObeWP8OaJ6qtMkglU9Etc+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244995; c=relaxed/simple;
	bh=qgUuG6x2D01JeW1ls/KsraS0g/6Y2Buzfpo5t5rYHiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LDxFYp+3ajb7FvIKaVD1UJLBs3Wghh7mysldm0/xJMkvVz8zHU9IaUhS+/P6KFXjGMs9aaQxLqjzIGUr05+gVffjJDjK8HiiSeQLlYp4tuTPcC5RJey72fDqpwWuT9awEAhTpArz+3MPQXcuJ4Q0kO75y7yWwxmcbolwuTctiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjJMg2pn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjJMg2pn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5066B1F00A3A;
	Thu, 20 Aug 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787244993;
	bh=iPHR41ed3HrVv7Bd05PHkb8iYM4KBufv6i8VC+xyx3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjJMg2pn+yRtBtC/H3l6tHH2PJXW/qmqVKgTFuCClAlRBrdsjGzj5krw4WXpOVDRE
	 I9+pEAKoMgJfRIfhoWCow2DYieG7QZqcToj8qMM+UyRlPcgv9Zgvlyy/mcb3h7S4PG
	 u9ZLgT/mwO1MyKGOyYeycDkjGBhPr1ylUsE4RoVafA1WgCgPJ7jjY3URmxev7SKNeF
	 1S69WBoseGodJaO5mqkGV2U/xRK8+L1Mb2yM7WWPG+abNDB9ZxmqP4ZgN7vnqBIJqK
	 JsoM2NOCSvTH5GW5Un7+14gC+fpGTNaxUpLOVTy1ZWaD0KETdOpZBCdUL0OHip17Qb
	 41r22tHmYia2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] selftests/verification: Add tlob selftests
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <c1305284e09e0522c5c88e8ebf4a0f6e59541999.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
 <c1305284e09e0522c5c88e8ebf4a0f6e59541999.1787243842.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 16:56:32 +0000
Message-Id: <20260820165633.5066B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Using `$(nproc) - 1` to determine a target CPU ID assumes that C=
PU IDs are contiguous and start from 0, which breaks on sparse affinity mas=
ks or offline CPUs.
- [Medium] The ELF parser in `tlob_sym.c` lacks sufficient bounds checks wh=
en validating headers and iterating over sections, leading to out-of-bounds=
 memory accesses.
--

--- Patch [8]: [PATCH v6 8/9] selftests/verification: Add tlob selftests ---
commit cb49807af49abc34cb32dee7d7e1d06575cff80a
Author: Wen Yang <wen.yang@linux.dev>

selftests/verification: Add tlob selftests

This commit adds seven ftrace-style test scripts for the tlob RV monitor,=20
covering uprobe binding management, budget violation detection, and per-sta=
te=20
time accounting. It also includes a standalone runner and C helper programs=
=20
for target execution and ELF symbol parsing.

> diff --git a/tools/testing/selftests/verification/test.d/tlob/uprobe_deta=
il_waiting.tc b/tools/testing/selftests/verification/test.d/tlob/uprobe_det=
ail_waiting.tc
> new file mode 100644
> index 0000000000000..798a04012b6ea
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/tlob/uprobe_detail_wait=
ing.tc
[ ... ]
> +start_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_preempt_wo=
rk 2>/dev/null)
> +stop_offset=3D$("$TLOB_SYM" sym_offset "$UPROBE_TARGET" tlob_preempt_wor=
k_done 2>/dev/null)
> +
> +# Pick the last CPU to avoid cpu0 which is used by vng infrastructure.
> +cpu=3D$(($(nproc) - 1))
> +

[Severity: Medium]
Does this CPU ID calculation safely handle systems with sparse CPU affinity
masks or offline CPUs?

If a system has non-contiguous CPU IDs (for example, if CPU 1 is offline but
CPUs 0 and 2 are online), nproc will evaluate to 2. This calculation would
yield CPU 1, which might cause the subsequent taskset commands to fail with
an invalid argument error since CPU 1 is unavailable.

> +echo 1 > ../events/rv/detail_env_tlob/enable
> +echo 1 > ../tracing_on
> +echo 1 > monitors/tlob/enable
> +echo > ../trace
[ ... ]
> diff --git a/tools/testing/selftests/verification/tlob_sym.c b/tools/test=
ing/selftests/verification/tlob_sym.c
> new file mode 100644
> index 0000000000000..2d9561331d2f9
> --- /dev/null
> +++ b/tools/testing/selftests/verification/tlob_sym.c
[ ... ]
> +		for (int pass =3D 0; pass < 2 && !found; pass++) {
> +			const char *target =3D pass ? ".dynsym" : ".symtab";
> +
> +			for (si =3D 0; si < ehdr->e_shnum && !found; si++) {
> +				Elf64_Shdr *sh =3D &shdrs[si];
> +				const char *name =3D shstrtab + sh->sh_name;

[Severity: Medium]
Is there a risk of an out-of-bounds read when accessing the string table
here?

It appears sh->sh_name is used as an offset into shstrtab and passed to
strcmp() without bounds checking against the actual string table size. Could
a malformed binary cause a segmentation fault when the tool attempts to read
beyond the mapped memory?

> +
> +				if (strcmp(name, target) !=3D 0)
> +					continue;
> +
> +				Elf64_Shdr *strtab_sh =3D &shdrs[sh->sh_link];

[Severity: Medium]
Could this array indexing access memory outside the section header table?

The sh->sh_link field is used directly as an index into shdrs. Since there
is no verification that sh->sh_link is less than ehdr->e_shnum, a malformed
ELF file could cause the tool to read arbitrary memory when mapping headers.

> +				const char *strtab =3D (char *)map + strtab_sh->sh_offset;
> +				Elf64_Sym *syms =3D (Elf64_Sym *)((char *)map + sh->sh_offset);
> +				uint64_t nsyms =3D sh->sh_size / sizeof(Elf64_Sym);
> +				uint64_t j;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787243842.gi=
t.wen.yang@linux.dev?part=3D8
