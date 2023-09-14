Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B62EDE9A0
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 10:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbjINKD7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbjINKD7 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE3A1BEA;
        Thu, 14 Sep 2023 03:03:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E9AxfC030138;
        Thu, 14 Sep 2023 10:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=2D0NkypXItHJBLjpDcaztYTa/IRT7vftCoAENU2fS+M=;
 b=Yzvakjsjc399NNCLBkl+mtn4P5C/d0OKEHkfXV9kAo5xG03n/+N051YOZREIswdURgij
 xA/z2zqtFXoBCFJOoLtCpomVNmyIEDdxp5ICIk6dracrEezCbo/YfVo/Y6bqDsA0Rrv9
 Mf74ix8zkqwUuqRncmcceRBDyc3gE2pGXr9p1tnpQ1XEBpFOgL9M3D7quMxlNfTXaCTS
 e54+tlHfAKA2J5JFBRMViyH1VyXXLdGMqvNlvSoLqS0+bNtfbWYnFIuBjf4xF0YKPwCd
 HfVS26pLsCGIxu+1bJMP6DQtGLTEJFMTi5efa5AtqtOQKLB7+BzM9PgmS9lPfAMFtWmy Og== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3h0dj3b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EA3fcE009439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:41 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 03:03:38 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        "Linyu Yuan" <quic_linyyuan@quicinc.com>
Subject: [PATCH 6/8] usb: cdns2: trace: reduce buffer usage of trace event
Date:   Thu, 14 Sep 2023 18:03:00 +0800
Message-ID: <20230914100302.30274-7-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
References: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QfYC7P6oIR5HaWyVV3TOvgy4kEflsIN5
X-Proofpoint-GUID: QfYC7P6oIR5HaWyVV3TOvgy4kEflsIN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=688 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140085
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Save u32 members into trace event ring buffer and parse it for possible
bit information.

Use DECLARE_EVENT_CLASS_PRINT_INIT() related macro for output stage.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h | 175 ++++++++++++++-------
 1 file changed, 121 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-trace.h b/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
index 61f241634ea5..f81caa12cb63 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-trace.h
@@ -94,51 +94,74 @@ DEFINE_EVENT(cdns2_log_simple, cdns2_device_state,
 	TP_ARGS(msg)
 );
 
-TRACE_EVENT(cdns2_ep_halt,
+TRACE_EVENT_PRINT_INIT(cdns2_ep_halt,
 	TP_PROTO(struct cdns2_endpoint *ep_priv, u8 halt, u8 flush),
 	TP_ARGS(ep_priv, halt, flush),
 	TP_STRUCT__entry(
-		__string(name, ep_priv->name)
+		__field(u32, edw3)
 		__field(u8, halt)
 		__field(u8, flush)
 	),
 	TP_fast_assign(
-		__assign_str(name, ep_priv->name);
+		__entry->edw3 = ep_priv->endpoint.dw3;
 		__entry->halt = halt;
 		__entry->flush = flush;
 	),
 	TP_printk("Halt %s for %s: %s", __entry->flush ? " and flush" : "",
-		  __get_str(name), __entry->halt ? "set" : "cleared")
+		  __s, __entry->halt ? "set" : "cleared"),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
-TRACE_EVENT(cdns2_wa1,
+TRACE_EVENT_PRINT_INIT(cdns2_wa1,
 	TP_PROTO(struct cdns2_endpoint *ep_priv, char *msg),
 	TP_ARGS(ep_priv, msg),
 	TP_STRUCT__entry(
-		__string(ep_name, ep_priv->name)
+		__field(u32, edw3)
 		__string(msg, msg)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, ep_priv->name);
+		__entry->edw3 = ep_priv->endpoint.dw3;
 		__assign_str(msg, msg);
 	),
-	TP_printk("WA1: %s %s", __get_str(ep_name), __get_str(msg))
+	TP_printk("WA1: %s %s", __s, __get_str(msg)),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
-DECLARE_EVENT_CLASS(cdns2_log_doorbell,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns2_log_doorbell,
 	TP_PROTO(struct cdns2_endpoint *pep, u32 ep_trbaddr),
 	TP_ARGS(pep, ep_trbaddr),
 	TP_STRUCT__entry(
-		__string(name, pep->num ? pep->name :
-				(pep->dir ? "ep0in" : "ep0out"))
+		__field(u32, edw3)
 		__field(u32, ep_trbaddr)
 	),
 	TP_fast_assign(
-		__assign_str(name, pep->name);
+		__entry->edw3 = pep->endpoint.dw3;
 		__entry->ep_trbaddr = ep_trbaddr;
 	),
-	TP_printk("%s, ep_trbaddr %08x", __get_str(name),
-		  __entry->ep_trbaddr)
+	TP_printk("%s, ep_trbaddr %08x", __s,
+		  __entry->ep_trbaddr),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 DEFINE_EVENT(cdns2_log_doorbell, cdns2_doorbell_ep0,
@@ -186,26 +209,34 @@ TRACE_EVENT(cdns2_dma_ep_ists,
 		  __entry->dma_ep_ists >> 16)
 );
 
-DECLARE_EVENT_CLASS(cdns2_log_epx_irq,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns2_log_epx_irq,
 	TP_PROTO(struct cdns2_device *pdev, struct cdns2_endpoint *pep),
 	TP_ARGS(pdev, pep),
 	TP_STRUCT__entry(
-		__string(ep_name, pep->name)
+		__field(u32, edw3)
 		__field(u32, ep_sts)
 		__field(u32, ep_ists)
 		__field(u32, ep_traddr)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, pep->name);
+		__entry->edw3 = pep->endpoint.dw3;
 		__entry->ep_sts = readl(&pdev->adma_regs->ep_sts);
 		__entry->ep_ists = readl(&pdev->adma_regs->ep_ists);
 		__entry->ep_traddr = readl(&pdev->adma_regs->ep_traddr);
 	),
 	TP_printk("%s, ep_traddr: %08x",
 		  cdns2_decode_epx_irq(__get_buf(CDNS2_MSG_MAX), CDNS2_MSG_MAX,
-				       __get_str(ep_name),
+				       __s,
 				       __entry->ep_ists, __entry->ep_sts),
-		  __entry->ep_traddr)
+		  __entry->ep_traddr),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 DEFINE_EVENT(cdns2_log_epx_irq, cdns2_epx_irq,
@@ -266,11 +297,11 @@ DEFINE_EVENT(cdns2_log_ctrl, cdns2_ctrl_req,
 	TP_ARGS(ctrl)
 );
 
-DECLARE_EVENT_CLASS(cdns2_log_request,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns2_log_request,
 	TP_PROTO(struct cdns2_request *preq),
 	TP_ARGS(preq),
 	TP_STRUCT__entry(
-		__string(name, preq->pep->name)
+		__field(u32, edw3)
 		__field(struct usb_request *, request)
 		__field(struct cdns2_request *, preq)
 		__field(void *, buf)
@@ -278,9 +309,7 @@ DECLARE_EVENT_CLASS(cdns2_log_request,
 		__field(unsigned int, length)
 		__field(int, status)
 		__field(dma_addr_t, dma)
-		__field(int, zero)
-		__field(int, short_not_ok)
-		__field(int, no_interrupt)
+		__field(u32, rdw1)
 		__field(struct scatterlist*, sg)
 		__field(unsigned int, num_sgs)
 		__field(unsigned int, num_mapped_sgs)
@@ -288,7 +317,7 @@ DECLARE_EVENT_CLASS(cdns2_log_request,
 		__field(int, end_trb)
 	),
 	TP_fast_assign(
-		__assign_str(name, preq->pep->name);
+		__entry->edw3 = preq->pep->endpoint.dw3;
 		__entry->request = &preq->request;
 		__entry->preq = preq;
 		__entry->buf = preq->request.buf;
@@ -296,9 +325,7 @@ DECLARE_EVENT_CLASS(cdns2_log_request,
 		__entry->length = preq->request.length;
 		__entry->status = preq->request.status;
 		__entry->dma = preq->request.dma;
-		__entry->zero = preq->request.zero;
-		__entry->short_not_ok = preq->request.short_not_ok;
-		__entry->no_interrupt = preq->request.no_interrupt;
+		__entry->rdw1 = preq->request.dw1;
 		__entry->sg = preq->request.sg;
 		__entry->num_sgs = preq->request.num_sgs;
 		__entry->num_mapped_sgs = preq->request.num_mapped_sgs;
@@ -308,15 +335,25 @@ DECLARE_EVENT_CLASS(cdns2_log_request,
 	TP_printk("%s: req: %p, preq: %p, req buf: %p, length: %u/%u, status: %d,"
 		  "buf dma: (%pad), %s%s%s, sg: %p, num_sgs: %d, num_m_sgs: %d,"
 		  "trb: [start: %d, end: %d]",
-		  __get_str(name), __entry->request, __entry->preq,
+		  __s, __entry->request, __entry->preq,
 		  __entry->buf, __entry->actual, __entry->length,
 		  __entry->status, &__entry->dma,
-		  __entry->zero ? "Z" : "z",
-		  __entry->short_not_ok ? "S" : "s",
-		  __entry->no_interrupt ? "I" : "i",
+		  tr.zero ? "Z" : "z",
+		  tr.short_not_ok ? "S" : "s",
+		  tr.no_interrupt ? "I" : "i",
 		  __entry->sg, __entry->num_sgs, __entry->num_mapped_sgs,
 		  __entry->start_trb,
 		  __entry->end_trb
+	),
+	TP_printk_init(
+		struct usb_ep te;
+		struct usb_request tr;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		tr.dw1 = __entry->rdw1;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
 	)
 );
 
@@ -370,23 +407,31 @@ TRACE_EVENT(cdns2_ep0_enqueue,
 		  __entry->length)
 );
 
-DECLARE_EVENT_CLASS(cdns2_log_map_request,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns2_log_map_request,
 	TP_PROTO(struct cdns2_request *priv_req),
 	TP_ARGS(priv_req),
 	TP_STRUCT__entry(
-		__string(name, priv_req->pep->name)
+		__field(u32, edw3)
 		__field(struct usb_request *, req)
 		__field(void *, buf)
 		__field(dma_addr_t, dma)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_req->pep->name);
+		__entry->edw3 = priv_req->pep->endpoint.dw3;
 		__entry->req = &priv_req->request;
 		__entry->buf = priv_req->request.buf;
 		__entry->dma = priv_req->request.dma;
 	),
 	TP_printk("%s: req: %p, req buf %p, dma %p",
-		  __get_str(name), __entry->req, __entry->buf, &__entry->dma
+		  __s, __entry->req, __entry->buf, &__entry->dma
+	),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
 	)
 );
 
@@ -399,11 +444,11 @@ DEFINE_EVENT(cdns2_log_map_request, cdns2_mapped_request,
 	     TP_ARGS(req)
 );
 
-DECLARE_EVENT_CLASS(cdns2_log_trb,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns2_log_trb,
 	TP_PROTO(struct cdns2_endpoint *pep, struct cdns2_trb *trb),
 	TP_ARGS(pep, trb),
 	TP_STRUCT__entry(
-		__string(name, pep->name)
+		__field(u32, edw3)
 		__field(struct cdns2_trb *, trb)
 		__field(u32, buffer)
 		__field(u32, length)
@@ -411,7 +456,7 @@ DECLARE_EVENT_CLASS(cdns2_log_trb,
 		__field(u32, type)
 	),
 	TP_fast_assign(
-		__assign_str(name, pep->name);
+		__entry->edw3 = pep->endpoint.dw3;
 		__entry->trb = trb;
 		__entry->buffer = le32_to_cpu(trb->buffer);
 		__entry->length = le32_to_cpu(trb->length);
@@ -419,10 +464,18 @@ DECLARE_EVENT_CLASS(cdns2_log_trb,
 		__entry->type = usb_endpoint_type(pep->endpoint.desc);
 	),
 	TP_printk("%s: trb V: %p, dma buf: P: 0x%08x, %s",
-		 __get_str(name), __entry->trb, __entry->buffer,
+		 __s, __entry->trb, __entry->buffer,
 		 cdns2_decode_trb(__get_buf(CDNS2_MSG_MAX), CDNS2_MSG_MAX,
 				  __entry->control, __entry->length,
-				  __entry->buffer))
+				  __entry->buffer)),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 DEFINE_EVENT(cdns2_log_trb, cdns2_queue_trb,
@@ -463,22 +516,20 @@ DEFINE_EVENT(cdns2_log_ring, cdns2_ring,
 	TP_ARGS(pep)
 );
 
-DECLARE_EVENT_CLASS(cdns2_log_ep,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns2_log_ep,
 	TP_PROTO(struct cdns2_endpoint *pep),
 	TP_ARGS(pep),
 	TP_STRUCT__entry(
-		__string(name, pep->name)
-		__field(unsigned int, maxpacket)
-		__field(unsigned int, maxpacket_limit)
+		__field(u32, edw3)
+		__field(u32, edw1)
 		__field(unsigned int, flags)
 		__field(unsigned int, dir)
 		__field(u8, enqueue)
 		__field(u8, dequeue)
 	),
 	TP_fast_assign(
-		__assign_str(name, pep->name);
-		__entry->maxpacket = pep->endpoint.maxpacket;
-		__entry->maxpacket_limit = pep->endpoint.maxpacket_limit;
+		__entry->edw3 = pep->endpoint.dw3;
+		__entry->edw1 = pep->endpoint.dw1;
 		__entry->flags = pep->ep_state;
 		__entry->dir = pep->dir;
 		__entry->enqueue = pep->ring.enqueue;
@@ -486,14 +537,22 @@ DECLARE_EVENT_CLASS(cdns2_log_ep,
 	),
 	TP_printk("%s: mps: %d/%d, enq idx: %d, deq idx: %d, "
 		  "flags: %s%s%s%s, dir: %s",
-		__get_str(name), __entry->maxpacket,
-		__entry->maxpacket_limit, __entry->enqueue,
+		__s, te.maxpacket,
+		te.maxpacket_limit, __entry->enqueue,
 		__entry->dequeue,
 		__entry->flags & EP_ENABLED ? "EN | " : "",
 		__entry->flags & EP_STALLED ? "STALLED | " : "",
 		__entry->flags & EP_WEDGE ? "WEDGE | " : "",
 		__entry->flags & EP_RING_FULL ? "RING FULL |" : "",
 		__entry->dir ? "IN" : "OUT"
+	),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
 	)
 );
 
@@ -555,11 +614,11 @@ DEFINE_EVENT(cdns2_log_request_handled, cdns2_request_handled,
 	TP_ARGS(priv_req, current_index, handled)
 );
 
-DECLARE_EVENT_CLASS(cdns2_log_epx_reg_config,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns2_log_epx_reg_config,
 	TP_PROTO(struct cdns2_device *pdev, struct cdns2_endpoint *pep),
 	TP_ARGS(pdev, pep),
 	TP_STRUCT__entry(
-		__string(ep_name, pep->name)
+		__field(u32, edw3)
 		__field(u8, burst_size)
 		__field(__le16, maxpack_reg)
 		__field(__u8, con_reg)
@@ -568,7 +627,7 @@ DECLARE_EVENT_CLASS(cdns2_log_epx_reg_config,
 		__field(u32, ep_cfg_reg)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, pep->name);
+		__entry->edw3 = pep->endpoint.dw3;
 		__entry->burst_size = pep->trb_burst_size;
 		__entry->maxpack_reg = pep->dir ? readw(&pdev->epx_regs->txmaxpack[pep->num - 1]) :
 						  readw(&pdev->epx_regs->rxmaxpack[pep->num - 1]);
@@ -581,9 +640,17 @@ DECLARE_EVENT_CLASS(cdns2_log_epx_reg_config,
 
 	TP_printk("%s, maxpack: %d, con: %02x, dma_ep_sel: %08x, dma_ep_sts_en: %08x"
 		  " dma_ep_cfg %08x",
-		  __get_str(ep_name), __entry->maxpack_reg, __entry->con_reg,
+		 __s, __entry->maxpack_reg, __entry->con_reg,
 		  __entry->ep_sel_reg, __entry->ep_sts_en_reg,
 		  __entry->ep_cfg_reg
+	),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
 	)
 );
 
-- 
2.17.1

