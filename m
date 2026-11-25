Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633226;
	b=RS3fnMyvjucoEp92eZwS2HviV/KTsOAAaTUUAbMoE2D/t+Mm7ks87xGy/vSxlpfamSIN
	 of2ujUutjCs/5cBtQzVAzkQN9mNa22SB7RAbcv37CrTS4qQ0Lp3cp009vEVwthPNzQxHL
	 BJD4KlpQeX/AaXYKlcXFeCAZP7j7aqGh7mW6X4VDi87VBgm8V4v/s6NSLkBrvsyEbTqb8
	 4g/W3kjPeZ8D/TVRjongfhVaC/C2R+nmuq//YfFjnTiRdry76H5mcLiWku5wWtrm0Sm6P
	 X/r8A/H4gBADpknK3cFpynJFPd6WbrOwzLe8QfrKzzJObdBa698hHQwGSFmqm2C/Fvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RpX7QRVPOlulKtcbyEdfFFbSN3FcV/DWzPsiNOfv6jA=;
	b=pa+7guIqcroskB/0SpcOaukJYfGblMVPMIwXBybYS0P++OSFL7QAsaqbFpwz44NeZs4q
	 Gg2YQh/N7sT8LZvLxE9kmJ7HnNhtFDFJNjzg/wZmYfsk2DlaMxDixlnTa0bvplvlaUl7s
	 3UA55QPd3Hj6Dt4fIz1PGkXj7BOwBbS6xVNUifR70KEtjuUSaUPxMV8DwUlOKSOh8gQV0
	 rxI5i/9WX+4OTVeFL8dsTMvIvOr0YdxOL9QbTfc4VUG2mGb6d+csnkw1rs/W9EULzPiCP
	 5giuxrfiZ4nbQianEt7R9foBP5lihcvDEqR905O9ma59r75uoxbDg2/hyc/Ibfs/o0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFCRXlQZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55390606A331
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFCRXlQZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95711F000D0;
	Wed, 25 Nov 2026 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633225;
	bh=RpX7QRVPOlulKtcbyEdfFFbSN3FcV/DWzPsiNOfv6jA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZFCRXlQZ598GxtCNczSyhe1wlg7vImLLAuglDxPPLfEJtp89nWwSMY4s6LfFYEMLt
	 KCJjY5lUWMFYQ1j0jNIwSKX2azhgCr/TvRpWLV3VanlIGRu517/pPJF1RaJHtrKvmC
	 Jxkdn77F74W3pvv84oa8TAZKl+ta2TxvELcpkR8Px+NTYfZnDgDfDNTsT+mIxhBFHf
	 P/d9gGRcb0EizYTtRlHYDrEPG34BWobyZtqJ3d01eMJQyQhzTiPqkR6l04s2T0FQaQ
	 as9ceLYxkwb+kYF1Zu3ZUjsWpTgT+m3IaxF5lwsiaNcU0UEoSaX1u0JSts0iFDXGqL
	 rHvW+0R9h1WGQ==
Message-ID: <sashiko-outbox-234027@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] media: Trace the stateless controls when set in
 v4l2-ctrls-core.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261125-v4l2-add-ftrace-v3-6-1d1db48372ed@collabora.com>
References: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
 <20261125-v4l2-add-ftrace-v3-6-1d1db48372ed@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 19:00:25 +0000
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
- [High] media: v4l2-ctrls: trace_ext_ctrl() traces stale p_cur instead
  of p_new
- [Medium] media: v4l2-ctrls: trace_ext_ctrl() called on error in
  try_set_ext_ctrls_common()
- [Medium] media: v4l2-ctrls: missing HEVC RPS cases in
  v4l2_ctrl_type_op_trace()
--

commit f76da63b5503cac75415a06f2f5c14ded049c6e5
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: Trace the stateless controls when set in v4l2-ctrls-core.c

This commit adds a trace callback to struct v4l2_ctrl_type_ops to trace
stateless codec controls when set in try_set_ext_ctrls_common(), and
removes the driver-specific control tracing from visl.

[Severity: High]
In drivers/media/v4l2-core/v4l2-ctrls-api.c, should trace_ext_ctrl() pass
ctrl->p_new instead of ctrl->p_cur to ctrl->type_ops->trace()?

When stateless controls are set through a request (hdl->req_obj.req is
non-NULL), try_set_ext_ctrls_common() calls try_or_set_cluster() with its
set argument false and copies ctrl->p_new into ref->p_req via new_to_req().
Because new_to_cur() is not called until the request is later applied by
v4l2_ctrl_request_setup(), ctrl->p_cur still holds the previous or initial
default value when trace_ext_ctrl() runs, so request-based control updates
trace stale data.

[Severity: Medium]
In drivers/media/v4l2-core/v4l2-ctrls-api.c, inside
try_set_ext_ctrls_common(), should the trace_ext_ctrl(fh, master) call be
guarded by if (!ret && set) instead of only if (set)?

Without checking !ret, trace_ext_ctrl() still fires when user_to_new(),
validate_new(), try_or_set_cluster(), or new_to_user() fails earlier in the
loop iteration.

[Severity: Medium]
In drivers/media/v4l2-core/v4l2-ctrls-core.c, does
v4l2_ctrl_type_op_trace() drop tracing for
V4L2_CTRL_TYPE_HEVC_EXT_SPS_LT_RPS and V4L2_CTRL_TYPE_HEVC_EXT_SPS_ST_RPS?

visl_trace_ctrls() in drivers/media/test-drivers/visl/visl-dec.c previously
called trace_v4l2_ctrl_hevc_ext_sps_lt_rps() and
trace_v4l2_ctrl_hevc_ext_sps_st_rps(), but removing visl_trace_ctrls()
without adding those two types to v4l2_ctrl_type_op_trace() leaves those
tracepoints unused.  Also, for dynamic-array stateless controls (such as
V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS, V4L2_CTRL_TYPE_AV1_TILE_GROUP_ENTRY, and
the two HEVC RPS controls), v4l2_ctrl_type_op_trace() only traces the first
element instead of iterating over ctrl->new_elems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-v4l2-add-f=
trace-v3-0-1d1db48372ed@collabora.com?part=3D6
