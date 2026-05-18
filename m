Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC61358363
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123677; cv=none; b=Fal28tV5QDNKmr3HAqYpDr7oygEzuKLCM7TfocckmVY8u9D8IqYUIZz0kiHmHZikDR+Kcl8ggCPj/+CTSWL9l7y9sOwQL96BjUNX97R1HsL0HIXYxfaGf+kLnvQ2AkLmxsC60VYoCHwAe7dQ0BQOVi0H99oaGCdGaFpe/q+d5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123677; c=relaxed/simple;
	bh=UHMJrmT2ONvAIhQJivnj9PTIHD8kS546Sv7JR6mvijk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=klbKQcNySRs433ZhJG7S+ElNy5pyO1pNs2u3AKa+MMr0/iT/VGuGE9KJEHnGgJW9lDWdw9uID1J8PTorXR3vzmxrXM9ohd0CdKtr3q8MT/q5/tiZUGu07KR1qR72KbT/SZgspJo1cIfNKWwEzIGHd9mlqG6UcRTquP3TV2vl0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BqHx4Ajp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UqhrdG0I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BqHx4Ajp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UqhrdG0I"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IGwjqc2083012
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 17:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06u6G2Yp0YNV28hLRQxgGgcv716slVdRo5eq0en7VLc=; b=BqHx4AjpWCa4b4iK
	Z8UbGBWxMq4rDlzparAxyMSkir/lLMA8xl3Ew01q9r0h0aRmQFHjwbvWIBDNxuY5
	6cV/XYdyuz+/rBLzZItL4q9vm2HNDD7HLP/GSV5chHW0ug6+X+YptC2s18k9cK6c
	FIEkkPR6udsXHguI2nNGHGOJrHy5ul5Q/aC5Wu8vVsIHmBJtad5PcSNBawPYlwti
	X5BkA2r4meJeWnjWi8l/Vhca1ysoQA9AJoYtzLuSrobu6FlTfs/wXITD1bl7Tqsb
	sq7N4e0o+bM5fGkipHEvh1GaWjFIt0lGT5MYhwPRXQy4Kmd+iEmB0J2kZpJFRfF7
	2VZwuw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81ch9ewu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 17:01:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-366015bca9bso2886909a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779123674; x=1779728474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06u6G2Yp0YNV28hLRQxgGgcv716slVdRo5eq0en7VLc=;
        b=UqhrdG0IGTmvJXUFPCc9dM9D3lWC+bKb05hIp+SybJl4MRaJ2jdWk58UoEuDuUsj6N
         i3zkgF1F8KEz2Mgkq+l1cl1+0HjFUM9DFI1G20Q06TzlfCyOQtftHcNdpYrtG9WPvODu
         XBHd8FAloNSGdl55LLpQOfS/O2prGUA31yWpnJQSrS1u6TRUahpXAFXd5uT/8rEkUOJs
         OV5DImi8T66g5He/yqtm/7dj7QBGal2NnXepQnf+hQoW+mwP/fjytsXICSoIkIRIdcfZ
         kEZTgLWcJQ4ei3ATFBVbuWKRDotyXbBGAzR4o3C5TWvajVfvjHVV9xn8flfn9Q/r64bX
         5toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123674; x=1779728474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=06u6G2Yp0YNV28hLRQxgGgcv716slVdRo5eq0en7VLc=;
        b=WAtiY9S+LSmev88pyRdTAkoLhSPTpP+unmb1acLVZDPMPJxFfn2ukvxm3eAa7SSZ1b
         BwkVdCBCNoQd4VJS7boSo2FV00NXc9jJN9ZcqS5RgDdHQMiGjGeOZa6fhNU126Y8Sg4I
         9v3UfLaaj3oCs9ugJf2FdtRXIQJH+4P/3BoYMRvy5xwjJD61BfrMEvGVKDFIlS5mnpJG
         7SQ5cbtu3JddNF+9U+S8TykkgWIYyXvFpBZscFu9h4/Ac5gsOcC8NA19sG6HmJlS58hA
         tTrXeCItUxUNshFcyvbhBCW8XY7ej6BGu/68Vw1abtRLd9YAVJ+8FD2eNwOMYDFSjSUQ
         fUPg==
X-Forwarded-Encrypted: i=1; AFNElJ/VV4ydTV5fufWeXhT1c+zijLVRjIVAHbOa4Uuak35ZcM0sXeYNRD6hxI2e0geo4epJLedCpUI/BP3iAlyqTWabmCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmqiY2dFVUxPMZDPYKwh5hgKVSK9hsx/gr5h1gJfDvAOOxItu
	OdTHVuI1JVdsLEIR29fMOe6ASyPjNOV6v7I96xzSv/8do3M5kUS3+hkEoN5U/vyIAEIao0UDuZu
	k5DHTBgRAtmoNjS1Dt5knThyf6NKrcde1riQJ2fWKt/3DGTP0IUknEcaZ6Wr6Mk1nc3AhLC8P4y
	E=
X-Gm-Gg: Acq92OGveRDx80FRbJzmR7VcTgDGORXbV59/i4xMqsSRyvsenlJNoGoSmkK7KtSk+K9
	ZvwtuuOgDEWgVRO192R/oR80KOlpkRc8hNnPm1/SzaNlgdhb08NnqXlMnjRKoU5kkHj3acKYlA/
	8krONXUyz2WExmy9EOks99QYuzfIrRgGtW9Ij+rMaPJhjw8rrK5lR/QCSg6hgC8OdFrVs18CSc8
	LNUxftcqgQSi/oz6dlmSenAHyVMJsfIWlohrPkmIzcxo06f/264U4o8/HSfYVSb8A6SI0xYJlSk
	fWsNKvsk0aWmklSAk/KNKjR6Magwuee6QBvM9cZ+n+KSeneoEiWrZ1x9nIq/DGCatByImOFiZWq
	wWVe49tTHYuSpDIJRvSj0j/uAc3f0UU65Dsr8+wuDM1mbrU9TF1q3yds=
X-Received: by 2002:a17:90b:58e4:b0:369:1dbb:4732 with SMTP id 98e67ed59e1d1-369511320aemr11037381a91.0.1779123673709;
        Mon, 18 May 2026 10:01:13 -0700 (PDT)
X-Received: by 2002:a17:90b:58e4:b0:369:1dbb:4732 with SMTP id 98e67ed59e1d1-369511320aemr11037331a91.0.1779123672973;
        Mon, 18 May 2026 10:01:12 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695652466dsm5783808a91.0.2026.05.18.10.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:01:12 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 18 May 2026 22:30:52 +0530
Subject: [PATCH v3 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-add-tracepoints-for-qcom-geni-spi-v3-2-7928f6810a79@oss.qualcomm.com>
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779123658; l=2796;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=UHMJrmT2ONvAIhQJivnj9PTIHD8kS546Sv7JR6mvijk=;
 b=JMAeu+sCVD+tN57RQIT++CBVyQUVHpUT5cUM9HcdnM5/XXvsqZewC0nfi8M3Vq2OjpPUmFRJL
 e+ZzxXT6baMDNLiQ1iN00HAsJrChQl+3PjN2XX5+GSSzpBsil0kqxvk
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a0b45da cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=yQWrNeiMpWR-rHkHbRUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NiBTYWx0ZWRfX4xuFNQEdaspt
 VFgm/U/SLwdR00y4AcA/g847cpuJWyRROJS/mFc5GfK/EJMzMVAFaXKPkZy2zcZIfuKj8KBQdld
 hrlXEFaVQ2Rn+rZSpUYRcdx43ZPmK/uzy4XhY+m0w/vvvtwNPcvabZU4ZwkgMNXBKwiKVwGtxo8
 /kVkZY5PMQOA7oU3btF7DTtArssigoEciPj/TblQVGFj9UPPC2BDmLEYgFreM7Lqfn9358GmGMd
 L5EaYQr9sGs2mjvw6DXN3GNhS4dUgScAX2vtK/asS4hcFexZ13MUmKCksoLYMgJSsuWJe3L6HWZ
 Oyi6yuOY2Ps3G4caeQgzBTLd7TR1fK002P4WudA/OEaboURLTh+Jknad+RoJ8EvSlGdeU7Q83bs
 V4NnC4wrUgOXLdzZ1uexSvW01Xpl1towcou60YnHFKT2zvuMUlFiASwNrZgQXrxxAVGrCePFTk9
 a6TTPtI+rGOy8WHDG5g==
X-Proofpoint-ORIG-GUID: QyWJ_bNdB4Uv2RhtYysJriAxxjWTQCh8
X-Proofpoint-GUID: QyWJ_bNdB4Uv2RhtYysJriAxxjWTQCh8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180166

Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
These trace events enable runtime debugging and performance analysis
of SPI operations.

The trace events capture SPI clock configuration, setup parameters,
transfer details, interrupt status.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v2->v3:
- Replaced geni_spi_fifo_params with geni_spi_setup_params trace event.
- Updated commit text.

v1->v2:
- Removed tx/rx data capture since spi core had already support.
- Updated commit text.
---
 drivers/spi/spi-geni-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d5fb0edc8e0c..a04cdc1e5ad4 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_geni_spi.h>
+
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -332,6 +335,9 @@ static int geni_spi_set_clock_and_bw(struct spi_geni_master *mas,
 	writel(clk_sel, se->base + SE_GENI_CLK_SEL);
 	writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
 
+	trace_geni_spi_clk_cfg(mas->dev, clk_hz, mas->cur_sclk_hz, idx, div,
+			       mas->cur_bits_per_word);
+
 	/* Set BW quota for CPU as driver supports FIFO mode only. */
 	se->icc_paths[CPU_TO_GENI].avg_bw = Bps_to_icc(mas->cur_speed_hz);
 	ret = geni_icc_set_bw(se);
@@ -366,6 +372,9 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 	if ((mode_changed & SPI_CS_HIGH) || (cs_changed && (spi_slv->mode & SPI_CS_HIGH)))
 		writel((spi_slv->mode & SPI_CS_HIGH) ? BIT(chipselect) : 0, se->base + SE_SPI_DEMUX_OUTPUT_INV);
 
+	trace_geni_spi_setup_params(mas->dev, chipselect, spi_slv->mode,
+				    mode_changed, cs_changed);
+
 	return 0;
 }
 
@@ -861,6 +870,8 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	spin_lock_irq(&mas->lock);
 	geni_se_setup_m_cmd(se, m_cmd, m_params);
 
+	trace_geni_spi_transfer(mas->dev, len, m_cmd);
+
 	if (mas->cur_xfer_mode == GENI_SE_DMA) {
 		if (m_cmd & SPI_RX_ONLY)
 			geni_se_rx_init_dma(se, sg_dma_address(xfer->rx_sg.sgl),
@@ -915,6 +926,8 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	if (!m_irq && !dma_tx_status && !dma_rx_status)
 		return IRQ_NONE;
 
+	trace_geni_spi_irq(mas->dev, m_irq, dma_tx_status, dma_rx_status);
+
 	if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
 		     M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
 		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))

-- 
2.34.1

