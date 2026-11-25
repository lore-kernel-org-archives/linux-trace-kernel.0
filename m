Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633022;
	b=INACJufrlk39Hkr9/DHfERsBPFvSK6aDZlei0r1fB/d/Tphnwc5Ait0sKvE7uZpwRFsm
	 DcUwPHTuapi0v88XWFzL/cmXm3g5XDn3g8jNVVGSbhMkITVcTXOQG4UKSLDrmpnq/Jr4h
	 91Bfg/WrxgvvXpOzQosby/Gbs/c6LrPx/BwYQyLbh1zceJx3yA9UKjMeDuulDmFEdJHiB
	 pgGPpn7njhZngrs6y4v7tIYzf6/mX/Cd98UW5p2M9ncDwEAmEXMXwUAXwx8n/3gHOOO9l
	 DbSfckIo8Ik/Ai67rvCgkmfUPu5nUIlyLDqp2JfVSuJqPIdeunusR5fvEAcNgj6mvAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n2H6NEDWLKgZ/5AiikBaLLMeGUVt/IYL6/Gb++uVNwI=;
	b=VsbQhmdoK42yROU9Dd+xS7p0fIgm8CVMFn+ULyCC4lMqNFH61p8gkSptxmrQJmLNh7dk
	 sjugWHmAboYl/66pSVKYKduWY0f7xQJ/BZcFAroAKvvtnhdAh2D3DDi8wy0iY5xKiMvOv
	 iurA5P+EoKMfD7yVRyENYNPNBVUAi3qVaFSlkMkIN2CcAGYQI3MwwnECFwIUTH0zRtXbK
	 bYP1r2SGVEnpJX4vwibl3jXfLNavo72Hq+sZZxGV+Z93+cuCx5Hs778TmSnu07ZoEfLBS
	 3iTVgENpPxRCOJl/RlWMWCbLQev4Zdl/wK8ER8ESBWnrA5BiodP2NTkYufEB/FznXfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnnxlArM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE34F606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GnnxlArM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5921F000D1;
	Wed, 25 Nov 2026 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633022;
	bh=n2H6NEDWLKgZ/5AiikBaLLMeGUVt/IYL6/Gb++uVNwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GnnxlArM4XVhUR1uPE4yauP4Gtz6oT6BOpyLJi20OAmCe2P7OgnPBmZB9hXcdvdjJ
	 pn88il+SZ5sHgVsaqjp2swh2erFvlZu/R1hOF8LRKOVIJIMj8DU2olY/ouG0lEwNpS
	 Q5+LBP/nvJQu4f9w3VGXKAyn+2HrckEaMcB+T5nx0expkz0W7Gr1ogET2DxGP8CJft
	 WqJE0UEw/CrJKbg/P0jyIUH1iELb8vIKtxU2f68aBQrCrFZLRzr4eyAtLtvvsrjH4c
	 M9rzuonL1ahySyAiCJ0k6ZnueaPoBukvBfNbqzRGeCIQWOnao253nbWessDxzpOaIn
	 GR51q3yBy2RyQ==
Message-ID: <sashiko-outbox-234023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] media: Add stream on/off traces and run them in
 the ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261125-v4l2-add-ftrace-v3-7-1d1db48372ed@collabora.com>
References: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
 <20261125-v4l2-add-ftrace-v3-7-1d1db48372ed@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:57:01 +0000
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
- [Medium] media: v4l2: v4l2_streamon and v4l2_streamoff trace events
  omit queue type
- [Low] media: v4l2: unsigned u32 fd field in v4l2_stream_class
  tracepoints
--

commit 56aeec86320ecb65b07b7c0b600412ff631ceacb
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: Add stream on/off traces and run them in the ioctl

This commit defines v4l2_streamon and v4l2_streamoff trace events in
include/trace/events/v4l2.h and triggers them from v4l_streamon() and
v4l_streamoff() in drivers/media/v4l2-core/v4l2-ioctl.c.

[Severity: Medium]
In include/trace/events/v4l2.h (v4l2_stream_class, lines 273-297) and
drivers/media/v4l2-core/v4l2-ioctl.c (v4l_streamon at line 1974 and
v4l_streamoff at line 1988), should v4l2_stream_class also record the
v4l2_buf_type queue type?

As the comment above v4l2_stream_class notes, mem2mem drivers start and
stop both output and capture queues on the same tgid and fd pair. Without
recording the queue type passed in *(unsigned int *)arg (which can be
formatted with the existing show_type() helper in
include/trace/events/v4l2.h), trace consumers cannot tell which queue was
started or stopped.

[Severity: Low]
In include/trace/events/v4l2.h (v4l2_stream_class, lines 274-286), can
declaring fd as u32 and printing it with %u misreport negative fd values?

In include/media/v4l2-fh.h, struct v4l2_fh defines fd as a signed int,
and __video_do_ioctl() in drivers/media/v4l2-core/v4l2-ioctl.c (line
3113) sets vfh->fd =3D -1 when iterate_fd() returns 0 (such as when the
video device is opened on file descriptor 0 or is not found in
current->files). Recording fd as u32 marks the trace field unsigned and
prints -1 as 4294967295.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-v4l2-add-f=
trace-v3-0-1d1db48372ed@collabora.com?part=3D7
