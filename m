Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A3EDE99C
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 10:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbjINKEE (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbjINKEB (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:04:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597161BE3;
        Thu, 14 Sep 2023 03:03:57 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E7sNGY007218;
        Thu, 14 Sep 2023 10:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=gzgvHVyYZMDdJgUpboU+FPJbVa2j8qL3M3b7RSrxMEU=;
 b=agCGBk9fxeg/GE8CBSJpqoywuRKDL+4V3EmW5mu+A6eUwIzzUOvtBe14Cu7Ho/evDqbF
 hClP5kc2TB1Ca/nEzEjJCNuN7OFMUamXgPh/W5/8QnuTPVG8KVBwRljm+IXkl+mzFOZ9
 2J37uFkmFeSYdkFXE5Vfo5L3P6e5qCCGRvP30sDyYoCAHFh9rrrd0AyNMzZt173XuTPj
 OhoqdmBFylbOdhnWd/oCxU2zxmJCdGKihhlQCmf2e6IXxAAxZ2feJDsayP1P0SdTtoYd
 a7PP+QUpw92v8m0Ky5hEfVBycVsUJ9k+9+rXiXYbrp+DmxJ1WH+RkD/5OSdCnJXlC9kw IA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3x6mra6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EA3j0Q023414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:45 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 03:03:41 -0700
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
Subject: [PATCH 7/8] usb: mtu3: trace: reduce buffer usage of trace event
Date:   Thu, 14 Sep 2023 18:03:01 +0800
Message-ID: <20230914100302.30274-8-quic_linyyuan@quicinc.com>
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
X-Proofpoint-GUID: cdLlE1kUgsRsa0PoHZKAU3cz9RfNfEAi
X-Proofpoint-ORIG-GUID: cdLlE1kUgsRsa0PoHZKAU3cz9RfNfEAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=633 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
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
 drivers/usb/mtu3/mtu3_trace.h | 76 +++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_trace.h b/drivers/usb/mtu3/mtu3_trace.h
index 03d2a9bac27e..22b821771c24 100644
--- a/drivers/usb/mtu3/mtu3_trace.h
+++ b/drivers/usb/mtu3/mtu3_trace.h
@@ -113,35 +113,43 @@ DEFINE_EVENT(mtu3_log_setup, mtu3_handle_setup,
 	TP_ARGS(setup)
 );
 
-DECLARE_EVENT_CLASS(mtu3_log_request,
+DECLARE_EVENT_CLASS_PRINT_INIT(mtu3_log_request,
 	TP_PROTO(struct mtu3_request *mreq),
 	TP_ARGS(mreq),
 	TP_STRUCT__entry(
-		__string(name, mreq->mep->name)
+		__field(u32, edw3)
 		__field(struct mtu3_request *, mreq)
 		__field(struct qmu_gpd *, gpd)
 		__field(unsigned int, actual)
 		__field(unsigned int, length)
 		__field(int, status)
-		__field(int, zero)
-		__field(int, no_interrupt)
+		__field(u32, rdw1)
 	),
 	TP_fast_assign(
-		__assign_str(name, mreq->mep->name);
+		__entry->edw3 = mreq->mep->ep.dw3;
 		__entry->mreq = mreq;
 		__entry->gpd = mreq->gpd;
 		__entry->actual = mreq->request.actual;
 		__entry->length = mreq->request.length;
 		__entry->status = mreq->request.status;
-		__entry->zero = mreq->request.zero;
-		__entry->no_interrupt = mreq->request.no_interrupt;
+		__entry->rdw1 = mreq->request.dw1;
 	),
 	TP_printk("%s: req %p gpd %p len %u/%u %s%s --> %d",
-		__get_str(name), __entry->mreq, __entry->gpd,
+		__s, __entry->mreq, __entry->gpd,
 		__entry->actual, __entry->length,
-		__entry->zero ? "Z" : "z",
-		__entry->no_interrupt ? "i" : "I",
+		tr.zero ? "Z" : "z",
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
 
@@ -170,11 +178,11 @@ DEFINE_EVENT(mtu3_log_request, mtu3_req_complete,
 	TP_ARGS(req)
 );
 
-DECLARE_EVENT_CLASS(mtu3_log_gpd,
+DECLARE_EVENT_CLASS_PRINT_INIT(mtu3_log_gpd,
 	TP_PROTO(struct mtu3_ep *mep, struct qmu_gpd *gpd),
 	TP_ARGS(mep, gpd),
 	TP_STRUCT__entry(
-		__string(name, mep->name)
+		__field(u32, edw3)
 		__field(struct qmu_gpd *, gpd)
 		__field(u32, dw0)
 		__field(u32, dw1)
@@ -182,7 +190,7 @@ DECLARE_EVENT_CLASS(mtu3_log_gpd,
 		__field(u32, dw3)
 	),
 	TP_fast_assign(
-		__assign_str(name, mep->name);
+		__entry->edw3 = mep->ep.dw3;
 		__entry->gpd = gpd;
 		__entry->dw0 = le32_to_cpu(gpd->dw0_info);
 		__entry->dw1 = le32_to_cpu(gpd->next_gpd);
@@ -190,9 +198,17 @@ DECLARE_EVENT_CLASS(mtu3_log_gpd,
 		__entry->dw3 = le32_to_cpu(gpd->dw3_info);
 	),
 	TP_printk("%s: gpd %p - %08x %08x %08x %08x",
-		__get_str(name), __entry->gpd,
+		__s, __entry->gpd,
 		__entry->dw0, __entry->dw1,
 		__entry->dw2, __entry->dw3
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
 
@@ -211,41 +227,49 @@ DEFINE_EVENT(mtu3_log_gpd, mtu3_zlp_exp_gpd,
 	TP_ARGS(mep, gpd)
 );
 
-DECLARE_EVENT_CLASS(mtu3_log_ep,
+DECLARE_EVENT_CLASS_PRINT_INIT(mtu3_log_ep,
 	TP_PROTO(struct mtu3_ep *mep),
 	TP_ARGS(mep),
 	TP_STRUCT__entry(
-		__string(name, mep->name)
+		__field(u32, edw3)
 		__field(unsigned int, type)
 		__field(unsigned int, slot)
-		__field(unsigned int, maxp)
-		__field(unsigned int, mult)
-		__field(unsigned int, maxburst)
+		__field(u32, edw1)
+		__field(u32, edw2)
 		__field(unsigned int, flags)
 		__field(unsigned int, direction)
 		__field(struct mtu3_gpd_ring *, gpd_ring)
 	),
 	TP_fast_assign(
-		__assign_str(name, mep->name);
+		__entry->edw3 = mep->ep.dw3;
 		__entry->type = mep->type;
 		__entry->slot = mep->slot;
-		__entry->maxp = mep->ep.maxpacket;
-		__entry->mult = mep->ep.mult;
-		__entry->maxburst = mep->ep.maxburst;
+		__entry->edw1 = mep->ep.dw1;
+		__entry->edw2 = mep->ep.dw2;
 		__entry->flags = mep->flags;
 		__entry->direction = mep->is_in;
 		__entry->gpd_ring = &mep->gpd_ring;
 	),
 	TP_printk("%s: type %s maxp %d slot %d mult %d burst %d ring %p/%pad flags %c:%c%c%c:%c",
-		__get_str(name), usb_ep_type_string(__entry->type),
-		__entry->maxp, __entry->slot,
-		__entry->mult, __entry->maxburst,
+		__s, usb_ep_type_string(__entry->type),
+		te.maxpacket, __entry->slot,
+		te.mult, te.maxburst,
 		__entry->gpd_ring, &__entry->gpd_ring->dma,
 		__entry->flags & MTU3_EP_ENABLED ? 'E' : 'e',
 		__entry->flags & MTU3_EP_STALL ? 'S' : 's',
 		__entry->flags & MTU3_EP_WEDGE ? 'W' : 'w',
 		__entry->flags & MTU3_EP_BUSY ? 'B' : 'b',
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

