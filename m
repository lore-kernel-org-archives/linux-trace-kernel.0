Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14774360EE2
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 05:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930611; cv=none; b=ikpgqKiWE3fxlXbIpIMaM0mcBwEC9Itzwp2EvZ6OKGqgw2zBMRuinGr9C+0IPY4U2LDePfE7Yj15Q3zxb0OXOxUMkcg8fqubCrYgaarpLgHzpHRhntzjMu3xSA+yJSMxW5+dk0zK+0HqalVpGUYr4yeaHW34X1j2uN3VKjuc984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930611; c=relaxed/simple;
	bh=g8lTclxGhOqcW7CZT8rYnXsAoNxsoFJn/wn4jG/TwCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFYEn4K/XJcSbkeSHTLYUJSTs9NCIt07bG4reBqy8QT5/NQFzD0rCCoS0GuLqz0X+YiVIyEDgoLTOhtX7lPW7B+d+sPuUuEiyNHiqG6Awk0bnQgJ+zYT7eSQpCZSiE1SDnUcdnKj30ExK2Rhu/kJnKWi7JI+bP0d56/7mL5WKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=paOT+6WP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fwBr2ATw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="paOT+6WP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fwBr2ATw"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688Mg0rO3654006
	for <linux-trace-kernel@vger.kernel.org>; Wed, 9 Sep 2026 05:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ut6uHPVnRZtHbF7GE08rnRaLAQ7S+8eEO2cEaVL+cVE=; b=paOT+6WPk1VHHOTy
	oiinnobbBnCN5ELec1xQZwolYuGfJIMYcbc7cwdqIcOq7TXXelYr2vfMXeYTgUUL
	kBFihqhT03u8BJdY1jBPAMO15Td/fg7k0LREQmj5g2yICr6uMAk0EEu1fPmBVVGL
	RcYsKCHntdlGpUPXFn27VGVlhMpDsStNtZQvdl5N/B+x/6M6ehZPT6O4UYOldlLC
	qP6a77cE9ediJTKaelZTlhTmird9Yazt/4hc74dAWq8HSch35ns2jHu/rkONqZZN
	Q8iO0z6jL3xOKh+gztIbOZ14W+Mky0z/ZGAiAH3TNznCoJ5BTqwCfsmPyMsKvFa9
	uPWFJA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjppp2fth-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 05:10:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39533bb224cso2920003a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 22:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788930609; x=1789535409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ut6uHPVnRZtHbF7GE08rnRaLAQ7S+8eEO2cEaVL+cVE=;
        b=fwBr2ATw2rm7JIp2ZinPxiER4Burk35ID2AVfr1C8TCT5pbVDK8lyVYGkX8nfbvfhN
         whZs3pLaHNWetOqyu2zxQHqWyOmcKvryVUb0VpoRcuCdcnP16EabAfqnH2rn378UdNu0
         1M20As1OnHDYhARKLENe+hvuduJo0xrormdaut5xC4jisdaGlpderbKsLDhNNqgteHWP
         qkXRwYDyrAvGtCb6IYbjLMdJseL+RJDQGTJvtWyG3oLylJhb3kRljVq8j3MIbYeESs4Y
         VFSS3Ld+V/T7Ew1pJa/GWpxyc/4B7tHwBZ/cdy8to/tjMzQp1JMYwooDdFEOQfoA+17E
         Aoww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788930609; x=1789535409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ut6uHPVnRZtHbF7GE08rnRaLAQ7S+8eEO2cEaVL+cVE=;
        b=irldUH+2CnwShuGcJcu1JAWkkdyLcgB8xMknBCHTReSbxQ38MQdUJY3uecLhpYpRBy
         OrOs0Fpd4rsHU4+5R0Io2CivHwPDaS2KSpeOiZih13i6qNiCFI2HtA3DIVPuCm+65FpB
         PrDWmOyIm88voN/KhVeCPNfKHq82Ii7p+BugrVrc3RQzfU0fjimy3k7VuBtXmz4RwtyX
         P0zQdLXCG5bj4bxpKEB9JFWgi0eD2As0WpSh3t52bJPF4n/+03b2B56vMQQjDG8SezqE
         CyR1Eetc2Rx2QgDQMx0rgiz8D28fqUG/P4rfWiXe4thtwWMKJKznzxbkmWgELCkWOOxp
         xd5A==
X-Forwarded-Encrypted: i=1; AKwUvBz1oVmH+GJXQqZi8qVBhbpTBE7rSJGEKyaz61X+MVRXB2/80A68hL3L+tLX0FY21pn45PfFT4lsThWgtl+Nfk+7N2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mGq2KsTfLX2pkw+n8NmBO4sg7WdZhiVix9v3H0ySoShp0bHKs6
	oerkJASl2qoZrtXgYVCKQn5OB14WPl3q/Vq6j/pZ/hsk78L/O2Ljzl/eoBrnG5RmwROi14xBqgC
	ISXLR/xb3bpkPsqARluVnqjcwd3n2EcTjJuHpB6Az01MX6umIoV/zekRfjF6pLzZjmEZpnkjI+U
	o=
X-Gm-Gg: AYBFou3iyESF4TGm4Y3VbX758QXWZHb0DxUiJEotSTMQ1XiaFyZR58q+Mq+E6+MKa9v
	000HeYWpAWSp5lwznJdWSpwQjoGFsXa4TV6XhGxYcxW0wx9t3osQl8wHcwGtUXRoRdmHElsKj87
	EArF6sKvtU9zCbynwKfYizvxx6SoKioHYn8HUJ7tRU44w0eLXEiBpET/YuPHjVtU8IAxiiSfCeg
	/x4pLEWWRH06p0aYqZz2BxnTGsLxWR6aJ1MQeo2iRfGBVmX8aqqGfWQRp3sGUryJX3T52/mMoUW
	Jrzmd6KP7qOwJwfE3LILy4y8Y2Gw6mlw26l2oR1MKottscnpBryxeHEyeP5YCzh1SBf3x1X6wv7
	kAIxFtiEBLWHuZESCcielrLAXaLuvl7vjOg==
X-Received: by 2002:a17:90b:3b8d:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39b2624f10amr48280051a91.22.1788930608540;
        Tue, 08 Sep 2026 22:10:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8d:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39b2624f10amr48279961a91.22.1788930607861;
        Tue, 08 Sep 2026 22:10:07 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338f7bad290sm11082833eec.14.2026.09.08.22.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 22:10:07 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 10:39:43 +0530
Subject: [PATCH v2 3/3] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-add-trace-support-gpio-v2-3-01f81739bb88@oss.qualcomm.com>
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
In-Reply-To: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788930590; l=8161;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=g8lTclxGhOqcW7CZT8rYnXsAoNxsoFJn/wn4jG/TwCc=;
 b=KMAY/q7s2DO7opzeXAOweCApCdi/eaakZlXPEVuHb99p1p3J24VoxvMMNpZJ7h1Ohk4p8tjO9
 nb+pqT4D3Z5CQ1NCtb8x/hmMguDItXaK4tvtQqorQjdqg6YmOiE5Yrc
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: udJO8KGtBqiqGcFjPf2BPDG6FFEfZ-V9
X-Proofpoint-ORIG-GUID: udJO8KGtBqiqGcFjPf2BPDG6FFEfZ-V9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA1NiBTYWx0ZWRfX1uipS+PCKLrt
 V/T63XgTPlNYWd5ffabEJswUNsKGrLXv2GFUlafxk4wKAECD/66wAhCZn4HJwVywNJHice85671
 nA8ltFgKa/7LjeuIneyoNpti2B2IR/T+rrQip8u0efFDpMvNIBITBrJd/hTkuuNljHdiCdi+6u/
 26K4FAAKmFoaMQlevA36HkEa4kbEE5fHxTSYProBc3ilLpFul5M/YO+Wtrc+iByuitlqS0lRWJh
 xjEoKZEsvynjHubU8PZ/+7cnOsCG2LXK0hvEXicCJKsFB/3s8M7ZEqV+jct9eI6ahWJ0DKC4k6Y
 TQJ7NkeWix5bsHWvs3mdKkVTnuG9Ag5EZq8jKO4FMK8lPqJtJ/cjjnc1UPGHqYEggJQ359xOHVn
 ZYe43iM1SLdn1GKNxsHqY5KCLdARRXGuS/sKqo+D9TyuZjy5Gc/RUrJRWO5l8kbsr0FXQ5c9i8j
 yv/T0Nz4sZo3jMQmpnw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA1NiBTYWx0ZWRfX6ACXhqj6IYwa
 vJr5ZYYuObpFcgH52A0LOV0UiuYU2vN4sT9filG4OZetrmoJpU0L3ae5rKjADJWPWCM3WbH5Sgr
 9FgezDpZv5rtfPXbS5GYZYycbVbd7q0=
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=6aa0ea31 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=aSNI5RSwOxee8bqK_isA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090056

Replace the remaining dev_dbg() based debug logging in the GPI DMA
driver with the qcom_gpi tracepoints, providing structured runtime
visibility into GPI DMA behavior without requiring invasive debug
patches. dev_err() calls are left untouched.

Tracepoints are added at the same points as the dev_dbg() calls they
replace: channel/event command dispatch in gpi_send_cmd(), error and
top-level interrupt status in gpi_process_gen_err_irq() and
gpi_handle_irq(), event/channel control state transitions in the IRQ
handler and gpi_process_ch_ctrl_irq(), completion event handling
(including the no-pending-descriptor and transfer result paths) in
gpi_process_imed_data_event(), gpi_process_xfer_compl_event() and
gpi_process_events(), ring allocation details in gpi_alloc_ring(),
already-in-state checks in gpi_pause()/gpi_resume(), TRE contents in
gpi_create_i2c_tre()/gpi_create_spi_tre(), and TRE queuing in
gpi_issue_pending().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c | 58 ++++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index b09354a73b46..8e7d25a46147 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -684,8 +684,6 @@ static int gpi_send_cmd(struct gpii *gpii, struct gchan *gchan,
 	if (IS_CHAN_CMD(gpi_cmd))
 		chid = gchan->chid;
 
-	dev_dbg(gpii->gpi_dev->dev,
-		"sending cmd: %s:%u\n", TO_GPI_CMD_STR(gpi_cmd), chid);
 	trace_gpi_send_cmd(gpii->gpi_dev->dev, chid, gpi_cmd, TO_GPI_CMD_STR(gpi_cmd));
 
 	/* send opcode and wait for completion */
@@ -797,7 +795,7 @@ static void gpi_process_gen_err_irq(struct gpii *gpii)
 	u32 irq_stts = gpi_read_reg(gpii, gpii->regs + offset);
 
 	/* clear the status */
-	dev_dbg(gpii->gpi_dev->dev, "irq_stts:0x%x\n", irq_stts);
+	trace_gpi_gen_err_irq(gpii->gpi_dev->dev, gpii_id, irq_stts);
 
 	/* Clear the register */
 	offset = GPII_n_CNTXT_GPII_IRQ_CLR_OFFS(gpii_id);
@@ -866,8 +864,6 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
 			u32 ev_state;
 			u32 ev_ch_irq;
 
-			dev_dbg(gpii->gpi_dev->dev,
-				"processing EV CTRL interrupt\n");
 			offset = GPII_n_CNTXT_SRC_EV_CH_IRQ_OFFS(gpii_id);
 			ev_ch_irq = gpi_read_reg(gpii, gpii->regs + offset);
 
@@ -887,15 +883,14 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
 				ev_state = DEFAULT_EV_CH_STATE;
 
 			gpii->ev_state = ev_state;
-			dev_dbg(gpii->gpi_dev->dev, "setting EV state to %s\n",
-				TO_GPI_EV_STATE_STR(gpii->ev_state));
+			trace_gpi_ev_ctrl_irq(gpii->gpi_dev->dev, gpii_id, ev_ch_irq,
+					      gpii->ev_state);
 			complete_all(&gpii->cmd_completion);
 			type &= ~(GPII_n_CNTXT_TYPE_IRQ_MSK_EV_CTRL);
 		}
 
 		/* channel control irq */
 		if (type & GPII_n_CNTXT_TYPE_IRQ_MSK_CH_CTRL) {
-			dev_dbg(gpii->gpi_dev->dev, "process CH CTRL interrupts\n");
 			gpi_process_ch_ctrl_irq(gpii);
 			type &= ~(GPII_n_CNTXT_TYPE_IRQ_MSK_CH_CTRL);
 		}
@@ -945,17 +940,10 @@ static void gpi_process_imed_data_event(struct gchan *gchan,
 		struct gpi_tre *gpi_tre;
 
 		spin_unlock_irqrestore(&gchan->vc.lock, flags);
-		dev_dbg(gpii->gpi_dev->dev, "event without a pending descriptor!\n");
 		gpi_ere = (struct gpi_ere *)imed_event;
-		dev_dbg(gpii->gpi_dev->dev,
-			"Event: %08x %08x %08x %08x\n",
-			gpi_ere->dword[0], gpi_ere->dword[1],
-			gpi_ere->dword[2], gpi_ere->dword[3]);
 		gpi_tre = tre;
-		dev_dbg(gpii->gpi_dev->dev,
-			"Pending TRE: %08x %08x %08x %08x\n",
-			gpi_tre->dword[0], gpi_tre->dword[1],
-			gpi_tre->dword[2], gpi_tre->dword[3]);
+		trace_gpi_ev_no_desc(gpii->gpi_dev->dev, imed_event->chid,
+				     gpi_ere->dword, gpi_tre->dword);
 		return;
 	}
 	gpi_desc = to_gpi_desc(vd);
@@ -1064,11 +1052,10 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
 		dev_err(gpii->gpi_dev->dev, "Error in Transaction\n");
 		result.result = DMA_TRANS_ABORTED;
 	} else {
-		dev_dbg(gpii->gpi_dev->dev, "Transaction Success\n");
 		result.result = DMA_TRANS_NOERROR;
 	}
 	result.residue = gpi_desc->len - compl_event->length;
-	dev_dbg(gpii->gpi_dev->dev, "Residue %d\n", result.residue);
+	trace_gpi_xfer_result(gpii->gpi_dev->dev, chid, result.result, result.residue);
 
 	dma_cookie_complete(&vd->tx);
 	dmaengine_desc_get_callback_invoke(&vd->tx, &result);
@@ -1100,11 +1087,8 @@ static void gpi_process_events(struct gpii *gpii)
 			chid = gpi_event->xfer_compl_event.chid;
 			type = gpi_event->xfer_compl_event.type;
 
-			dev_dbg(gpii->gpi_dev->dev,
-				"Event: CHID:%u, type:%x %08x %08x %08x %08x\n",
-				chid, type, gpi_event->gpi_ere.dword[0],
-				gpi_event->gpi_ere.dword[1], gpi_event->gpi_ere.dword[2],
-				gpi_event->gpi_ere.dword[3]);
+			trace_gpi_process_event(gpii->gpi_dev->dev, chid, type,
+						gpi_event->gpi_ere.dword);
 
 			switch (type) {
 			case XFER_COMPLETE_EV_TYPE:
@@ -1113,7 +1097,6 @@ static void gpi_process_events(struct gpii *gpii)
 							     &gpi_event->xfer_compl_event);
 				break;
 			case STALE_EV_TYPE:
-				dev_dbg(gpii->gpi_dev->dev, "stale event, not processing\n");
 				break;
 			case IMMEDIATE_DATA_EV_TYPE:
 				gchan = &gpii->gchan[chid];
@@ -1121,11 +1104,8 @@ static void gpi_process_events(struct gpii *gpii)
 							    &gpi_event->immediate_data_event);
 				break;
 			case QUP_NOTIF_EV_TYPE:
-				dev_dbg(gpii->gpi_dev->dev, "QUP_NOTIF_EV_TYPE\n");
 				break;
 			default:
-				dev_dbg(gpii->gpi_dev->dev,
-					"not supported event type:0x%x\n", type);
 			}
 			gpi_ring_recycle_ev_element(ev_ring);
 		}
@@ -1409,10 +1389,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
 		bit++;
 	len = 1 << bit;
 	ring->alloc_size = (len + (len - 1));
-	dev_dbg(gpii->gpi_dev->dev,
-		"#el:%u el_size:%u len:%u actual_len:%llu alloc_size:%zu\n",
-		  elements, el_size, (elements * el_size), len,
-		  ring->alloc_size);
+	trace_gpi_alloc_ring(gpii->gpi_dev->dev, elements, el_size,
+			     (elements * el_size), len, ring->alloc_size);
 
 	ring->pre_aligned = dma_alloc_coherent(gpii->gpi_dev->dev,
 					       ring->alloc_size,
@@ -1437,10 +1415,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
 	/* update to other cores */
 	smp_wmb();
 
-	dev_dbg(gpii->gpi_dev->dev,
-		"phy_pre:%pad phy_alig:%pa len:%u el_size:%u elements:%u\n",
-		&ring->dma_handle, &ring->phys_addr, ring->len,
-		ring->el_size, ring->elements);
+	trace_gpi_ring_info(gpii->gpi_dev->dev, ring->dma_handle, ring->phys_addr,
+			    ring->len, ring->el_size, ring->elements);
 
 	return 0;
 }
@@ -1542,7 +1518,7 @@ static int gpi_pause(struct dma_chan *chan)
 	 * client needs to call pause only once
 	 */
 	if (gpii->pm_state == PAUSE_STATE) {
-		dev_dbg(gpii->gpi_dev->dev, "channel is already paused\n");
+		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_state);
 		mutex_unlock(&gpii->ctrl_lock);
 		return 0;
 	}
@@ -1578,7 +1554,7 @@ static int gpi_resume(struct dma_chan *chan)
 
 	mutex_lock(&gpii->ctrl_lock);
 	if (gpii->pm_state == ACTIVE_STATE) {
-		dev_dbg(gpii->gpi_dev->dev, "channel is already active\n");
+		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_state);
 		mutex_unlock(&gpii->ctrl_lock);
 		return 0;
 	}
@@ -1703,8 +1679,7 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 	}
 
 	for (i = 0; i < tre_idx; i++)
-		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
-			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
+		trace_gpi_tre(dev, chan->chid, i, desc->tre[i].dword);
 
 	return tre_idx;
 }
@@ -1797,8 +1772,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 					 TRE_FLAGS_IEOT);
 
 	for (i = 0; i < tre_idx; i++)
-		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
-			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
+		trace_gpi_tre(dev, chan->chid, i, desc->tre[i].dword);
 
 	return tre_idx;
 }

-- 
2.34.1

