Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4011FF1A0;
	Fri, 29 Aug 2025 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432589; cv=none; b=TJVptfEvs/Row9HOqPjlLlIYJtGCSknm8wHftt8tRbMygTpUgvn+TCERekM6Ky61lpWHIJEXVwhVTmdq/Wv8pWeATmQSPg5RZncvIWiOCSA17XBuzQXuaUi6OJUXUDclyg+vwAWpO5eMOiAZ/6T/UmPCvl3T8kcTsRaodnp1+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432589; c=relaxed/simple;
	bh=KUmRm6wGRzwd8d4vpk2py4TElSiA2CAsGm0SJ7MQvSE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dFGeXDvAetkMvSdqXlLxMOWtSIDMC2P++sW1OljZqbxZYbGwCBgHxXSihD/vpbBG6a+7xVbdW0GdUuhBeVGZL1lwRsI4JwkcCOXGxAqHnxMrtoby0sqosg8D4KKT4yu5uEe+A2xXGC1WII73CeJN6z/zoHm5c/wpLzp5jjYe5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bb6thhdW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bb6thhdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A8FC4CEF8;
	Fri, 29 Aug 2025 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756432588;
	bh=KUmRm6wGRzwd8d4vpk2py4TElSiA2CAsGm0SJ7MQvSE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Bb6thhdWxJ9y/sMC7wTqnt1ISQJJIkEWWLxGEDIIciZZ4aLeiusnDr8ziPwQPakuj
	 2ACbNlPMJzSlRew+ytmZuk9wWlOPv2lm+j0memCZ5SZoGhA+fU50XF3AYoX5sz2M76
	 hpRkE+traKZHZT6JDrS9S3+qBUYRNGTaJxIX+OQPlUSLq82thd4FRoAGS6V3iliFga
	 qWiXXzipxgt1vaBB5fntu2IX8jV4woteu8BJipccShsht1F1PpgZh/53gcXTmnpt8L
	 znXiBxJ9V1qnIbgW97TwOauOi2IDWmaxHSP5Q7zjQ72M15buSgkaCjeFaUufDy3EHd
	 QinW9vUadB5Gg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uroME-00000004Pr7-0qgE;
	Thu, 28 Aug 2025 21:56:50 -0400
Message-ID: <20250829015650.053498355@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 21:55:54 -0400
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
Subject: [PATCH 2/3] cdns3: Remove unused tracepoints
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

Remove the unused tracepoints of the cdns3 subsystem. They are:
cdns3_mapped_request
cdns3_map_request
cdns3_stream_transfer_split
cdns3_stream_transfer_split_next_part

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/usb/cdns3/cdns3-trace.h | 61 ---------------------------------
 1 file changed, 61 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-trace.h b/drivers/usb/cdns3/cdns3-trace.h
index c4e542f1b9b7..21a6a2ce7a3d 100644
--- a/drivers/usb/cdns3/cdns3-trace.h
+++ b/drivers/usb/cdns3/cdns3-trace.h
@@ -283,39 +283,6 @@ TRACE_EVENT(cdns3_ep0_queue,
 		  __entry->length)
 );
 
-DECLARE_EVENT_CLASS(cdns3_stream_split_transfer_len,
-	TP_PROTO(struct cdns3_request *req),
-	TP_ARGS(req),
-	TP_STRUCT__entry(
-		__string(name, req->priv_ep->name)
-		__field(struct cdns3_request *, req)
-		__field(unsigned int, length)
-		__field(unsigned int, actual)
-		__field(unsigned int, stream_id)
-	),
-	TP_fast_assign(
-		__assign_str(name);
-		__entry->req = req;
-		__entry->actual = req->request.length;
-		__entry->length = req->request.actual;
-		__entry->stream_id = req->request.stream_id;
-	),
-	TP_printk("%s: req: %p,request length: %u actual length: %u  SID: %u",
-		  __get_str(name), __entry->req, __entry->length,
-		  __entry->actual, __entry->stream_id)
-);
-
-DEFINE_EVENT(cdns3_stream_split_transfer_len, cdns3_stream_transfer_split,
-	     TP_PROTO(struct cdns3_request *req),
-	     TP_ARGS(req)
-);
-
-DEFINE_EVENT(cdns3_stream_split_transfer_len,
-	     cdns3_stream_transfer_split_next_part,
-	     TP_PROTO(struct cdns3_request *req),
-	     TP_ARGS(req)
-);
-
 DECLARE_EVENT_CLASS(cdns3_log_aligned_request,
 	TP_PROTO(struct cdns3_request *priv_req),
 	TP_ARGS(priv_req),
@@ -354,34 +321,6 @@ DEFINE_EVENT(cdns3_log_aligned_request, cdns3_prepare_aligned_request,
 	TP_ARGS(req)
 );
 
-DECLARE_EVENT_CLASS(cdns3_log_map_request,
-	TP_PROTO(struct cdns3_request *priv_req),
-	TP_ARGS(priv_req),
-	TP_STRUCT__entry(
-		__string(name, priv_req->priv_ep->name)
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
-DEFINE_EVENT(cdns3_log_map_request, cdns3_map_request,
-	     TP_PROTO(struct cdns3_request *req),
-	     TP_ARGS(req)
-);
-DEFINE_EVENT(cdns3_log_map_request, cdns3_mapped_request,
-	     TP_PROTO(struct cdns3_request *req),
-	     TP_ARGS(req)
-);
-
 DECLARE_EVENT_CLASS(cdns3_log_trb,
 	TP_PROTO(struct cdns3_endpoint *priv_ep, struct cdns3_trb *trb),
 	TP_ARGS(priv_ep, trb),
-- 
2.50.1


