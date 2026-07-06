Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB03FF1B8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336118; cv=none; b=X1hzgNNuzPU+ukPElqH/I9Nixl/2uQ8Pu+8LjbOyKmQeISx7BLyTkJlDLbQvpi0jXApR4oZn2y7nlBJOo5kPccD4N7Xjn1S2uhOn0szCEe0gsPjqeETcVisPS1K32OGAdBwna5Qdyu2TI3rjUStSXEKRescTYMJ8jZer055ZILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336118; c=relaxed/simple;
	bh=soA3BDJ7EjqA5hWfm4kj9buFogwtZYzZXE0zhdq8A0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffzbTnG0X+lnnpgnT4P+T6JPeTPSXtr/Qgkd1Eta3ctGs8Kiy9umivFhJUQInD8BtNF6yRAABBIjxDGsMrOOz6SYlKpTs/s6m/QSepDQB6qFDSIXOSo1f+zH+LkSIJ3RbovBqne+o1qi4X2U42LW9ZW3d4sXWudRszvaa0KDhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cV++0cZH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fEJawWEm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cV++0cZH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fEJawWEm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxKRJ367180
	for <linux-trace-kernel@vger.kernel.org>; Mon, 6 Jul 2026 11:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lOTzOSxHynqZ5lzAB097GOfQw5XXG6mSt3mT/6tBBeU=; b=cV++0cZHir9gZelD
	8opZkpEb2tUMwX/Tf4NQ6gd90/l5hsfsuOJZu5svZNBwgtXP3fnD54CkfBL2sqVY
	GwDYS0O+1cDURo1LEkXBCCG5UHsee26Kl4NVGDKH4+NI9wtLmyPCLRSgbq5rYeDo
	NDYiBzbiBifBNGcCaTmcrrehPQ9ELXf739xdhygNMj/mCd8kOMAx94SKuV2bW47S
	HZL2/gxe3FrNmMF4dlnIXaERGvlQ561BVjzGbc5vSvcSCzlGWqbgpxbR6NGEt6TJ
	7f7NYomZ3bxj3+5Q0VAmQnfrekyqQgVdeBtkoRxQ7Jd1c5xwRL4GFA2N5usbOZJI
	bamTkQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891urj91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 11:08:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c354050c34so31515975ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336116; x=1783940916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOTzOSxHynqZ5lzAB097GOfQw5XXG6mSt3mT/6tBBeU=;
        b=fEJawWEmI78u4fBnfmZQtDfe5K1WVEN7r+ttvnyKpE4kIXRj6f7mb0oP9i0Xa/DLBQ
         TWsf80Pa1cV+f9bNIFxtrFHyxWZF2mWqW5HLQQf4PTntAuXL14K7NNg1D3d0do/iZojF
         enFtAIP5bOeg9V+NOWEkLTPI2KoxaiQyNrkvmbjrmnJVj7obMuYKhF7s045f5OCEB/fE
         rRjh7zQSoHKgdxHM3Emmk9FscKudAuEjhE3ZMmZWVx+k0t9nhYptW9ALm/pwApDuoU48
         AENo5E3Y1Wtg/SFP+iEz/2GGjK8HSPrz9Kfge6leCxspvAWMaAcwe0TfFnZLzk+4PX82
         kVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336116; x=1783940916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOTzOSxHynqZ5lzAB097GOfQw5XXG6mSt3mT/6tBBeU=;
        b=CNr/A6x8UjSamkuWhL53+NsP0uYcUeUNpYfYHH6373YQVAlruURF/7lLVhzTKLV5yS
         uThzFGl4i1P+/A5KXpwWKlkya3oW/QvO/0g22Y8ZegVgLiQ1eKfayobYEmF7bdzWQ+fG
         kW/lkyd3mvvrg7JwYJtUZp9XOaoZZvortPWpQUdy48ID/0sk9HWxxmJBgdVPELBhqJV2
         OX3re9LAQVwHklxdC9nTp0zBD3GRnp8BFDrVz51ujEe54RK3zgyRnXXUSbW04bMND//E
         vtSSGhidPhFiktKmu/j4AtkcGRCvoLW1cxtW/GH2fanFEE//BdrOvkZVkBUYPizJNSJP
         2uDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyOaUtEb9/xK+GotRUCFHv5QXVFFrGpxrvNpY53BdupJORU4DOlgVjEoWFj1dCL5i61eg9C9Mo0s/KyBg33MuDilA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfMJHGMvShlQPIgUWulxNAWqbb4gUKOm2Z9pDpozQl7hR1XfE
	YZDoP2zJH6nuojMiJSkX0BsL2Cm/mBRikreCAPTRaq/7yv6PpSQHAymmHl+ikqCvy7Kp87jrf6a
	9ddVUvT0Zh6oiTBoVIe1n/9CTamHKlSreMVFo6so+xFEGaO7jbCm7KaVBaj+QMXEW2EEyxpqQVd
	w=
X-Gm-Gg: AfdE7cn4Jp0yY3T31YxTep0xEHcWhAuCy1+qz+9mwrObOR/qaHYdQvrVaEB7DiXiVLq
	CDpZB3Xl9Q9pIiwjNkVFPwrl8fNpaOwm+7h7w3bR3RZebCKh75RS5Frn4k9u+UapCUmLSNaSYy3
	HKdrTcrL+UBuYbK3tmKfSjbzOBNcSDbDf4iKiDncpexK4BAJfN3AUMEVS3FI9lpzR/NtukvjLFF
	85ZR+j6RFypSPTdvM8ee+zuDpxXtNJAowyedrB5iCyZBLzQI4sSbEdUtLW64Z8sgp2lsBZimFYl
	TQXNqt+byRjgkhYyACA7HmB2BFjTz44ZBoGwuiA5mX9v3L7p2lnwanuQS1iTEoz4UDZrqcFDxPq
	3BziNuXtSRFgdyVimOdtMiTeicKNPggAHW7iyJtOsFRSw
X-Received: by 2002:a17:902:e78b:b0:2cc:98b4:e7e2 with SMTP id d9443c01a7336-2cc98b4e9b8mr39300965ad.44.1783336116082;
        Mon, 06 Jul 2026 04:08:36 -0700 (PDT)
X-Received: by 2002:a17:902:e78b:b0:2cc:98b4:e7e2 with SMTP id d9443c01a7336-2cc98b4e9b8mr39300675ad.44.1783336115518;
        Mon, 06 Jul 2026 04:08:35 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7871285sm47730685ad.64.2026.07.06.04.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:08:35 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 16:38:13 +0530
Subject: [PATCH 2/2] spi: qcom-geni: add GENI SE registers trace event on
 error paths
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
In-Reply-To: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783336101; l=4376;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=soA3BDJ7EjqA5hWfm4kj9buFogwtZYzZXE0zhdq8A0g=;
 b=mshxjBsL4s7tH3/JNjX7VohPwJ6AxOs8q2vboeGbMu9861OFrOa9dNhHLbd1IS0UNdTmCZMq+
 Dbzv6JONoEWB8yTTTAFAoIihszsrJxmOBg40lz5nQzZHmkNfNyh8wXn
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: 0F0CzZ3Ob9dkYHEWrFMZbb048kDvB2Y4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX/jsTRSzt1YJA
 mi4Zy9VUZKaM7NxiC4UR+JXUCilUVN8sdjdtOuS/PdByj0I+e1ZQ6zlEFL9eH9L1u/e/PuV4HHm
 iquNG/LPHGFYPEYv8xKrdBetuUTTKqk=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4b8cb4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=SuVZUjzzKY3ZPv7-dKMA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX+x+WvxZza/r3
 kEHkaCHYAe2/voh0HyjLL6DonAEBbwXKFrMDdebbCEFfS59LOyuDDiya8oF5ULk0Z9GcyFvRFsF
 G2a2TOkOvKxIcoTbaJzGFY/wZtoIws1051M+fbfLORJhPpSmCe8z6yGLz2K23XFKPOZ0zY2N1Wu
 Qcr+5iTtf6tKNe6/IebYwSc9jlXNdlAFR/ng7geZlBJzrd35+67A2ZbRH75EECK1KVAsuvLFCuH
 RJHNWenNV6giF6pDYOfW8B9G3C1gWLMt5ULVngryW2NeAo9tl0d15LHSGsyR/+E2Bxi/nvNWCnB
 Fl2m/5YWk0YlpLAGSgBJOiTkauo3olsnScv82Yo3i37+oqlFBpFnaWZ3Rml3LnZEXDSrwH+EN84
 MUJzJvPE5LPP1PNuzJf5NlpD+9QHt7cxQoD7rfGqtm30rkZnhHADjE/37SFmBUW1ZfzvabYiWVx
 RHaIb/aDLqgzdgklQvQ==
X-Proofpoint-ORIG-GUID: 0F0CzZ3Ob9dkYHEWrFMZbb048kDvB2Y4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113

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

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..7db0836308c2 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -3,6 +3,7 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/qcom_geni_spi.h>
+#include <trace/events/qcom_geni_se.h>
 
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
@@ -184,6 +185,7 @@ static void handle_se_timeout(struct spi_controller *spi)
 	time_left = wait_for_completion_timeout(&mas->abort_done, HZ);
 	if (!time_left) {
 		dev_err(mas->dev, "Failed to cancel/abort m_cmd\n");
+		trace_geni_se_regs(se);
 
 		/*
 		 * No need for a lock since SPI core has a lock and we never
@@ -201,8 +203,10 @@ static void handle_se_timeout(struct spi_controller *spi)
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
@@ -210,8 +214,10 @@ static void handle_se_timeout(struct spi_controller *spi)
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
@@ -382,10 +388,12 @@ static void
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
@@ -395,6 +403,7 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 		dev_dbg(&spi->dev, "DMA txn completed\n");
 	} else {
 		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
+		trace_geni_se_regs(&mas->se);
 	}
 
 	spi_finalize_current_transfer(spi);
@@ -941,8 +950,10 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 	if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
 		     M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
-		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))
+		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN)) {
 		dev_warn(mas->dev, "Unexpected IRQ err status %#010x\n", m_irq);
+		trace_geni_se_regs(se);
+	}
 
 	spin_lock(&mas->lock);
 
@@ -974,10 +985,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
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

