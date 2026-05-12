Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784753B8111
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606066; cv=none; b=kpQ2mmYYpDKbgQLLjiuDfs444nsTnQihLnL1SZ5ilajaAXJwKIX0wDDEmHkVSeCyqih+U0rlYneTyTMpX7EIa1xcnRupRHIkCKADWRx65ZgbJ7+i15iN7q7XeObjGA1LSmU63+YJeIJYsHqbPgL83i/aAeSOCdIa3zf/McuDlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606066; c=relaxed/simple;
	bh=cN4714YKFgE3Cy3MMrWdct7feqTVFb9iQz2fsCrzvwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhRJpSsvHhz23t+aORPMyRd5Womv9Pn49z+4R9+5FnJkp3/IULFA2Ubg1GoOAx9nEleSYJe5v8wjP/LyIQY72LtCEHNG26+mZCLDmVTfD21q7r3e8okMrYrRoIhj2Bnt86M50FOEcICTaeDUDsT2l2UDN8wBgedQ2qCREJNUkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SoxZUgwW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nd5Dm9gp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SoxZUgwW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nd5Dm9gp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CC4TYR3320988
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 17:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=; b=SoxZUgwWU5PZ3/XJ
	dhdbg8AdK7tiX7oCDXkC6Q+CPCkh0+JlCjXzymUNd4n8enaDDHKRV3Izjd97nLHT
	6nNnhWr9otJg83vLoZxI/fpaU0YEY1VvwQ5xl6UGbcMpo1bx+4E4SmB9JW/kI6zg
	4WontDoO6MsFooza7RVVaZiwpvuZnN8pN8EHnYVoMrlUfdFtYOZAC/y76XTgrebn
	tWX46tAHsSwJp+zcfOgL8X1vqpqNUzonrwvySlsyl9pRsVEwWlwvjennP5G5UZU+
	muSp0N/4IxScFeOJca4JqUtFCq1f6d21UjpugpvlwJ+p7tZFy1VRKK8+49KMAPaE
	RsM75A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1s729-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 17:14:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b4678c6171so60508605ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 10:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778606064; x=1779210864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=;
        b=Nd5Dm9gpQG4RQpD0azwvWEzoeTSF1TqxMzJP2bNFXX6qkTKw+6cLcsvzMLqlZyLMOr
         AgbXK3KyBsWPPqTFbssssWfErYK38YoNCYIpxU1rWJv/RF2ZbgDNS3+nPYESzGi56c8Q
         J3C4w0KJSH3twiFnkyFuSRwQPA4lEEs3eRzWcRseUZfcIqYmHrnPit1E3iYeISkvNbp7
         hoNzs6QiiFw1eLsbhBOMWrgpITVI5xRAwBcnZboYPZ7zG1sVSWzEMlk4dK24iAsGfYs2
         3/UvM0/UME4lX1OOUkYl++V5G05GiRchiBEKhtWnXVdH5f+oP4IxL775eKzsiGieloOp
         YL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606064; x=1779210864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VrjvN4YoXoq6Qx8iD0D8HvuSXAGY4OIP3vppn+Pqo/g=;
        b=Bhi2lGCo+p6q7v75Fib+baPxAsxkFvipbLkXasBEYfh4UUmyH0zXOCGdM/NMHmjX8M
         MR1d1VwvCTSq++76up4reVfPumHr02usGAv/fbheyqdDXS0fpPr5Mszd9ehob71ULjvV
         Llmt3oxc4AtgpuQ6sRzfxoRdoErhavu2M1Y1MzLODEZ/9pRXl4qx+7ZQK/MPNEQ/EkYI
         4r/U9CII7iHkszXM0+nWHsbaDP/w2tP9erZaLN1vekyG2wPA4jOmiiJj1zAavh5F98Bh
         5R99LFgow4rVWitJ9nbT+8xtfXfJol2BsuiO452P+0GnG9FUbSXOY8mG2To0a1YSXaFR
         A12g==
X-Forwarded-Encrypted: i=1; AFNElJ/Atxo8dMEOWugxC57fMFl5iSxbLcjnhovQwsPUz3VSHhjmINq0Lrtn0pw9QhSBMM5qIWEqXScywghT49W3e6TiTvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YdKfeCmiDrb8/6DuWONjqXq2kFXUhsMdsidz9xvQIku1NP59
	Ay5TyyTRljFTuai9ST0kuwcB8IO06EMBQKcWEaSF+Zt+h2zwDIOEr+GGlYYkQe6VRCpYUW5jTHE
	5r8WYIxCutDv4lf/azXWNomyAjL226NwJ876/VQfmUdNjcsDnlWHiem+yvsAqyZX1/EQVXClKig
	c=
X-Gm-Gg: Acq92OFH+pdqeG2Zfny7MHYxIC8ZkgfwYXJddJ6OiGI2oZI43J72LaAd8k1LMTDj7+M
	AR9h2HJeNfNj0RW+ZCgyg8WBBtOM2d0r7VZESDV/7CMJJy0to6KItNrlpY0572HSFgH2+KAqfq+
	NYazi4k8l/5KUpgMSNVU9HCr97IeF3HQgXhcZk8GX1bGjtfRQ8fD+bze9nH/2eOeCmH8hR6P0Fn
	/t7FhLwPhiH40WYWY9j8H7Ojf0tXuVLiovt/9n29R/Zneq+iyntJQUSXkbelzFse9XW7UCVfvtK
	W0YjgYkNZKpCkBPCW1QRD+OoHdVdYcepyTLkygn/rnF51lBW0YOexdU2FYNPBscGvgjT5Un0NoX
	iXI2cVtA5iX/5tpW/yZwivNE8XsEFAKSxoElhP4+7eTc6vl+U8TzFK8k=
X-Received: by 2002:a17:903:3bc7:b0:2b2:d09c:c07c with SMTP id d9443c01a7336-2bc7ac7305emr157039215ad.36.1778606063484;
        Tue, 12 May 2026 10:14:23 -0700 (PDT)
X-Received: by 2002:a17:903:3bc7:b0:2b2:d09c:c07c with SMTP id d9443c01a7336-2bc7ac7305emr157038725ad.36.1778606062723;
        Tue, 12 May 2026 10:14:22 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40427sm149996685ad.24.2026.05.12.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:14:22 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 12 May 2026 22:44:04 +0530
Subject: [PATCH v2 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-tracepoints-for-qcom-geni-serial-v2-2-a5726421b3af@oss.qualcomm.com>
References: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778606047; l=5509;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=cN4714YKFgE3Cy3MMrWdct7feqTVFb9iQz2fsCrzvwo=;
 b=edNqEIQASRPfmCjJJ76xPFTodkyNIPwMyvZj8qPhFLmYKe3Df+d09/fEWq5af5duIUgvcmKmj
 DTwBZbqVdLTB36fsAa5Bz122lyRjz3k8e06oqcO/sMRYsj0vcLrG4iC
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: vMpd_Q24Bbwg4_aRA6CktJ9vquUJ1VkG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3OSBTYWx0ZWRfX6IWFiFzKqTZD
 i3TIPNwAPm1mBY2+DuQQ9Nl3nM9PIB+oNflV9wKmg3iWS86Euy9xHttW3CxCCbOowr0aIpHhyte
 wsvCQDPzMIlA7rPzeKauq8ifZEQIfwfWn4zRFzsavVcI7irhDTKFn4nK8wXtjW0VWBy0cdPm6BJ
 T2eoXVrJlpZZNA/LjSPk42bx9VZITpGUiAeqJTtkGy/1X7+6SAVJHvXs6je/dhHTh0dbXAIKDdb
 OlUO7aWet0xskCFDoZlS7eESbsk1H3eZI7J+zcljj20mB4NRTdC0cMes18S3mkz3Q+/merzI4xC
 f0kWlkxIcdOd1bLlHEjz7cVrB70XMR977X98KlD4KeC/UAQcH6k+5c3TGsJKn1ak7LZv5G3swJq
 PElOTn1FT4HIiVO9nzoeroL2ClKS+/F48RcEamgsGHXMwLCs7ac9rG3cl0UrlvJJ5r6v8vWHbrN
 151cAgL4qQl8489xQIQ==
X-Proofpoint-ORIG-GUID: vMpd_Q24Bbwg4_aRA6CktJ9vquUJ1VkG
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a035ff0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=9bDMwBodl1-tA_8t4OkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120179

Add tracing to the Qualcomm GENI serial driver to improve runtime
observability.

Trace hooks are added at key points including termios and clock
configuration, manual control get/set, interrupt handling, and data
TX/RX paths.

Usage examples:

Enable all serial traces:
  echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_serial/enable
  cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:

2517.938432: geni_serial_clk_cfg: a94000.serial: desired_rate=1843200
     clk_rate=7372800 clk_div=4 clk_idx=0
2517.938753: geni_serial_irq: a94000.serial: m_irq=0x88800000
     s_irq=0x08000111 dma_tx=0x00000000 dma_rx=0x00000000
2517.938803: geni_serial_set_termios: a94000.serial: baud=115200 bpc=8
     tx_trans=0x00000002 tx_par=0x00000000 rx_trans=0x00000000
rx_par=0x00000000 stop=0
2517.938807: geni_serial_set_mctrl: a94000.serial: mctrl=0x8006
     uart_manual_rfr=0x00000000
2517.938818: geni_serial_get_mctrl: a94000.serial: mctrl=0x0160
     geni_ios=0x00000001
2517.939165: geni_serial_irq: a94000.serial: m_irq=0x00400000
     s_irq=0x00000000 dma_tx=0x00000000 dma_rx=0x00000000
2517.939592: geni_serial_tx_data: a94000.serial: tx_len=8 data=61 62 63
     64 65 66 67 68
2517.940610: geni_serial_irq: a94000.serial: m_irq=0x00000001
     s_irq=0x00000000 dma_tx=0x00000003 dma_rx=0x00000000
2517.942174: geni_serial_irq: a94000.serial: m_irq=0x08000000
     s_irq=0x08000100 dma_tx=0x00000000 dma_rx=0x00000003
2517.942323: geni_serial_rx_data: a94000.serial: rx_len=8 data=61 62 63
     64 65 66 67 68
2517.942680: geni_serial_set_mctrl: a94000.serial: mctrl=0x8000
     uart_manual_rfr=0x80000002

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e6b0a55f0cfb..9e2de074d799 100644
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
@@ -225,7 +228,7 @@ static void qcom_geni_serial_config_port(struct uart_port *uport, int cfg_flags)
 static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 {
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
-	u32 geni_ios;
+	u32 geni_ios = 0;
 
 	if (uart_console(uport)) {
 		mctrl |= TIOCM_CTS;
@@ -235,6 +238,8 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 			mctrl |= TIOCM_CTS;
 	}
 
+	trace_geni_serial_get_mctrl(uport->dev, mctrl, geni_ios);
+
 	return mctrl;
 }
 
@@ -253,6 +258,8 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 	if (!(mctrl & TIOCM_RTS) && !uport->suspended)
 		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
 	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
+
+	trace_geni_serial_set_mctrl(uport->dev, mctrl, uart_manual_rfr);
 }
 
 static const char *qcom_geni_serial_get_type(struct uart_port *uport)
@@ -683,6 +690,8 @@ static void qcom_geni_serial_start_tx_dma(struct uart_port *uport)
 	xmit_size = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail,
 			UART_XMIT_SIZE);
 
+	trace_geni_serial_tx_data(uport->dev, tail, xmit_size);
+
 	qcom_geni_set_rs485_mode(uport, SER_RS485_RTS_ON_SEND);
 
 	qcom_geni_serial_setup_tx(uport, xmit_size);
@@ -909,8 +918,10 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 		return;
 	}
 
-	if (!drop)
+	if (!drop) {
+		trace_geni_serial_rx_data(uport->dev, port->rx_buf, rx_in);
 		handle_rx_uart(uport, rx_in);
+	}
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
 				  DMA_RX_BUF_SIZE,
@@ -1069,6 +1080,10 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
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
@@ -1281,8 +1296,8 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 		return -EINVAL;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n, clk_idx = %u\n",
-		baud * sampling_rate, clk_rate, clk_div, clk_idx);
+	trace_geni_serial_clk_cfg(uport->dev, baud * sampling_rate, clk_rate,
+				  clk_div, clk_idx);
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
@@ -1432,6 +1447,10 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
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

