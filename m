Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04240426EB7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338025; cv=none; b=fZL4zf6f46yXsJWM3AOqMj3a79spHaO0fTdAdrERniVuybntrwtNw9yb4VBu3mvFQzZkHVlo+IaCO7pgWY6Tw7ZwrDKS6s9rzmuQp4i36cZqjblVhpkqV/lnkSlHK45AH+WjQBseWN2ewljKvBzrm1in3cZcV+GJ2pW5QY4QkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338025; c=relaxed/simple;
	bh=NW9OfWcn7zy6+5dpNWHitm6R6TnMYmxPjElKxMspfvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4DX6S827UjrMgfWO4BbO6XqUqm5A/5z1W14dAzbQJS4XRyw8jppMvUqClJenQHEKeAhRrw5xpaufaWJ8ShbgbkGmE2V39c1fsJMh/GkRzm+r6F36bcO3KZ3dI4t93YwQxmIy/Cs4740A0HbBvH3BMQEMmmKGXrJrxXSCNXJpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jvNXJEyc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N9b7SboP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jvNXJEyc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N9b7SboP"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF3Lvd2195053
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sITuVOmRTLgtM0SYU13wJSBTuqa5KGwf+255oDtx3hc=; b=jvNXJEycsdFKlA17
	1LIpCdo8B+a6KtIUogOiHSikPtGEpRRE0aB7ks62pSWTllCrhr4oDC6lucDJst85
	tFRFo+9YRmU+kvVQTDHeGICImcz1FY7jA2B5qnPmMVU5ywL+m+C+2miJhcc5P9zK
	mGpPH5JHHpVv7hLnIIaAb20TPqGl+uxINpN/XNP2GV9qmZSXu4o8oPfgOQybgoJO
	efssY10crJ2EOaD+JiWCRb166NkLki7C17B4RXRg0U3FgX/JpXixL9LV/sAvyKUn
	BETU9s+a/AKKSFHiq7a3DY2pdKv+blEHMIn1xPUzjN/QeGjKxDVJp6XO7hBHQZAw
	RVvVpg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkfm8775-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:13:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8487eb67173so1870826b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785338022; x=1785942822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sITuVOmRTLgtM0SYU13wJSBTuqa5KGwf+255oDtx3hc=;
        b=N9b7SboPHWnEGf1mdPATzAEC+5ci/q2M9a0F5lrOScxIqKK6jDhXR2prAbcSns1tkT
         sJaRcIPRnf7/mXpmiI/sdWnfWXGKwJ/rtHN9hx6eJIh1xy9f894klMIO8ep+yr039P4x
         Bo5Falz+RG4ISOgqAXf1NHwM9RgE5EJ3h7rpNb/nJoe9alief2gdhCtINs/txlsyxGpz
         99Df62Z+sC0ZX6lUhsjPREOW1C68A/K780iM+PSRJ9LY91pW8jTFsgYaVFu3oGJotbYl
         5E8s22jsqqNE5ns/MoE6pr84x5pLyM2Dvuu9a2kQyOen7Y38+U030KUlRlAYrcoEYi7q
         /U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338022; x=1785942822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sITuVOmRTLgtM0SYU13wJSBTuqa5KGwf+255oDtx3hc=;
        b=J2e/nIJ/CzFoK12BAhNxICvyNUvkBQdaec44sxa7FHxjg5l77/yyiZVRBNDpTJXo4x
         m1yHk1rYxvf8RdE13hb4+Cl8mpTRRPQeasEoBeEpHiAD2llbevoB78rRRtaF4Z2t+K6x
         G3lEPQhjvAQtxSug7VzLcq8fhNDYYICLzY9CznTc8xi1n+Tlkfy/Yj+yYjCYK1xL/jum
         GCOvJsyIk1qMjQDVTnOpgBt+XlGa+j8HMwZAWNVq0I3BQAhOL+tE0Zf2sI4ycoyS62jD
         VQAun0CSkZl0oX9TtW4FjnhH9kqLrhKi7EnRDTdNKbpkTFUT0hrbFwbUjq/xRNLUk28O
         QkEA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0lwK5VBPZ9vNTHKIoUAB2jEKKYwfCvWimOkWQssRBcBQTammxlHyXBK/J0VMDm922mdqsNPIPbz90KWIXFcZBZTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbRwEiNJ5sfVs+7pWQ7nUcuEy9u7hiauOX3jMQRzDiGR5FZBuU
	micO9m4e1bc4X7QtnCci4lRpzt+mcyLOov11qAuCjR2lisv131R3+2BEJn3qJhL79jGXOcc+XmE
	TdC2vPgVTgG//AGp7F5m4uncSrH2MxI0kM3J0GGxaqk95CD0Expwzm2f6SeMQsWG6aIoiF3SSn+
	k=
X-Gm-Gg: AR+sD13p9OJLCBc4aHdX1ry7exMCZ4PIyNOOXlQytshlr4O/S+apdek4fbl//CW2EbP
	SI17ns3Tkm86n4A69tAWJ+Dm4ngFaVJ6oTduIuwO/lQzMEZq7YaerGrzKLxexiKjf6OAqxtl+s/
	Xi6vUdnlwSVTJmA4FrUjIBtxNdgTeiDrsG6JXeeVheidbdvx/TWPvHBmMkhkbn2fG9QE8KTiQjR
	iN8Q0ltA73MZ9GNBM5UTz+u1NgYcV7mMkQ1jl5Z5bZtYGYB5oRO7xDO/km9jV1jGFyKU500L/eQ
	nvI3A1+CIkpUvhoIv++pQ1TsaDeLDL4FYDx2ENt2pMARrLCJCXiXwwAgfZME96Kh7H04qzK9On/
	IPOzISbMTPzTlcq72EbqnQRz3fOg7gIsqxg==
X-Received: by 2002:a05:6a00:4f83:b0:847:8f8a:a05d with SMTP id d2e1a72fcca58-84e9324bc95mr7447250b3a.29.1785338021787;
        Wed, 29 Jul 2026 08:13:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f83:b0:847:8f8a:a05d with SMTP id d2e1a72fcca58-84e9324bc95mr7447216b3a.29.1785338021277;
        Wed, 29 Jul 2026 08:13:41 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe238ffsm1617920b3a.12.2026.07.29.08.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:13:40 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 20:43:26 +0530
Subject: [PATCH v4 2/2] spi: qcom-geni: add GENI SE registers trace event
 on error paths
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-add-tracepoints-for-se-reg-dump-v4-2-08bbd63b0ed2@oss.qualcomm.com>
References: <20260729-add-tracepoints-for-se-reg-dump-v4-0-08bbd63b0ed2@oss.qualcomm.com>
In-Reply-To: <20260729-add-tracepoints-for-se-reg-dump-v4-0-08bbd63b0ed2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>, konrad.dybcio@oss.qualcomm.com
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785338008; l=4641;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=NW9OfWcn7zy6+5dpNWHitm6R6TnMYmxPjElKxMspfvA=;
 b=Cows3PFQgRziy5axFV+RsOhLjyzXw9+7M173yBpGUmJifzYNXbk74VmLMq6UV6uruzkYXz6+9
 OU6O0b120FsAwNHPFwGM5/VskIhFkMri6Pne74glL4+S+u1RLqrEevq
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=D6p37PRj c=1 sm=1 tr=0 ts=6a6a18a6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=SuVZUjzzKY3ZPv7-dKMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: QRY6NrjxqjDNvhsk_lkd9zmwvYnxcCzS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXwEuaXH37BuAk
 FlHU1cLUZbGRIFONKCD/K3a1ZoCnGkzOnzB/U0rPvIdTSXl3jja8lWABHb8DSy5cWCNQ3qNZ+IM
 w/csQ1NsGXBU5Tqrw83H11o9ItwCc5g=
X-Proofpoint-ORIG-GUID: QRY6NrjxqjDNvhsk_lkd9zmwvYnxcCzS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfXzS7RcjCUoKx5
 yAky8j+/504Vgk4+fVVJAOzautbymkO288qhZFfll3pm8Q2UEXxftxjWxjIkqJjFkdLjSOHPIZu
 bCjZOdzNNT2dmqxlDafgT837lODRrY3lqmyAFsboaG5aDCDkqeVvDoWQOUWiffannDIwJbrfjkG
 IUsEzBE9u4l8GvPbgukX6oPLQJEXlONHQxQ4IE052TGVMqmfcT0Xbbt68AWpz3nJYOZ75lh+VEw
 +AOmFAehTxfcRRW3sqHETb3SBoTOmxi8PV05OqAj6nIUje/tM8fITIaKdhn7mS+dgyv7nKfTtT9
 YZmYMiBQnyA7F+dSsNn2COURLZUlOcO0X2F7cBv1XXZDtxqeuO0Dr+odST6qOwxE5lTxEW2HZvN
 s6FXdJ+OpNxOkAoQlL2YmkPEjMMoFLTKoQMr+VUm29N+m6Xpobi91eLJzVhhWKSc9UcHrlQK1h1
 ZxuAWlPwA4y8cqqmjJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

The GENI SPI driver reports various transfer failures such as command
timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
interrupt conditions. However, diagnosing the root cause of these
failures is difficult as the hardware state is not captured when the
error occurs.

Add trace_geni_se_regs() calls at critical SPI error handling paths to
automatically capture GENI serial engine debug registers when failures
are detected. This includes:

- M_CMD abort/cancel timeout
- DMA TX/RX FSM reset timeout
- DMA transaction failures and pending residue conditions
- Unexpected interrupt error status
- Premature transfer completion with pending TX/RX data

Dumping the SE debug registers at the time of failure provides
additional hardware context and significantly improves post-mortem
analysis of SPI transfer issues without affecting normal operation.

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 2914d781dbf5..8528f9b80f03 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
+#include <trace/events/qcom_geni_se.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/qcom_geni_spi.h>
 
@@ -192,6 +194,7 @@ static void handle_se_timeout(struct spi_controller *spi)
 	time_left = wait_for_completion_timeout(&mas->abort_done, HZ);
 	if (!time_left) {
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
+		trace_geni_se_regs(se);
 
 		/*
 		 * No need for a lock since SPI core has a lock and we never
@@ -209,8 +212,10 @@ static void handle_se_timeout(struct spi_controller *spi)
 				writel(1, se->base + SE_DMA_TX_FSM_RST);
 				spin_unlock_irq(&mas->lock);
 				time_left = wait_for_completion_timeout(&mas->tx_reset_done, HZ);
-				if (!time_left)
+				if (!time_left) {
 					dev_err(mas->dev, "DMA TX RESET failed\n");
+					trace_geni_se_regs(se);
+				}
 			}
 			if (xfer->rx_buf) {
 				spin_lock_irq(&mas->lock);
@@ -218,8 +223,10 @@ static void handle_se_timeout(struct spi_controller *spi)
 				writel(1, se->base + SE_DMA_RX_FSM_RST);
 				spin_unlock_irq(&mas->lock);
 				time_left = wait_for_completion_timeout(&mas->rx_reset_done, HZ);
-				if (!time_left)
+				if (!time_left) {
 					dev_err(mas->dev, "DMA RX RESET failed\n");
+					trace_geni_se_regs(se);
+				}
 			}
 		} else {
 			/*
@@ -391,10 +398,12 @@ static void
 spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 {
 	struct spi_controller *spi = cb;
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
 	spi->cur_msg->status = -EIO;
 	if (result->result != DMA_TRANS_NOERROR) {
 		dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
+		trace_geni_se_regs(&mas->se);
 		spi_finalize_current_transfer(spi);
 		return;
 	}
@@ -404,6 +413,7 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 		dev_dbg(&spi->dev, "DMA txn completed\n");
 	} else {
 		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
+		trace_geni_se_regs(&mas->se);
 	}
 
 	spi_finalize_current_transfer(spi);
@@ -953,8 +963,10 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 	if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
 		     M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
-		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))
+		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN)) {
 		dev_warn(mas->dev, "Unexpected IRQ err status %#010x\n", m_irq);
+		trace_geni_se_regs(se);
+	}
 
 	spin_lock(&mas->lock);
 
@@ -983,13 +995,16 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 				 * weren't written correctly.
 				 */
 				if (mas->tx_rem_bytes) {
+					trace_geni_se_regs(se);
 					writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
 					dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
 						mas->tx_rem_bytes, mas->cur_bits_per_word);
 				}
-				if (mas->rx_rem_bytes)
+				if (mas->rx_rem_bytes) {
 					dev_err(mas->dev, "Premature done. rx_rem = %d bpw%d\n",
 						mas->rx_rem_bytes, mas->cur_bits_per_word);
+					trace_geni_se_regs(se);
+				}
 			} else {
 				complete(&mas->cs_done);
 			}

-- 
2.34.1

