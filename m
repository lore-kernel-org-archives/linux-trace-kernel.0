Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08A5EDE99E
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 10:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbjINKDx (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbjINKDv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C91BE9;
        Thu, 14 Sep 2023 03:03:47 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E8bGwG022131;
        Thu, 14 Sep 2023 10:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=pw3jsm3Y7QRnqw7h6E6O/yja2ZxxeTwhbEcz9szz+F4=;
 b=ammW6bMCi9WBwcKCEcs/AEWunbrB63TmS+MLmDcopFKbe3JglEwXwsewV2s/aQLfC7+o
 y+GJ1yDzdJ0HxrDIGQSNwgPNb/XynlqluI4zvNQa4GpQr2fmuzuXND+uP5CKWEHa+9N5
 E3f8WnxuEy4BxGUwdpkK2Plsg7HWYFd4XahqF1m9DCw7pVmJFQwNvpNf3p3LJ36hNAg9
 rEQzI/O6KOdhOstPfCUtt84TZXZFfN5LzqQElSk1man+vQgfvEekQ57f57Zp/93K4FHw
 HEfMzW8CakuU0NcUBFqiLbOYhBfGNqmopDZsz2f2ykCzUDgFp2u9r3HNh7Ah6AnxPgsg kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3dj8ankh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EA3Yj2009111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:34 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 03:03:28 -0700
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
Subject: [PATCH 4/8] usb: cdns3: trace: reduce buffer usage of trace event
Date:   Thu, 14 Sep 2023 18:02:58 +0800
Message-ID: <20230914100302.30274-5-quic_linyyuan@quicinc.com>
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
X-Proofpoint-GUID: u6MmEXlAa5kwgNQgTtSjQqEdoz5fK8MU
X-Proofpoint-ORIG-GUID: u6MmEXlAa5kwgNQgTtSjQqEdoz5fK8MU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=673 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140085
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Save u32 members into trace event ring buffer and parse it for possible
bit information.

Use DECLARE_EVENT_CLASS_PRINT_INIT() related macro for output stage.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 drivers/usb/cdns3/cdns3-trace.h | 201 ++++++++++++++++++++++----------
 drivers/usb/cdns3/cdnsp-trace.h | 105 +++++++++++------
 2 files changed, 209 insertions(+), 97 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-trace.h b/drivers/usb/cdns3/cdns3-trace.h
index 40db89e3333c..9711d4b48eb6 100644
--- a/drivers/usb/cdns3/cdns3-trace.h
+++ b/drivers/usb/cdns3/cdns3-trace.h
@@ -24,49 +24,73 @@
 
 #define CDNS3_MSG_MAX	500
 
-TRACE_EVENT(cdns3_halt,
+TRACE_EVENT_PRINT_INIT(cdns3_halt,
 	TP_PROTO(struct cdns3_endpoint *ep_priv, u8 halt, u8 flush),
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
 
-TRACE_EVENT(cdns3_wa1,
+TRACE_EVENT_PRINT_INIT(cdns3_wa1,
 	TP_PROTO(struct cdns3_endpoint *ep_priv, char *msg),
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
 
-TRACE_EVENT(cdns3_wa2,
+TRACE_EVENT_PRINT_INIT(cdns3_wa2,
 	TP_PROTO(struct cdns3_endpoint *ep_priv, char *msg),
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
-	TP_printk("WA2: %s %s", __get_str(ep_name), __get_str(msg))
+	TP_printk("WA2: %s %s", __s, __get_str(msg)),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 DECLARE_EVENT_CLASS(cdns3_log_doorbell,
@@ -114,18 +138,18 @@ DEFINE_EVENT(cdns3_log_usb_irq, cdns3_usb_irq,
 	TP_ARGS(priv_dev, usb_ists)
 );
 
-DECLARE_EVENT_CLASS(cdns3_log_epx_irq,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns3_log_epx_irq,
 	TP_PROTO(struct cdns3_device *priv_dev, struct cdns3_endpoint *priv_ep),
 	TP_ARGS(priv_dev, priv_ep),
 	TP_STRUCT__entry(
-		__string(ep_name, priv_ep->name)
+		__field(u32, edw3)
 		__field(u32, ep_sts)
 		__field(u32, ep_traddr)
 		__field(u32, ep_last_sid)
 		__field(u32, use_streams)
 	),
 	TP_fast_assign(
-		__assign_str(ep_name, priv_ep->name);
+		__entry->edw3 = priv_ep->endpoint.dw3;
 		__entry->ep_sts = readl(&priv_dev->regs->ep_sts);
 		__entry->ep_traddr = readl(&priv_dev->regs->ep_traddr);
 		__entry->ep_last_sid = priv_ep->last_stream_id;
@@ -133,11 +157,19 @@ DECLARE_EVENT_CLASS(cdns3_log_epx_irq,
 	),
 	TP_printk("%s, ep_traddr: %08x ep_last_sid: %08x use_streams: %d",
 		  cdns3_decode_epx_irq(__get_buf(CDNS3_MSG_MAX),
-				       __get_str(ep_name),
+				       __s,
 				       __entry->ep_sts),
 		  __entry->ep_traddr,
 		  __entry->ep_last_sid,
-		  __entry->use_streams)
+		  __entry->use_streams),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 DEFINE_EVENT(cdns3_log_epx_irq, cdns3_epx_irq,
@@ -195,51 +227,56 @@ DEFINE_EVENT(cdns3_log_ctrl, cdns3_ctrl_req,
 	TP_ARGS(ctrl)
 );
 
-DECLARE_EVENT_CLASS(cdns3_log_request,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns3_log_request,
 	TP_PROTO(struct cdns3_request *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
-		__string(name, req->priv_ep->name)
+		__field(u32, edw3)
 		__field(struct cdns3_request *, req)
 		__field(void *, buf)
 		__field(unsigned int, actual)
 		__field(unsigned int, length)
 		__field(int, status)
-		__field(int, zero)
-		__field(int, short_not_ok)
-		__field(int, no_interrupt)
+		__field(u32, rdw1)
 		__field(int, start_trb)
 		__field(int, end_trb)
 		__field(int, flags)
 		__field(unsigned int, stream_id)
 	),
 	TP_fast_assign(
-		__assign_str(name, req->priv_ep->name);
+		__entry->edw3 = req->priv_ep->endpoint.dw3;
 		__entry->req = req;
 		__entry->buf = req->request.buf;
 		__entry->actual = req->request.actual;
 		__entry->length = req->request.length;
 		__entry->status = req->request.status;
-		__entry->zero = req->request.zero;
-		__entry->short_not_ok = req->request.short_not_ok;
-		__entry->no_interrupt = req->request.no_interrupt;
+		__entry->rdw1 = req->request.dw1;
 		__entry->start_trb = req->start_trb;
 		__entry->end_trb = req->end_trb;
 		__entry->flags = req->flags;
-		__entry->stream_id = req->request.stream_id;
 	),
 	TP_printk("%s: req: %p, req buff %p, length: %u/%u %s%s%s, status: %d,"
 		  " trb: [start:%d, end:%d], flags:%x SID: %u",
-		__get_str(name), __entry->req, __entry->buf, __entry->actual,
+		__s, __entry->req, __entry->buf, __entry->actual,
 		__entry->length,
-		__entry->zero ? "Z" : "z",
-		__entry->short_not_ok ? "S" : "s",
-		__entry->no_interrupt ? "I" : "i",
+		tr.zero ? "Z" : "z",
+		tr.short_not_ok ? "S" : "s",
+		tr.no_interrupt ? "I" : "i",
 		__entry->status,
 		__entry->start_trb,
 		__entry->end_trb,
 		__entry->flags,
-		__entry->stream_id
+		tr.stream_id
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
 
@@ -283,26 +320,34 @@ TRACE_EVENT(cdns3_ep0_queue,
 		  __entry->length)
 );
 
-DECLARE_EVENT_CLASS(cdns3_stream_split_transfer_len,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns3_stream_split_transfer_len,
 	TP_PROTO(struct cdns3_request *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
-		__string(name, req->priv_ep->name)
+		__field(u32, edw3)
 		__field(struct cdns3_request *, req)
 		__field(unsigned int, length)
 		__field(unsigned int, actual)
 		__field(unsigned int, stream_id)
 	),
 	TP_fast_assign(
-		__assign_str(name, req->priv_ep->name);
+		__entry->edw3 = req->priv_ep->endpoint.dw3;
 		__entry->req = req;
 		__entry->actual = req->request.length;
 		__entry->length = req->request.actual;
 		__entry->stream_id = req->request.stream_id;
 	),
 	TP_printk("%s: req: %p,request length: %u actual length: %u  SID: %u",
-		  __get_str(name), __entry->req, __entry->length,
-		  __entry->actual, __entry->stream_id)
+		  __s, __entry->req, __entry->length,
+		  __entry->actual, __entry->stream_id),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 DEFINE_EVENT(cdns3_stream_split_transfer_len, cdns3_stream_transfer_split,
@@ -316,11 +361,11 @@ DEFINE_EVENT(cdns3_stream_split_transfer_len,
 	     TP_ARGS(req)
 );
 
-DECLARE_EVENT_CLASS(cdns3_log_aligned_request,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns3_log_aligned_request,
 	TP_PROTO(struct cdns3_request *priv_req),
 	TP_ARGS(priv_req),
 	TP_STRUCT__entry(
-		__string(name, priv_req->priv_ep->name)
+		__field(u32, edw3)
 		__field(struct usb_request *, req)
 		__field(void *, buf)
 		__field(dma_addr_t, dma)
@@ -329,7 +374,7 @@ DECLARE_EVENT_CLASS(cdns3_log_aligned_request,
 		__field(u32, aligned_buf_size)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_req->priv_ep->name);
+		__entry->edw3 = priv_req->priv_ep->endpoint.dw3;
 		__entry->req = &priv_req->request;
 		__entry->buf = priv_req->request.buf;
 		__entry->dma = priv_req->request.dma;
@@ -338,9 +383,17 @@ DECLARE_EVENT_CLASS(cdns3_log_aligned_request,
 		__entry->aligned_buf_size = priv_req->aligned_buf->size;
 	),
 	TP_printk("%s: req: %p, req buf %p, dma %pad a_buf %p a_dma %pad, size %d",
-		__get_str(name), __entry->req, __entry->buf, &__entry->dma,
+		__s, __entry->req, __entry->buf, &__entry->dma,
 		__entry->aligned_buf, &__entry->aligned_dma,
 		__entry->aligned_buf_size
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
 
@@ -354,23 +407,31 @@ DEFINE_EVENT(cdns3_log_aligned_request, cdns3_prepare_aligned_request,
 	TP_ARGS(req)
 );
 
-DECLARE_EVENT_CLASS(cdns3_log_map_request,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns3_log_map_request,
 	TP_PROTO(struct cdns3_request *priv_req),
 	TP_ARGS(priv_req),
 	TP_STRUCT__entry(
-		__string(name, priv_req->priv_ep->name)
+		__field(u32, edw3)
 		__field(struct usb_request *, req)
 		__field(void *, buf)
 		__field(dma_addr_t, dma)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_req->priv_ep->name);
+		__entry->edw3 = priv_req->priv_ep->endpoint.dw3;
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
 DEFINE_EVENT(cdns3_log_map_request, cdns3_map_request,
@@ -382,11 +443,11 @@ DEFINE_EVENT(cdns3_log_map_request, cdns3_mapped_request,
 	     TP_ARGS(req)
 );
 
-DECLARE_EVENT_CLASS(cdns3_log_trb,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns3_log_trb,
 	TP_PROTO(struct cdns3_endpoint *priv_ep, struct cdns3_trb *trb),
 	TP_ARGS(priv_ep, trb),
 	TP_STRUCT__entry(
-		__string(name, priv_ep->name)
+		__field(u32, edw3)
 		__field(struct cdns3_trb *, trb)
 		__field(u32, buffer)
 		__field(u32, length)
@@ -395,7 +456,7 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
 		__field(unsigned int, last_stream_id)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_ep->name);
+		__entry->edw3 = priv_ep->endpoint.dw3;
 		__entry->trb = trb;
 		__entry->buffer = le32_to_cpu(trb->buffer);
 		__entry->length = le32_to_cpu(trb->length);
@@ -404,7 +465,7 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
 		__entry->last_stream_id = priv_ep->last_stream_id;
 	),
 	TP_printk("%s: trb %p, dma buf: 0x%08x, size: %ld, burst: %d ctrl: 0x%08x (%s%s%s%s%s%s%s) SID:%lu LAST_SID:%u",
-		__get_str(name), __entry->trb, __entry->buffer,
+		__s, __entry->trb, __entry->buffer,
 		TRB_LEN(__entry->length),
 		(u8)TRB_BURST_LEN_GET(__entry->length),
 		__entry->control,
@@ -417,6 +478,14 @@ DECLARE_EVENT_CLASS(cdns3_log_trb,
 		TRB_FIELD_TO_TYPE(__entry->control) == TRB_NORMAL ? "Normal" : "LINK",
 		TRB_FIELD_TO_STREAMID(__entry->control),
 		__entry->last_stream_id
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
 
@@ -451,28 +520,24 @@ DEFINE_EVENT(cdns3_log_ring, cdns3_ring,
 	TP_ARGS(priv_ep)
 );
 
-DECLARE_EVENT_CLASS(cdns3_log_ep,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdns3_log_ep,
 	TP_PROTO(struct cdns3_endpoint *priv_ep),
 	TP_ARGS(priv_ep),
 	TP_STRUCT__entry(
-		__string(name, priv_ep->name)
-		__field(unsigned int, maxpacket)
-		__field(unsigned int, maxpacket_limit)
-		__field(unsigned int, max_streams)
+		__field(u32, edw3)
+		__field(u32, edw1)
+		__field(u32, edw2)
 		__field(unsigned int, use_streams)
-		__field(unsigned int, maxburst)
 		__field(unsigned int, flags)
 		__field(unsigned int, dir)
 		__field(u8, enqueue)
 		__field(u8, dequeue)
 	),
 	TP_fast_assign(
-		__assign_str(name, priv_ep->name);
-		__entry->maxpacket = priv_ep->endpoint.maxpacket;
-		__entry->maxpacket_limit = priv_ep->endpoint.maxpacket_limit;
-		__entry->max_streams = priv_ep->endpoint.max_streams;
+		__entry->edw3 = priv_ep->endpoint.dw3;
+		__entry->edw2 = priv_ep->endpoint.dw2;
+		__entry->edw1 = priv_ep->endpoint.dw1;
 		__entry->use_streams = priv_ep->use_streams;
-		__entry->maxburst = priv_ep->endpoint.maxburst;
 		__entry->flags = priv_ep->flags;
 		__entry->dir = priv_ep->dir;
 		__entry->enqueue = priv_ep->enqueue;
@@ -480,10 +545,10 @@ DECLARE_EVENT_CLASS(cdns3_log_ep,
 	),
 	TP_printk("%s: mps: %d/%d. streams: %d, stream enable: %d, burst: %d, "
 		  "enq idx: %d, deq idx: %d, flags %s%s%s%s%s%s%s%s, dir: %s",
-		__get_str(name), __entry->maxpacket,
-		__entry->maxpacket_limit, __entry->max_streams,
+		__s, te.maxpacket,
+		te.maxpacket_limit, te.max_streams,
 		__entry->use_streams,
-		__entry->maxburst, __entry->enqueue,
+		te.maxburst, __entry->enqueue,
 		__entry->dequeue,
 		__entry->flags & EP_ENABLED ? "EN | " : "",
 		__entry->flags & EP_STALLED ? "STALLED | " : "",
@@ -494,6 +559,16 @@ DECLARE_EVENT_CLASS(cdns3_log_ep,
 		__entry->flags & EP_RING_FULL ? "RING FULL |" : "",
 		__entry->flags & EP_CLAIMED ?  "CLAIMED " : "",
 		__entry->dir ? "IN" : "OUT"
+	),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw1 = __entry->edw1;
+		te.dw2 = __entry->edw2;
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
 	)
 );
 
diff --git a/drivers/usb/cdns3/cdnsp-trace.h b/drivers/usb/cdns3/cdnsp-trace.h
index 4b51011eb00b..e749e80a2ee1 100644
--- a/drivers/usb/cdns3/cdnsp-trace.h
+++ b/drivers/usb/cdns3/cdnsp-trace.h
@@ -34,11 +34,11 @@
  */
 #define CDNSP_MSG_MAX 500
 
-DECLARE_EVENT_CLASS(cdnsp_log_ep,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdnsp_log_ep,
 	TP_PROTO(struct cdnsp_ep *pep, u32 stream_id),
 	TP_ARGS(pep, stream_id),
 	TP_STRUCT__entry(
-		__string(name, pep->name)
+		__field(u32, edw3)
 		__field(unsigned int, state)
 		__field(u32, stream_id)
 		__field(u8, enabled)
@@ -48,7 +48,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_ep,
 		__field(u8, drbls_count)
 	),
 	TP_fast_assign(
-		__assign_str(name, pep->name);
+		__entry->edw3 = pep->endpoint.dw3;
 		__entry->state = pep->ep_state;
 		__entry->stream_id = stream_id;
 		__entry->enabled = pep->ep_state & EP_HAS_STREAMS;
@@ -59,9 +59,17 @@ DECLARE_EVENT_CLASS(cdnsp_log_ep,
 	),
 	TP_printk("%s: SID: %08x, ep state: %x, stream: enabled: %d num %d "
 		  "tds %d, first prime: %d drbls %d",
-		  __get_str(name), __entry->stream_id, __entry->state,
+		  __s, __entry->stream_id, __entry->state,
 		  __entry->enabled, __entry->num_streams, __entry->td_count,
-		  __entry->first_prime_det, __entry->drbls_count)
+		  __entry->first_prime_det, __entry->drbls_count),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 DEFINE_EVENT(cdnsp_log_ep, cdnsp_tr_drbl,
@@ -291,27 +299,35 @@ DEFINE_EVENT(cdnsp_log_ctrl, cdnsp_ctrl_req,
 	TP_ARGS(ctrl)
 );
 
-DECLARE_EVENT_CLASS(cdnsp_log_bounce,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdnsp_log_bounce,
 	TP_PROTO(struct cdnsp_request *preq, u32 new_buf_len, u32 offset,
 		 dma_addr_t dma, unsigned int unalign),
 	TP_ARGS(preq, new_buf_len, offset, dma, unalign),
 	TP_STRUCT__entry(
-		__string(name, preq->pep->name)
+		__field(u32, edw3)
 		__field(u32, new_buf_len)
 		__field(u32, offset)
 		__field(dma_addr_t, dma)
 		__field(unsigned int, unalign)
 	),
 	TP_fast_assign(
-		__assign_str(name, preq->pep->name);
+		__entry->edw3 = preq->pep->endpoint.dw3;
 		__entry->new_buf_len = new_buf_len;
 		__entry->offset = offset;
 		__entry->dma = dma;
 		__entry->unalign = unalign;
 	),
 	TP_printk("%s buf len %d, offset %d, dma %pad, unalign %d",
-		  __get_str(name), __entry->new_buf_len,
+		  __s, __entry->new_buf_len,
 		  __entry->offset, &__entry->dma, __entry->unalign
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
 
@@ -448,11 +464,11 @@ DEFINE_EVENT(cdnsp_log_pdev, cdnsp_setup_addressable_priv_device,
 	TP_ARGS(vdev)
 );
 
-DECLARE_EVENT_CLASS(cdnsp_log_request,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdnsp_log_request,
 	TP_PROTO(struct cdnsp_request *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
-		__string(name, req->pep->name)
+		__field(u32, edw3)
 		__field(struct usb_request *, request)
 		__field(struct cdnsp_request *, preq)
 		__field(void *, buf)
@@ -460,17 +476,14 @@ DECLARE_EVENT_CLASS(cdnsp_log_request,
 		__field(unsigned int, length)
 		__field(int, status)
 		__field(dma_addr_t, dma)
-		__field(unsigned int, stream_id)
-		__field(unsigned int, zero)
-		__field(unsigned int, short_not_ok)
-		__field(unsigned int, no_interrupt)
+		__field(u32, rdw1)
 		__field(struct scatterlist*, sg)
 		__field(unsigned int, num_sgs)
 		__field(unsigned int, num_mapped_sgs)
 
 	),
 	TP_fast_assign(
-		__assign_str(name, req->pep->name);
+		__entry->edw3 = req->pep->endpoint.dw3;
 		__entry->request = &req->request;
 		__entry->preq = req;
 		__entry->buf = req->request.buf;
@@ -478,10 +491,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_request,
 		__entry->length = req->request.length;
 		__entry->status = req->request.status;
 		__entry->dma = req->request.dma;
-		__entry->stream_id = req->request.stream_id;
-		__entry->zero = req->request.zero;
-		__entry->short_not_ok = req->request.short_not_ok;
-		__entry->no_interrupt = req->request.no_interrupt;
+		__entry->rdw1 = req->request.dw1;
 		__entry->sg = req->request.sg;
 		__entry->num_sgs = req->request.num_sgs;
 		__entry->num_mapped_sgs = req->request.num_mapped_sgs;
@@ -489,14 +499,24 @@ DECLARE_EVENT_CLASS(cdnsp_log_request,
 	TP_printk("%s; req U:%p/P:%p, req buf %p, length %u/%u, status %d, "
 		  "buf dma (%pad), SID %u, %s%s%s, sg %p, num_sg %d,"
 		  " num_m_sg %d",
-		  __get_str(name), __entry->request, __entry->preq,
+		  __s, __entry->request, __entry->preq,
 		  __entry->buf, __entry->actual, __entry->length,
 		  __entry->status, &__entry->dma,
-		  __entry->stream_id, __entry->zero ? "Z" : "z",
-		  __entry->short_not_ok ? "S" : "s",
-		  __entry->no_interrupt ? "I" : "i",
+		  tr.stream_id, tr.zero ? "Z" : "z",
+		  tr.short_not_ok ? "S" : "s",
+		  tr.no_interrupt ? "I" : "i",
 		  __entry->sg, __entry->num_sgs, __entry->num_mapped_sgs
-		)
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
+	)
 );
 
 DEFINE_EVENT(cdnsp_log_request, cdnsp_request_enqueue,
@@ -662,11 +682,11 @@ DEFINE_EVENT(cdnsp_log_slot_ctx, cdnsp_configure_endpoint,
 	TP_ARGS(ctx)
 );
 
-DECLARE_EVENT_CLASS(cdnsp_log_td_info,
+DECLARE_EVENT_CLASS_PRINT_INIT(cdnsp_log_td_info,
 	TP_PROTO(struct cdnsp_request *preq),
 	TP_ARGS(preq),
 	TP_STRUCT__entry(
-		__string(name, preq->pep->name)
+		__field(u32, edw3)
 		__field(struct usb_request *, request)
 		__field(struct cdnsp_request *, preq)
 		__field(union cdnsp_trb *, first_trb)
@@ -674,7 +694,7 @@ DECLARE_EVENT_CLASS(cdnsp_log_td_info,
 		__field(dma_addr_t, trb_dma)
 	),
 	TP_fast_assign(
-		__assign_str(name, preq->pep->name);
+		__entry->edw3 = preq->pep->endpoint.dw3;
 		__entry->request = &preq->request;
 		__entry->preq = preq;
 		__entry->first_trb = preq->td.first_trb;
@@ -683,10 +703,18 @@ DECLARE_EVENT_CLASS(cdnsp_log_td_info,
 							 preq->td.first_trb)
 	),
 	TP_printk("%s req/preq:  %p/%p, first trb %p[vir]/%pad(dma), last trb %p",
-		  __get_str(name), __entry->request, __entry->preq,
+		  __s, __entry->request, __entry->preq,
 		  __entry->first_trb, &__entry->trb_dma,
 		  __entry->last_trb
-		)
+	),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 DEFINE_EVENT(cdnsp_log_td_info, cdnsp_remove_request_td,
@@ -796,21 +824,30 @@ DEFINE_EVENT(cdnsp_log_portsc, cdnsp_link_state_changed,
 		TP_ARGS(portnum, portsc)
 );
 
-TRACE_EVENT(cdnsp_stream_number,
+TRACE_EVENT_PRINT_INIT(cdnsp_stream_number,
 	TP_PROTO(struct cdnsp_ep *pep, int num_stream_ctxs, int num_streams),
 	TP_ARGS(pep, num_stream_ctxs, num_streams),
 	TP_STRUCT__entry(
-		__string(name, pep->name)
+		__field(u32, edw3)
 		__field(int, num_stream_ctxs)
 		__field(int, num_streams)
 	),
 	TP_fast_assign(
+		__entry->edw3 = pep->endpoint.dw3;
 		__entry->num_stream_ctxs = num_stream_ctxs;
 		__entry->num_streams = num_streams;
 	),
 	TP_printk("%s Need %u stream ctx entries for %u stream IDs.",
-		  __get_str(name), __entry->num_stream_ctxs,
-		  __entry->num_streams)
+		  __s, __entry->num_stream_ctxs,
+		  __entry->num_streams),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
+	)
 );
 
 #endif /* __CDNSP_TRACE_H */
-- 
2.17.1

