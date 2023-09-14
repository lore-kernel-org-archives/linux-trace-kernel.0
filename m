Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB22EDE99E
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 10:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbjINKEK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbjINKEF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:04:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546301BFA;
        Thu, 14 Sep 2023 03:04:01 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E8rR8B020024;
        Thu, 14 Sep 2023 10:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=w7k/A+rWELP81LFtvSGccaamwsLAy8ZMoFv2TZCeTf4=;
 b=dllZ9OYQxfWogyMKIy9NkusOu4uOt9nOndgHZuzrCHGBnhFgj4rb8yttyVxHlRzJVSAq
 ddjQgcSPT1xzuJO4guC2V8QBNK3ztfIPWjgwlmV0PKQ5g2kEz43u9eNwEWel8GKSXPFX
 22VktFNwzYPQrGcLnw4tiV2xgdJqaBaUBseitZx91STJFqCLCLDJ2Zrg6iTPWNAmAcAC
 aKApazhJzZPNx6lifgQS3i0SkJ8DnJhBMc7+NY4qWg9zVvngnwic/GClLJnzqS5RmyhR
 w/foGRMj0yjVaZB6BhasELnkYswJ+2q4VNTi401b+MR2/BsM6C9FGKxevczR26pzeXOi Nw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3h0dj3bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:50 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EA3nBq023886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:49 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 03:03:45 -0700
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
Subject: [PATCH 8/8] usb: musb: trace: reduce buffer usage of trace event
Date:   Thu, 14 Sep 2023 18:03:02 +0800
Message-ID: <20230914100302.30274-9-quic_linyyuan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: F0vLxjhdMS2uH-rUTnEKdbJ3mUVkT6VW
X-Proofpoint-GUID: F0vLxjhdMS2uH-rUTnEKdbJ3mUVkT6VW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=711 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140085
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Save u32 member into trace event ring buffer and parse it for possible
bit information.

Use DECLARE_EVENT_CLASS_PRINT_INIT() related macro for output stage.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 drivers/usb/musb/musb_trace.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_trace.h b/drivers/usb/musb/musb_trace.h
index f246b14394c4..8add5e81ed8d 100644
--- a/drivers/usb/musb/musb_trace.h
+++ b/drivers/usb/musb/musb_trace.h
@@ -233,7 +233,7 @@ DEFINE_EVENT(musb_urb, musb_urb_deq,
 	TP_ARGS(musb, urb)
 );
 
-DECLARE_EVENT_CLASS(musb_req,
+DECLARE_EVENT_CLASS_PRINT_INIT(musb_req,
 	TP_PROTO(struct musb_request *req),
 	TP_ARGS(req),
 	TP_STRUCT__entry(
@@ -243,9 +243,7 @@ DECLARE_EVENT_CLASS(musb_req,
 		__field(int, status)
 		__field(unsigned int, buf_len)
 		__field(unsigned int, actual_len)
-		__field(unsigned int, zero)
-		__field(unsigned int, short_not_ok)
-		__field(unsigned int, no_interrupt)
+		__field(u32, rdw1)
 	),
 	TP_fast_assign(
 		__entry->req = &req->request;
@@ -254,18 +252,20 @@ DECLARE_EVENT_CLASS(musb_req,
 		__entry->status = req->request.status;
 		__entry->buf_len = req->request.length;
 		__entry->actual_len = req->request.actual;
-		__entry->zero = req->request.zero;
-		__entry->short_not_ok = req->request.short_not_ok;
-		__entry->no_interrupt = req->request.no_interrupt;
+		__entry->rdw1 = req->request.dw1;
 	),
 	TP_printk("%p, ep%d %s, %s%s%s, len %d/%d, status %d",
 			__entry->req, __entry->epnum,
 			__entry->is_tx ? "tx/IN" : "rx/OUT",
-			__entry->zero ? "Z" : "z",
-			__entry->short_not_ok ? "S" : "s",
-			__entry->no_interrupt ? "I" : "i",
+			tr.zero ? "Z" : "z",
+			tr.short_not_ok ? "S" : "s",
+			tr.no_interrupt ? "I" : "i",
 			__entry->actual_len, __entry->buf_len,
 			__entry->status
+	),
+	TP_printk_init(
+		struct usb_request tr;
+		tr.dw1 = __entry->rdw1;
 	)
 );
 
-- 
2.17.1

