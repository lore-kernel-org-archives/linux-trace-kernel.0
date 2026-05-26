Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71341B347
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817081; cv=none; b=dzQuc9caO4+kmyovId1zCug9uqhV/2sVKktxGyIFKgHlzs44S9nwDjROMUFkgHUy0jF4XnU2oFC7t8r4/Vv6DeTusBiGA3McQdUFvTe93MpeNUYfitC2G1cHf9tCagWftc/vhdCzneZFokmvfzF1bUFNJC8OO2ve/emlctMqDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817081; c=relaxed/simple;
	bh=UK0w8cVX6HonoLLMdXc+3FVa/9hg3gdhTjqWi4T6mns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brUtTX5CBKBoazUAGoi+U2sLwpdCBfPumUQ93ZqGjhK+szpDTFxhR0RIpSWKdjNZ4byu5H+Tzekhx1GPQJ91haIwiuYryOceLIncz/Mv8pAJusnMSnX24x2BeHy38Qz2D1EhtqyQPpPKq8Nc3u6SVxkZZu+f5WF5jRWvWdfckSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UH/ftc1G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jL/grDhG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UH/ftc1G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jL/grDhG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH0uRv2022395
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 17:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=; b=UH/ftc1Go6WNiRG7
	P8ZitGD+wHJFBCNIrhG93ShLh4eYvKATklbEHd7i6ogf2pp7kjDcPIHvJmnNwhcA
	pSal/sXJMId2vvSFN0e3OOwuH0qTFJTnQPiYPpmI+9zioiyRUGJ7l689J0wjFpOC
	Z5H6DvjPqwMI/Rz/ke8OS7mZ34Q9ZLBDgLfAtr9VeM5aZzuEerp7g4/Ob51ObSP3
	uvmI8I9bWWrVG1b6bW6eMpk9F7/X+7KRps+nBHCRCWN+w96juaRbp0DjbndxYtUC
	GqdZt0BLlDkmEvr05Arf0CTBqMoXzPkGz9GoTfSNmpZbnSWspYKjQ13Blh3xvKKq
	mwKgfw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edefugk6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 17:37:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-83536dc3be5so12372451b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779817078; x=1780421878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=;
        b=jL/grDhGC4us7AvtnILb5rGlguwotK2gBLYTZzOHALLhgc2raWouRzlOTU7Selki7E
         9/Vv2XsYatZTwW1nIiGk/ScRQzJwqeufqw7YWTLjhTrmFrDl7jhnN1mw9QE4xNYp8AxO
         WMkAjureVpPLwEjkYDJHdR8xB1+ONKvE/hgG9Mm6RTPaB+tmIWsMzSGENsiBjVmfQvOe
         6Emv7/+LkExzCRYE90Ere7/diA65k7jmu3R7RNXeQ2xnbtOIap2uaVUio28TCANYNhoo
         3YRRCCxtpuwBNnMC0UUNdzpSWxE7voAUoafCrFcrZaKaGdLmL3Gx2DV0ubjHm0i6iKmH
         q8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779817078; x=1780421878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=;
        b=nKxx8nFBKd+IBkT0DjcaHGyPkxuquj2sXZ4qVSNg1lRd/NH9+ix1laa4ede0J1IdQL
         jNN4O2fp6yeddRVfZgnbccTfQ2vCL/E/qDGpGEc61fx72xu4smwnucBTvImKHVNKdecL
         tUEtvUmVEYQfqGp+43WHNiceOY9+bro4jNHwpmmTKPxsLWxrtQTI3hd8SM0vfiHnzK2J
         20tw9CIO+Gq7yhwOh+E4eLOSqOysNGxs6Vn21pVovNVD8J0IE7lJf27XnimWcDZSeMaN
         IbB4dah5v6gPYtTByenQ324wTUyHpJNX1fxVYRZKg17JPMSKzjUuWiIKz2gNucNSn7Bj
         QCvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vLEonb+HysHAVLaMtMmJsG0tMM4Sdd6FviM1735cZ4dZ+0XpQG3PiF21Zcjknn/d8rjqoXLSMNcsVpwC7BmhLqLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3x4CIYszFl6P+FM72pxVsb7wcbiR0Lo/XAKlVV4hFobSB8gjO
	2mX9KLzJszmRCzkAE71Vz7rZi5CiZXEOMK6XQ3DohR3iLIyjl/3REoaMbp25w3iY9cpRgfKKWqc
	vqMvT2YI4Jat0LyVG/gLWwo2PDbK61rUatwnFjDTUF567YjvAu/xNgkMLMZqrTBD35cq/acWZ1r
	M=
X-Gm-Gg: Acq92OG2kHp94f1zotKTQrqSP5R3cA1HZw37w6pM3rdfgPpEy+QuGo3p4JRUc8lpRqk
	ZNy4yfHouiyCXNoChm/3tZ4UL/ie8tblzGIaYfKk5DlOFyhvgdWkEosqQbizqp22KWT7g7jxuN+
	8PM7V6KD5ra86xd6lp6aEnEPD4usI/D6FbcR/hIUTG/HMSSO/gTuU5lMOeaPQna3Ir47so+0Mwk
	thLiZDqnpUAAvFU4UYpa9b7/QxFTA5XUfIZRoUXHqIDQR/u9VKXhRIjjRltj9zq4TSzm/KK88RQ
	7xRIxlnd+sk2VZIgxVClWRmV5uifWYvzdqm16xFT8CHnPlqJcyBL5pYIrwR6MbjrGiQoXZFomok
	41vShsTEXaQ2qv9KkGP4mOcc778UEjK55B8qpyAhYVixsWhS3viMzjwQ=
X-Received: by 2002:a05:6a00:887:b0:83a:7516:5be0 with SMTP id d2e1a72fcca58-8415f3f197amr18011095b3a.50.1779817078480;
        Tue, 26 May 2026 10:37:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:887:b0:83a:7516:5be0 with SMTP id d2e1a72fcca58-8415f3f197amr18011061b3a.50.1779817077812;
        Tue, 26 May 2026 10:37:57 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841c32b511dsm3260461b3a.48.2026.05.26.10.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:37:57 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 26 May 2026 23:07:40 +0530
Subject: [PATCH v4 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-add-tracepoints-for-qcom-geni-serial-v4-2-e94fbaec0232@oss.qualcomm.com>
References: <20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com>
In-Reply-To: <20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779817064; l=4256;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=UK0w8cVX6HonoLLMdXc+3FVa/9hg3gdhTjqWi4T6mns=;
 b=B+01FdhrNr8H2zS6hZLDVdozovxGugFAYbEnpRfGUk2mrlnH3CoqferFlm3DfPXRabC8h9zWA
 319EjkjFMRxCu6AuiQJkRJ+vXYD3MveQrlKjWrs1Vq2HBfl2ZCkbV7H
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE1MyBTYWx0ZWRfX6RYleeesmrrs
 ZgCkaVYkIv1+rUlopu5bYohRHf/i+xj6Aq6JY5fwZO3FqVzLndiWFOJ1yiBqqFxCD1aajzHftUG
 6FTGpnP3fTfi36rvSNYjeRrDS38U5q+FXVKpTuY5eRDy9k6A8ClatDswlNOIFSrSe9/ip1DreIm
 VXsNY0HbcEfjTbfvCPN+6TKNZtei/8r6CfOtESgogzuxj2aSkJmcEXj5G3lIrmRqHEtZIEcbdCB
 LQuITZ6v5AhzBiSG7jZt6qP9mkUzSjQsejd+UCBNpscIdxUSuaiWEOTVu4Pv5huIaPNpVshPriC
 h39kYFY+a9HiohNCGvJnAe+1ZcyD/bRUZHgJbG1J1EGMVk/WGO6tA+cey7k5L1vaWTtkHalzI76
 +4U0fZOJaPA5dAw0itTsME2N4hOfImjbaPiJuWR75Gg7Jy7ukMygEnV0WQG5AV30av3Nl+2zDzD
 RQCHwzIEW6dEMPb06JA==
X-Proofpoint-GUID: Kx3i2xnE3WwysnKbEJ9IbUCYIT0JkeJl
X-Proofpoint-ORIG-GUID: Kx3i2xnE3WwysnKbEJ9IbUCYIT0JkeJl
X-Authority-Analysis: v=2.4 cv=cPnQdFeN c=1 sm=1 tr=0 ts=6a15da77 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KXSloCXmEunfo-Xy6rIA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260153

Add tracing to the Qualcomm GENI serial driver to improve runtime
observability.

Trace hooks are added at key points including termios and clock
configuration, manual control get/set, interrupt handling, and data
TX/RX paths.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v2->v3:
- Updated commit text(removed example as it was available on cover
  letter).
---
 drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d81b539cff7f..4b62e58d4918 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -7,6 +7,9 @@
 /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
 #define __DISABLE_TRACE_MMIO__
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_geni_serial.h>
+
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
@@ -226,7 +229,7 @@ static void qcom_geni_serial_config_port(struct uart_port *uport, int cfg_flags)
 static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 {
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
-	u32 geni_ios;
+	u32 geni_ios = 0;
 
 	if (uart_console(uport)) {
 		mctrl |= TIOCM_CTS;
@@ -236,6 +239,8 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 			mctrl |= TIOCM_CTS;
 	}
 
+	trace_geni_serial_get_mctrl(uport->dev, mctrl, geni_ios);
+
 	return mctrl;
 }
 
@@ -254,6 +259,8 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 	if (port->manual_flow && !(mctrl & TIOCM_RTS) && !uport->suspended)
 		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
 	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
+
+	trace_geni_serial_set_mctrl(uport->dev, mctrl, uart_manual_rfr);
 }
 
 static const char *qcom_geni_serial_get_type(struct uart_port *uport)
@@ -684,6 +691,8 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 	xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
 			UART_XMIT_SIZE);
 
+	trace_geni_serial_tx_data(uport->dev, tail, xmit_size);
+
 	qcom_geni_set_rs485_mode(uport, SER_RS485_RTS_ON_SEND);
 
 	qcom_geni_serial_setup_tx(uport, xmit_size);
@@ -910,8 +919,10 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 		return;
 	}
 
-	if (!drop)
+	if (!drop) {
+		trace_geni_serial_rx_data(uport->dev, port->rx_buf, rx_in);
 		handle_rx_uart(uport, rx_in);
+	}
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
 				  DMA_RX_BUF_SIZE,
@@ -1082,6 +1093,10 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 	geni_status = readl(uport->membase + SE_GENI_STATUS);
 	dma = readl(uport->membase + SE_GENI_DMA_MODE_EN);
 	m_irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
+
+	trace_geni_serial_irq(uport->dev, m_irq_status, s_irq_status,
+			      dma_tx_status, dma_rx_status);
+
 	writel(m_irq_status, uport->membase + SE_GENI_M_IRQ_CLEAR);
 	writel(s_irq_status, uport->membase + SE_GENI_S_IRQ_CLEAR);
 	writel(dma_tx_status, uport->membase + SE_DMA_TX_IRQ_CLR);
@@ -1294,8 +1309,8 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 		return -EINVAL;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u, clk_idx = %u\n",
-		baud * sampling_rate, clk_rate, clk_div, clk_idx);
+	trace_geni_serial_clk_cfg(uport->dev, baud * sampling_rate, clk_rate,
+				  clk_div, clk_idx);
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
@@ -1455,6 +1470,10 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	writel(bits_per_char, uport->membase + SE_UART_TX_WORD_LEN);
 	writel(bits_per_char, uport->membase + SE_UART_RX_WORD_LEN);
 	writel(stop_bit_len, uport->membase + SE_UART_TX_STOP_BIT_LEN);
+
+	trace_geni_serial_set_termios(uport->dev, baud, bits_per_char,
+				      tx_trans_cfg, tx_parity_cfg, rx_trans_cfg,
+				      rx_parity_cfg, stop_bit_len);
 }
 
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE

-- 
2.34.1

