Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82C48BD58
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088603; cv=none; b=awSr6EZGoS0Ds5Na5AfAYWfqEcGoFMlSEqL5oM3iDX+XlVOO295vrDxJEiF/P6eZe0CjyDiW0TOh55JcxCbrE+7/eFjvn8APZ+WMWMuaRWP9B1blXIR+AKJ2LE3/yylGKChzc2GKB4ZpNF9+jWagpz0Veqga1QJBZDur5EFs5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088603; c=relaxed/simple;
	bh=koNBStVdcC5+4m4qVXikoLETuVjLx01Mbb0BXniq3oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EsuqA9v6hI3c7dZzg0w20yosqNHEPPS4wPY+qF5XBGX3BujdantaYCmdLnp/cU5t9hrALANsUGT1BwYrJYWmtYUFL+b6UT2wSX3qV/MRAG3mRM0B3FWBl9HHYqzk7f7HApHvJ2RDZO/CLnwEed1GMEwjez/YUM6eoQ/VdncOZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DPueg81i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VeqooVxa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DPueg81i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VeqooVxa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646C5K6i3036458
	for <linux-trace-kernel@vger.kernel.org>; Wed, 6 May 2026 17:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7Bu5I4Phk3bl5hOaeKMU154m5IfQGip+W4DHvInroQ=; b=DPueg81iv9D64n0l
	ZnY2CukN9YYlkOrFnAa/ITV1SlSgOBpceWbXPTTe105wiRZRdSjymCeGi8GQg1SM
	tQ90kW4Ze6xrNTHJwOYYok+TYi+EC0dQ+dKFS4DkSUo7zkBRbnwqF1ilHmPrLMtB
	o3ruVI8i938sQWwtZqF2YD9oDxra5Vjh1JRYjDRgRIC/dGsxkDUWX+SVVSFtqtA+
	jd2FZemBdmi6UBwzd4lODZMzip9OmeuQv7DstwOzApx85cT9W25b5LPJf+dJ3N8h
	cDqYJc77thd1O9Aoi0Gc4VaiYJA7jUWBiHnDsE0q34A9Pc3rDoMLXg6Jfh+cJ0/M
	Nni9rg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf190a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 17:30:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso119608a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778088600; x=1778693400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7Bu5I4Phk3bl5hOaeKMU154m5IfQGip+W4DHvInroQ=;
        b=VeqooVxayMympo6m//bhp8P+pXe3BykzZRvoBESWn0/97JV4bOJyQBuwM7ankKcAkv
         d49ucPdkrYXvaMbU7qBlenOkHnwNVaumUfuYv/Gy51EG2QxHzfV586qLoC4n7BoTfNjR
         2WXo74GActXNqtHRo+z02HwkSc+rc/qRXzfPYGIuJvfh4QNL9tsK16HSG7k/M0ik3A13
         FCSIBr6NAf8yttjAfv7SNARSrogkcOhekdMDo4BdpqDVkVFjufHlcKtlidNwf/XoaIaD
         37c1yAEr6r+5ZZE6GUiPix8NQuTNJ9rNBX7w3+qUSIvZ0JTKB9NA3jpoN/zjeiGp30Ov
         NK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088600; x=1778693400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n7Bu5I4Phk3bl5hOaeKMU154m5IfQGip+W4DHvInroQ=;
        b=ei8p23Ga05XTVd7gROdimFazX/7XYjYIg+RynTIjFcjd5whO5j4qP9+rrqXAfmaPjX
         6TMYtXHbLVCH7yGZAPnip6g+Dwk9scSogOIn0Vx43ng2qQQSXkUOizTzLGoGupHKriCx
         CR2QcTOboqFwpzMTkkmtcvQLztheoT7Nr8zaDqFHkxO+5t58hv0QtBTJXB3NwbJHCmPO
         Du7DLUmd6DS4atASRLQKrbaIANAhcbDk6+fR2dr3oF+szyBYrTqtmfJXeGmhUuI95tCR
         pPOtdzRS77bngsBTi9VghYzrf+/yQ1Lses7afqyFdDqcvOwiVhsTr9WaZeqz29vsvSex
         3Kew==
X-Forwarded-Encrypted: i=1; AFNElJ92PgOy73KXqXzBY+OUJFUWzbiANfcFxVEIz5fEQXQ4Ge0+NkjIGhBhQ5glQnEjm76vFFirUth3F2vmDOELCBV14LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBlJ52UxpZJKXytSVrV4r3skS3WYdNhQTzQnVLFWnmGFr1FKJ
	aVJcfvh6NuxM2A00pkz5mBmLH68sezWDJ9qu3thuPyV1m5Wkht7RH07Uq+ujr/WoA0O9ZiFfQoW
	K88YncwM8MbjOm4PMoQ98s4sff/NZ1ARzcobh4bzakHHlC23rGXFyOzM0h7qe3z8UyDQ3SuiBK7
	Y=
X-Gm-Gg: AeBDietPFX5oqoqX2Bjk2vHdzH+8OAsSMmIIAfy4RHJAHp2EXp/pVRsX08QFtspeQh8
	xFcAEEN5FGxJQhSsIYocR923zabU4r83qz25RUl3qDWVE0idLGSivfzRwTtd1R5sYa2sGHS4oaV
	OkKuN/5FjdOhek1XPPSOgeZSXJ9BqSAFCMxd9oXK16KWinskhNGbmDpYiPAqI2nZZ+pmGpR9Cjt
	8+UfMq9Oku2nX5acEjDukba+gAwoWlvpD0T7KBha/xcD/6eFFxPXXkPF5CMM40gDkXGe+LBCC6y
	LmE/HVu2MrvU9m0v8UmOshIJX83mpmlCWV82jQqDyVDKF9mGxzZQ9enw9FCwdAktjyMdM40rIHC
	eYH7fQJheOrFVg/3Wo+DU+eogKpnFtfEuxHfOj5++KMCMwVvRduXhvEb/ujdjxb6ihw==
X-Received: by 2002:a17:90a:d886:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-365ab3e592amr4675134a91.1.1778088599510;
        Wed, 06 May 2026 10:29:59 -0700 (PDT)
X-Received: by 2002:a17:90a:d886:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-365ab3e592amr4675085a91.1.1778088598917;
        Wed, 06 May 2026 10:29:58 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365c25f8cf9sm3370143a91.4.2026.05.06.10.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:29:58 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 06 May 2026 22:59:43 +0530
Subject: [PATCH v1 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-add-tracepoints-for-qcom-geni-spi-v1-2-c957cfe712d1@oss.qualcomm.com>
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
In-Reply-To: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        "Mukesh Kumar Savaliya mukesh.savaliya"@oss.qualcomm.com,
        "Aniket Randive aniket.randive"@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778088585; l=4307;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=koNBStVdcC5+4m4qVXikoLETuVjLx01Mbb0BXniq3oE=;
 b=HN2AHHhrUfmFpmtaj+zY4KZuBKKeyAYcKBVexa6xYvmnaDePfMzl7tTUvARJk0ibqY1YoAq8U
 +4IlZ5Qp4C2AJHTIpRU41t4GqgyC0VeNvyBB8+j7gjM5bdCkPltx1Z1
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3MCBTYWx0ZWRfX6XVunOmcioLt
 XhIVtiz0bHGEaUoxrZtulR0ac3k6EkwExMl5Dfr+oxzHEfEv7BECkkqW1TlAhGouCodZXQDSUCA
 Xg/CCg17vH+vCydFkpHqLCLbJuhom8b8tYFif/4GeX+kWK40hrO+UtG4otaCtObDrckpbrkcilV
 7wcKEMU7+VBjBV751evUuINVSHiYr9s9G3RSuyWmoySoLJrrcz+/y6ip0OaidvHDAT1yw0FJtAe
 qZ9R6thz1Dcbr7oARFNeZBkeXi6048HcWcNbP1b/Porj8WUIWdA9Q3svWhRHONFyYEN9LCMgKKq
 noKDd5gBfeVFJHNnUDXbGl5+dPu2KUdtoxUOnSfo0fzDY9zKb0xHtc7dMsEUF94YvdBy4d1kd54
 o2pCGRbt/nO9BjW2B2qrTE4J3aNQQwXW2OSnPNoP0SPPe43Ov86Acz66RXDKnjsOmGr45j16tXu
 a+zQm/0dFp3YYK+jSbg==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fb7a98 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=YigI2Qbdxp8Yt7aqB9kA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: MxlOWD94FEw_2S-3N14EnLIjh1UTmGCW
X-Proofpoint-ORIG-GUID: MxlOWD94FEw_2S-3N14EnLIjh1UTmGCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060170

Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
These trace events enable runtime debugging and performance analysis
of SPI operations.

The trace events capture SPI clock configuration, FIFO parameters,
transfer details, interrupt status, and actual transmitted/received
data in hexadecimal format.

Usage examples:

Enable all SPI traces:
  echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_spi/enable
  cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:

71.364028: geni_spi_fifo_params: 888000.spi: cs=0 mode=0x00000020
   mode_changed=0x00000020 cs_changed=0
71.364054: geni_spi_clk_cfg: 888000.spi: req_hz=10000000
   sclk_hz=100000000 clk_idx=5 clk_div=10 bpw=8
71.364095: geni_spi_transfer: 888000.spi: len=16 m_cmd=0x00000003
71.364096: geni_spi_tx_data: 888000.spi: tx_len=16 tx_rem=0 data=56 f1
   0d 95 c1 09 33 d2 27 e7 ec 9d 9c e2 11 ff
71.364121: geni_spi_irq: 888000.spi: m_irq=0x08000081 dma_tx=0x00000000
   dma_rx=0x00000000
71.364126: geni_spi_rx_data: 888000.spi: rx_len=16 rx_rem=0 data=56 f1
   0d 95 c1 09 33 d2 27 e7 ec 9d 9c e2 11 ff

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d5fb0edc8e0c..4da888359cfc 100644
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
 
+	trace_geni_spi_fifo_params(mas->dev, chipselect, spi_slv->mode,
+				   mode_changed, cs_changed);
+
 	return 0;
 }
 
@@ -717,6 +726,7 @@ static bool geni_spi_handle_tx(struct spi_geni_master *mas)
 		max_bytes = mas->tx_rem_bytes;
 
 	tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
+
 	while (i < max_bytes) {
 		unsigned int j;
 		unsigned int bytes_to_write;
@@ -729,6 +739,7 @@ static bool geni_spi_handle_tx(struct spi_geni_master *mas)
 		iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 1);
 	}
 	mas->tx_rem_bytes -= max_bytes;
+	trace_geni_spi_tx_data(mas->dev, tx_buf, max_bytes, mas->tx_rem_bytes);
 	if (!mas->tx_rem_bytes) {
 		writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
 		return false;
@@ -778,6 +789,8 @@ static void geni_spi_handle_rx(struct spi_geni_master *mas)
 			rx_buf[i++] = fifo_byte[j];
 	}
 	mas->rx_rem_bytes -= rx_bytes;
+
+	trace_geni_spi_rx_data(mas->dev, rx_buf, rx_bytes, mas->rx_rem_bytes);
 }
 
 static int setup_se_xfer(struct spi_transfer *xfer,
@@ -861,6 +874,8 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	spin_lock_irq(&mas->lock);
 	geni_se_setup_m_cmd(se, m_cmd, m_params);
 
+	trace_geni_spi_transfer(mas->dev, len, m_cmd);
+
 	if (mas->cur_xfer_mode == GENI_SE_DMA) {
 		if (m_cmd & SPI_RX_ONLY)
 			geni_se_rx_init_dma(se, sg_dma_address(xfer->rx_sg.sgl),
@@ -915,6 +930,8 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 	if (!m_irq && !dma_tx_status && !dma_rx_status)
 		return IRQ_NONE;
 
+	trace_geni_spi_irq(mas->dev, m_irq, dma_tx_status, dma_rx_status);
+
 	if (m_irq & (M_CMD_OVERRUN_EN | M_ILLEGAL_CMD_EN | M_CMD_FAILURE_EN |
 		     M_RX_FIFO_RD_ERR_EN | M_RX_FIFO_WR_ERR_EN |
 		     M_TX_FIFO_RD_ERR_EN | M_TX_FIFO_WR_ERR_EN))

-- 
2.34.1

