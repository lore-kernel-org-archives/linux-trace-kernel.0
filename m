Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50143B6CE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703562; cv=none; b=Tn7tvNbmTwFovqLfVgyZ4qc5/dYzah732/yh70jJHBs5y4JMw1s0WVOJ1cFoTojgZLBCe+2g/a3oYGWu5wDzEQ0xTZT63Si6n+kxNmU4Bwp/0xJv+1CjRJeWRgNKwLkVzXE+8ge+QRNUFXabajZO9yk+uNFdo4Ix4/jms/Fp2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703562; c=relaxed/simple;
	bh=CKcPA57E+Oa92HCiw+SaghIFdh+X1G6PfizEiFISbQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uq56K1oruIMkd03d/PYjIR22HRc0PZYMw4tyCF/OBdEtqqT/5IKfBnIjjWaSCdjvzn/YR1whimeGGJLpoqoB7fVeKTnDdqzd7AqKSNbjdCpGWvtv1B+alSUMv8Ok9vvOyD4+G5cYtgdlcF1LHh/49VXouaP6ry4Uzlz5I1tE+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g3cIHxj8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fU4Br62J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g3cIHxj8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fU4Br62J"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH4Hdg1234471
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P9kkponGRrhkevTw3sXseMJA8Q766uzDiDCjmMShwDg=; b=g3cIHxj8Mvf0O6CT
	7Q/0YNUmQ2zZkCtagBPDl1wkZYlFc/O7khF1Gsau54YO1tt6xUK8S8g5YSwdFL0G
	now1t9vSg+YGCI7CpwnwqoBzgKbVxsSe0QiirOheAf30NFUPDEZsUTMD/HK9zzqT
	59oqGfrD+D0pGTC7GNos2IJ8q6E+cDEdr0WUrOaqE45qoXezoC6nCb1LEWLkElam
	mz7aB/Dcgm4Oj+ugGXpM6in4FJqFN9XGfUualHGjTmDbWue7e2iqVuLxZEHQPeDi
	CO73fmLc41BWtBfB4kAixBkLOrDWrOAyp8W3KZ5tR0Y+/0Q8PCw0c+u6vVAXM7NM
	7Hg6Qw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm81tq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cceabd70f5so26080365ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783703560; x=1784308360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9kkponGRrhkevTw3sXseMJA8Q766uzDiDCjmMShwDg=;
        b=fU4Br62JJ6etDDV4riKIc2a4EWwIRFCmF5RIkVv7HaLrPigVlL9EdvGe2PyTCRAZR7
         DK/QsEv4G7jU+Q14tQpumaQf2c7+Z8+0+YXIoUUmugbGukZqBzXBQozHzu+I7AnsDswJ
         PGDwRHSlRAT+UXhXjTCEfhRjtryFAlbVhPL6WRRUKetG1UjvsXA8WCCKkA9mzqFeXJcG
         4sl23y57jt1dy7psoiaHab7OvTTLLYdKHjyi9qWSPo9TJ7kek/volR3UtCMKgkfILASH
         U37pvOIPPHl07RTeV4nf/TPwVv2Uvg/GY2NWreoA5XT1wxSjH8gRd5zWBnIBYbfYieRy
         3yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783703560; x=1784308360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9kkponGRrhkevTw3sXseMJA8Q766uzDiDCjmMShwDg=;
        b=s6UcbM0TAEk2Oq5FM0sePsYX9RG/5JbJo+/m8ZaoSkkO3tbn7RJ+Kv2kBm1ERZZTaC
         LlC1EDibzV5tchnoebbEQk14K9eBLbR3Q6Cz7Z1+a4rPrW6FW0a3YxWy0p0KSRCOzDqA
         omcDEsphBUQtOkkud3OUOPaaMc83+PG7NurlINoXqygQSChYP0iC5LOEDMqTymFHhZc0
         DAAa/UA9WF8f3En6Tjt+cXHTzuUZdmqwq6vhamvto8TFBN2kmZs2P43n4bXlYpCle/+R
         gSztk1Rq1X6DtvJth/Y+uvCW41yz4gt+1fC/znmhbfvx2UZTB8UDS0H0VvMvG3yNbu+/
         0yvg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9ph1YcdX02wOiDh2K3IOIj2IbAI4qeC8Dh1zvywLc0AnccyN2xmEBxb4JGSl4LDHAlTOYlsz4V+2Q7Ix/mdOqsCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBB7iUKT1G4+NyuA4B+7JE/xG7tVZ3vCUhmIkruGtyNmFa0oH
	+EZAq7WFYTkB4+FBPmhbfdtk/wFZlOixv1h9SFQV5YBYgq6K78quQxTmVvZKM0cf5P2pzisApxJ
	gKSETdbwuxmI1SU11JOyk4FKdEg+SX6n9wsD2EpEA//bAa7JX7YcOeuYF333Cr3dDKiB95I7aDi
	rTq7EpD6I=
X-Gm-Gg: AfdE7cn8pXtG8DdYTnLc6GgJIyoZnYSnSCzBCCN9xJ53icQiwL8Q5/140szxiavgTdH
	AnRo8RBl00+/Rx3iRFukiL1X/RgMMxcRTp9SP3qUYuOVr+7RVd0/NuQNdYx12xbei2qYMObqJc5
	CuWTewqj3QSIw/HOImZy1OU3zHy6I9Zu2l3s8knGz1WPOil/FGQYyqC+xrYqcBGQnsySYaqZZ9C
	YgrvBy9lMAABONEHzidJdOy2PEf3q/9bWT2LASPopFhSsLINFasWX1K6k9TDT1yuQLnmhC7hdpM
	qJuW1fVionPjCVhx9q1YgFgbnru9Ux0ZwCOwTYWWZHMOCXz7ddG5SdudzSUhyOvYWdix+qj4iHk
	BsxyimD1CB6/684pDlxflkqw6cNgeZd2ILAHUrwGRpFlj
X-Received: by 2002:a05:6a20:7289:b0:3c0:9c1b:d0b2 with SMTP id adf61e73a8af0-3c0bd2953a9mr15495159637.61.1783703559844;
        Fri, 10 Jul 2026 10:12:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:7289:b0:3c0:9c1b:d0b2 with SMTP id adf61e73a8af0-3c0bd2953a9mr15495124637.61.1783703559349;
        Fri, 10 Jul 2026 10:12:39 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm46636277c88.12.2026.07.10.10.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:12:39 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 22:42:13 +0530
Subject: [PATCH v6 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-add-tracepoints-for-qcom-geni-serial-v6-2-2bb6b6836dfd@oss.qualcomm.com>
References: <20260710-add-tracepoints-for-qcom-geni-serial-v6-0-2bb6b6836dfd@oss.qualcomm.com>
In-Reply-To: <20260710-add-tracepoints-for-qcom-geni-serial-v6-0-2bb6b6836dfd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783703544; l=4300;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=CKcPA57E+Oa92HCiw+SaghIFdh+X1G6PfizEiFISbQ4=;
 b=1t6BRX+ncPwj/eM99WkVtM7CmN8G92EiLwYoon4VdQqjaw3BKziVTmfWb4SrhqTVUfGjEK6gd
 d1UsJrFaSM4CMqQDz4VIze2LKI3BAYVR32li96VCmvetweUJ3s0U5ZM
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: mTSA5r0ksIeDqeAUitfVMpv3x5yi_vjt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE3MSBTYWx0ZWRfX4u737VmZCyVM
 wKGAPFeHmkmHtjBnkvJ4EoaXE2nhApOzoX+CtKZFyOFxD7ZcsnapcE/pmSzP+BkIZEHrGCwEGFe
 XE2QhIZToSqymTSM6l9kzqhIRpoAKz4yK5CfMu0w71NBmLlSK7NniBbssVWF/ZSHK7Le0rv70Ed
 umeXq93/ug+H9Sm/ol09Pg4hJBA7AoRZKXn9weCWPmLmfndGVmzebKJbOpCfK763eIvXzwh2Ssm
 iOUS62ZAk4EF6zE1RWzhHwP96eCicgS3g4R4rgjE3TYXV3RcwVwSgP+az5wZYPjLrbbr/NQckzT
 tQjHaryya7tdR5uBTDAqN2pCwQNoUN+BI5fua9zMgRq8GqEPZbb7YRvWUKS8YS20d3VCz8vpmJX
 XzMctjWqISRUMvk09zqTXwdvfQsiLrhyCXIKhvnBkBCFreuEKUF+vkwwnCbAzzn3sbrcrM6i65a
 MbAmmUPt1S/uIcr2Y/Q==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a512808 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KXSloCXmEunfo-Xy6rIA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: mTSA5r0ksIeDqeAUitfVMpv3x5yi_vjt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE3MSBTYWx0ZWRfX815301hXqhJd
 dbPsmSg44lJVgE/sQ+/6T5hjwTQu5ZLVmpyPi0Jw1Fgm9bEeS50FNzTKXwl8uf48m5Mw7gnfog7
 pOxWjkwSW8/WFUjMzyZg0GhapJZxlvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100171

Add tracing to the Qualcomm GENI serial driver to improve runtime
observability.

Trace hooks are added at key points including termios and clock
configuration, manual control get/set, interrupt handling, and data
TX/RX paths.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..23024fef95bb 100644
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
@@ -907,8 +916,10 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
 	if (!rx_in)
 		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n");
-	else if (!drop)
+	else if (!drop) {
+		trace_geni_serial_rx_data(uport->dev, port->rx_buf, rx_in);
 		handle_rx_uart(uport, rx_in);
+	}
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
 				  DMA_RX_BUF_SIZE,
@@ -1079,6 +1090,10 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
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
@@ -1291,8 +1306,8 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 		return -EINVAL;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u, clk_idx = %u\n",
-		baud * sampling_rate, clk_rate, clk_div, clk_idx);
+	trace_geni_serial_clk_cfg(uport->dev, baud * sampling_rate, clk_rate,
+				  clk_div, clk_idx);
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
@@ -1452,6 +1467,10 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
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

