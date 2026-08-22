Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DD175A9C;
	Sat, 22 Aug 2026 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407925; cv=none; b=B0u94ojEAPrShkAAA7G6Jo7afCoLKQc+fB7+CTlymozGOo+G+h3tegvjiXSZ3rnIoOdc/P4ncoXVR6faFbZ2ESsu+hc0yA55hs2UYJv8Z85ESpCVoZPd6dP/HH8MQU1hgYBNMubR1tIt9zLnq7EMGqZdDYCPK6NddOyyG/W8S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407925; c=relaxed/simple;
	bh=ds26tb4uA8xP7XUX1tlIMQRHDDM8pBEN4qtLpUGFl0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JSKBdh2MopNuyKEFxhm/nDxNyJXm/46lvCXJFncYSgGdgG1B1y+KW1iK4ALBIjODLZV1HR4yndkUjCB/YcMSA/WD1IFb8pmaeWqo5ykVzydEC1cH8AFXl+M8qHwBnUxHrOObirYk9jYAYWSDkCBvAKvceRMcrNywVyVFWIGMuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVuSw91g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVuSw91g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EAF1F000E9;
	Sat, 22 Aug 2026 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787407923;
	bh=3goj8r7jgCLFPzle5xic4wzdoQFVA2hJmgZFK0qieww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVuSw91gPQ3MQ/NMt8M14Kaxb/Ja304f7zpdv+vigRuImi94QCPzSZjd8fJuw3e4F
	 FTH5s2Cki5wq1VEh0lCNh30cxGtRFZBtL9LcD+aWMgc5ZBxtLZOQdIVs1XYPjuNyG+
	 pIWIF2vH4n/wg8hGvN2apap03DCzUe55MFEwr2M6TrvjIs9hMdxqt7vosc7+d0HSP1
	 HEZXWgzV8/Ef8/UwYEvjWMN13y9GQZbTtdAMoyaVqCqYGM4He3Nat/DyGspITFXdyG
	 /3VDhXmnSUR08u7iud9SCCTmUkL6CBxFXU+Bs/7UFVvg4DNAFgq2wyTFnxyve543e5
	 4P50rYvD/dEhQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/9] arm64: module: Combine init and core PLT
 entries again
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260822135323.795946-19-ardb+git@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-19-ardb+git@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:12:03 +0000
Message-Id: <20260822141203.81EAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The check `s->st_shndx !=3D SHN_UNDEF` incorrectly skips PLT count=
ing for special symbols like `SHN_LIVEPATCH` and `SHN_ABS`, breaking livepa=
tching.
- [High] Combining core and init PLTs breaks module loading if `execmem_spl=
it` fails and falls back to an independent memory allocation.
--

--- Patch [8]: [RFC PATCH 8/9] arm64: module: Combine init and core PLT ent=
ries again ---
commit 9e8ee18408a9e3b59ec81f693240a4dd9c7669a3
Author: Ard Biesheuvel <ardb@kernel.org>

arm64: module: Combine init and core PLT entries again

This patch consolidates the core and init PLT sections into a single array,
operating on the assumption that .init.text and .text are now always placed
within direct branching range of each other. It also eliminates the need
to allocate PLT entries for intra-module cross-section calls.

> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-p=
lts.c
> index bde32979c06af..e30876b90e306 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
[ ... ]
> @@ -169,17 +167,17 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf=
64_Rela *rela, int num,
>  		case R_AARCH64_CALL26:
>  			/*
>  			 * We only have to consider branch targets that resolve
> -			 * to symbols that are defined in a different section.
> +			 * to symbols that are not defined in the same module.
>  			 * This is not simply a heuristic, it is a fundamental
>  			 * limitation, since there is no guaranteed way to emit
>  			 * PLT entries sufficiently close to the branch if the
>  			 * section size exceeds the range of a branch
>  			 * instruction. So ignore relocations against defined
> -			 * symbols if they live in the same section as the
> +			 * symbols if they live in the same module as the
>  			 * relocation target.
>  			 */

[Severity: High]
Does this safely account for memory pressure during module loading?

While this patch expects .init.text and .text to be placed within direct=20
branching range, kernel/module/main.c:module_memory_alloc() attempts to=20
enforce this by using execmem_split().=20

If execmem_split() fails, such as a mas_store_gfp() failure under memory=20
pressure, module_memory_alloc() falls back to an independent=20
execmem_alloc_rw() allocation. Because MODULES_VSIZE on ARM64 is 2GB,=20
couldn't this fallback place the init section more than 128MB away from=20
the core section?

If that happens, intra-module calls would exceed the architectural range.=20
Since this patch removes the PLT entries for them, wouldn't the module=20
load fail with a WARN_ON in module_emit_plt_entry() and abort the load?

>  			s =3D syms + ELF64_R_SYM(rela[i].r_info);
> -			if (s->st_shndx =3D=3D dstidx)
> +			if (s->st_shndx !=3D SHN_UNDEF)
>  				break;

[Severity: High]
Will this skip PLT allocations for special symbols like SHN_LIVEPATCH and=20
SHN_ABS?

When a livepatch module is loaded, its symbols are marked with SHN_LIVEPATC=
H=20
(0xff20) by objtool. Since SHN_LIVEPATCH is not SHN_UNDEF, this check evalu=
ates
to true, breaking the loop and skipping PLT allocation for these symbols.

Later, when klp_apply_section_relocs() attempts to apply the .klp.rela.*=20
relocations against vmlinux, out-of-range branches will need a PLT entry.
Since none were allocated, won't module_emit_plt_entry() hit the WARN_ON=20
for exceeding pltsec->plt_max_entries and abort the load with -ENOEXEC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822135323.7959=
46-11-ardb+git@google.com?part=3D8
