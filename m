Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25BB397944
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945556; cv=none; b=Wq4bVLMkAZynfyJcdwSM9X3UV99yyYPOdW8fhqbHovmbVoUNcm1wvv+aafE9mhXocB1Pb71RBaaqroG5v2yZA8AS+RH45mVlodN2uRr9InJZUu/Iuy+A2Bb6LWIEEDg5h6fRy00r3arI0clHTMepxjaZ2IHbWYTEzA8qHCdBML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945556; c=relaxed/simple;
	bh=qVJRxbA8OSfDIIuDVP+DVHDDW+JwDPeaSnOpqI5IEsc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=czJALg7BR1lPCIauMmXiHW2uSaKu5QXSagqStcK8+lZbu0n+RzaOuTMp93T0yJ6ggkm0xe6Clbgye/1SL7ug6R+5sTYgOXs0czXhCiFOppCMUXyp6hCc6BmYczsSW56rp1dBb/dxRxWUFBikpu3kpS1zOrLA07gXueArpPdm11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwvnKStZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwvnKStZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154FA1F000FF;
	Wed, 14 Oct 2026 02:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791945555;
	bh=Xv3aaFL8ZPmpu6tePdGG3fAqQYEqDYPJj3iD4r/zhyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hwvnKStZrnL6W/62qTRUUZlqwcB4WqHUbEmPHisC/f3Eg8Vr/fdGI4TZ4NVGO7t9c
	 qnrjZHqOIi2XRXH/Q6QzeLXIcK0UMm7W6zBBdoRuIiZwI0CSOKXR2iF7O+x5BUEvK2
	 XVnUVS8lyEkbFjOOM2CaBsI6KjBPqSpyoYMlh69K8mF4rguMO2lsja3CwunPoL0fSG
	 dBsUH5Fw493eAd71xjR83i+kNLcDRsMachFHS+Q38RMyzXjWm5HfHlnVQApKK4wPmI
	 D1E6yPiVLwNIbr5c5vOImH5BQrJykMHpWOllWi1uoVHfouVyP92qiplofv+Y60HX7x
	 IM/epBdB67Q2A==
Message-ID: <sashiko-outbox-170741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] tracing/osnoise: Split out per-cpu variable
 resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Crystal Wood" <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261014022640.695786-8-crwood@redhat.com>
References: <20261014022640.695786-1-crwood@redhat.com>
 <20261014022640.695786-8-crwood@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:39:14 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing/osnoise: unconditional osn_reset_cpu corrupts active trace=
r state
--

commit e7bd03b79c8b047561cc86479c9cbb434768ea94
Author: Crystal Wood <crwood@redhat.com>

tracing/osnoise: Split out per-cpu variable resets

Reset per-cpu state every time we stop a kthread or detach an fd, rather
than assume everything gets cleaned up properly, and avoiding the need
to explicitly zero individual fields.

> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 22263e08b968b..d799c400ed9b7 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c

[ ... ]

> @@ -2695,13 +2691,12 @@ timerlat_fd_read(struct file *file, char __user *=
ubuf, size_t count,
>  static int timerlat_fd_release(struct inode *inode, struct file *file)
>  {
>  	struct fd_data *fdd =3D file->private_data;
> -	struct osnoise_variables *osn_var;
> -
> -	osn_var =3D cpu_osn_var(fdd->cpu);
> +	struct osnoise_variables *osn_var =3D cpu_osn_var(fdd->cpu);
> =20
>  	mutex_lock(&osn_var->lock);
>  	if (fdd =3D=3D osn_var->fdd)
>  		timerlat_fd_detach(fdd);
> +	osn_reset_cpu(fdd->cpu);

[Severity: High]
Does this unconditionally call osn_reset_cpu() even when the file descriptor
was already detached?

If tracing is stopped and the active file descriptor is detached, userspace
can start a new tracing session. This sets osn_var->fdd to a new fdd and ar=
ms
a new hrtimer on the CPU.

If userspace subsequently closes the old, detached file descriptor,
timerlat_fd_release() executes, skips timerlat_fd_detach(), and
unconditionally calls osn_reset_cpu().

Could this trigger a WARN_ON(osn->fdd) and zero out the tlat->zero and
osn->zero structs of the newly active session, corrupting its queued hrtimer
and potentially causing memory corruption or a kernel panic?

>  	mutex_unlock(&osn_var->lock);
> =20
>  	kfree(fdd);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014022640.6957=
86-1-crwood@redhat.com?part=3D7
