Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633150;
	b=WlctEvFDaPLZWtK3mvJDsXISLiPbUuuSELFz4zXuAk6RtGxnOWtD4RjQo8U/WV5i0LXU
	 ABtH8saH7q7jYnEoO/Bo39ymVgUX0HescLaEqnzTWcEaXDVXPOhQDojJbyLjQTGzRMeHr
	 iZMQWb3igJkZe5wZw1OWAxczga9beHHy9iKxcQ2cQC2AEUcziIfcokU/EOlCfWjXNwJ5n
	 8S520AcdQl7cEJPYbrpQe4iSTOsVxCtg15pR03EQYNFrRmAB/jEglWIZO/kLXrjIpMjo/
	 d2JT+NC0B65ACmzptXbFNv51/Rw9F0VyPS+dFFiC39j5rAR6GIJL34x9ARJDebXRtcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Hd8RyLjbUGxi/bqv3N8S9ii2w4FgLse5+gFtdBQPMts=;
	b=plSzXblsTsbbQhxd7d966D086pLqUIssi835gyoedidz7/empIsPlf73t20yEKRxVU+P
	 dbf2KOp4LqhFyGYgs06i5gKseNRRJ2eAHU6kV3TneZK2KWhwegtPRX+gp6hYPTcmRs1KN
	 dm6o2BNPPdr+IIk5Iaaluv77dYphskHC1rbX9nvJJeeKiOv4pjuIrn8e8QqsmvbC+YFqh
	 yoQxzFkOYDteFhe7VZw+4pfr7j6ghf32sNQH0FxfgAUCQLeFDuF0Qyw3/r/dwcQ1VEdL7
	 az32nqw3rWX7o5W9B4O/e0kcG83gcZJQAJQ3R8G4UxA8AOWj1YaEKKCPCVBvJBK15/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaomJgk6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E1606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaomJgk6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63681F000C0;
	Wed, 25 Nov 2026 18:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633149;
	bh=Hd8RyLjbUGxi/bqv3N8S9ii2w4FgLse5+gFtdBQPMts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaomJgk6Mg5UXG2oJf7yyzrVoIpHdfe030lcOS5nWiz3dc5nu+cZEFsL3EVNG4xZ0
	 FAtOl2mS43umLMZ0uP3ylh9aXPU4q3kaZ3zBf9rDG13cP70U5gggPnqRaTLrEK8J2q
	 btZ8Fv7PhEwq63aaWyiTF5KB0XE0Pve4AMCOjgMwmc2ia+fq/siFIBGZRWYS35ahl1
	 VdpGMbQsPmEt5VMn/A5IfTVftevnIHaJAvm8+Gefavl+326GyPQxa8VHCBySA0hA88
	 a42fuS/jRmUd+O6MkmenjInWl2B5U813+Yjl797JdzCGwTrmvBmMDyDjqGC6F4K0I6
	 O95V/97ywR4iQ==
Message-ID: <sashiko-outbox-234026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] media: Add tgid and fd fields in v4l2_fh struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261125-v4l2-add-ftrace-v3-3-1d1db48372ed@collabora.com>
References: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
 <20261125-v4l2-add-ftrace-v3-3-1d1db48372ed@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:59:09 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] media: v4l2: file descriptor 0 misrecorded as -1 in
  __video_do_ioctl()
- [Low] media: v4l2: mismatched tgid and fd across processes in
  __video_do_ioctl()
- [Low] media: v4l2: unlocked data race on vfh->fd init in
  __video_do_ioctl()
--

commit bce5397775deae4092f0cee0059ee45f433e0773
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: Add tgid and fd fields in v4l2_fh struct

This commit adds tgid and fd fields to struct v4l2_fh, recording the
opening process's tgid in v4l2_fh_init() and resolving the file descriptor
number via iterate_fd() on the first ioctl in __video_do_ioctl().

> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 17ba1ae707355..5d7fbaa1b41a1 100644
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
> +		return fd;
> +
> +	return 0;
> +}
> +
>  static long __video_do_ioctl(struct file *file,
>  		unsigned int cmd, void *arg)
>  {
> @@ -3083,6 +3094,12 @@ static long __video_do_ioctl(struct file *file,
>  		return ret;
>  	}
> =20
> +	if (unlikely(!vfh->fd)) {
> +		vfh->fd =3D iterate_fd(current->files, 0, _file_iterate, file);
> +		if (!vfh->fd)
> +			vfh->fd =3D -1;
> +	}

[Severity: Medium]
Does this misrecord valid file descriptor 0 as -1?

iterate_fd() stops only when the callback returns a non-zero value:

fs/file.c:iterate_fd() {
	...
	for (fdt =3D files_fdtable(files); n < fdt->max_fds; n++) {
		...
		res =3D f(p, file, n);
		if (res)
			break;
	}
	...
}

When a video device is opened at fd 0 (for example, in a daemon or test
process that closed stdin), _file_iterate() returns 0 on match, so
iterate_fd() treats it as a non-match, scans the rest of the fd table
under files->file_lock, and returns 0.  __video_do_ioctl() then sees
!vfh->fd and overwrites vfh->fd with -1.

Initializing fh->fd to -1 in v4l2_fh_init(), checking vfh->fd < 0, and
returning fd + 1 from _file_iterate() (then subtracting 1) would handle
fd 0 properly.

[Severity: Low]
Can concurrent ioctls on the same struct file race on vfh->fd here?

This initialization runs before v4l2_ioctl_get_lock() is acquired, so two
threads calling ioctl() on the same open file description can read and
write vfh->fd concurrently across the two-step assignment, triggering a
KCSAN data race and potentially observing an intermediate 0 value.

> diff --git a/include/media/v4l2-fh.h b/include/media/v4l2-fh.h
> index aad4b3689d7ea..080cb00e3867b 100644
> --- a/include/media/v4l2-fh.h
> +++ b/include/media/v4l2-fh.h
> @@ -28,6 +28,8 @@ struct v4l2_ctrl_handler;
>   * @vdev: pointer to &struct video_device
>   * @ctrl_handler: pointer to &struct v4l2_ctrl_handler
>   * @prio: priority of the file handler, as defined by &enum v4l2_priority
> + * @tgid: process id that initialized the v4l2_fh
> + * @fd: file descriptor associated to this v4l2_fh for the process id in=
 tgid

[Severity: Low]
Does vfh->fd always belong to the process identified by vfh->tgid?

v4l2_fh_init() records current->tgid at open() time, whereas
__video_do_ioctl() looks up vfh->fd in current->files of whichever process
issues the first ioctl without checking current->tgid =3D=3D vfh->tgid.  If
the open file is inherited across fork() or passed via SCM_RIGHTS before
the first ioctl, vfh->tgid and vfh->fd will refer to different processes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-v4l2-add-f=
trace-v3-0-1d1db48372ed@collabora.com?part=3D3
