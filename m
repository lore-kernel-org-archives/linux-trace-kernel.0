Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C73806AD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709354; cv=none; b=htqFYiv56OfgAMqULnWFZQfC+4UZbNhNWNqZkRMBOHIMTmBFI5ancpkkVVcIAArxHH4k62bX4P9DgQEaAOndYrKWEQc1XeDH4xZIVrFpIkAFOzI2K6CQVQCVK4aLOU2xGup4UksQkr74GCvT9oU/Cl3Ndfdh9JBmGfIJntkAmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709354; c=relaxed/simple;
	bh=8IjvFdh38GVjti8EyyCPNx+zrsozIfJZeDc/Jq92K18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVtpQmaPFTLVldhnbYH7gZqNlrGc47P0a3fGl6tnArQhc8HpWyGKs6jzBYf1Vwd06fGknM+ftbmYh+TEwUcRuszk9ozcNNLSI7eqDKcJMiMVVjRldhoS5DwtITj1mbLiRmO9evIg4tvRCnT0xrUbkXPRZXRsf6eRHVOW+RN+uVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bHBzGJjq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hVI5KLzy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHBzGJjq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hVI5KLzy"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3XiR1502022
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ghB+78yE/3ES4lSKNpqNXaMIAgtNADaxhoROyeNa6cY=; b=bHBzGJjqAn9Ojahn
	G6UM/CzYLViNReJZA8caBIuFcR4umLZf2duLK7fbtRZg0Ng90v1TtbkGl1jvA7Hf
	84mrbOjeU84bi0akGWgvJhh2XlQKw0g3eAdWWJuUDMmnM6v0uOR/kqmYYtd7DfUp
	gXJfQczW+vxd/M+tGbup/FNdvDfD91L0iaY5Lp3rfdAcdzWgu5R8gFHRSFwrcuPv
	mU6ovfjslJL57lZmPSyjhfiB/mQGC6jxWbnxji2cW+XEMDB7GSqAS0k/SToi10J6
	eDoVVD1eiXCBZYRgR0WYyTGONZvSnYtcHLeUgL4sG2z/lQ2byHFj4CqEMWY2gDMs
	kkzLHw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvrjy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso101976a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783709350; x=1784314150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ghB+78yE/3ES4lSKNpqNXaMIAgtNADaxhoROyeNa6cY=;
        b=hVI5KLzy8B3KgLLzClf+1Rcw9l8FJPEthAp3fCBfDeyYoRpGwKCATIAwxHHOJByBAY
         6vJmozBtLnA46NshTP0MeMyfVjdlzqb7qm1cXAbjEn3SoP9p0qEb6RVpZ7R8bvpaLSgn
         TNHvYj2/JR7KtB9o+S6DNRwPOTH0rT4Ur4u9sYqNHPy+NMGtDD047q7md6kzDhn4kr7A
         xmDw09PfQ5a5UgrE/a5KVmLssUC3d0iz4QqukdZrxCTBqbwDCJknll0pGndA7aULCZRu
         Vr0b4yOmElcrp9j4igV+zobgFqYMBt49dG4awD1jXRudzadmyLpNZAWsIGz8Tq61oVPf
         5KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709350; x=1784314150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghB+78yE/3ES4lSKNpqNXaMIAgtNADaxhoROyeNa6cY=;
        b=Mr5N3vzlFmPosVgO4q0KxP81wZbySEa3ZnP6WZOCjxDQS99uHr4FQFtC3nv5EgDFU4
         rNFnve25Me1jEaxnJ2TTIcC/zldtcp+tdnaHx866Rjom6urqvTzeSgXeQVcBcANacBzw
         toyhJ8hl6RetlXFpzmdA9pronqJx5uY1G7qmr1eE55qQy1/7WXPb+qB3tS2hiGDSyiEM
         n4Gsi9tJA8chqFpQvkwvTyYiWsfJr3i5T155Ur/K+oSa1E4rl3pPI+/vDlAgxMc0SJg5
         p4XdWsRzUv7+Z4VRdQw2y5nL+cLRA4UUv9W9vYnuqgSXoDUjP1PjF3kpy+4PI51NahE9
         DOGg==
X-Forwarded-Encrypted: i=1; AHgh+Rrk/at/NoPU1W3R5RK4sUZ3KxtUBca20t1A9022BNM/r1kqDc5vjCDY190/scOPazIvCPNpdvK34SeA0XqUukpjxR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxbfnbf9/METGcL/x2Aw3zzuSLp6Bkwxbh2Y/IevlYe8TMmHM
	ULoguahEFuUA0L7s/CTqC/WM7IM4Tb0Pf9PjL07lSK1eXzL44gpvF+qOmkvDKNVJ2gJJTExpbby
	sR3qSwTS8MU/I1r8DhiZ5Ta0L2ga7CGjdsT8gK7c/oDDn5ZnU1pf1RkjJumkRFn2WIli3sQDtau
	I=
X-Gm-Gg: AfdE7cnVGziAmyh3X8zyqUznrPZDtAo68ifCd+S84IuiPpxkUEOW0VWEVm/g97VVXb+
	zwgWMsm2ezGzw9IUNsbCYuyI3A1OS4xAgGTMVLJ4987j20QEZwnsHp84vaRK5LA7o9Q5ny7d1q1
	ZbSNaS9g4v4nY8LvkTCSzc/dXeCiS5q6UqMvqjqYPjLZlCtOhnQPKg0wUvlV+mU2ujCcSs1olS+
	aC2JFfjTqvhyzGvmVMi8+zSjW4D4XmFu0aaSp6rNm8vL5YGgE4qS/7fGJ6L7zRqzbWGQA2KnY9L
	EOxdgvLtPwHHOV5MPex1ZoKyHt6IKjwSa+n4kT86YTPHbeB4kqLYc5gdMXnlmnbTDOuvuUUK2M4
	zhUUbHYskrbXMElBmVSiqFABukXVEqhIm3wqxYHJXvmLy
X-Received: by 2002:a05:6a21:9211:b0:3bf:49c8:f8a with SMTP id adf61e73a8af0-3c110be0ee7mr239220637.36.1783709350124;
        Fri, 10 Jul 2026 11:49:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:9211:b0:3bf:49c8:f8a with SMTP id adf61e73a8af0-3c110be0ee7mr239192637.36.1783709349555;
        Fri, 10 Jul 2026 11:49:09 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm47226919c88.12.2026.07.10.11.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:49:09 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:18:42 +0530
Subject: [PATCH v2 2/2] spi: qcom-geni: add GENI SE registers trace event
 on error paths
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-add-tracepoints-for-se-reg-dump-v2-2-ca1e9ba62359@oss.qualcomm.com>
References: <20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com>
In-Reply-To: <20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783709336; l=4547;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=8IjvFdh38GVjti8EyyCPNx+zrsozIfJZeDc/Jq92K18=;
 b=LZBu61HhIxIB/wxtIfaMNakkUitzJXJmclwcuWrTXejzPiOhF6JokQ33ZCjOT0Er27vVIVkVW
 Rhar8SB3nC+CGmT7LSlLEfHj26NXQAFEiUVAWVFg+M8FdNfUmAA5na/
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: KWS49IhMa6Ryl6iyhf9uk7XEiDiNI4Ba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfX3nOh2qRuzn7K
 9jUQPn6W0Apmy5LcCIyoYBXcQswVDtk6cD8/2BkvWq6OwUaxvR5x1q6lNr1oTVQNvnTp/Smrfhv
 1bpSUQelANSJRQKK+f81jLS0nCqChmtK1RTFiyLxEzXB8Bs3iT7L2QjkTjBJi45e/lLEyjkKRBO
 ZBvMxNlDElAxjB2lKBR6B0vjQJIcHSP5T7mYynfbUjGDO0yLPCEBUPQMUBaeT7mMTkU24YJ1LNi
 GRyFpoH59j+89iH6OOSywoFcxAL8u5wuu+fpN7l+k+CVB6SEUmJG/KA37miZpAkYLRlNv8aqzoL
 XmpvSkJzpE0Jz/QU5ZpIbstzpeQ5YN3QckGnqqxN832RwZoB/l4R8FZKBy1vxwbsm3J79BZY5rh
 yUe7Lt98COJngyFA9tynFnl6lK6w7c2iZLXBa7b7h7jaV/qdia7YR+Cjkb/RTL66MvHcM/eS0Yb
 ZuV2bpYsar75uFuwSTQ==
X-Proofpoint-GUID: KWS49IhMa6Ryl6iyhf9uk7XEiDiNI4Ba
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a513ea6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=SuVZUjzzKY3ZPv7-dKMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfXzW8TXLm251iu
 MAFd7p/+QDURK452VIk4tG6nLvwwu69l2qBRlaT8wgTGdoSkm3azAPNyJpDj74/6Lj3HzApzFWz
 B97WWZ8VsblkkG2UtDFBAhry4TUgJU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100189

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
 drivers/spi/spi-geni-qcom.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 2914d781dbf5..33020273c5df 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
 #define CREATE_TRACE_POINTS
+#include <trace/events/qcom_geni_se.h>
 #include <trace/events/qcom_geni_spi.h>
 
 #include <linux/clk.h>
@@ -192,6 +193,7 @@ static void handle_se_timeout(struct spi_controller *spi)
 	time_left = wait_for_completion_timeout(&mas->abort_done, HZ);
 	if (!time_left) {
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
+		trace_geni_se_regs(se);
 
 		/*
 		 * No need for a lock since SPI core has a lock and we never
@@ -209,8 +211,10 @@ static void handle_se_timeout(struct spi_controller *spi)
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
@@ -218,8 +222,10 @@ static void handle_se_timeout(struct spi_controller *spi)
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
@@ -391,10 +397,12 @@ static void
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
@@ -404,6 +412,7 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 		dev_dbg(&spi->dev, "DMA txn completed\n");
 	} else {
 		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
+		trace_geni_se_regs(&mas->se);
 	}
 
 	spi_finalize_current_transfer(spi);
@@ -953,8 +962,10 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 	if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
 		     M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
-		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))
+		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN)) {
 		dev_warn(mas->dev, "Unexpected IRQ err status %#010x\n", m_irq);
+		trace_geni_se_regs(se);
+	}
 
 	spin_lock(&mas->lock);
 
@@ -986,10 +997,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 					writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
 					dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
 						mas->tx_rem_bytes, mas->cur_bits_per_word);
+					trace_geni_se_regs(se);
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

