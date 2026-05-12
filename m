Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D242B728
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566421; cv=none; b=WdnF2NWJDNwCGNt4OczAEdGN+xDVuoFr4/VBtbZfmBZNNVxciVYBmMVd6Y0tWoGweLEJlVGjfkB+8RH5k4QsYyLVnWbbobp997jU/Y6dM5QqDCMzKnHCDKR5fbODXxejMqYW+kMdIFVwZ/fBA9y8WhYp5GRvA1MSBbErw+psSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566421; c=relaxed/simple;
	bh=TyvIvNFT+CvopkY3GIXo2HJiH8nquYeN4rxT+/Zw/aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdJipK8nBb2+fRBggPqyWY2n5yEhL8AnUsvZmsfc7+d/Pv5hFyd55/DdA8Ox9rD3jHoR4+eXemyWSjG6gmgFScuFQh5YAW4npNLb1g3hToXd70Uz9RACFHTNxeDh+aaAwtiEr0V40M8IgJx+kYEZ97VzjAI4C2FBOKvKhR+zEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KjVt9612; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W3fwOnIp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KjVt9612";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W3fwOnIp"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5J0vi2573861
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IpoQWTuq0pCUojlwtQJQ/ytOD4k0BhTtMwmEYgzCGto=; b=KjVt9612g66u07ty
	klEjeh04BO2/hkslJXOokYx9rPtT/Ax1L8xAYwedBTONUpdjhuVJi+k21+D/PBhd
	0wMPWRlEJBK2l7BeST7juGBVhrLCabGJVR02Ev8zoiCc+0KHEKdhMT2FYOQbpNja
	pYH0mtXgb9QgTDG5BOKMAjcuL37LKDkiAOntw6XV7ct0wQE6QvKq16oz/NjzUA4k
	A35bPyAkOnLb/Fhb0RY/uaC/0LvOTVTju8tGjMPfSBgfFaTYIqJrzjE6wvKwoKEj
	AOwHVE/ncFrQ9lY5Frd9bw/DZ874fnNJ76/LfNnkw9Ipk6F61eRCLmpS9xyzH1gU
	fQKeFA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv29rqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:27 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36865d109dcso1860621a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778566407; x=1779171207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpoQWTuq0pCUojlwtQJQ/ytOD4k0BhTtMwmEYgzCGto=;
        b=W3fwOnIpyhj2TbxeezS88ZBSSUkcAVY5SucDc3w1/f9kLiSztIoZCQ8yoAUme9JAX5
         0NZNk0jHEqvw/A9xlm54Eq97xAE7oBQPk73z6Tz5cBV2i86dEaYb5B/dl2QGAvvnd+c0
         kFQt1/t6A+MJGIpawkT+SVM9hiYoVnLqx1DuCCSRJHEju44UBGBc7lLg3j2eckqLBq01
         yKfOwVQRQToekAYHCmVIP2PH6CdGKeD+DWw1YQj74mnAO0F/PRprBZ31CtiHGD5bqTov
         KTPoJ5xUzWN0AhoiEZ3BorIVeLlPAasZ8szYMIBEiBAEoGyAX7bjM0Xf7wOdR75GPDMr
         KURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566407; x=1779171207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IpoQWTuq0pCUojlwtQJQ/ytOD4k0BhTtMwmEYgzCGto=;
        b=snZ3o9lwk7QHXsfmHFE/PrtV8ykS25CjVBZesA9cU5v5rvlnrEpvhDLvl5wDtT6iNi
         cJYWRBaXM9W3hb9RymVBhCmlQqgYNb4FkKd6iRS87cICWZ4xAVqLpFv1tKndWnAjD23L
         6cbMI1MZ8vGClKNKeud0l9aGPf8nsfkMB8gmHzPRALvblJ0JR9F2WuyNuIOWPKt37rTR
         0nWKvWjl+bU6/NKCZXWa5tbfDPo3sjuVCgqPzyN5L4NosA/Jpb5Ga/PJoEXIMHY5K3Hl
         FTjQb31BdHwllLrHu0tmAmZP+dJLjFj1qA7HxVT7QpCHhRcyfl6X1cm8JIeO9qQJBzS4
         Jpmg==
X-Forwarded-Encrypted: i=1; AFNElJ8BSBDXDFYxnnC30GXeg4hUoiQgqxgtWRKwFaXh5UJHUiT01Pcvj/+ncGYyesEdWOoybuGy7tRSKyDG/1aWLPCEp60=@vger.kernel.org
X-Gm-Message-State: AOJu0YykVoc74zO5soqs1D4fTZY7XoxBCOaDqB3exRhrWr3jsx0SWdvb
	xMAX7h98KT2Gl42dXyAmjr7TIbMc/SkmseSMr2A9NV+rMpsHE6S0msKonWSMhxyK3sFLt+fSk2g
	VmnjuOjkTMuJl+XzVR0ulDyzLgeLR8upQqTEUXBSQADQERsRC5PdJHWNLuaZRir84Ej6YYlM7oT
	V//8jT050=
X-Gm-Gg: Acq92OElPkZCHCv92c3ttGO8FaOJ/GQk+1XS1aE1gu08JGEyIWvcdXI1lody59BvWJw
	nuUKN56PAVHL/q46G1W1FJG3lmumqXft6yS/gmAsG6jKV8tKwnzwoXUHlVzV9PUmM3NtXG+9WVz
	G4M8vxPEK4sJPoxbNyXE4nFL6+ccutWgd5SIL5riGS2yuXmJCva5je9M3xMPxJRWpd0KfKOi58t
	dB5D7IvlVZMf8qJ85NLjQp0Fce7xrhzJgLM/a0+hfxCwBgBl1QuD9vkV/CUJD0hDyioJzeUviir
	inPSgOrH+BlddOv67pxC7xreHjJfcvfdiB6TYqR5T1zf/oD6pwFiYSS528Ma8BOBTSPvbdq83FN
	/w0++gUZdH0Kc6yko4efDw+ihnKuFpMxe4ddtlgLbgZVpIkwIT7z1O+8=
X-Received: by 2002:a17:90b:1cc4:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-368b4a5c615mr1966400a91.2.1778566406673;
        Mon, 11 May 2026 23:13:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1cc4:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-368b4a5c615mr1966342a91.2.1778566406104;
        Mon, 11 May 2026 23:13:26 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b00d2131sm842518a91.1.2026.05.11.23.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:13:25 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:42:53 +0530
Subject: [PATCH v2 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-tracepoints-for-qcom-geni-spi-v2-2-3b184068ecf9@oss.qualcomm.com>
References: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566392; l=3916;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=TyvIvNFT+CvopkY3GIXo2HJiH8nquYeN4rxT+/Zw/aE=;
 b=iV92GtYb71Z6+FDs2w5XX5o/tN0LMR/wMDMF7MRIpaGSUeKEeiSc+rZj6FLZUmpktYCaobjDu
 bTpvDoheAcxAk/KHaMsFpghjdxKap4H+4CvwDlojaCzNE1QzOFrZHq4
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=IsAutr/g c=1 sm=1 tr=0 ts=6a02c507 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=NVsub6H0E-3clS5m2s8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: GIe9-zgep8kUd-EEIzme_JPsRlxRNg7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1OCBTYWx0ZWRfX12a/9BiLyNa+
 an8hLBC/GNJ9yG3HjO+grNxKWMoTpBo3rcx79+UgnWoTX9j3du3ezIs7WrZrTiuDiMjG/E8P87a
 DZ84N38JUbNcrsfRQVGPxfy4JY4ozKx+NZTx4QEnTktEp/+BF9+F1zMjI9JUWzhbt+jyPKObVdG
 ZEhQZLOqPwEtzpQOMy78MyNAznL4gYVbgsODTLiRV7GbU3JmK1EzScAlaTpWLA3/YPx0EqqJN0c
 /VhlhlqaN90ljH5SfAyD8Qp1jAks37C1aYoK2A+TmT6rYKNvoDdILpu6AdEA/Q/EfMwdZiQVK8r
 C+qopszwY7A5EQUNr+uZsuNmHqDonwDhNrfobvBzwizhEp4xvDOcKH6yF9GVLsznXy+w+UTXtyI
 Dm1IYggTzpK0FPEXk9sqXfCmNcTGO05+l6hPwIld73SFMeNxc3PgY/UmOHdQWA1WKKtASoUgnQU
 xXAK0jLVr7aMnjfn/rw==
X-Proofpoint-ORIG-GUID: GIe9-zgep8kUd-EEIzme_JPsRlxRNg7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120058

Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
These trace events enable runtime debugging and performance analysis
of SPI operations.

The trace events capture SPI clock configuration, FIFO parameters,
transfer details, interrupt status.

Usage examples:

Enable all SPI traces:
  echo 1 > /sys/kernel/tracing/events/spi/enable
  echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_spi/enable
  cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:

1003.956560: spi_message_submit: spi16.0 000000001b20b93c
1003.956642: spi_controller_busy: spi16
1003.956643: spi_message_start: spi16.0 000000001b20b93c
1003.956646: geni_spi_fifo_params: 888000.spi: cs=0 mode=0x00000020
     mode_changed=0x00000007 cs_changed=0
1003.956647: spi_set_cs: spi16.0 activate
1003.956648: spi_transfer_start: spi16.0 00000000ea1cf8b6 len=16
     tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
rx=[00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00]
1003.956653: geni_spi_clk_cfg: 888000.spi: req_hz=20000000
     sclk_hz=100000000 clk_idx=5 clk_div=5 bpw=8
1003.956691: geni_spi_transfer: 888000.spi: len=16 m_cmd=0x00000003
1003.956708: geni_spi_irq: 888000.spi: m_irq=0x08000081
     dma_tx=0x00000000 dma_rx=0x00000000
1003.956717: spi_transfer_stop: spi16.0 00000000ea1cf8b6 len=16
     tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
rx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
1003.956717: spi_set_cs: spi16.0 deactivate
1003.956718: spi_message_done: spi16.0 000000001b20b93c len=16/16

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v1->v2:
- Removed tx/rx data capture since spi core had already support.
- Updated commit text.
---
 drivers/spi/spi-geni-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index d5fb0edc8e0c..164c6c0b9544 100644
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

