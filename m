Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE55582BAD;
	Wed,  9 Sep 2026 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971533; cv=none; b=XNag6qsbarmKPMDKwt3pghG+XUDV6IqnT0dIn7PvaIcj5Y6DCpJw3A44IrpV4QcP2s3kF5uN7/9mmVLC+L0HuttCLMN4K2/CEuLTewljue1leN4jJttd8H+jDLpgBU4wHrZAjMZoSXnreLvAbOLup7d+c+4cr4GQkJOLByi3he4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971533; c=relaxed/simple;
	bh=2nSEuaJsEC2Ji1FLee2Ctn4KAUGv6K2n3B6kzSTMdUo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hArV0kf2V4iWX4nJ73PICjbGo058FmxSGAuxlpyaqB/S6+ET4kMM5ScdAdmIGfkimjua3vIxShxUBU2jVoBYaG536pOMmbGgfd60H7bF1F4wRejET4m/CuoTEmldgNmCmikjdrazcDB125vJAiE6OQ1TedY0w7vlt/bRqw0SJVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1MDOxOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1MDOxOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF521F000FF;
	Wed,  9 Sep 2026 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971531;
	bh=4SKUtPs8a80QUZEjrbIxEcVDtl2+iAWi22AK5QJBWqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1MDOxOtc21xwKh7SHFCTEztlajLCD7N9/Ve1DrFhoeMQxuNxh2PqZXAJxX1r+4Nn
	 HNJ3c6i7HQVb6Kg89epC4wfqi3MmDgJd9ARqZOHdtN0F242ipnT7NAoMxAKQEZ5y5q
	 vj5cGGwG7yCeV44vEqbIy2q0TSv6vQFK+jr2K7CmogYHEv3ydj6DrwMVrO47/FZ+Je
	 kgMK2IH4d4s/VSUv7q6dKKpnc0StSk3ltwcZwv5BO6zFFVgOqPn3Lub2eXzkukXtvp
	 mEIGtWSUkwHGrMKpjKpusOco52BxNYVIwBf/+KhHsPsVypS9F7jmPK62wjXgLKyTA4
	 IZfP/oiq7ND/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] dmaengine: add union chan_dev for dma_chan::dev
 for clarity
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-trace-kernel@vger.kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, linux-sunxi@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260909-dma-chan_dev-rename-v4-4-d8fb6892a70f@nxp.com>
References: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
 <20260909-dma-chan_dev-rename-v4-4-d8fb6892a70f@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:32:10 +0000
Message-Id: <20260909163210.DFF521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Kernel-doc build warning introduced by removing the `@dev:` documen=
tation tag while retaining `dev` in the structure.
--

commit 0443f99a737aae399ea7d93dad586cf7543a34af
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: add union chan_dev for dma_chan::dev for clarity

This commit introduces an anonymous union in struct dma_chan to provide=20
a chan_dev member alongside the existing dev member, clarifying its purpose=
 as=20
the per-channel device. It also updates the kernel-doc to document chan_dev=
=20
instead of dev.

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 33aa1bfc8fb84..c3a49a33307c6 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -325,7 +325,8 @@ struct dma_router {
>   * @lock: protect between config and prepare transfer when driver have n=
ot
>   *	  implemented callback device_prep_config_sg().
>   * @chan_id: channel ID for sysfs
> - * @dev: class device for sysfs
> + * @chan_dev: class channel device for sysfs, some device use it for per=
-channel
> + *            IOMMU mapping.
>   * @name: backlink name for sysfs
>   * @dbg_client_name: slave name for debugfs in format:

[ ... ]

> @@ -351,7 +352,14 @@ struct dma_chan {
> =20
>  	/* sysfs */
>  	int chan_id;
> -	struct dma_chan_dev *dev;
> +	union {
> +		struct dma_chan_dev *chan_dev;
> +		/*
> +		 * Use chan_dev; dev will be removed once all users are
> +		 * converted.
> +		 */
> +		struct dma_chan_dev *dev;
> +	};

[Severity: Low]
Does this removal of the @dev kernel-doc tag trigger a kernel-doc build=20
warning?

Since the dev member is kept inside an anonymous union for backward=20
compatibility, and the kernel-doc parser flattens anonymous unions, it=20
typically expects all non-private members to be explicitly documented.=20

Would it be better to retain the @dev documentation tag with a note=20
indicating it is deprecated, or mark it as private to avoid the build=20
warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-dma-chan_d=
ev-rename-v4-0-d8fb6892a70f@nxp.com?part=3D4
