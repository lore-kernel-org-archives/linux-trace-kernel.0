Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC634FF79;
	Sat, 22 Aug 2026 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787407996; cv=none; b=gvOnCfOQnMnWfXe0CEBvMmrbSWHoJC7H/5l4tJSXH61a7Jqqr8GwqYxb+CAU6a1PW5zfReH2EUDcbkD1rTFEH7j2ynMMVTYY6xeixLXUwUwLv17riiQYmjVB8B3y8xR2Er1IbulisKorA9/KGkRKkvn9xkk2EwF9Yx1+wR0+P24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787407996; c=relaxed/simple;
	bh=bFaCMEB66d+Vc/kXWt1AUlH3GY49tiPitno+Y0b7l3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GxDZmTYVW5Uje6jyRTvZmVvxcusGC2ozZyrYUKW6dO9iAO5w3mW/+K1W+htTbCM8NOcpzs+UZ2JaFFytlMpdAjw7XLv0yYG3nhzsJvtt92sGsR2WBe3BAG9Ka64tImgJ7Qwsd9dQ/7SjV5bUiW/4/72kYSt57gaa5f4vwlkGJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG28AUUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG28AUUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464241F00A3A;
	Sat, 22 Aug 2026 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787407994;
	bh=p44FKbbiBIZr4bCU0hlrmcZmibvUdqFBgy23qECxnyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mG28AUUXWDaco5ZHhQUP656wTS0uMYvfYF3t6pv0l8+TG9Rx2SCr6+Mvc8tqErJlj
	 E9pIlwMAGf9om5QKnczIDe2F8uVu93SWL3Jaj/cAEL6VZU0MiNuB6cn/rHUHZE8PhH
	 pEph4WEgqZJ2RD9YymAlTzA0wa+Oe04xhoVHWJ7w7/bMmY1DFCW/t4NPfdb/0eftjY
	 qFDqxBfs3aajXAd0LljZIymP6S2e9dSBbQW3a3WFR5ZHSbC5WvGp6naVHJyoNk8aBl
	 xh01YKImx9PME/AouSdyZlctGKSAjTFWjjar94phQxovmXCX3zLVRA/3nF1i8vc2ki
	 +Cq4spw7XHpVw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/9] arm64: Enable the execmem ROX cache for module
 text
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260822135323.795946-17-ardb+git@google.com>
References: <20260822135323.795946-11-ardb+git@google.com>
 <20260822135323.795946-17-ardb+git@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 14:13:13 +0000
Message-Id: <20260822141314.464241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `execmem_fill_trapping_insns()` writes trapping instructions using=
 `memset32()` with a host-endian constant, producing incorrect/unallocated =
instructions on big-endian ARM64 kernels.
- [High] `execmem_fill_trapping_insns()` fails to synchronize D/I caches to=
 the Point of Unification (PoU), potentially causing execution of random un=
initialized garbage.
- [Low] The function `system_supports_bbml2_noabort()` is called but is com=
pletely undefined in the kernel tree.
--

--- Patch [6]: [RFC PATCH 6/9] arm64: Enable the execmem ROX cache for modu=
le text ---
commit 9f2855ae0653215694678b01c1ed088b2dce033c
Author: Ard Biesheuvel <ardb@kernel.org>

arm64: Enable the execmem ROX cache for module text

This commit wires up execmem ROX cache support on arm64 for module text and
init.text regions. This allows these regions to be allocated from a single
chunk of memory in subsequent changes.

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3b9e1b8de6cbd..40088d362f6c7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
[ ... ]
> @@ -557,9 +558,25 @@ struct execmem_info __init *execmem_arch_setup(void)
[ ... ]
>  	};
> =20
> +	if (!system_supports_bbml2_noabort())

[Severity: Low]
Does system_supports_bbml2_noabort() exist in the kernel tree? It appears
this might cause a compilation error due to an undefined reference.

> +		execmem_info.ranges[EXECMEM_DEFAULT].flags |=3D EXECMEM_NO_HUGE_VMAP;
> +
>  	return &execmem_info;
>  }
> +
> +void execmem_fill_trapping_insns(void *ptr, size_t size)
> +{
> +	memset32(ptr, AARCH64_BREAK_FAULT, size / sizeof(__le32));

[Severity: High]
Does this correctly handle big-endian ARM64 kernels?=20

Since AARCH64_BREAK_FAULT is a host-endian constant and instruction fetches
are strictly little-endian, it looks like this might write an incorrect byte
pattern and execute unallocated instructions instead of the intended trap if
cpu_to_le32() isn't used.

[Severity: High]
Does this missing cache synchronization allow the CPU to fetch stale
instructions?

Writing instructions as data requires cleaning the D-cache and invalidating
the I-cache to the Point of Unification (PoU) (e.g., using
flush_icache_range()). Otherwise, the CPU might bypass the newly written tr=
ap
instructions and fetch garbage from physical memory or the I-cache.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822135323.7959=
46-11-ardb+git@google.com?part=3D6
