Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1425221FB6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006144; cv=none; b=WNGG07Ts9QPUsCbNhR1CkSmPk7dhBxpxAgNq8Kor57Xwm3ZH793T4bwu8ILwLmDGAx91BDnDZMvTyWY5rOndFnJlmwFBZvA5yDX8kpzu9jE2py5BwPkW8Q75j2MRqXaNM+qo7EtztOyNhfK8Z66b55SdGyimp1TmyxSJbiC1Cik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006144; c=relaxed/simple;
	bh=w3GsU/32SdZg6gD+yZcjMwDl4O4mjr+t6QTTSbT9x/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GfI5epCOUu8wHt8hEvphODS1DIoNWVQkwT17BzNwpvcYvRzR5za4dHGkHStga9klCQG27L0lf+9QXrE/Sr8HQvnvNfAcm+2B7qwiw+T6P0Mhk3T6ERHN8r/m4X206uCNhYgAIsJ6SlIDhuLjImbeHPSFVvKPMZc8se6UHUmuloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDenLpO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDenLpO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193961F000FF;
	Thu, 10 Sep 2026 02:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006142;
	bh=kA/bsVZVokfsn+DGy4FB0lPV4pzaPVriAuq0+Q8+72k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eDenLpO0/JjPgw91Tw6x4cDo4MwlRy3tuJW2MVhKdmho0rj0IlSnwxeV3As+ydxoZ
	 Fi79v4dBbH9lw0HgjUxPSoozhOGCdX7JK26Y6cRHc6y2wJ17iMZzLtdVhgVIIh+zfi
	 Oxlek2h+vKH2cq2LeJlH+KGrvyeMSMj1R0vL4g/mZYNmz7tNSrIo8tmjRgivyOtSfM
	 3FugSfVk8Xk+hzNrkPogvvGUqbSknImmfqHteLkUQ5FyiE8GdtFY+ezE6G8XBcUaHg
	 6X7NPHx7AMaA9A+xYfp01jV+G0Djr3TJ1AQHQP5BqnQ6z00c7FSM+ipa+5BirwOT0K
	 gDMR8jo/ykObg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] bootconfig: Fix integer overflow in initrd size
 check
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <178900557529.200943.11099215789605267709.stgit@devnote2>
References: <178900555453.200943.4719889510443114485.stgit@devnote2>
 <178900557529.200943.11099215789605267709.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 02:09:01 +0000
Message-Id: <20260910020902.193961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Mismatched boundary checks for XBC_DATA_MAX cause inconsistent f=
allback behavior for embedded bootconfigs.
- [Low] Misleading error message when bootconfig size exceeds XBC_DATA_MAX.
--

commit a24325c6fe0374f1cfc3fc8cbe63efbad0f22f32
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

bootconfig: Fix integer overflow in initrd size check

This commit fixes an integer overflow where a crafted initrd with a huge
bootconfig size can cause pointer arithmetic wrap-around. It ensures the
initrd bounds are respected and verifies the size does not exceed max limit=
s.

Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel=
.org/

> diff --git a/init/main.c b/init/main.c
> index a9362b2cc258a..de24c41ce815e 100644
> --- a/init/main.c
> +++ b/init/main.c

[ ... ]

> @@ -294,16 +295,21 @@ static void * __init get_boot_config_from_initrd(si=
ze_t *_size)
> =20
>  found:
>  	hdr =3D (u8 *)(data - 8);
> +	if ((unsigned long)hdr < initrd_start)
> +		return NULL;
> +
>  	size =3D get_unaligned_le32(hdr);
>  	csum =3D get_unaligned_le32(hdr + 4);
> =20
> -	data =3D ((void *)hdr) - size;
> -	if ((unsigned long)data < initrd_start) {
> -		pr_err("bootconfig size %d is greater than initrd size %ld\n",
> +	if (size > XBC_DATA_MAX ||

[Severity: Medium]
If the size is exactly equal to XBC_DATA_MAX, this check passes and the
function returns a valid data pointer. This prevents the caller from falling
back to the embedded bootconfig:

init/main.c:setup_boot_config() {
	...
	data =3D get_boot_config_from_initrd(&size);
	if (!data) {
		data =3D xbc_get_embedded_bootconfig(&size);
		...
	}
	...
}

However, setup_boot_config() uses inclusive inequality for XBC_DATA_MAX:

init/main.c:setup_boot_config() {
	...
	if (size >=3D XBC_DATA_MAX) {
		pr_err("bootconfig size %ld greater than max size %d\n", ...);
		return;
	}
	...
}

Because the limits don't match, an exact size of XBC_DATA_MAX causes
setup_boot_config() to reject the payload and abort without attempting
the fallback. Should this check use size >=3D XBC_DATA_MAX to match?

> +	    size > ((unsigned long)hdr - initrd_start)) {
> +		pr_err("bootconfig size %u is greater than initrd size %lu\n",
> +			size, initrd_end - initrd_start);

[Severity: Low]
If this error path is taken specifically because size > XBC_DATA_MAX, the
error message claims the bootconfig size is greater than the initrd size.
Can this message be updated to accurately reflect which limit was exceeded?

>  		return NULL;
>  	}
> =20
> +	data =3D ((void *)hdr) - size;
> +
>  	if (xbc_calc_checksum(data, size) !=3D csum) {
>  		pr_err("bootconfig checksum failed\n");
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178900555453.200943=
.4719889510443114485.stgit@devnote2?part=3D2
