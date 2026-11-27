Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799043;
	b=OBwvY3zF+b18j1Npv4oZhlkHWpbE/4XK0E5bF7UmueP0m2vwKPxFAY+LKw4/4bb3yiKW
	 XcaPInRDS8CZPrOpnisNpWHAmZCuawcs6TysXJ0nXgZXN10gc9sj06fLSYAyylhJUvPxV
	 BA9z/9qMddH911e6tT0OAuK+bCtZYImxUpIswB3DPdqdFmUZJpefEsBiLRQs5DAiY8Njl
	 QR6Ep7hFzMa2MIaUVjjTWDdqFBU/+/suSGKLt6tnFJGN3mso+Ve/PdI5OupGNMoFm+P/M
	 7/5C1wo4MT4p7lvAWZ6KwlDQMEs5WQHtr+BKkr+6NAtmOHxRaqp/Ub+yNpUx/ZTxvfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AxOt9Ei8HMrCHSqNsA+ScnMP5JcrLxwkyRECm9gx2UI=;
	b=GvwuGQ/6nNPw2Zls2IPvQ04hHXdX0ysPle0eKdMOvMHyesTO/3+PMCL0zEfOPNiNNjgh
	 ztBT3CZfWmbN+GavsMY+bHacNTaN7pwEC/1pk7/ADDXILiWh0FmxzhMXK1fWEAVCzcIu0
	 4VGLHDmXKBaSHzveTqOfuZRJ/HhD7Up6aw480mW0/+o0Px+GHzlSeNRs8G7oimSjhr8XN
	 36lwck3kn7S+KYCjipvvU/cBWGHQJ3ADca7uRWpdhmNL71w49oF9lmGiNpv8IZyx0wKFz
	 Pa/4H/5o14BWc9GxpLCviiIbYxiRNTQehZT+8vdjq7d4d3z7q7QNl6ZoTlZNi65mfMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRHqp0hw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6A606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRHqp0hw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3582D1F00919;
	Fri, 27 Nov 2026 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799043;
	bh=AxOt9Ei8HMrCHSqNsA+ScnMP5JcrLxwkyRECm9gx2UI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PRHqp0hwXOKjN3OYTx8NwdchZ6aVuA27eEvmLg5jcs4vV26+cepT2gPfY/LbHC7pU
	 etpAp7cU55KDYaZFajU+XxGq5crh4HGxd5klOUpmTVECUwRCtcyfdjfqDiu/FHJe+P
	 q/f8+h5H0ssbQ8y/kY4ALkNQXbBDhfa3uNT2nSeVI7a1vmAIHsi9davA+PTVaiQ4K2
	 btf+K8UQUmXM8dZIyNZQo+hUk4H9ayGfH8IJBIxVXhLuwd83uq+5/V79/pF+yG70pE
	 FaQmpQYfRODHGJWHRtj7k3MseHVRGZXuLREw/Fkc9sZ/nUjm4IYWPbDRBp6OWFlZM9
	 zFR0KyWQVhLTw==
Message-ID: <sashiko-outbox-237960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] media: Trace the stateless controls when set in
 v4l2-ctrls-core.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261127-v4l2-add-ftrace-v4-6-24138479002f@collabora.com>
References: <20261127-v4l2-add-ftrace-v4-0-24138479002f@collabora.com>
 <20261127-v4l2-add-ftrace-v4-6-24138479002f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:04:02 +0000
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
- [Medium] media: v4l2-ctrls: missing array loops in
  v4l2_ctrl_type_op_trace()
--

commit b1326148b2e9e09d59e2a932934d81276051e3bb
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: Trace the stateless controls when set in v4l2-ctrls-core.c

This commit moves stateless control tracing from the visl test driver into
the V4L2 control core by introducing a trace callback in
v4l2_ctrl_type_ops and calling it when controls are set.

[Severity: Medium]
In drivers/media/v4l2-core/v4l2-ctrls-core.c, in v4l2_ctrl_type_op_trace()
(lines 1626 and 1672), should the V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS and
V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY cases loop over ctrl->new_elems like
V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS and V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS
do?

In drivers/media/v4l2-core/v4l2-ctrls-defs.c, v4l2_ctrl_fill() marks both
V4L2_CID_STATELESS_HEVC_SLICE_PARAMS (line 1574) and
V4L2_CID_STATELESS_AV1_TILE_GROUP_ENTRY (line 1605) with
V4L2_CTRL_FLAG_DYNAMIC_ARRAY. Tracing only ptr.p_hevc_slice_params and
ptr.p_av1_tile_group_entry at index 0 drops all remaining slice parameters
and tile group entries when userspace submits a multi-slice HEVC frame or
a multi-tile AV1 frame.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-v4l2-add-f=
trace-v4-0-24138479002f@collabora.com?part=3D6
