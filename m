Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797951;
	b=2FWIkin6+T7J+ar0Q5j2M3rrzYFKNLNRrGd2JgRV2ub7JXxY2nAdf2iG4rMohPFNnMm4
	 9hEtqormbAS6TG1QToj439m4ffVjhyOSG/sxpQeL9gFkW5PTFUHO8Xh8IKWd55TwgGu3O
	 hfC/mMm66Bhae6yx6qk9lPD8UTCt14UU+Jyoo9XB8jIUQezaPTh/15AKCPonCA2zr4clY
	 KlGACrH11ScufWF1oIFzOGgeJftW5gYx7YtQa6yaU4Boyu/s4RPMIEHjJbNQVoB05ajip
	 w6/dTmom6jY+5Gh+09lEhFy858JQefWR+b23kfkF0iM3yeHN7a2VELhwJyBugtf730w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797951;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=6TexNp2ZDl+3hX+Vq6c0lera+2kj3Ba5hH/oMxLRynY=;
	b=yDm/bbFlpt9RvBhyJKdrKmNZl3kdl7yPpudU3jynk02Vw4w4jxKoKkSieEvsvuP9PauI
	 V5yjvW+rnxxR65kTWYs7ngbh+epPEO9ElvTm0T5IRYFMEbheY8rH2QXeKRvP2aigmqhpq
	 2jZOiopeItTQn4/yJFE8TCWpt9iNGt3a6GPaTxwNCNC5ZfTA1XZnnWJCsh3h23A5368ml
	 KNAIXxXFvYXmQN5Csh+iBfAxQMLoK34pAUiPjsA+wTugL3KoLqf7dLfRc+CnL00l1zzIe
	 8xeekNnoxpT0qzDDwIPZj07b1BJregxOsy/4xnAEID6MAB8NFDd+l51Za5B9iCnRmkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=J8YFFQ0a;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C0606A32F;
	Fri, 27 Nov 2026 16:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 330C0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=J8YFFQ0a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795797949;
	bh=Ojr4CPkhMmvonRIHNhgph/1SQ75Ajo/2PT1nLoJMfng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J8YFFQ0aUe4gZM0y9GtsFjGfErA4HSVCjwbflJNONTsK+FHkDPQwQdCcEZ3ycJItw
	 LovaW/wXwR9GlBzioupxneGCONKP1yV6uiN99In+foU5KVE3/QX/LZpAiDR352Y99r
	 cXIuLSRB9koyYflF0GOsak+Be796vMm7NASpP0KoxkcS0iL61Bsfj27+V8K8iCaEIc
	 RCwd9s1CccSY9RmlKa1eRLMBgMRo+UF8PKV9zv+/xq7VaDxCIQQv/VC78T1BO73C3F
	 Ptq+NWCedbrf5bFjhYiZpIGATIVndhqhJJhQrsURNYX/7/QfPNIjaYu/QCUjM6wMGG
	 JYoXhgQ5OXXSQ==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AEC0717E08C6;
	Fri, 27 Nov 2026 17:45:47 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Fri, 27 Nov 2026 11:45:09 -0500
Subject: [PATCH v4 5/9] media: Add missing types to v4l2_ctrl_ptr
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-v4l2-add-ftrace-v4-5-24138479002f@collabora.com>
References: <20261127-v4l2-add-ftrace-v4-0-24138479002f@collabora.com>
In-Reply-To: <20261127-v4l2-add-ftrace-v4-0-24138479002f@collabora.com>
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
index cec9217d97ac..6e363262c868 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -49,6 +49,8 @@ struct video_device;
  * @p_hevc_sps:			Pointer to an HEVC sequence parameter set structure.
  * @p_hevc_pps:			Pointer to an HEVC picture parameter set structure.
  * @p_hevc_slice_params:	Pointer to an HEVC slice parameters structure.
+ * @p_hevc_decode_params:	Pointer to an HEVC decode parameters structure.
+ * @p_hevc_scaling_matrix:	Pointer to an HEVC scaling matrix structure.
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
2.56.1

