Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18341ACED7;
	Fri, 29 Aug 2025 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432588; cv=none; b=LlOb7FtZuw8aDru898K3dgaRVgT2C/ZsvLJEYyoiDlBUjayz2T6fheRlrU1bl22IKOJK1ju+usSWr/DPTPA/5klXtodFADysjl1ru+o33vfDtx3ih+7Iy4A5JOnOjR4i4iGqxMrJb08rqaS7qzVnKDf0TXNVvhN2QtaB2NGFrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432588; c=relaxed/simple;
	bh=DsF8Q2GnjZbAlXFzOOw6Vu1NkOPPgUZHPCcAMrL9200=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lCjn+4G7Y00ASwGxcxVQ4qPrrOf4HyocXYhu/GPl8ovxZVytIYK/ksFhB8pam/fjCP/dbjUfZ+ZwWuL4E9wes5aqviN72k7xF++9exI2BuvR3qfBqPX1e1oNorjnVWYVkRbMT7ShbXGxhCht1xuemUsrqANzyfDGMiEm1GHpOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNlqrvay; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNlqrvay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B90C4CEEB;
	Fri, 29 Aug 2025 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756432588;
	bh=DsF8Q2GnjZbAlXFzOOw6Vu1NkOPPgUZHPCcAMrL9200=;
	h=Date:From:To:Cc:Subject:References:From;
	b=sNlqrvaysKWxNtTUIsQ+Dm+ADeQuKNcO0EbwuFl94fm6fD3ngeCFFihDebJe6xDN1
	 x48RJ6jTv5qOAjA/dZRxbdkWasLosq6g5RUA7xvScl2IRHGW/aYi94VR/5Gzs9ZhdS
	 FCqul/NvDlkluVabA++4Za+PsaDCZEMcZLGnTNDDgX5P8utGru1+36x5VDjdOkD+W3
	 b0wI+uHYxi/CSUseRpenW32X8cwAq4ViA1nEVIG5GTS3Z1FClOjbJe+fT+nD4J6ZyV
	 5LabvwFzEBoVTRvuBnSsOFZm5VOt/+MUEwYworZDs8GT04aT+WeWw0sgmZ8qk8VLW7
	 rfjZkIl/VFi0A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uroME-00000004Pqd-08Up;
	Thu, 28 Aug 2025 21:56:50 -0400
Message-ID: <20250829015649.885512884@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 21:55:53 -0400
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
Subject: [PATCH 1/3] cdns2: Remove unused tracepoints
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

Remove the unused tracepoints of the cdns2 subsystem. They are:

cdns2_ep0_enqueue
cdns2_ep0_set_config
cdns2_ep_queue
cdns2_iso_out_ep_disable
cdns2_lpm
cdns2_mapped_request
cdns2_map_request
cdns2_may_wakeup

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h | 69 ----------------------
 1 file changed, 69 deletions(-)

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-trace.h b/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
index ade1752956b1..f4df0e2ff853 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
@@ -47,16 +47,6 @@ DEFINE_EVENT(cdns2_log_enable_disable, cdns2_pullup,
 	TP_ARGS(set)
 );
 
-DEFINE_EVENT(cdns2_log_enable_disable, cdns2_lpm,
-	TP_PROTO(int set),
-	TP_ARGS(set)
-);
-
-DEFINE_EVENT(cdns2_log_enable_disable, cdns2_may_wakeup,
-	TP_PROTO(int set),
-	TP_ARGS(set)
-);
-
 DECLARE_EVENT_CLASS(cdns2_log_simple,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg),
@@ -79,11 +69,6 @@ DEFINE_EVENT(cdns2_log_simple, cdns2_ep0_status_stage,
 	TP_ARGS(msg)
 );
 
-DEFINE_EVENT(cdns2_log_simple, cdns2_ep0_set_config,
-	TP_PROTO(char *msg),
-	TP_ARGS(msg)
-);
-
 DEFINE_EVENT(cdns2_log_simple, cdns2_ep0_setup,
 	TP_PROTO(char *msg),
 	TP_ARGS(msg)
@@ -340,11 +325,6 @@ DEFINE_EVENT(cdns2_log_request, cdns2_free_request,
 	TP_ARGS(preq)
 );
 
-DEFINE_EVENT(cdns2_log_request, cdns2_ep_queue,
-	TP_PROTO(struct cdns2_request *preq),
-	TP_ARGS(preq)
-);
-
 DEFINE_EVENT(cdns2_log_request, cdns2_request_dequeue,
 	TP_PROTO(struct cdns2_request *preq),
 	TP_ARGS(preq)
@@ -355,50 +335,6 @@ DEFINE_EVENT(cdns2_log_request, cdns2_request_giveback,
 	TP_ARGS(preq)
 );
 
-TRACE_EVENT(cdns2_ep0_enqueue,
-	TP_PROTO(struct cdns2_device *dev_priv, struct usb_request *request),
-	TP_ARGS(dev_priv, request),
-	TP_STRUCT__entry(
-		__field(int, dir)
-		__field(int, length)
-	),
-	TP_fast_assign(
-		__entry->dir = dev_priv->eps[0].dir;
-		__entry->length = request->length;
-	),
-	TP_printk("Queue to ep0%s length: %u", __entry->dir ? "in" : "out",
-		  __entry->length)
-);
-
-DECLARE_EVENT_CLASS(cdns2_log_map_request,
-	TP_PROTO(struct cdns2_request *priv_req),
-	TP_ARGS(priv_req),
-	TP_STRUCT__entry(
-		__string(name, priv_req->pep->name)
-		__field(struct usb_request *, req)
-		__field(void *, buf)
-		__field(dma_addr_t, dma)
-	),
-	TP_fast_assign(
-		__assign_str(name);
-		__entry->req = &priv_req->request;
-		__entry->buf = priv_req->request.buf;
-		__entry->dma = priv_req->request.dma;
-	),
-	TP_printk("%s: req: %p, req buf %p, dma %p",
-		  __get_str(name), __entry->req, __entry->buf, &__entry->dma
-	)
-);
-
-DEFINE_EVENT(cdns2_log_map_request, cdns2_map_request,
-	     TP_PROTO(struct cdns2_request *req),
-	     TP_ARGS(req)
-);
-DEFINE_EVENT(cdns2_log_map_request, cdns2_mapped_request,
-	     TP_PROTO(struct cdns2_request *req),
-	     TP_ARGS(req)
-);
-
 DECLARE_EVENT_CLASS(cdns2_log_trb,
 	TP_PROTO(struct cdns2_endpoint *pep, struct cdns2_trb *trb),
 	TP_ARGS(pep, trb),
@@ -507,11 +443,6 @@ DEFINE_EVENT(cdns2_log_ep, cdns2_gadget_ep_disable,
 	TP_ARGS(pep)
 );
 
-DEFINE_EVENT(cdns2_log_ep, cdns2_iso_out_ep_disable,
-	TP_PROTO(struct cdns2_endpoint *pep),
-	TP_ARGS(pep)
-);
-
 DEFINE_EVENT(cdns2_log_ep, cdns2_ep_busy_try_halt_again,
 	TP_PROTO(struct cdns2_endpoint *pep),
 	TP_ARGS(pep)
-- 
2.50.1


