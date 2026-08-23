Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F083D333D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787488071; cv=none; b=kmUsltlRpFjN0pzIbpGhMmu5H894IZFzYuFJFQ/ADxEWtruzqgEK5Ntd5HC9OM2bzDwxkmTiTdfInW/DSjxCKJI8jIRRgnJWBNmGC1Z3XDwfFWSGjZu65cJxsM2N4ZuiwWXQSNpON5hRMuElCUsiUBmzxyPtp4rlb+5aWJ0PedA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787488071; c=relaxed/simple;
	bh=tTNq8P+fuO5bU2IKcg6ttbO2AqRa/bmZPe5yzpkIYLs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RwaoGEEXw1/K2Utr71Sy9JAg9PORSMe74O9QyIEg7sW1ZQhypEVwFvLIaLxDZEwuhaFwyY0pGPL3oLpSAdwIGfrLMX95jbNQBCd6W/jpKrVTQ7fAeA1/3p2N3b2GLKlFajOKbuVkJ9iN93F48K5YBGd2KFI4Py9WMs7A8hBCtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBdvsXx1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBdvsXx1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6E01F000E9;
	Sun, 23 Aug 2026 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787488070;
	bh=wQcBZ7zZN1RahbAFZ6QlF3Vfp+cQaV2Qml2t489gnhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBdvsXx1Y1ey01S4c7wW+lt4NWAE8lsP/Fm4SPWG/rFJZEyHCPGc9s3tRkjXWDMow
	 KTBayJGcKUm2dq65XCMO3twgadz6Hk5vWEWfvuxLwGLll7ymW7m5Djs/e0WgWPR3bQ
	 z3I3qZb5/k+nMtY56EJ++cN9Rzgh7V/AJ4NECZqUNh8c5pRxpRct+0nNIiliMT4wU4
	 Bg5sPX40YQdl4ZgIuSJGjZpn6XtDwJnVLKOR676kpXCgijO6RVBEFt95POM7us25xP
	 bYVL1/c+qx8kPyGq0OxDxniWF7xWGWVdyeOTYu/6oDA3DefpSiB5onNTugNsPkKKEg
	 5p/L6R9pPDvJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] userfaultfd: constify VMA parameter of
 userfaultfd_*() helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-2-3086981b33cf@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-2-3086981b33cf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 12:27:49 +0000
Message-Id: <20260823122750.0E6E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete API refactoring: userfaultfd_wp() mock in VMA test frame=
work was not updated to take a const VMA.
--

--- Patch [2]: [PATCH 2/6] userfaultfd: constify VMA parameter of userfault=
fd_*() helpers ---
commit 6a82c674bb78b012b867cde9192fff955e6adee6
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

userfaultfd: constify VMA parameter of userfaultfd_*() helpers

This patch constifies the VMA parameter for various userfaultfd helper
functions. These helpers only read from the VMA, so this change ensures
const-correctness without affecting functionality.

> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index a4351cffc60ce..3396d270b159d 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h

[ ... ]

> @@ -204,22 +204,22 @@ static inline bool uffd_disable_fault_around(struct=
 vm_area_struct *vma)
>  					VMA_UFFD_MINOR));
>  }
> =20
> -static inline bool userfaultfd_missing(struct vm_area_struct *vma)
> +static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
>  {
>  	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
>  }
> =20
> -static inline bool userfaultfd_wp(struct vm_area_struct *vma)
> +static inline bool userfaultfd_wp(const struct vm_area_struct *vma)
>  {
>  	return vma_test_any_mask(vma, VMA_UFFD_WP);
>  }

[Severity: Low]
Does the mock definition of userfaultfd_wp() in the VMA test framework also
need to be updated to take a const VMA?

tools/testing/vma/include/stubs.h:userfaultfd_wp() {
	static inline bool userfaultfd_wp(struct vm_area_struct *vma)
	{
		return false;
	}
}

Leaving this mock out of sync with the actual kernel API might break the VMA
userland test suite build (due to a "discarding const qualifier" warning) if
future code passes a const struct vm_area_struct * to this function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823-uffd-vm-fl=
ags-v1-v1-0-3086981b33cf@kernel.org?part=3D2
