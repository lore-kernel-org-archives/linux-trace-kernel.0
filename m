Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798647;
	b=w5Or3WGJowSmzX7bazBQ8zUD/OQAuWbrDhKfgPfBdOV/yijT3hxUFmU2DF5D7JOTSNip
	 BiBR37BP/uxjAMhT0Ru1K2vuKFjSEADMjNFvwDCXWeeWkYj0q31JHW3dij9bhnDznsF/5
	 IGon+ud4x2lSGkrdYwihmam/6+AIuJkfeCBfP4VL03vY7ED/c3RMplW09eozrOqEE8hyX
	 NRk/B6OG/WyBcqAL3uVCUNftXnGUtLbikqscxDOrHJ33GsUvHiR5O84Mfr77Ozz7Nuv9k
	 qSiNgmsIURNRUiU21A5HA/zcIIRrFnWHI8nrbqfWgpkZHmAIE8V2uCok2GRM74m9Xeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EmVZxI9Aq8CZWDWgL8lGxCljqnSPq9AvM1t6+TDcGwE=;
	b=pwPwvgCcXs9qwPZsqjsQpFsgOHsFaolx9T0CQ1PwiMCX8hZhfZmJcWSL5z5z37B1MdDW
	 L3hiSf1Mw4rVYn31OVx2CGeZC6INABGp7lqvX59MgVg9f0nBoGnvXBoXKYZdBH+kPMs85
	 xckJyhPFpC8vzh0MBBBNK39BtOm3Z2a4TWPiYuNtA943jrPM/uyUFCIAH7XgHVaf/gVky
	 M1ROC2+Uhc4eByYfGbc5HxCc847pNsRCTcHBrQu4wVpeiTIX/hV6HPVOGqukIF3zl0kiW
	 eYeJFFl45XmrtIS+BbbrRVMk2M37wRgfsY7Wd5iG/F3riqzm3A1HRawyG2wHo9Mycjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMFesxkv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B453606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aMFesxkv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF1B1F00898;
	Fri, 27 Nov 2026 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798646;
	bh=EmVZxI9Aq8CZWDWgL8lGxCljqnSPq9AvM1t6+TDcGwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aMFesxkvxGNM2V6OxWrfaDOfQxn2Kn0bRaNFycF5W4qx0ZwNU0v0qLZm/5ST+EAR/
	 67yKVWcZKn/sV4AbHR0HDQcvPXN8gGaA2OLiHQd5mlvUvZIDWKdBDJCv+e7rHSAFDP
	 XdT9x/KpB3aFK9a3O0eXfD6FbkfAp7wEJ3JkH0pch0rIUbDsCAefdxHSr+z0rj5Imp
	 BxsAsSez5SlpINEmB/oqJpfHUZYn5iIzMQLgh81RFThH8u1p6cM3lzQ6mx78MeYnF8
	 jJd/5/8lnEah5hUUxlLC2CZonjgvZbPsjEvxMxUG210wTupFP2i8vL7UcQo8Foo/hU
	 Hf+MYUDjdDzaQ==
Message-ID: <sashiko-outbox-237953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] media: Add tgid and fd fields in v4l2_fh struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261127-v4l2-add-ftrace-v4-3-24138479002f@collabora.com>
References: <20261127-v4l2-add-ftrace-v4-0-24138479002f@collabora.com>
 <20261127-v4l2-add-ftrace-v4-3-24138479002f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:57:26 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] media: v4l2: file descriptor 0 overwritten with -1 in
  __video_do_ioctl()
- [Low] media: v4l2: mismatched tgid and fd across processes in
  __video_do_ioctl()
--

commit 85c2231f2b1b5eff1384b64415c724ad919f3c23
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: Add tgid and fd fields in v4l2_fh struct

This commit adds tgid and fd fields to struct v4l2_fh, recording the
opening process's tgid in v4l2_fh_init() and resolving the file descriptor
in __video_do_ioctl() for tracing.

> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 17ba1ae707355..29ca2f7959efb 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c

[ ... ]

> @@ -3063,6 +3064,16 @@ void v4l_printk_ioctl(const char *prefix, unsigned=
 int cmd)
>  }
>  EXPORT_SYMBOL(v4l_printk_ioctl);
> =20
> +static int _file_iterate(const void *priv, struct file *filp, unsigned i=
nt fd)
> +{
> +	const struct file *fh_filp =3D priv;
> +
> +	if (fh_filp =3D=3D filp)
> +		return fd + 1;
> +
> +	return 0;
> +}
> +
>  static long __video_do_ioctl(struct file *file,
>  		unsigned int cmd, void *arg)
>  {
> @@ -3111,6 +3122,12 @@ static long __video_do_ioctl(struct file *file,
>  		goto unlock;
>  	}
> =20
> +	if (unlikely(vfh->fd < 0)) {
> +		vfh->fd =3D iterate_fd(current->files, 0, _file_iterate, file) - 1;

[Severity: Low]
Can vfh->tgid and vfh->fd belong to different processes if the file is
inherited across fork() or passed over SCM_RIGHTS before the first ioctl?
v4l2_fh_init() records current->tgid at open() time, whereas iterate_fd()
looks up vfh->fd in current->files of whichever process issues the first
ioctl, breaking the documented struct v4l2_fh contract that @fd belongs to
the process in @tgid.

> +		if (!vfh->fd)
> +			vfh->fd =3D -1;
> +	}

[Severity: Medium]
Does the !vfh->fd check overwrite a valid file descriptor 0 with -1?

_file_iterate() returns fd + 1 on a match and 0 otherwise, so subtracting
1 from iterate_fd() already maps a missing entry to -1 and fd 0 to 0.
When the video device is opened on fd 0, resetting vfh->fd to -1 records
the wrong descriptor for tracing and causes every subsequent ioctl on this
handle to repeat the iterate_fd() scan.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-v4l2-add-f=
trace-v4-0-24138479002f@collabora.com?part=3D3
