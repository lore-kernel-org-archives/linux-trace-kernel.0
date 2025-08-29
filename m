Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CF1E1C1A;
	Fri, 29 Aug 2025 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432590; cv=none; b=IKfCR7zVv/1Mz4v2H9ssRG+e7xCIyqdwN3utvk6z/fhDJNz/WhMu0zYZ12dSElPo3lCO2DVmZsjgof9IfttlQjc4PIDI7/c0w1F2LCqk929nhc4s6XfmhpRXmXS+g0BYnqB51Wrypq+CUgb82iqJ6cOuF9SG/IGi0SJ7UAaLCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432590; c=relaxed/simple;
	bh=5TyW6yrGeyb7nMU0ulwU5MSbnNPSaEJZ7KfGOW7dCqw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Mekl5tagGsgOXW3iy5wHT1oLLqwcEYNWO4BNW4Oa/gm1b0yx5cgHjOGvYGPa8s2IZ+b1g4cUwx0HknhT58OIRW5HyiJyeQQ2ujVRMd3Flu1RQ5T/IG8i0Vz8FHCPThWNdjSosLfOEMjVHRmQ86FVvTzeh8a/i3Emi3C+In4F8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMf/YGJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMf/YGJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC48C4CEFB;
	Fri, 29 Aug 2025 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756432588;
	bh=5TyW6yrGeyb7nMU0ulwU5MSbnNPSaEJZ7KfGOW7dCqw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kMf/YGJoHz5UypoQ6DWMc2pj+6VszUnwU/bXsBp6B7JdXcDzW8R+qXfO5rIAfzzfO
	 cktfF/ok9SbvgcrUC384jdu/6Sn33Ee8Q2ewcmjBaRtinvwM/J7vcxcL+ay2xERKH4
	 Xi3VZAs/noLrmq9WGyxo5Tv48SPB9+r1NjaI4XzlksbnSeA3IZyHhFaufaF1thP/2E
	 afvwE19UHg94YAuUszAgCawiTqM/FltkKaaMkR0A4+S5kdilZckzHoPD/p1DVbemBk
	 pTelZssk1wSEc9XPBNH05VFn+1qnt7o1yxHetkBpsXHOH2qVikSn+hHbyP8S+GsHmO
	 9WwhoFiBO6NdA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uroME-00000004Prb-1YA0;
	Thu, 28 Aug 2025 21:56:50 -0400
Message-ID: <20250829015650.224063821@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 21:55:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] cdnsp: Remove unused tracepoints
References: <20250829015552.314865014@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Tracepoints that are defined take up around 5K each, even if they are not
used. If they are defined and not used, then they waste memory for unused
code. Soon unused tracepoints will cause warnings.

Remove the unused tracepoints of the cdnsp subsystem. They are:

cdnsp_defered_event
cdnsp_ep0_halted
cdnsp_free_priv_device
cdnsp_handle_cmd_flush_ep

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/usb/cdns3/cdnsp-trace.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp-trace.h
index f2bcf77a5d0a..9b33a736c3de 100644
--- a/drivers/usb/cdns3/cdnsp-trace.h
+++ b/drivers/usb/cdns3/cdnsp-trace.h
@@ -178,11 +178,6 @@ DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_set_config,
 	TP_ARGS(msg)
 );
 
-DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep0_halted,
-	TP_PROTO(char *msg),
-	TP_ARGS(msg)
-);
-
 DEFINE_EVENT(cdnsp_log_simple, cdnsp_ep_halt,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg)
@@ -399,11 +394,6 @@ DEFINE_EVENT(cdnsp_log_trb, cdnsp_cmd_timeout,
 	TP_ARGS(ring, trb)
 );
 
-DEFINE_EVENT(cdnsp_log_trb, cdnsp_defered_event,
-	TP_PROTO(struct cdnsp_ring *ring, struct cdnsp_generic_trb *trb),
-	TP_ARGS(ring, trb)
-);
-
 DECLARE_EVENT_CLASS(cdnsp_log_pdev,
 	TP_PROTO(struct cdnsp_device *pdev),
 	TP_ARGS(pdev),
@@ -433,16 +423,6 @@ DEFINE_EVENT(cdnsp_log_pdev, cdnsp_alloc_priv_device,
 	TP_ARGS(vdev)
 );
 
-DEFINE_EVENT(cdnsp_log_pdev, cdnsp_free_priv_device,
-	TP_PROTO(struct cdnsp_device *vdev),
-	TP_ARGS(vdev)
-);
-
-DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_device,
-	TP_PROTO(struct cdnsp_device *vdev),
-	TP_ARGS(vdev)
-);
-
 DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_addressable_priv_device,
 	TP_PROTO(struct cdnsp_device *vdev),
 	TP_ARGS(vdev)
@@ -575,11 +555,6 @@ DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_stop_ep,
 	TP_ARGS(ctx)
 );
 
-DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_flush_ep,
-	TP_PROTO(struct cdnsp_ep_ctx *ctx),
-	TP_ARGS(ctx)
-);
-
 DEFINE_EVENT(cdnsp_log_ep_ctx, cdnsp_handle_cmd_set_deq_ep,
 	TP_PROTO(struct cdnsp_ep_ctx *ctx),
 	TP_ARGS(ctx)
-- 
2.50.1


