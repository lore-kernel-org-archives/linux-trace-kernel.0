Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D577CEDE99F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 10:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbjINKDy (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjINKDx (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4551BE3;
        Thu, 14 Sep 2023 03:03:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E9NJOu025935;
        Thu, 14 Sep 2023 10:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7Iitds83LGkA0Fe0fAhAW0xdV+NJrmCnBhamduXSc5g=;
 b=HVZOrxXbEt1KjkJSis+gTpO+0Fd24nfBczruU5a+B8MJ9W1yBiGHP/Io41L5zL/PJjNQ
 SIj7pzOYfPKdz0cSu5cvHjONQUZOs9JpDHqn8AnfD/0kP1zTPEdoardAJdmdmZEj2zmu
 Fe2HaSsOAu4xxGtdhtlDgim2RVz38IMEuWqGJFD8XSAv8in8InA/CmU+GDkBFQGWrVXa
 49Z+IBf6m4ITwxDmnrMXvqpc3m1ZbgMuiR2HI+aIbVq7h1jH7Gna23UWBJvMZqFHn3g1
 guOUJVClEM+AXH3HQawbUDy+ss4Pf/UJJNyCMvlRzjT4cQ1STAElUrkWKZA/zsShhgrk dw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3wx18c4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:39 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EA3beL023170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:37 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 03:03:34 -0700
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
Subject: [PATCH 5/8] usb: dwc3: trace: reduce buffer usage of trace event
Date:   Thu, 14 Sep 2023 18:02:59 +0800
Message-ID: <20230914100302.30274-6-quic_linyyuan@quicinc.com>
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
X-Proofpoint-GUID: JK6VnH0Aeh1MFu9mm9Am2joVAmpztIz_
X-Proofpoint-ORIG-GUID: JK6VnH0Aeh1MFu9mm9Am2joVAmpztIz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=710 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140085
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Save u32 members into trace event ring buffer and parse it for possible
bit information.

Use DECLARE_EVENT_CLASS_PRINT_INIT() related macro for output stage.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 drivers/usb/dwc3/trace.h | 99 +++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 36 deletions(-)

diff --git a/drivers/usb/dwc3/trace.h b/drivers/usb/dwc3/trace.h
index d2997d17cfbe..3caac180b225 100644
--- a/drivers/usb/dwc3/trace.h
+++ b/drivers/usb/dwc3/trace.h
@@ -98,35 +98,41 @@ DEFINE_EVENT(dwc3_log_ctrl, dwc3_ctrl_req,
 	TP_ARGS(ctrl)
 );
 
-DECLARE_EVENT_CLASS(dwc3_log_request,
+DECLARE_EVENT_CLASS_PRINT_INIT(dwc3_log_request,
 	TP_PROTO(struct dwc3_request *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
-		__string(name, req->dep->name)
+		__field(u32, edw3)
 		__field(struct dwc3_request *, req)
 		__field(unsigned int, actual)
 		__field(unsigned int, length)
 		__field(int, status)
-		__field(int, zero)
-		__field(int, short_not_ok)
-		__field(int, no_interrupt)
+		__field(u32, rdw1)
 	),
 	TP_fast_assign(
-		__assign_str(name, req->dep->name);
+		__entry->edw3 = req->dep->endpoint.dw3;
 		__entry->req = req;
 		__entry->actual = req->request.actual;
 		__entry->length = req->request.length;
 		__entry->status = req->request.status;
-		__entry->zero = req->request.zero;
-		__entry->short_not_ok = req->request.short_not_ok;
-		__entry->no_interrupt = req->request.no_interrupt;
+		__entry->rdw1 = req->request.dw1;
 	),
 	TP_printk("%s: req %p length %u/%u %s%s%s ==> %d",
-		__get_str(name), __entry->req, __entry->actual, __entry->length,
-		__entry->zero ? "Z" : "z",
-		__entry->short_not_ok ? "S" : "s",
-		__entry->no_interrupt ? "i" : "I",
+		__s, __entry->req, __entry->actual, __entry->length,
+		tr.zero ? "Z" : "z",
+		tr.short_not_ok ? "S" : "s",
+		tr.no_interrupt ? "i" : "I",
 		__entry->status
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
 
@@ -180,12 +186,12 @@ DEFINE_EVENT(dwc3_log_generic_cmd, dwc3_gadget_generic_cmd,
 	TP_ARGS(cmd, param, status)
 );
 
-DECLARE_EVENT_CLASS(dwc3_log_gadget_ep_cmd,
+DECLARE_EVENT_CLASS_PRINT_INIT(dwc3_log_gadget_ep_cmd,
 	TP_PROTO(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params, int cmd_status),
 	TP_ARGS(dep, cmd, params, cmd_status),
 	TP_STRUCT__entry(
-		__string(name, dep->name)
+		__field(u32, edw3)
 		__field(unsigned int, cmd)
 		__field(u32, param0)
 		__field(u32, param1)
@@ -193,7 +199,7 @@ DECLARE_EVENT_CLASS(dwc3_log_gadget_ep_cmd,
 		__field(int, cmd_status)
 	),
 	TP_fast_assign(
-		__assign_str(name, dep->name);
+		__entry->edw3 = dep->endpoint.dw3;
 		__entry->cmd = cmd;
 		__entry->param0 = params->param0;
 		__entry->param1 = params->param1;
@@ -201,10 +207,18 @@ DECLARE_EVENT_CLASS(dwc3_log_gadget_ep_cmd,
 		__entry->cmd_status = cmd_status;
 	),
 	TP_printk("%s: cmd '%s' [%x] params %08x %08x %08x --> status: %s",
-		__get_str(name), dwc3_gadget_ep_cmd_string(__entry->cmd),
+		__s, dwc3_gadget_ep_cmd_string(__entry->cmd),
 		__entry->cmd, __entry->param0,
 		__entry->param1, __entry->param2,
 		dwc3_ep_cmd_status_string(__entry->cmd_status)
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
 
@@ -214,11 +228,11 @@ DEFINE_EVENT(dwc3_log_gadget_ep_cmd, dwc3_gadget_ep_cmd,
 	TP_ARGS(dep, cmd, params, cmd_status)
 );
 
-DECLARE_EVENT_CLASS(dwc3_log_trb,
+DECLARE_EVENT_CLASS_PRINT_INIT(dwc3_log_trb,
 	TP_PROTO(struct dwc3_ep *dep, struct dwc3_trb *trb),
 	TP_ARGS(dep, trb),
 	TP_STRUCT__entry(
-		__string(name, dep->name)
+		__field(u32, edw3)
 		__field(struct dwc3_trb *, trb)
 		__field(u32, bpl)
 		__field(u32, bph)
@@ -229,7 +243,7 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
 		__field(u32, dequeue)
 	),
 	TP_fast_assign(
-		__assign_str(name, dep->name);
+		__entry->edw3 = dep->endpoint.dw3;
 		__entry->trb = trb;
 		__entry->bpl = trb->bpl;
 		__entry->bph = trb->bph;
@@ -240,7 +254,7 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
 		__entry->dequeue = dep->trb_dequeue;
 	),
 	TP_printk("%s: trb %p (E%d:D%d) buf %08x%08x size %s%d ctrl %08x sofn %08x (%c%c%c%c:%c%c:%s)",
-		__get_str(name), __entry->trb, __entry->enqueue,
+		__s, __entry->trb, __entry->enqueue,
 		__entry->dequeue, __entry->bph, __entry->bpl,
 		({char *s;
 		int pcm = ((__entry->size >> 24) & 3) + 1;
@@ -272,7 +286,14 @@ DECLARE_EVENT_CLASS(dwc3_log_trb,
 		__entry->ctrl & DWC3_TRB_CTRL_CSP ? 'S' : 's',
 		__entry->ctrl & DWC3_TRB_CTRL_ISP_IMI ? 'S' : 's',
 		__entry->ctrl & DWC3_TRB_CTRL_IOC ? 'C' : 'c',
-		  dwc3_trb_type_string(DWC3_TRBCTL_TYPE(__entry->ctrl))
+		dwc3_trb_type_string(DWC3_TRBCTL_TYPE(__entry->ctrl))),
+	TP_printk_init(
+		struct usb_ep te;
+		char __s[9];
+		te.dw3 = __entry->edw3;
+		snprintf(__s, 9, "ep%d%s", te.address, \
+			(te.caps.dir_in && te.caps.dir_out) ? "" : \
+			te.caps.dir_in ? "in" : "out");
 	)
 );
 
@@ -286,35 +307,31 @@ DEFINE_EVENT(dwc3_log_trb, dwc3_complete_trb,
 	TP_ARGS(dep, trb)
 );
 
-DECLARE_EVENT_CLASS(dwc3_log_ep,
+DECLARE_EVENT_CLASS_PRINT_INIT(dwc3_log_ep,
 	TP_PROTO(struct dwc3_ep *dep),
 	TP_ARGS(dep),
 	TP_STRUCT__entry(
-		__string(name, dep->name)
-		__field(unsigned int, maxpacket)
-		__field(unsigned int, maxpacket_limit)
-		__field(unsigned int, max_streams)
-		__field(unsigned int, maxburst)
+		__field(u32, edw3)
+		__field(u32, edw1)
+		__field(u32, edw2)
 		__field(unsigned int, flags)
 		__field(unsigned int, direction)
 		__field(u8, trb_enqueue)
 		__field(u8, trb_dequeue)
 	),
 	TP_fast_assign(
-		__assign_str(name, dep->name);
-		__entry->maxpacket = dep->endpoint.maxpacket;
-		__entry->maxpacket_limit = dep->endpoint.maxpacket_limit;
-		__entry->max_streams = dep->endpoint.max_streams;
-		__entry->maxburst = dep->endpoint.maxburst;
+		__entry->edw3 = dep->endpoint.dw3;
+		__entry->edw1 = dep->endpoint.dw1;
+		__entry->edw2 = dep->endpoint.dw2;
 		__entry->flags = dep->flags;
 		__entry->direction = dep->direction;
 		__entry->trb_enqueue = dep->trb_enqueue;
 		__entry->trb_dequeue = dep->trb_dequeue;
 	),
 	TP_printk("%s: mps %d/%d streams %d burst %d ring %d/%d flags %c:%c%c%c%c:%c",
-		__get_str(name), __entry->maxpacket,
-		__entry->maxpacket_limit, __entry->max_streams,
-		__entry->maxburst, __entry->trb_enqueue,
+		__s, te.maxpacket,
+		te.maxpacket_limit, te.max_streams,
+		te.maxburst, __entry->trb_enqueue,
 		__entry->trb_dequeue,
 		__entry->flags & DWC3_EP_ENABLED ? 'E' : 'e',
 		__entry->flags & DWC3_EP_STALL ? 'S' : 's',
@@ -322,6 +339,16 @@ DECLARE_EVENT_CLASS(dwc3_log_ep,
 		__entry->flags & DWC3_EP_TRANSFER_STARTED ? 'B' : 'b',
 		__entry->flags & DWC3_EP_PENDING_REQUEST ? 'P' : 'p',
 		__entry->direction ? '<' : '>'
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
 
-- 
2.17.1

