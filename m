Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD683DC4B3;
	Wed, 10 Jun 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102066; cv=none; b=ohPAPz/BwzXB/DrQF5IuFvUoSFWG9FWp0cUGO6XDszEHEe4V6UtimJVjUyUiK8uLNxkYN6mLsNlj5d9nX5/lsbBrZRh+82wYCqPNKEA5z0Fu8bvkPVQ5oGmaemNnEY0rEltC0MkhHJDx6Y5juhTNAYCHab10k99kVNtEurTX6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102066; c=relaxed/simple;
	bh=z+uPayXXzrDWT3k+9PFgnY2VlIbKirFE96Daw//LC8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fqSnlP9Mxtv/7KCvAB/vB73ygY3nLTCl+BLcX3ieG9tGhn0Q2tG94bABvAMxQYs9GLndFgagCPRw6+2aCVxQucnDmfIUfw8/hzrZl16CxYMf9Wc7HFSGYQdT/3Gmo+qF7w+h7p4OzlvOimuH/jRDTRW6qz6oqdxdeHA8FrUoup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f/R7Co1N; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f/R7Co1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781102060;
	bh=z+uPayXXzrDWT3k+9PFgnY2VlIbKirFE96Daw//LC8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f/R7Co1N/iroADdMnP220+rnpvfGLJ+6vg6zYxvSmM2PoF3DGJ/aMJD+NwPMtyrZB
	 hk3LeZN+CE5RosxXVZ3gt59Wtn6sps+gKLcBWQLi2K4iNira/2b6JL4dVQfQyIIAce
	 izYNoy2abPH6bI9MOUAjZsMLiB7ZeWKV4V+PWaVFQMdAbhMkmX3PzD6h9cvuf5INqS
	 2eHnOE2Q4SoPPpPXftRpHDNAZ2YNCxuPQKDai7uCS9nETiFdZ5El+A/t02idp0gh5l
	 4cciUzo2Z+RlZoMejs10kN75jdcSPM2qDjV5clR3hEnupuxknzZC4OFgY+tYjjiqPW
	 2pmGrpue96bpg==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00B4517E0FD0;
	Wed, 10 Jun 2026 16:34:18 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Wed, 10 Jun 2026 10:33:35 -0400
Subject: [PATCH v2 5/9] media: Add missing types to v4l2_ctrl_ptr
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-v4l2-add-ftrace-v2-5-9756edf72ac1@collabora.com>
References: <20260610-v4l2-add-ftrace-v2-0-9756edf72ac1@collabora.com>
In-Reply-To: <20260610-v4l2-add-ftrace-v2-0-9756edf72ac1@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Detlev Casanova <detlev.casanova@collabora.com>
X-Mailer: b4 0.15.2

The v4l2_ctrl_ptr union contains pointers for all control types, but
v4l2_ctrl_hevc_decode_params and v4l2_ctrl_hevc_scaling_matrix are missing.

Add them.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 include/media/v4l2-ctrls.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index 327976b14d50..a2b4c96a9a6f 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -49,6 +49,8 @@ struct video_device;
  * @p_hevc_sps:			Pointer to an HEVC sequence parameter set structure.
  * @p_hevc_pps:			Pointer to an HEVC picture parameter set structure.
  * @p_hevc_slice_params:	Pointer to an HEVC slice parameters structure.
+ * @p_hevc_decode_params:	Pointer to an HEVC decode parameters structure.
+ * @p_hevc_scaling_matrix	Pointer to an HEVC scaling matrix structure.
  * @p_hdr10_cll:		Pointer to an HDR10 Content Light Level structure.
  * @p_hdr10_mastering:		Pointer to an HDR10 Mastering Display structure.
  * @p_area:			Pointer to an area.
@@ -81,6 +83,8 @@ union v4l2_ctrl_ptr {
 	struct v4l2_ctrl_hevc_sps *p_hevc_sps;
 	struct v4l2_ctrl_hevc_pps *p_hevc_pps;
 	struct v4l2_ctrl_hevc_slice_params *p_hevc_slice_params;
+	struct v4l2_ctrl_hevc_decode_params *p_hevc_decode_params;
+	struct v4l2_ctrl_hevc_scaling_matrix *p_hevc_scaling_matrix;
 	struct v4l2_ctrl_vp9_compressed_hdr *p_vp9_compressed_hdr_probs;
 	struct v4l2_ctrl_vp9_frame *p_vp9_frame;
 	struct v4l2_ctrl_hdr10_cll_info *p_hdr10_cll;

-- 
2.54.0

