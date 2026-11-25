Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632302;
	b=O3xFyIxJdRAtSaY7zK89pHRIFtDzcspFe9lTFFlp7AE3yxfmAO2ULBXvGnUrtZeQggLr
	 Ht/D9A9t4dJVGmhOWS4RKWiUkP6LXwWde1fElLSJwviODqwRTNrHQcxAMdE77eADSnxdV
	 TjLJk5ivOYgIR33AfP4x5MSj9J6ODuDlXMdPMiNDy+OaseX5luAr0YExUhq+ihFh2PY/p
	 lQogqL3pOD6MntZGoH41JDmCiQlCw4Bz3cpabLmX/a2szXht8gflx4rsFNxiJmyT0l6KT
	 0NvGPncRtbPiisY6nBMsWRj81ExSvO7rq8XovXXVGEPme0Uhaqjv7uRIobJaU0d+w0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632302;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=6TexNp2ZDl+3hX+Vq6c0lera+2kj3Ba5hH/oMxLRynY=;
	b=ScNnrklKWKgCI5h7mJ6EfcUM2WvjurgNfq20+kpeq38ROZjGBF74WKBnkjIt6d1qH4qs
	 R39S9FgBfYRlRnLkMwgYfIqf8JeuFGtA/OFmC1VBnbyn0XmXNEah1ZVFaXHqIWu6qcVxc
	 qzPTxw2vry+yq4S2pg8zk/4PCwf7VNvUVApuJgYs78ovdHoEAknrhfRB9LlufRvnRj4fE
	 rdLCeSaYBUsxb2kJjpnv+8VthBfsN9K0PmAQSiv8LC6/iS+sTdZ8eYDvO198u5di2xqlI
	 vg4d3pRUO8QFAj7cf55lQqT8Nl/woV1om4iw4/18LYoEyuwzOdySiQDAKHmtwXfFXEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DwvH3gte;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F79606A6BB;
	Wed, 25 Nov 2026 18:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F79606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DwvH3gte
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795632300;
	bh=Ojr4CPkhMmvonRIHNhgph/1SQ75Ajo/2PT1nLoJMfng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DwvH3gtezJ+4oH1RMZdnB4D83zg0cMy/kuhOGAW1HaP6kJKNg93Hcr2w7umBLdAiD
	 GZYqj1R/zZU61EJ3SxfhmLLkrWcBsVlYflwTzN/8Wh2b9UJNWvAWKm9EAXaild+3Qy
	 19XhqP5wdqEaa3egnvZvijmt9qHnbL/ojYCI14DPMr3kkg7XJ1xy6Jdlz57j8gwUZE
	 MHCxCXKqynfDUcBU/+dY+5tja9w/gLXyIiyj75J23ARqMLz/fqxxl9T5bkow+MuMX3
	 n8v99Q4zjApvxl039NFZbMS/cPeITiO05akxhidBc+BRBryiG3oXwaC2eRU+uJj7ck
	 cwQLbg5ISaitw==
Received: from [192.168.0.15] (unknown [100.64.0.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 60FD817E1202;
	Wed, 25 Nov 2026 19:44:58 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
Date: Wed, 25 Nov 2026 13:33:27 -0500
Subject: [PATCH v3 5/9] media: Add missing types to v4l2_ctrl_ptr
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
Message-Id: <20261125-v4l2-add-ftrace-v3-5-1d1db48372ed@collabora.com>
References: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
In-Reply-To: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
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

