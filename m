Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ACEEDE99C
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 10:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238000AbjINKEM (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbjINKEK (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:04:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37171FDF;
        Thu, 14 Sep 2023 03:04:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E8dH1U013875;
        Thu, 14 Sep 2023 10:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=V+UPymKxhrEpH5IqAuMdRbOriDSJ90pL9K5kDLow1OQ=;
 b=pc3ZWZleg3WPqzOXHdwgvFxeqKk+tdlS+AiL7PgGbHcY/bcIlw5Ir6C9T7AYXG8+MReH
 0tFjCGtO5t8AbGxRK4vhihWuw5Ij4IZ0kgQ7XycEHTPkb0JW/sv/pFni5fcWwqtVEH4S
 vp+BIl6+O45e+BTH4FXdWnQxdxqdNKHP/l7Ze5o4ybdZ5Qol/LCFKzRlNKINd2ZgXxs/
 baUc5TqEXSXoYEkPSfh9DAGFQ+6gbW4Muuf2Zab2GJfyCkJ+zH0qF1UXH1oBBe5QwRKv
 EnQRfTerCJzow5NxRqS/c8wVnlqaOikCFCxeY0A/pyBH4ixsX7JVg1VQEW2hsmSe6H5F OQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3v4h8p1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EA3O83009453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:24 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 03:03:20 -0700
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
Subject: [PATCH 2/8] usb: gadget: add anonymous definition in some struct for trace purpose
Date:   Thu, 14 Sep 2023 18:02:56 +0800
Message-ID: <20230914100302.30274-3-quic_linyyuan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: woM156LwQlArsJBXp5KzehXiWr4WnsLx
X-Proofpoint-GUID: woM156LwQlArsJBXp5KzehXiWr4WnsLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=875 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140085
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Some UDC trace event will save usb udc information, but it use one int
size buffer to save one bit information of usb udc, it is wast trace
buffer.

Add anonymous union which have one u32 member can be used by trace event
during fast assign stage to save more entries with same trace ring buffer
size.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 include/linux/usb/gadget.h | 113 +++++++++++++++++++++++--------------
 1 file changed, 72 insertions(+), 41 deletions(-)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 75bda0783395..4894f256df55 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -41,6 +41,7 @@ struct usb_ep;
  * @num_sgs: number of SG entries
  * @num_mapped_sgs: number of SG entries mapped to DMA (internal)
  * @length: Length of that data
+ * @dw1: trace event purpose
  * @stream_id: The stream id, when USB3.0 bulk streams are being used
  * @is_last: Indicates if this is the last request of a stream_id before
  *	switching to a different stream (required for DWC3 controllers).
@@ -105,12 +106,17 @@ struct usb_request {
 	unsigned		num_sgs;
 	unsigned		num_mapped_sgs;
 
-	unsigned		stream_id:16;
-	unsigned		is_last:1;
-	unsigned		no_interrupt:1;
-	unsigned		zero:1;
-	unsigned		short_not_ok:1;
-	unsigned		dma_mapped:1;
+	union {
+		struct {
+			u32	stream_id:16;
+			u32	is_last:1;
+			u32	no_interrupt:1;
+			u32	zero:1;
+			u32	short_not_ok:1;
+			u32	dma_mapped:1;
+		} __packed;
+		u32		dw1;
+	};
 
 	void			(*complete)(struct usb_ep *ep,
 					struct usb_request *req);
@@ -163,13 +169,13 @@ struct usb_ep_ops {
  * @dir_out:Endpoint supports OUT direction.
  */
 struct usb_ep_caps {
-	unsigned type_control:1;
-	unsigned type_iso:1;
-	unsigned type_bulk:1;
-	unsigned type_int:1;
-	unsigned dir_in:1;
-	unsigned dir_out:1;
-};
+	u8	type_control:1;
+	u8	type_iso:1;
+	u8	type_bulk:1;
+	u8	type_int:1;
+	u8	dir_in:1;
+	u8	dir_out:1;
+} __packed;
 
 #define USB_EP_CAPS_TYPE_CONTROL     0x01
 #define USB_EP_CAPS_TYPE_ISO         0x02
@@ -199,6 +205,9 @@ struct usb_ep_caps {
  * @caps:The structure describing types and directions supported by endpoint.
  * @enabled: The current endpoint enabled/disabled state.
  * @claimed: True if this endpoint is claimed by a function.
+ * @dw1: trace event purpose
+ * @dw2: trace event purpose
+ * @dw3: trace event purpose
  * @maxpacket:The maximum packet size used on this endpoint.  The initial
  *	value can sometimes be reduced (hardware allowing), according to
  *	the endpoint descriptor used to configure the endpoint.
@@ -228,15 +237,30 @@ struct usb_ep {
 	const char		*name;
 	const struct usb_ep_ops	*ops;
 	struct list_head	ep_list;
-	struct usb_ep_caps	caps;
-	bool			claimed;
-	bool			enabled;
-	unsigned		maxpacket:16;
-	unsigned		maxpacket_limit:16;
-	unsigned		max_streams:16;
-	unsigned		mult:2;
-	unsigned		maxburst:5;
-	u8			address;
+	union {
+		struct {
+			u32	maxpacket:16;
+			u32	maxpacket_limit:16;
+		} __packed;
+		u32	dw1;
+	};
+	union {
+		struct {
+			u32	max_streams:16;
+			u32	mult:2;
+			u32	maxburst:5;
+		} __packed;
+		u32	dw2;
+	};
+	union {
+		struct {
+			struct usb_ep_caps	caps;
+			u8			claimed:1;
+			u8			enabled:1;
+			u8			address;
+		} __packed;
+		u32	dw3;
+	};
 	const struct usb_endpoint_descriptor	*desc;
 	const struct usb_ss_ep_comp_descriptor	*comp_desc;
 };
@@ -357,6 +381,7 @@ struct usb_gadget_ops {
  * @in_epnum: last used in ep number
  * @mA: last set mA value
  * @otg_caps: OTG capabilities of this gadget.
+ * @dw1: trace event purpose
  * @sg_supported: true if we can handle scatter-gather
  * @is_otg: True if the USB device port uses a Mini-AB jack, so that the
  *	gadget driver must provide a USB OTG descriptor.
@@ -432,25 +457,31 @@ struct usb_gadget {
 	unsigned			mA;
 	struct usb_otg_caps		*otg_caps;
 
-	unsigned			sg_supported:1;
-	unsigned			is_otg:1;
-	unsigned			is_a_peripheral:1;
-	unsigned			b_hnp_enable:1;
-	unsigned			a_hnp_support:1;
-	unsigned			a_alt_hnp_support:1;
-	unsigned			hnp_polling_support:1;
-	unsigned			host_request_flag:1;
-	unsigned			quirk_ep_out_aligned_size:1;
-	unsigned			quirk_altset_not_supp:1;
-	unsigned			quirk_stall_not_supp:1;
-	unsigned			quirk_zlp_not_supp:1;
-	unsigned			quirk_avoids_skb_reserve:1;
-	unsigned			is_selfpowered:1;
-	unsigned			deactivated:1;
-	unsigned			connected:1;
-	unsigned			lpm_capable:1;
-	unsigned			wakeup_capable:1;
-	unsigned			wakeup_armed:1;
+	union {
+		struct {
+			u32		sg_supported:1;
+			u32		is_otg:1;
+			u32		is_a_peripheral:1;
+			u32		b_hnp_enable:1;
+			u32		a_hnp_support:1;
+			u32		a_alt_hnp_support:1;
+			u32		hnp_polling_support:1;
+			u32		host_request_flag:1;
+			u32		quirk_ep_out_aligned_size:1;
+			u32		quirk_altset_not_supp:1;
+			u32		quirk_stall_not_supp:1;
+			u32		quirk_zlp_not_supp:1;
+			u32		quirk_avoids_skb_reserve:1;
+			u32		is_selfpowered:1;
+			u32		deactivated:1;
+			u32		connected:1;
+			u32		lpm_capable:1;
+			u32		wakeup_capable:1;
+			u32		wakeup_armed:1;
+		} __packed;
+
+		u32			dw1;
+	};
 	int				irq;
 	int				id_number;
 };
-- 
2.17.1

