Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB5C4F55B1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369512; cv=none; b=eVeWFV0FUuY/Jq+VwBAHOEzwEC8WFkKn296bwC9oC/yPBjwPs07SAHZhgkAlS9KUycxGLVoZKQ/DhFhnlJHOMxklxJnbQSN4b2m0erg5zu4/ClZMFzDcAdiUx6PhNscjkae6OI+qepFTqKAP+tOlbKI/HLMkJK8+WNUmmeffBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369512; c=relaxed/simple;
	bh=Q0GQSFNnxzjh7QJ0TPu35gluKAst3z+Q57VIYVkwkt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nK7k+m/GYiD2IHR4PVXCzwBWWjI8xWMfK8MX5/fd8CtrK3LZPazjz2aUEByVe1TYBe5qBDOhDjBBqKU2wP/ujAzHHqwaiG/aE4QwcoMyukIDWQNbBSybq8XX8Wh/8ejaN7Ogs63i2pT+tXNf7blofjYy5wGaLbS1ZczehOJewxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lR5SFMDC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XBqv7Xja; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lR5SFMDC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XBqv7Xja"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PIneXk2888887
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 20:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hXEWsrMj8YsWuXAHVVNPxeZafw4Osmo9egEVowveV8w=; b=lR5SFMDCzKEzgvlc
	Md/3/TJoUMZqR5lG2TVQyt+mQAgfzAghyJaj82HVKJLIRea2maX5Pbjl4DojVOc+
	Pdwi4dYUySCgbb/kwC7xyxHUWnjwzeYeFCKwAEao2QxR/oGmK+UDB1mUnYvsTbk2
	0v5iDF88ftSWNQ2+pHwm+qT/MDdX5p03YfBi6tAhWsTpH6An0wRJvZ/767iBKFk9
	QZp9iqePm3q/J7I1kUbP0wjoDzm+sSnjNLOa3gb3k+VjyOHhmiImL0CATOfY9awR
	BNMbcYxX83BMfhmD5jg0wGR5CW0f2r17miaHEnPESyenx5kdkH2iNLsayVx0mY56
	QQl62Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwwjc8qv5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 20:51:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3412efc2661so1661805eec.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 13:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790369509; x=1790974309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXEWsrMj8YsWuXAHVVNPxeZafw4Osmo9egEVowveV8w=;
        b=XBqv7Xjah9KS99GTDuzOQkq2bVNLY2+JGtdjmqNHmjVss2batJK7eYyVcYX/4mJX6e
         A1P1mKGB+OGzIoIoqtdRHLyi9SHLdF2VkYXrX7XLxEKvJlS/+FYyq45o60r0YDiWB0xj
         Ioq4r0or673hM56U6vm7a0H7IUMfJFGqPdenhZafpFNbsFxfvK2pH88/hLje92TGT6JX
         hGnUaIMiixK5pXP39m1jflMTbg3KTa5Dhi4NCvMo9KBydpWEOpbqvTfxFIuPj/+wPxsB
         cW/F7iYU9VFS2PazgN91bzZoU5TGqTbKcYPmXmxJJhpLPrQNPM0aSPgbNnyNJuDCbQ7t
         82Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369509; x=1790974309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXEWsrMj8YsWuXAHVVNPxeZafw4Osmo9egEVowveV8w=;
        b=kCbtOVwQ3hp2a1AOO8c2cqSrqYiu8ANjf3DqcfT6ITfhb+nQVIoy0ZWCEPXhCCBGP0
         OTLCShxRmnxeHA+PorOxCz5VbFoLTum8w5Hl2huOaCMaNOWUOYz6e2z9h0EX0VC4Ajzs
         Nle992RJ5J9l24+pyYn69tdfErofX8BQqPZBi/avOq1Oexqguv9rNvWR7UQd/EtkVlt0
         1OUcub/NNsuxE3VJ/LQn6B1HuKjR7aOAfAAqqT5dCeQQD+OjXEYFIwl6S4X8V8H2ve3r
         TtZGCpFxU6I12/soBvLGEjHYz6v2ThagUsaRW2piZXXdKWQbPBsCmnBHkLyPVKIgLUfK
         Xm+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxJLEuMncsLYJcpvwGmqUCVQq8QsP2cyZcMD+C50PGuGjN5Za88cDpLaCUYlhMQjuln0ORtLcweriVLk4U9RQpk6SQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l/++T9iwBkkGPJn9Zp/FkxjuTw2uiLu07jmGfyW4bN+r1q5/PB
	2lHtiYz0etjg9Q84fMB0RH+brqBrS6ePBXnWf/x02uIvFc6VfPeXmHHd5YG30c1FrvgbX/Rhrde
	XA88jXwcZ74Do2uLi/9Xo0jHJ0PkvS6rbRQ5M7u5jc2bengmc+RKG8rI2qAqMv3OBhzvbalvJKz
	4=
X-Gm-Gg: AYBFou3KES1j/xzdulU193wMen8nLSw9/2EhERjWORKgtf/gmogGF1EGay3yKuzUIQb
	I65SnLe80EaL42p9twMZV4dHdj0IAGSQBxY3LCs0wA1uXoPVduRbLByP8MIO7uaWPVpM9DBt2xX
	b6F7p5jaHruLI5B4q9Q7CQAvehDL/rCvfX3rsq1CZl+GPJDoRDqQt2eZQ8Wo4vSLI02YAjQrVjE
	2AzhrkSu9yDKh6S1uYZi41FFgTiSNMStwjvKcMV+hp5y2YLMIvZfB7yOoaE2hELLEXs0XHM+CXI
	5Oor+mc3S2Ie5yBXhATHzb+kxZbq1+4OGIPAcjB1ylSb7gX13VH6+wl442ZYaeqWwZIfjmdlsCB
	5or3Bm/y1Ei7467UU6TwrP+2WL4iGsPgL
X-Received: by 2002:a05:7301:790d:b0:341:6ebb:4e2c with SMTP id 5a478bee46e88-342727579d8mr1228520eec.35.1790369508886;
        Fri, 25 Sep 2026 13:51:48 -0700 (PDT)
X-Received: by 2002:a05:7301:790d:b0:341:6ebb:4e2c with SMTP id 5a478bee46e88-342727579d8mr1228486eec.35.1790369508002;
        Fri, 25 Sep 2026 13:51:48 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757f31sm13085734eec.14.2026.09.25.13.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:51:47 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 02:21:35 +0530
Subject: [PATCH v3 1/2] dmaengine: qcom: gpi: Add trace event support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-add-trace-support-gpio-v3-1-8572bf7456b2@oss.qualcomm.com>
References: <20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com>
In-Reply-To: <20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790369498; l=13347;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=Q0GQSFNnxzjh7QJ0TPu35gluKAst3z+Q57VIYVkwkt0=;
 b=OmHJ2AuuhOYXLzZBNZgEa2rnqi6cE+JThVBm0FfP7uigKA9RyQq0hBXBzDWVE5x+Jf3JWc29V
 4zzPjc5ZRfPD5KBFjDRUcGwJHQysIo0F83PDKekhL7hv/ffzB3LMS6I
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4MyBTYWx0ZWRfXz+RvozkI2d4z
 l+aUtrLOX+eJZ/AdQ0q2dExpfu61e3UXCHela18arfytB3kxj7h/2rdEn8qQtbpOoEvJJfkoid+
 qt0AjRgn7E1riJoTOsEEKDqbAoSShDY=
X-Authority-Analysis: v=2.4 cv=dZwVTnXe c=1 sm=1 tr=0 ts=6ab6dee5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=11w8Wl5C-LXbRnlNqkMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4MyBTYWx0ZWRfX7jrAz3/S87At
 mIf2iHyfyKxcVW+pIaydsk5kccL7we3hE/0oDdS4w7kdOBU58+7pz9FNOyj+L9sHMCPm3t9gOaA
 auYoK/MjJhtJJ8Ygae+oGEazrzn4wQu9PX6GnwWxhorSfxCIQKd0yCng8VQqU8q9Y/7ES3KW2qd
 J1WjpPA7SgmG6Gn0LkLRxnNexj92xd6AxuSCpqZBed3qi+kVIjEzQX6hrjbO6pMQ8IVoEW6zVsV
 6fWgSSMxN5qK4PPp7OrvQ0+RGnO7iWqO9XqjfpJlZ+BZ+VrY/CN7ZXO7ECLeMuulHQ/Ql/veO9+
 Q2Owqcug4luv1tA5AB1tMD3A95X+3vYQ5/bi5CSJKcIBBAXiVjSjsF3zNplCy4qMCbnqv1/5rPa
 Ecl1aH1bRcL8IlSJ+W3pX2l4lMvmQraLibfp7O+w3aFK7SQMfDRq3+9RI7IlPEM0LGR267KW0Vm
 TmxPJ4TDSC0TvwpdcHw==
X-Proofpoint-GUID: JNJ22z4ngkmohQMgk4RxaaG52qrJdubq
X-Proofpoint-ORIG-GUID: JNJ22z4ngkmohQMgk4RxaaG52qrJdubq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250083

Add tracepoint support to the Qualcomm GPI DMA engine driver, giving
structured runtime visibility into GPI DMA behavior without requiring
invasive debug patches.

The events cover channel/event command dispatch, IRQ type handling,
channel/event control state transitions, error IRQ status, completion
event processing (including the no-pending-descriptor and transfer
result paths), per-event processing in the event ring, ring
allocation/programming details, already-in-state checks for
pause/resume, and TRE queuing and contents.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c       |  11 ++
 drivers/dma/qcom/gpi_trace.h | 317 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 328 insertions(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index c41bfac65ddf..fafe6ac848d9 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -17,6 +17,9 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
+#define CREATE_TRACE_POINTS
+#include "gpi_trace.h"
+
 #define TRE_TYPE_DMA		0x10
 #define TRE_TYPE_IMMEDIATE_DMA	0x11
 #define TRE_TYPE_GO		0x20
@@ -683,6 +686,7 @@ static int gpi_send_cmd(struct gpii *gpii, struct gchan *gchan,
 
 	dev_dbg(gpii->gpi_dev->dev,
 		"sending cmd: %s:%u\n", TO_GPI_CMD_STR(gpi_cmd), chid);
+	trace_gpi_send_cmd(gpii->gpi_dev->dev, chid, gpi_cmd, TO_GPI_CMD_STR(gpi_cmd));
 
 	/* send opcode and wait for completion */
 	reinit_completion(&gpii->cmd_completion);
@@ -773,6 +777,7 @@ static void gpi_process_ch_ctrl_irq(struct gpii *gpii)
 		if (gpii->gpi_cmd == GPI_CH_CMD_DE_ALLOC)
 			state = DEFAULT_CH_STATE;
 		gchan->ch_state = state;
+		trace_gpi_ch_ctrl_irq(gpii->gpi_dev->dev, chid, gchan->ch_state);
 
 		/*
 		 * Triggering complete all if ch_state is not a stop in process.
@@ -841,6 +846,7 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
 
 	offset = GPII_n_CNTXT_TYPE_IRQ_OFFS(gpii->gpii_id);
 	type = gpi_read_reg(gpii, gpii->regs + offset);
+	trace_gpi_irq_status(gpii->gpi_dev->dev, gpii_id, type);
 
 	do {
 		/* global gpii error */
@@ -968,6 +974,8 @@ static void gpi_process_imed_data_event(struct gchan *gchan,
 	smp_wmb();
 
 	chid = imed_event->chid;
+	trace_gpi_ev_process(gpii->gpi_dev->dev, chid, IMMEDIATE_DATA_EV_TYPE,
+			     imed_event->code, imed_event->status, imed_event->length);
 	if (imed_event->code == MSM_GPI_TCE_EOT && gpii->ieob_set) {
 		if (chid == GPI_RX_CHAN)
 			goto gpi_free_desc;
@@ -1043,6 +1051,8 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
 	smp_wmb();
 
 	chid = compl_event->chid;
+	trace_gpi_ev_process(gpii->gpi_dev->dev, chid, XFER_COMPLETE_EV_TYPE,
+			     compl_event->code, compl_event->status, compl_event->length);
 	if (compl_event->code == MSM_GPI_TCE_EOT && gpii->ieob_set) {
 		if (chid == GPI_RX_CHAN)
 			goto gpi_free_desc;
@@ -1887,6 +1897,7 @@ static void gpi_issue_pending(struct dma_chan *chan)
 	}
 
 	gpi_desc = to_gpi_desc(vd);
+	trace_gpi_queue_xfer(gpii->gpi_dev->dev, gchan->chid, gpi_desc->num_tre);
 	for (i = 0; i < gpi_desc->num_tre; i++) {
 		tre = &gpi_desc->tre[i];
 		gpi_queue_xfer(gpii, gchan, tre, &wp);
diff --git a/drivers/dma/qcom/gpi_trace.h b/drivers/dma/qcom/gpi_trace.h
new file mode 100644
index 000000000000..f16d156833b9
--- /dev/null
+++ b/drivers/dma/qcom/gpi_trace.h
@@ -0,0 +1,317 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_gpi
+
+#if !defined(_TRACE_QCOM_GPI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GPI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(gpi_send_cmd,
+	    TP_PROTO(struct device *dev, u32 chid, u32 cmd, const char *cmd_str),
+	    TP_ARGS(dev, chid, cmd, cmd_str),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __string(cmd_str, cmd_str)
+			     __field(u32, chid)
+			     __field(u32, cmd)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __assign_str(cmd_str);
+			   __entry->chid = chid;
+			   __entry->cmd = cmd;
+	    ),
+
+	    TP_printk("%s: chid=%u cmd=%s(%u)",
+		      __get_str(name), __entry->chid, __get_str(cmd_str),
+		      __entry->cmd)
+);
+
+TRACE_EVENT(gpi_irq_status,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_type),
+	    TP_ARGS(dev, gpii_id, irq_type),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, irq_type)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->irq_type = irq_type;
+	    ),
+
+	    TP_printk("%s: gpii=%u irq_type=0x%08x",
+		      __get_str(name), __entry->gpii_id, __entry->irq_type)
+);
+
+TRACE_EVENT(gpi_ch_ctrl_irq,
+	    TP_PROTO(struct device *dev, u32 chid, u32 ch_state),
+	    TP_ARGS(dev, chid, ch_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, ch_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->ch_state = ch_state;
+	    ),
+
+	    TP_printk("%s: chid=%u ch_state=%u",
+		      __get_str(name), __entry->chid, __entry->ch_state)
+);
+
+TRACE_EVENT(gpi_ev_process,
+	    TP_PROTO(struct device *dev, u32 chid, u32 ev_type, u8 code,
+		     u16 status, u32 length),
+	    TP_ARGS(dev, chid, ev_type, code, status, length),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, ev_type)
+			     __field(u32, length)
+			     __field(u16, status)
+			     __field(u8, code)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->ev_type = ev_type;
+			   __entry->code = code;
+			   __entry->status = status;
+			   __entry->length = length;
+	    ),
+
+	    TP_printk("%s: chid=%u ev_type=0x%02x code=%u status=%u length=%u",
+		      __get_str(name), __entry->chid, __entry->ev_type,
+		      __entry->code, __entry->status, __entry->length)
+);
+
+TRACE_EVENT(gpi_queue_xfer,
+	    TP_PROTO(struct device *dev, u32 chid, u32 num_tre),
+	    TP_ARGS(dev, chid, num_tre),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, num_tre)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->num_tre = num_tre;
+	    ),
+
+	    TP_printk("%s: chid=%u num_tre=%u",
+		      __get_str(name), __entry->chid, __entry->num_tre)
+);
+
+TRACE_EVENT(gpi_gen_err_irq,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_stts),
+	    TP_ARGS(dev, gpii_id, irq_stts),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, irq_stts)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->irq_stts = irq_stts;
+	    ),
+
+	    TP_printk("%s: gpii=%u irq_stts=0x%08x",
+		      __get_str(name), __entry->gpii_id, __entry->irq_stts)
+);
+
+TRACE_EVENT(gpi_ev_ctrl_irq,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 ev_ch_irq, u32 ev_state),
+	    TP_ARGS(dev, gpii_id, ev_ch_irq, ev_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, ev_ch_irq)
+			     __field(u32, ev_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->ev_ch_irq = ev_ch_irq;
+			   __entry->ev_state = ev_state;
+	    ),
+
+	    TP_printk("%s: gpii=%u ev_ch_irq=0x%08x ev_state=%u",
+		      __get_str(name), __entry->gpii_id, __entry->ev_ch_irq,
+		      __entry->ev_state)
+);
+
+TRACE_EVENT(gpi_ev_no_desc,
+	    TP_PROTO(struct device *dev, u32 chid, const u32 *ev_dword,
+		     const u32 *tre_dword),
+	    TP_ARGS(dev, chid, ev_dword, tre_dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __array(u32, ev_dword, 4)
+			     __array(u32, tre_dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   memcpy(__entry->ev_dword, ev_dword, sizeof(__entry->ev_dword));
+			   memcpy(__entry->tre_dword, tre_dword, sizeof(__entry->tre_dword));
+	    ),
+
+	    TP_printk("%s: chid=%u event=%08x:%08x:%08x:%08x pending_tre=%08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid,
+		      __entry->ev_dword[0], __entry->ev_dword[1],
+		      __entry->ev_dword[2], __entry->ev_dword[3],
+		      __entry->tre_dword[0], __entry->tre_dword[1],
+		      __entry->tre_dword[2], __entry->tre_dword[3])
+);
+
+TRACE_EVENT(gpi_xfer_result,
+	    TP_PROTO(struct device *dev, u32 chid, int result, u32 residue),
+	    TP_ARGS(dev, chid, result, residue),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(int, result)
+			     __field(u32, residue)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->result = result;
+			   __entry->residue = residue;
+	    ),
+
+	    TP_printk("%s: chid=%u result=%d residue=%u",
+		      __get_str(name), __entry->chid, __entry->result,
+		      __entry->residue)
+);
+
+TRACE_EVENT(gpi_process_event,
+	    TP_PROTO(struct device *dev, u32 chid, u32 type, const u32 *dword),
+	    TP_ARGS(dev, chid, type, dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, type)
+			     __array(u32, dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->type = type;
+			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
+	    ),
+
+	    TP_printk("%s: chid=%u type=0x%02x %08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid, __entry->type,
+		      __entry->dword[0], __entry->dword[1],
+		      __entry->dword[2], __entry->dword[3])
+);
+
+TRACE_EVENT(gpi_alloc_ring,
+	    TP_PROTO(struct device *dev, u32 elements, u32 el_size,
+		     u32 req_len, u64 len, size_t alloc_size),
+	    TP_ARGS(dev, elements, el_size, req_len, len, alloc_size),
+
+	    TP_STRUCT__entry(__field(u64, len)
+			     __field(size_t, alloc_size)
+			     __string(name, dev_name(dev))
+			     __field(u32, elements)
+			     __field(u32, el_size)
+			     __field(u32, req_len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->elements = elements;
+			   __entry->el_size = el_size;
+			   __entry->req_len = req_len;
+			   __entry->len = len;
+			   __entry->alloc_size = alloc_size;
+	    ),
+
+	    TP_printk("%s: elements=%u el_size=%u req_len=%u len=%llu alloc_size=%zu",
+		      __get_str(name), __entry->elements, __entry->el_size,
+		      __entry->req_len, __entry->len, __entry->alloc_size)
+);
+
+TRACE_EVENT(gpi_ring_info,
+	    TP_PROTO(struct device *dev, dma_addr_t dma_handle, phys_addr_t phys_addr,
+		     u32 len, u32 el_size, u32 elements),
+	    TP_ARGS(dev, dma_handle, phys_addr, len, el_size, elements),
+
+	    TP_STRUCT__entry(__field(u64, dma_handle)
+			     __field(u64, phys_addr)
+			     __string(name, dev_name(dev))
+			     __field(u32, len)
+			     __field(u32, el_size)
+			     __field(u32, elements)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->dma_handle = dma_handle;
+			   __entry->phys_addr = phys_addr;
+			   __entry->len = len;
+			   __entry->el_size = el_size;
+			   __entry->elements = elements;
+	    ),
+
+	    TP_printk("%s: dma_handle=%llx phys_addr=%llx len=%u el_size=%u elements=%u",
+		      __get_str(name), __entry->dma_handle, __entry->phys_addr,
+		      __entry->len, __entry->el_size, __entry->elements)
+);
+
+TRACE_EVENT(gpi_already_state,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 pm_state),
+	    TP_ARGS(dev, gpii_id, pm_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, pm_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->pm_state = pm_state;
+	    ),
+
+	    TP_printk("%s: gpii=%u already in pm_state=%u",
+		      __get_str(name), __entry->gpii_id, __entry->pm_state)
+);
+
+TRACE_EVENT(gpi_tre,
+	    TP_PROTO(struct device *dev, u32 chid, u32 idx, const u32 *dword),
+	    TP_ARGS(dev, chid, idx, dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, idx)
+			     __array(u32, dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->idx = idx;
+			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
+	    ),
+
+	    TP_printk("%s: chid=%u tre[%u]=%08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid, __entry->idx,
+		      __entry->dword[0], __entry->dword[1],
+		      __entry->dword[2], __entry->dword[3])
+);
+
+#endif /* _TRACE_QCOM_GPI_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/dma/qcom
+#define TRACE_INCLUDE_FILE gpi_trace
+#include <trace/define_trace.h>

-- 
2.34.1

