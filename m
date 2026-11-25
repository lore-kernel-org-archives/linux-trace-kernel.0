Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632996;
	b=ab9eQSPC1udlEqpI53y3Xr6LunAuZUFSq8ZvMR7OYGt3haceJjofK700NIme8G5CnuQO
	 e8SW5dcIInG475YP8+gy8COF2nAwhRh03RNyAoijcW3QE7zPVbs0OBRJLiLbLSbDYCgta
	 8i0OsFf+DKYUKjfyTAgQEpBTAu1Hcse/1TFx6LClydlD78Ma7wJqrFy2onwOchicIv02E
	 UASJkT0poLvkbgHQ4NaTGJVKUjJlnsGFAR8oToVV56ik1wo8kurYMgRIMKtejwM6uq0+A
	 3VvTe2zitiBuuN2//UFtiv1OhqWa9tdSuGPo8P764x/Jy6bN256OLHrsEHiqhCKLt3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632996;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0I9H/l59LtVKJf59L6zzu1WxB8OwJYohu0AJc09MKF8=;
	b=DapkMsWhVTQmyYSmYLRb1VZcbo1lRKubzfAB4qFMpzIbVTzBbefgW6dTqdjQioVr3PoG
	 QnvusXq4C8r4cdRAmiuL5TQLJRNGeDDBC9sVmvqWiEJy9DrfbXs3lJgNGYzRn0TB83OCP
	 DhuwkQciKbVawP41N3Q9W3Jan5ejVoZbWuVeMVEjSWd+zOJDM7S++NeWjnyt6SKQIq2Ji
	 RY5kISvxeenNV0zcB3A/XXzKKcP9UNunc5scimuBQngwPzZc4nt81OdWqOPF4n05DSSor
	 hjFI/cylP5NMFc2QycmvldsYkl+3NZy8DGxg/Iblvh2tioGiGF6NJvmV3cCjV6CU+Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEvaV4lv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976FB606A326
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEvaV4lv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161771F000C4;
	Wed, 25 Nov 2026 18:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632996;
	bh=0I9H/l59LtVKJf59L6zzu1WxB8OwJYohu0AJc09MKF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEvaV4lvx0uTz/ySlh1yGDC8b/eKJiVh/9q+1cmHBazWzQXPgTLf1J6RzggUSxHOS
	 xik18ws/uaohJzh5hgGknFwPmT4+M3IFvUtY1CWCVgAj1hbE5s2Cp8eicsmf2DI9Mt
	 T/YQMvjni2HSUSC26Z52ubxTIVqA+q8RZdtvxTjYxbxUun9CkxWfFffAo6N1/d337x
	 9bRMCoBQxcbRy9X3jK5eTKcjE8XxLRiScZTaxxcQFH6XqT6fpWNFPNz9ozPSMvBcGn
	 WXGctCP7V7gQICI4RZO83hYlqteg5FqvomVY8x/IiewmbxEa11pkIyT+2HzKJlcgyC
	 va2ULP+iErz0g==
Message-ID: <sashiko-outbox-234022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] media: Add tgid and fd to the v4l2-requests
 trace fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261125-v4l2-add-ftrace-v3-4-1d1db48372ed@collabora.com>
References: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
 <20261125-v4l2-add-ftrace-v3-4-1d1db48372ed@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:56:35 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] media: v4l2_controls tracepoints declare signed fd as unsigned
  u32
--

commit 3152eaf4ee2021252442052cd8aab150bbaf3891
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: Add tgid and fd to the v4l2-requests trace fields

This commit adds the v4l2_fh tgid and fd fields to all v4l2_controls
tracepoints and updates visl_trace_ctrls() to pass them.

> diff --git a/include/trace/events/v4l2_controls.h b/include/trace/events/=
v4l2_controls.h
> index 722e10a5078e3..531aef185b85e 100644
> --- a/include/trace/events/v4l2_controls.h
> +++ b/include/trace/events/v4l2_controls.h
> @@ -17,27 +17,39 @@
>   * They can be identified by the name of the event. All control fields a=
re copied in a TP_STRUCT
>   * field so that they can be filtered separately in userspace.
>   *
> + * In addition to the controls fields, tgid and fd are also added in eac=
h trace events.
> + * This allows to identify controls set by a specific process and to mat=
ch them with other events
> + * from the same process.
> + * tgid contains the process id that opened the video device.
> + * fd is the file descriptor in the tgid, used in case a process opens m=
ultiple video devices.
> + *
>   * Currently only the codec controls are supported.
>   */
> =20
>  /* AV1 controls */
>  DECLARE_EVENT_CLASS(v4l2_ctrl_av1_seq_tmpl,
> -	TP_PROTO(const struct v4l2_ctrl_av1_sequence *s),
> -	TP_ARGS(s),
> -	TP_STRUCT__entry(__field(__u32, flags)
> +	TP_PROTO(u32 tgid, u32 fd, const struct v4l2_ctrl_av1_sequence *s),
> +	TP_ARGS(tgid, fd, s),
> +	TP_STRUCT__entry(__field(u32, tgid)
> +			 __field(u32, fd)
> +			 __field(__u32, flags)
>  			 __field(__u8, seq_profile)
>  			 __field(__u8, order_hint_bits)
>  			 __field(__u8, bit_depth)
>  			 __field(__u16, max_frame_width_minus_1)
>  			 __field(__u16, max_frame_height_minus_1)),
> -	TP_fast_assign(__entry->flags =3D s->flags;
> +	TP_fast_assign(__entry->tgid =3D tgid;
> +		       __entry->fd =3D fd;
> +		       __entry->flags =3D s->flags;
>  		       __entry->seq_profile =3D s->seq_profile;
>  		       __entry->order_hint_bits =3D s->order_hint_bits;
>  		       __entry->bit_depth =3D s->bit_depth;
>  		       __entry->max_frame_width_minus_1 =3D s->max_frame_width_minus_1;
>  		       __entry->max_frame_height_minus_1 =3D s->max_frame_height_minus=
_1;),
> -	TP_printk("\nflags %s\nseq_profile: %u\norder_hint_bits: %u\nbit_depth:=
 %u\n"
> +	TP_printk("tgid =3D %u, fd =3D %u\n"
> +		  "flags %s\nseq_profile: %u\norder_hint_bits: %u\nbit_depth: %u\n"
>  		  "max_frame_width_minus_1: %u\nmax_frame_height_minus_1: %u\n",
> +		  __entry->tgid, __entry->fd,

[Severity: Low]
Should fd be declared as a signed int (or s32) and printed with %d
across all trace events in v4l2_controls.h?

struct v4l2_fh defines fd as int, and __video_do_ioctl() sets
vfh->fd =3D -1 when iterate_fd() returns 0 (for example, when the video
device is opened on file descriptor 0):

drivers/media/v4l2-core/v4l2-ioctl.c:__video_do_ioctl() {
	...
	if (unlikely(!vfh->fd)) {
		vfh->fd =3D iterate_fd(current->files, 0, _file_iterate, file);
		if (!vfh->fd)
			vfh->fd =3D -1;
	}
	...
}

Declaring fd as u32 and formatting it with %u turns -1 into 4294967295
in the trace output and exposes an unsigned field in tracefs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-v4l2-add-f=
trace-v3-0-1d1db48372ed@collabora.com?part=3D4
