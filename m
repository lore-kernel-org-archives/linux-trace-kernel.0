Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971603F44FC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533037; cv=none; b=rXI5+4gR+8rqfAnkR/sPvVynAdIyfLamht5gr+qc+UPo64LMzpfU7uhZKHG5Vq8BaNPPXKQ08XviWBEXKEhryHAlX+HMgXQVjDWSatXHTnV29QwJUobxINBT52rNl7SZB0tyGnwpAvMDGKoerYXkWMEcBvEvO9Dd4Knx10ocsDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533037; c=relaxed/simple;
	bh=UK0w8cVX6HonoLLMdXc+3FVa/9hg3gdhTjqWi4T6mns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D204fNuJpr4RJhyyYAtPqvAxmulTMiiSSU2CHvcEpijUR8Z8vQd/j22c+utezDVxaBSE4OKYTMPOX8A+LIYuuomnk2XnengYix50tap9zruoV0mg26QMDiwfH/0o+ivv8dDWqxa70W1GJL7sW2mcGSuzIJtb0cMLPMm8sq709Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJmt6HOi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A4vAyvgW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJmt6HOi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A4vAyvgW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZBWP2712649
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=; b=UJmt6HOi/rwRra3t
	l8sp3S4SBw4CBG7/oogEe0jOCglWUD9Wyay1ePvVTVrC4m4S9C+3QPQEiYk2C1Bh
	7acHVV2/bed6PEr7p4DsTv6sRHj1olZCdd585/6Rzui7TLXj6wkNp7iA7LMCZUMK
	QXbstIGi+U+8thXf68JzSaxUlBl50rYxap72vUxwabEsFnXzbZCjAYXrTNxBl1U5
	+jxFsBVC31EE/fEdEjxjw/jASWeEBv6a77EnNE+P5qLJmnC4bbcXeeSYCCpuM4ov
	0858wR1WVJs+iQbelDa8WSvl/6Xwshud2VfoOvDL8uRMev+REPj/Ac2kE+S1Mowe
	DYPHvQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete9818na-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so3822683a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 07:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781533035; x=1782137835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=;
        b=A4vAyvgW8d4tSA1qG9WHBJKH2rDZtVdyRVCJV0ZTbCM725BxdSaCpuGPqsbhbLJM9c
         gyO7/oBgc0mSKyGNlUmspys6DPw2dA0b/h0L/yLuzwczaeNtYBAwgcWmipDeoTjHH6t6
         eSZ6z8TDJ6E/0jEOWOMx3omQEGVVQlc3p7Rv4qNfGvsm1vJZWV691EdyvuC5nBgNVOf9
         coV28PYhqNko0J4ujE0G+EiOiAiD6yPpzoHyvcM9FXeZGqvqOr/A2HzQDVAioI1vaX/P
         AS+YUGziPWSkAUJoqMxGDDw+Sk1c9x6Xti4OtW+NKksDj4HMYt1fHdkPIsa4PPT34rjI
         VAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533035; x=1782137835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xxStlaNB4x9Mu659Ds+9UQmpLOGQ5xsUav0PKNZl0Yw=;
        b=iucDlTNHECY0i2bYUxD49zq+YwjJzgBCYWbj4zjZi7PpEsVuNpbFQKIAVPxZRY205C
         caN9sOvhuoCCxOs92gghwuf3tgDbL8SgUFzEzgU3OXKukdhKqWQkWUUaYlLqaoT5Vcvf
         DKzoYCKxQu9lxryHRe+rBeW+92DPgCRRuvmj43hHgNIccYGF74pCA2oYGWonhwFX8reS
         R0n1T4QBWZoq8zKpSX1uCojYPRspahSsJMiuUKgzj8sDBpzdiifPPgTAzTxCsYZ5JIBr
         vIAXfg3cC9hdRf0iEXA4RXu2HvQ0DkNFL2Bjom52bfwAFraGHxTjsslJldhKUefsWzMK
         CBXw==
X-Forwarded-Encrypted: i=1; AFNElJ9oJzgQl2mnLb5hlAzZ+T/yKpSybX/QHXtxANesuM+IPvGcJDl3MK2uJ0z3XM2xTBDqFHenG4cM5qJ3L/3dKKJ1N24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqNEVCYCjbif5p4NET/QktpUITZp2E64zJ2/Bg9yLs8gd6bKj
	HRd0xC+50VepKPlm8xbjDjJJrICzva2P8rChggeqOjybZxj90hFzAz2uG+Mc6p37eVRz9q8zJbQ
	30CqyWNhX2q9Q7v1lEscSezIxE5Qm5VgG+3CKw/bxRWs02D+uf7/mJlbLa2Hy/ibPbRmyrCD4Ri
	Q=
X-Gm-Gg: Acq92OEzpp2/OLO/aHINTRvCyFLRRJKtxh+TbH7xEcI7UQQqcBVIS9j/6V2ldyH0eqQ
	RYIESYUaRoKwzEGWu0tpniXiDSovU87VHqafyBc0OH1GWvVnMsWA2JfSqXRpe9CgDaa1cluHg9u
	onW0CKQUWiQEtHSrQYBeCDZUfZfeEm8X7wwaxKmrS1y5sD7lMx4Lr30VxVi/+Qd7rU5rGle44Tz
	xnv3wCL5gLWsZK2CsCn/1AH+4VlBwABtKytei8s2AkZI3Raa2N1R6qG/wsnj6b2StyM9O4FVIpZ
	o2DRhtHXdmxr5Njmqv7XmMGc1T1twvpnQt2gi7ArtK5qbQX/RB51iQ77WagHm9LuL9QY/UAMVhe
	2xEP4+0Nicsi+Q3XTKr5ZVfiFHnzDDbUechkH9d5N72SrppMmf2eltAc=
X-Received: by 2002:a17:90b:514f:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-37a0184a3bemr15713038a91.4.1781533035404;
        Mon, 15 Jun 2026 07:17:15 -0700 (PDT)
X-Received: by 2002:a17:90b:514f:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-37a0184a3bemr15712968a91.4.1781533034731;
        Mon, 15 Jun 2026 07:17:14 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7172476a91.2.2026.06.15.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:17:14 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 19:46:53 +0530
Subject: [PATCH v5 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-add-tracepoints-for-qcom-geni-serial-v5-2-2efa4c97e0e2@oss.qualcomm.com>
References: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
In-Reply-To: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781533020; l=4256;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=UK0w8cVX6HonoLLMdXc+3FVa/9hg3gdhTjqWi4T6mns=;
 b=qTbvMsUOC65Bt7ZLTkLfW54/qFSjUxfHmp6BMI0qwDqiP42Ml3uTZGq2DsyEV+gNq55q3IPdH
 e6PCr/CrgyGCOLA+sYrx/D/Rywd9phNURw0u2ZI1ocRUpjEirRPcvKo
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a30096c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KXSloCXmEunfo-Xy6rIA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: D7cM48z1NUVVNZGiCOc4Ikd3lqdolyxS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfXxiE1zmmgbyKk
 7TddMf0kN8ik+Qxabi61xMGhoL7Pu/G8yX5xJ6CfpD/QJrChQgKJ53iMsuJ12zPkW/useA9qqsR
 WzQw9Ye8NBZXZixoRkn1IJgkc0j2E8A=
X-Proofpoint-ORIG-GUID: D7cM48z1NUVVNZGiCOc4Ikd3lqdolyxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfXwtKN87w7ZC3Q
 rN4utfY+cks4BDgGdi6qLjtk57iHNf1f2VI5ZLWKPJ/sEqzmwEGTkB7QNAosAdpdYaTwICBcJ4z
 NErM/IxbpxAwHaTBMw14HcVERlcJVjpbNqmzkuApzsrAjbguMSsL8vZJLfDPb2oeZ1QXuTmwIGr
 DoPGFD7OZ5yDSDwGgkdsSkoCfpci0FAOozrXW5XaCOsNdSJewdx0tYKU3aN9yIlWe0ZIVgER/LH
 4DiyiMnNRuQpTJHaGiQ5Gl8of8SLVuCCebHpHNs4VIlmlSP4nta0c3nPPftT3Ib34+rhCX4qNY5
 MQpTb+ms/n1dlt92dLK2D+D2Io7tZ/g0gpcoYUMR9STV0r0Gn6UKfC2MiY3GCkX7Wc8ZrVc1f/O
 HHa5ALJPHxT/grSE2MvRqPwDlNL9pENfuhJ++E2X4dF0ACTxVdEE+VLiPxxkhK+SWLcISX/Ma51
 +wE579f2G0S0b/TwE3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150150

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

