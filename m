Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633114;
	b=bOBH/n3GrZFqoWPvbzcJJtRKzHW0Nd7IT9b1xBioEoEuRABXDAZitaKHRyXqaW48yhVb
	 azoeVdC/gnHxi7WwxZ903DJWP+PRQmjbMbphOgc0qEXsMzloUMJ7SpLI+Q9Wwb0YAM/mP
	 0FEUn8uSgg5pqFLE5vTDRMNsXMBU8r78ZxHA04s5pj3UdiY72O9gYjgQKnMgsn2Pb9Qsp
	 3RMncqzC14rfC9NJVUoW+ewJRMJ8OoLB9RcFP5Le9kMWhg6go4pU6/akxNACd9LHLcUdI
	 3vLTEAkw6/8zeNoT/GgkW4qq+A1eMTl7X7ADyCqIyOhzdlCz/muB1bXsuy/oNovHI6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=64n0F5NcVx514Spn8/266f5XHop1OmMR3by48iAzxaY=;
	b=29IWpJxUS+AEJzEGmrq9nwSOHDj2Fue6FRWR0ZWj2a61Z+GWsrzRUtd9Ft19ua0F9Pen
	 stQ6+yT97rrAlwiUqgwwuDo07X4emOg1bdiHf+bMWVpeYwL9YWc8vcCrGBBNMMUWYmHO1
	 Rf7bv9PruV3S0Ak1vJPDQLp7p8Uo90t+PX0y2ZLQbGSuEdPN/i6vDTBkas5xOcwCpuePg
	 Yk1A1x7RbjtfwSqFBVyl/liyc+artZ2ZZS5FmCeYxW65CG8j8a0TRFKVLcoSmrq+AOCEX
	 sSwgURZH9VmA7uFna2l/Dk/LvFA/IKPKdf6vV1a8aABFwQ+9g2JbA2sP2JrShzG9X5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdquRMQF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C025606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdquRMQF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A131F000C0;
	Wed, 25 Nov 2026 18:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633114;
	bh=64n0F5NcVx514Spn8/266f5XHop1OmMR3by48iAzxaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IdquRMQFPRoUe8VPmGMUgMXkL3Qzc5O8DBZ/ACFTPHD8lYuF0XOozNJEWEVz3lrdC
	 /f5aWzW0FRrgfJprw2FpPSpdwM6vJXNuXs34lAAbnvjk7DT+F2nZyptfpZMC4J/J+k
	 QnKNqZG1E7UJDqSicZmfrFdgenl6UyGkuN2Ola0wz2MVZVMQ3fnxUbBdgVMIV0E6bP
	 N89CAtZM3l2yZDRY0wVn1avgMbZ0W3VOuXp6HL5DQWd+BNSfiFf6ERzoxwC/EXBuhE
	 9YNEH7WPMQddwLkGDWf0kpOOifVeuqUUfr4xkydHN/zvOsZE6f7xErZ8vay+4sbPXx
	 ZHoCaiSmiCFqQ==
Message-ID: <sashiko-outbox-234024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] media: Move visl traces to v4l2-core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261125-v4l2-add-ftrace-v3-1-1d1db48372ed@collabora.com>
References: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
 <20261125-v4l2-add-ftrace-v3-1-1d1db48372ed@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:58:33 +0000
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
- [High] media: v4l2-trace: missing exports for HEVC SPS RPS tracepoints
- [Medium] media: v4l2_controls: commit message and doc trace system
  mismatch
- [Low] media: v4l2_controls: V4L2_FLAG() truncates HEVC PPS flag name
--

commit b360e3a86b5f1b07ed4a6b17a95a0ae81a5babd6
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: Move visl traces to v4l2-core

This commit moves the stateless V4L2 control tracepoint definitions from
the visl test driver into include/trace/events/v4l2_controls.h and exports
them from v4l2-core so other V4L2 drivers can use them.

[Severity: Medium]
Does the commit message match the trace header and trace system names
introduced by this patch?

The commit message refers to a new v4l2_requests.h header and a
v4l2_requests event directory, whereas the patch adds
include/trace/events/v4l2_controls.h and sets TRACE_SYSTEM to
v4l2_controls (placing the events under
/sys/kernel/tracing/events/v4l2_controls/).  In addition,
Documentation/admin-guide/media/visl.rst still tells users to look up and
enable trace events under the removed per-codec visl_*_controls
directories.  Also, in drivers/media/v4l2-core/v4l2-trace.c,
EXPORT_TRACEPOINT_SYMBOL_GPL(v4l2_ctrl_vp9_frame) is placed under the VP8
controls comment block instead of the VP9 comment block.

[Severity: High]
Are EXPORT_TRACEPOINT_SYMBOL_GPL(v4l2_ctrl_hevc_ext_sps_lt_rps) and
EXPORT_TRACEPOINT_SYMBOL_GPL(v4l2_ctrl_hevc_ext_sps_st_rps) missing from
drivers/media/v4l2-core/v4l2-trace.c?

Both trace events are defined in include/trace/events/v4l2_controls.h and
called from visl_trace_ctrls() in
drivers/media/test-drivers/visl/visl-dec.c.  When CONFIG_VIDEO_VISL=3Dm and
CONFIG_TRACEPOINTS=3Dy, the build fails at modpost with undefined symbol
errors for both tracepoints, and scripts/tracepoint-update warns about
unused tracepoints when CONFIG_TRACEPOINT_VERIFY_USED=3Dy and visl is not
built-in.

[Severity: Low]
In include/trace/events/v4l2_controls.h, does V4L2_FLAG(HEVC_PPS_FLAG_OUTPU=
T,
PRESENT) in v4l2_ctrl_hevc_pps_tmpl truncate the printed flag name for
V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT?

Because V4L2_FLAG(type, name) stringifies only its second argument, this
expands the trace output string to "PRESENT" instead of the previous
"OUTPUT_FLAG_PRESENT", which is ambiguous next to the five other
*_PRESENT flags in struct v4l2_ctrl_hevc_pps.  Using V4L2_FLAG(HEVC_PPS,
OUTPUT_FLAG_PRESENT) would preserve the full flag name, and V4L2_FLAG
should also be undefined before the end of the header so it does not leak
into including translation units.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-v4l2-add-f=
trace-v3-0-1d1db48372ed@collabora.com?part=3D1
