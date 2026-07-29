Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081433B05B6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338021; cv=none; b=B6iSaN9i7tDGh98Q6q5EIxHxPmBQPUiq0IaquqqXxtw0rvrXsy/dfF23fsuKhTyfJKEyt8xVqjis5PiiXqy6JT6fkxHTOYm6wWzxPlZ8lwb6GF6KulBvVxdzjT5pL2vcyuKWRKMT7jwJ1e6+2rL1bTmKqvOyYQsY+WgbaLPONFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338021; c=relaxed/simple;
	bh=PaGrVUU1B+dsPm8flL1YNvMAfBXfQR5897wvzefIUW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CeziRqRdVOE0EhrPzq1DbKkF6fG4TUma8i73A6JlnLx5th9GwXOh+M9ZZT72lM47BGB14v/jm5vxl7REd5WNV5feYs9n49z47niSQ20gLTE8rR4ZEz650yoDd36lk58M2+Qid/teP+01fH7K4Dm6T1fDgaisgakvByV77qBPl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jC1w3z2s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jYI2Jcrx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jC1w3z2s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYI2Jcrx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF3Lvb2195053
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WnQ5FPsv2PIzpoJYKxnBiZ/0FU27EtwloAXto/IhJrA=; b=jC1w3z2s0ZJaxqfu
	3VeS4Mvxhb8QPvJOswyQmrq0DILVE8qFDlYurCpb8bVgGbh2RF3/t/U99DOzEP5Z
	/JaSdGacfPZ139j4hjiYDVDfMfgp4mtkjcXb33jeWYxQS2IXC2T0Hw+fpya+DRxn
	FD2tLJGwv6gUcX5oliWNJ0PxiY+XMhOcKxEAiFKBEuL7J57AtcOWqAinTvq2uIzq
	IbO/2JeqN7ocTxiGghBaW1n7CpyoCRHAV1yJbKmBY4M1rE5LRWkdgboDdEFjV/pq
	oQjVjEx4+W5JNWmt92J66arb82AFx4ww1V3NgDiEgYzTaduSMuvXv1fwddB2/0tY
	f2YXSA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkfm876b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:13:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486ffba174so1820267b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785338018; x=1785942818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WnQ5FPsv2PIzpoJYKxnBiZ/0FU27EtwloAXto/IhJrA=;
        b=jYI2JcrxnmlONUOJIwc3+F9GTj0Qg6groCmUkckls6IM4+hE5yfGV8LJu11mW73dmM
         hK8krdddhw0TTTwS2jCxoTqDP/uYB723Tmu6V0wYhZSvSmyv9mNmdZ0v7NV4VGTlxFQD
         /oZ7gOncJPxum1NTZKOq4FTWzn4wkR3mGKLodiwazDLDhv/laQGXZ6exe0GZbY+Cwt7j
         R0o8Xs/W8WIQvA7KW/pC4PTxPCYLfNe7NIpYNfkpC6IwOkiG85nSiG74XhvJmB5flmtB
         x+kqTrnuNYbCUa/StQcdxJQoNfKWtp1piZ0mnLQiX7T5LO+IZ5G4Knkm1yr9lgGgOvmW
         1aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338018; x=1785942818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WnQ5FPsv2PIzpoJYKxnBiZ/0FU27EtwloAXto/IhJrA=;
        b=Fp8V8LuYGzmcnUcNA5qhQ8iXxMivfrejCgopL2kah5Fazvsi0lskjXiso5bA4IuQPO
         LKb6uR94hgdE4ARYEFUQHuX4VIAYPG72vKLw84kuGPVkGsB6CET02MlwNw1Y3XEciQgx
         sC4K9JZKkPoAY/JNfWDCtezWGc0E8ZVbs96z88bGSTTZbXVcuEvROa+TTHmT3EQdTRHG
         bJooSXUwDhR6Kha5xxmWm9WLpeInz0gsPPY9vRYmWwiJi56sth7K/FHN6g4V8CIVGKDH
         nUo5c1UaD17iW1VEEA04tiEsEO7LO7WfKrrVjM8ITuJOnL7nHzIFD6Qyig1Ntk4STLRh
         79JA==
X-Forwarded-Encrypted: i=1; AHgh+RqcWZavVQqWRKfMUZ9ESceHrKHsD8MGhqhR7pR7tbCxSpyk+0dh6brqSlHorhUeeb8QL8AS2DAUVgdbolE8ddPuTf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBe5g6sEabTOelsuJbbRs/vfYHWrsKmfKQbhjb1CfcJETdNyBJ
	uAG0Af1fQlAjwEY/FbGVjynq0yUaSZ9cwHOeSxVQFrugV7kb8HEwcK3lSN/SbcNwy+z2prptAjo
	i8306tRSGIbmJxYg2lyf3g+Fm2bDQ+fKYnw0gfjg6iUdQLjv3qTqBOaTU5Zcm26+vQz6KHxo1wq
	4=
X-Gm-Gg: AR+sD12f4TZL0MPHGjA24JDzGDOkpC6E9BY4YdYh8aW56o7C9qNDi/5mKuDCNdpesuO
	L062PAiYbxMft5jjqpbcscDGq3anIFhAWhxs+dCMohk9s+emsgxZr5vm7/BbEJFG5Ho1BcN28Ys
	ooJff2nWJv7PLYbxItiC01esJQ9nI4+MzEhCam3VAvOa5j9gww/G7v+kV92Lt9qJeAIZ6wesous
	fWsGpzrb7s7v7cIbZrjDGdR/2AWKCO80EBOhTyUTs+rJOMolrqwVtpSdThQaZo+tXdZI3JBBu2z
	+8rD5o/4aurBNRZNKjNL83fLBu5JnhtVsjivQgWU7h/EZ/cW+q4uVY8e1a2z8i9MvuwyB9rTvi1
	of07QRlrWvg3TbFgwzeORT9GujBsQ4ul61w==
X-Received: by 2002:a05:6a00:3315:b0:848:5ca1:bae0 with SMTP id d2e1a72fcca58-84e93334b86mr7873012b3a.42.1785338017413;
        Wed, 29 Jul 2026 08:13:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:3315:b0:848:5ca1:bae0 with SMTP id d2e1a72fcca58-84e93334b86mr7872962b3a.42.1785338016861;
        Wed, 29 Jul 2026 08:13:36 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e9fe238ffsm1617920b3a.12.2026.07.29.08.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:13:36 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 20:43:25 +0530
Subject: [PATCH v4 1/2] soc: qcom: geni-se: trace: Add trace event support
 for GENI SE registers dump
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-add-tracepoints-for-se-reg-dump-v4-1-08bbd63b0ed2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785338008; l=14698;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=PaGrVUU1B+dsPm8flL1YNvMAfBXfQR5897wvzefIUW8=;
 b=bzDvzCRN++wMkc5clLvEwl6UBd3PWrkYHnyur5t8Aa0FOUIpvV7zr6rVgxK9CdXZlRniQ/oaR
 afBjSD72JbwATFYTW/IZAz5CLJld1AvASo776HLOo1dR1dGcK6/YoOw
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=D6p37PRj c=1 sm=1 tr=0 ts=6a6a18a2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=meVymXHHAAAA:8 a=EUspDBNiAAAA:8 a=rDdGhCjhZGBWvw_hryAA:9
 a=kx6RazR-w7M1je--:21 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: qfJIQz-fE5iVf--ctHfaXCMOJQNy8-tX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX+bQN5q9qYWGt
 5ySjRQoKTX0iNC7WTeaVZhLg+b61DtX6OjdCI11GlSJXUhaEO5nyt8IaoFtGSGocBNQyrigrmQ6
 YuGDirDYxXaClDoeet5Ry7c2Z6iTKIo=
X-Proofpoint-ORIG-GUID: qfJIQz-fE5iVf--ctHfaXCMOJQNy8-tX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX7Q4xM1dNTtVP
 23q0KpXfsXgvhOZ21FADbV+TOYDVZDrqWj6rMYe3URRW38vLbXzTLLDaxZ85L3ywmYwghT2xQtV
 PkQ8IvW8jiBUuU2hFNEHvW8nXa2ni9lwyABQEF1g2Ok9UmJvtyaHACJ5by5ayds5g+jz5Q1Vd7J
 l1Bw8a8J8SuW+3qp1/Xf1uJTiD5YJESOgmP+H1eiKM3h8x2QF91oFlYFYHKNvP1OxK3MEyHzsja
 nTFT/ZLhqFsX1S/+X8bnx1snYhjp/l5QP0Hs8QKM8LGtF3pTUX3bVv/87tkw8HtCYIfMA/R1gId
 V2dY9OdJKqbUDMynQyMZqMvjCFvZBk6MiW7xyWe/pG2+rjJtZVGMqpTqM57RnRMWJBf8oTjoZe0
 +UvN+dqd3yoGRb2fzM7igqelTzeGuc0Z7SahN2UcKwhYo5GX8xUv0e3fjLYi5MINf1BAcylKDdU
 e3J5Tmz8atDUARAT/Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

Diagnosing GENI SE-based driver (serial, SPI, I2C) failures currently
requires reading each hardware register individually, either through
ad hoc debug code or a debugger. This is slow, requires the state to
remain stable across the multiple reads, and cannot be run
non-intrusively during normal operation without adding printk-style
noise to each driver.

Add a new trace event header for the Qualcomm GENI Serial Engine (SE)
framework providing a geni_se_regs tracepoint. This tracepoint
captures a comprehensive snapshot of the GENI SE hardware state in a
single trace record, making it possible to correlate register values at
a precise point in time without multiple sequential reads.

The trace event records the following register groups:

 - Main/secondary command and IRQ status (M_CMD0, S_CMD0, M/S_IRQ_STATUS)
 - Engine status, IOS, and command control/error registers
 - TX/RX FIFO status and watermark registers (including RFR watermark)
 - M/S GP length registers
 - DMA TX/RX IRQ, enable, length, pointer, attribute, and burst registers
 - DMA interface enable, general config, QSB trans config, and debug
 - M/S IRQ enable, GSI event enable, and top-level SE IRQ enable
 - Serial master/slave clock config, general config, output control,
   clock control RO, FIFO interface disable, and FW multilock MSA
 - Clock select register

Having all these registers captured atomically in a single ftrace record
allows drivers built on top of the GENI SE framework (serial, SPI, I2C)
to invoke this tracepoint on error paths and reconstruct the full engine
state during post-mortem analysis without instrumenting each driver
separately.

Acked-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c     |   5 ++
 include/linux/soc/qcom/geni-se.h    |  38 +++++++++
 include/trace/events/qcom_geni_se.h | 157 ++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 15636a8dc907..92b70b20abd8 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -7,6 +7,11 @@
 /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
 #define __DISABLE_TRACE_MMIO__
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_geni_se.h>
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(geni_se_regs);
+
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/clk.h>
diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index c5e6ab85df09..8c08c1917374 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -81,13 +81,16 @@ struct geni_se {
 };
 
 /* Common SE registers */
+#define GENI_GENERAL_CFG		0x10
 #define GENI_FORCE_DEFAULT_REG		0x20
 #define GENI_OUTPUT_CTRL		0x24
 #define SE_GENI_STATUS			0x40
 #define GENI_SER_M_CLK_CFG		0x48
 #define GENI_SER_S_CLK_CFG		0x4c
+#define GENI_CLK_CTRL_RO		0x60
 #define GENI_IF_DISABLE_RO		0x64
 #define GENI_FW_REVISION_RO		0x68
+#define GENI_FW_MULTILOCK_MSA_RO	0x74
 #define SE_GENI_CLK_SEL			0x7c
 #define SE_GENI_CFG_SEQ_START		0x84
 #define SE_GENI_DMA_MODE_EN		0x258
@@ -98,6 +101,8 @@ struct geni_se {
 #define SE_GENI_M_IRQ_CLEAR		0x618
 #define SE_GENI_M_IRQ_EN_SET		0x61c
 #define SE_GENI_M_IRQ_EN_CLEAR		0x620
+#define M_CMD_ERR_STATUS		0x624
+#define M_FW_ERR_STATUS			0x628
 #define SE_GENI_S_CMD0			0x630
 #define SE_GENI_S_CMD_CTRL_REG		0x634
 #define SE_GENI_S_IRQ_STATUS		0x640
@@ -115,15 +120,42 @@ struct geni_se {
 #define SE_GENI_IOS			0x908
 #define SE_GENI_M_GP_LENGTH		0x910
 #define SE_GENI_S_GP_LENGTH		0x914
+/* TX DMA registers */
+#define SE_DMA_TX_PTR_L			0xc30
+#define SE_DMA_TX_PTR_H			0xc34
+#define SE_DMA_TX_ATTR			0xc38
+#define SE_DMA_TX_LEN			0xc3c
 #define SE_DMA_TX_IRQ_STAT		0xc40
 #define SE_DMA_TX_IRQ_CLR		0xc44
+#define SE_DMA_TX_IRQ_EN		0xc48
+#define SE_DMA_TX_IRQ_EN_SET		0xc4c
+#define SE_DMA_TX_IRQ_EN_CLR		0xc50
+#define SE_DMA_TX_LEN_IN		0xc54
 #define SE_DMA_TX_FSM_RST		0xc58
+#define SE_DMA_TX_MAX_BURST		0xc5c
+/* RX DMA registers */
+#define SE_DMA_RX_PTR_L			0xd30
+#define SE_DMA_RX_PTR_H			0xd34
+#define SE_DMA_RX_ATTR			0xd38
+#define SE_DMA_RX_LEN			0xd3c
 #define SE_DMA_RX_IRQ_STAT		0xd40
 #define SE_DMA_RX_IRQ_CLR		0xd44
+#define SE_DMA_RX_IRQ_EN		0xd48
+#define SE_DMA_RX_IRQ_EN_SET		0xd4c
+#define SE_DMA_RX_IRQ_EN_CLR		0xd50
 #define SE_DMA_RX_LEN_IN		0xd54
 #define SE_DMA_RX_FSM_RST		0xd58
+#define SE_DMA_RX_MAX_BURST		0xd5c
+/* DMA general / debug registers */
+#define SE_GSI_EVENT_EN			0xe18
+#define SE_IRQ_EN			0xe1c
+#define DMA_IF_EN_RO			0xe20
 #define SE_HW_PARAM_0			0xe24
 #define SE_HW_PARAM_1			0xe28
+#define DMA_GENERAL_CFG			0xe30
+#define SE_DMA_QSB_TRANS_CFG		0xe38
+#define SE_DMA_DEBUG_REG0		0xe40
+#define SE_DMA_IF_EN			0x2004
 
 /* GENI_FORCE_DEFAULT_REG fields */
 #define FORCE_DEFAULT	BIT(0)
@@ -269,6 +301,12 @@ struct geni_se {
 #define RX_GENI_GP_IRQ_EXT		GENMASK(13, 12)
 #define RX_GENI_CANCEL_IRQ		BIT(14)
 
+/* SE_DMA_DEBUG_REG0 fields */
+#define DMA_TX_ACTIVE			BIT(0)
+#define DMA_RX_ACTIVE			BIT(1)
+#define DMA_TX_STATE			GENMASK(7, 4)
+#define DMA_RX_STATE			GENMASK(11, 8)
+
 /* SE_HW_PARAM_0 fields */
 #define TX_FIFO_WIDTH_MSK		GENMASK(29, 24)
 #define TX_FIFO_WIDTH_SHFT		24
diff --git a/include/trace/events/qcom_geni_se.h b/include/trace/events/qcom_geni_se.h
new file mode 100644
index 000000000000..4a6e1ba2d147
--- /dev/null
+++ b/include/trace/events/qcom_geni_se.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_geni_se
+
+#if !defined(_TRACE_QCOM_GENI_SE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GENI_SE_H
+
+#include <linux/io.h>
+#include <linux/tracepoint.h>
+#include <linux/soc/qcom/geni-se.h>
+
+TRACE_EVENT(geni_se_regs,
+	    TP_PROTO(struct geni_se *se),
+
+	    TP_ARGS(se),
+
+	    TP_STRUCT__entry(__string(geni_se_name,		dev_name(se->dev))
+		__field(u32,	geni_se_m_cmd0)
+		__field(u32,	geni_se_m_irq_status)
+		__field(u32,	geni_se_s_cmd0)
+		__field(u32,	geni_se_s_irq_status)
+		__field(u32,	geni_se_status)
+		__field(u32,	geni_se_ios)
+		__field(u32,	geni_se_m_cmd_ctrl)
+		__field(u32,	geni_se_m_cmd_err)
+		__field(u32,	geni_se_m_fw_err)
+		__field(u32,	geni_se_tx_fifo_status)
+		__field(u32,	geni_se_rx_fifo_status)
+		__field(u32,	geni_se_tx_watermark)
+		__field(u32,	geni_se_rx_watermark)
+		__field(u32,	geni_se_rx_watermark_rfr)
+		__field(u32,	geni_se_m_gp_length)
+		__field(u32,	geni_se_s_gp_length)
+		__field(u32,	geni_se_dma_tx_irq)
+		__field(u32,	geni_se_dma_rx_irq)
+		__field(u32,	geni_se_dma_tx_irq_en)
+		__field(u32,	geni_se_dma_rx_irq_en)
+		__field(u32,	geni_se_dma_rx_len)
+		__field(u32,	geni_se_dma_rx_len_in)
+		__field(u32,	geni_se_dma_tx_len)
+		__field(u32,	geni_se_dma_tx_len_in)
+		__field(u32,	geni_se_dma_tx_ptr_l)
+		__field(u32,	geni_se_dma_tx_ptr_h)
+		__field(u32,	geni_se_dma_rx_ptr_l)
+		__field(u32,	geni_se_dma_rx_ptr_h)
+		__field(u32,	geni_se_dma_tx_attr)
+		__field(u32,	geni_se_dma_tx_max_burst)
+		__field(u32,	geni_se_dma_rx_attr)
+		__field(u32,	geni_se_dma_rx_max_burst)
+		__field(u32,	geni_se_dma_if_en)
+		__field(u32,	geni_se_dma_if_en_ro)
+		__field(u32,	geni_se_dma_general_cfg)
+		__field(u32,	geni_se_dma_qsb_trans_cfg)
+		__field(u32,	geni_se_dma_dbg)
+		__field(u32,	geni_se_m_irq_en)
+		__field(u32,	geni_se_s_irq_en)
+		__field(u32,	geni_se_gsi_event_en)
+		__field(u32,	geni_se_irq_en)
+		__field(u32,	geni_se_ser_m_clk_cfg)
+		__field(u32,	geni_se_ser_s_clk_cfg)
+		__field(u32,	geni_se_general_cfg)
+		__field(u32,	geni_se_output_ctrl)
+		__field(u32,	geni_se_clk_ctrl_ro)
+		__field(u32,	geni_se_fifo_if_disable)
+		__field(u32,	geni_se_fw_multilock_msa)
+		__field(u32,	geni_se_clk_sel)
+	    ),
+
+	    TP_fast_assign(__assign_str(geni_se_name);
+		__entry->geni_se_m_cmd0		  = readl(se->base + SE_GENI_M_CMD0);
+		__entry->geni_se_m_irq_status	  = readl(se->base + SE_GENI_M_IRQ_STATUS);
+		__entry->geni_se_s_cmd0		  = readl(se->base + SE_GENI_S_CMD0);
+		__entry->geni_se_s_irq_status	  = readl(se->base + SE_GENI_S_IRQ_STATUS);
+		__entry->geni_se_status		  = readl(se->base + SE_GENI_STATUS);
+		__entry->geni_se_ios		  = readl(se->base + SE_GENI_IOS);
+		__entry->geni_se_m_cmd_ctrl	  = readl(se->base + SE_GENI_M_CMD_CTRL_REG);
+		__entry->geni_se_m_cmd_err	  = readl(se->base + M_CMD_ERR_STATUS);
+		__entry->geni_se_m_fw_err	  = readl(se->base + M_FW_ERR_STATUS);
+		__entry->geni_se_tx_fifo_status	  = readl(se->base + SE_GENI_TX_FIFO_STATUS);
+		__entry->geni_se_rx_fifo_status	  = readl(se->base + SE_GENI_RX_FIFO_STATUS);
+		__entry->geni_se_tx_watermark	  = readl(se->base + SE_GENI_TX_WATERMARK_REG);
+		__entry->geni_se_rx_watermark	  = readl(se->base + SE_GENI_RX_WATERMARK_REG);
+		__entry->geni_se_rx_watermark_rfr = readl(se->base + SE_GENI_RX_RFR_WATERMARK_REG);
+		__entry->geni_se_m_gp_length	  = readl(se->base + SE_GENI_M_GP_LENGTH);
+		__entry->geni_se_s_gp_length	  = readl(se->base + SE_GENI_S_GP_LENGTH);
+		__entry->geni_se_dma_tx_irq	  = readl(se->base + SE_DMA_TX_IRQ_STAT);
+		__entry->geni_se_dma_rx_irq	  = readl(se->base + SE_DMA_RX_IRQ_STAT);
+		__entry->geni_se_dma_tx_irq_en	  = readl(se->base + SE_DMA_TX_IRQ_EN);
+		__entry->geni_se_dma_rx_irq_en	  = readl(se->base + SE_DMA_RX_IRQ_EN);
+		__entry->geni_se_dma_rx_len	  = readl(se->base + SE_DMA_RX_LEN);
+		__entry->geni_se_dma_rx_len_in	  = readl(se->base + SE_DMA_RX_LEN_IN);
+		__entry->geni_se_dma_tx_len	  = readl(se->base + SE_DMA_TX_LEN);
+		__entry->geni_se_dma_tx_len_in	  = readl(se->base + SE_DMA_TX_LEN_IN);
+		__entry->geni_se_dma_tx_ptr_l	  = readl(se->base + SE_DMA_TX_PTR_L);
+		__entry->geni_se_dma_tx_ptr_h	  = readl(se->base + SE_DMA_TX_PTR_H);
+		__entry->geni_se_dma_rx_ptr_l	  = readl(se->base + SE_DMA_RX_PTR_L);
+		__entry->geni_se_dma_rx_ptr_h	  = readl(se->base + SE_DMA_RX_PTR_H);
+		__entry->geni_se_dma_tx_attr	  = readl(se->base + SE_DMA_TX_ATTR);
+		__entry->geni_se_dma_tx_max_burst = readl(se->base + SE_DMA_TX_MAX_BURST);
+		__entry->geni_se_dma_rx_attr	  = readl(se->base + SE_DMA_RX_ATTR);
+		__entry->geni_se_dma_rx_max_burst = readl(se->base + SE_DMA_RX_MAX_BURST);
+		__entry->geni_se_dma_if_en	  = readl(se->base + SE_DMA_IF_EN);
+		__entry->geni_se_dma_if_en_ro	  = readl(se->base + DMA_IF_EN_RO);
+		__entry->geni_se_dma_general_cfg  = readl(se->base + DMA_GENERAL_CFG);
+		__entry->geni_se_dma_qsb_trans_cfg = readl(se->base + SE_DMA_QSB_TRANS_CFG);
+		__entry->geni_se_dma_dbg	  = readl(se->base + SE_DMA_DEBUG_REG0);
+		__entry->geni_se_m_irq_en	  = readl(se->base + SE_GENI_M_IRQ_EN);
+		__entry->geni_se_s_irq_en	  = readl(se->base + SE_GENI_S_IRQ_EN);
+		__entry->geni_se_gsi_event_en	  = readl(se->base + SE_GSI_EVENT_EN);
+		__entry->geni_se_irq_en		  = readl(se->base + SE_IRQ_EN);
+		__entry->geni_se_ser_m_clk_cfg	  = readl(se->base + GENI_SER_M_CLK_CFG);
+		__entry->geni_se_ser_s_clk_cfg	  = readl(se->base + GENI_SER_S_CLK_CFG);
+		__entry->geni_se_general_cfg	  = readl(se->base + GENI_GENERAL_CFG);
+		__entry->geni_se_output_ctrl	  = readl(se->base + GENI_OUTPUT_CTRL);
+		__entry->geni_se_clk_ctrl_ro	  = readl(se->base + GENI_CLK_CTRL_RO);
+		__entry->geni_se_fifo_if_disable  = readl(se->base + GENI_IF_DISABLE_RO);
+		__entry->geni_se_fw_multilock_msa = readl(se->base + GENI_FW_MULTILOCK_MSA_RO);
+		__entry->geni_se_clk_sel	  = readl(se->base + SE_GENI_CLK_SEL);
+	    ),
+
+	    TP_printk("%s: m_cmd0=0x%08x m_irq_status=0x%08x s_cmd0=0x%08x s_irq_status=0x%08x geni_status=0x%08x geni_ios=0x%08x m_cmd_ctrl=0x%08x m_cmd_err=0x%08x m_fw_err=0x%08x tx_fifo_sts=0x%08x rx_fifo_sts=0x%08x tx_watermark=0x%08x rx_watermark=0x%08x rx_watermark_rfr=0x%08x m_gp_length=0x%08x s_gp_length=0x%08x dma_tx_irq=0x%08x dma_rx_irq=0x%08x dma_tx_irq_en=0x%08x dma_rx_irq_en=0x%08x dma_rx_len=0x%08x dma_rx_len_in=0x%08x dma_tx_len=0x%08x dma_tx_len_in=0x%08x dma_tx_ptr_l=0x%08x dma_tx_ptr_h=0x%08x dma_rx_ptr_l=0x%08x dma_rx_ptr_h=0x%08x dma_tx_attr=0x%08x dma_tx_max_burst=0x%08x dma_rx_attr=0x%08x dma_rx_max_burst=0x%08x dma_if_en=0x%08x dma_if_en_ro=0x%08x dma_general_cfg=0x%08x dma_qsb_trans_cfg=0x%08x dma_dbg=0x%08x m_irq_en=0x%08x s_irq_en=0x%08x gsi_event_en=0x%08x se_irq_en=0x%08x ser_m_clk_cfg=0x%08x ser_s_clk_cfg=0x%08x general_cfg=0x%08x output_ctrl=0x%08x clk_ctrl_ro=0x%08x fifo_if_dis=0x%08x fw_multilock_msa=0x%08x clk_sel=0x%08x",
+		      __get_str(geni_se_name),
+		      __entry->geni_se_m_cmd0, __entry->geni_se_m_irq_status,
+		      __entry->geni_se_s_cmd0, __entry->geni_se_s_irq_status,
+		      __entry->geni_se_status, __entry->geni_se_ios,
+		      __entry->geni_se_m_cmd_ctrl,
+		      __entry->geni_se_m_cmd_err, __entry->geni_se_m_fw_err,
+		      __entry->geni_se_tx_fifo_status, __entry->geni_se_rx_fifo_status,
+		      __entry->geni_se_tx_watermark, __entry->geni_se_rx_watermark,
+		      __entry->geni_se_rx_watermark_rfr,
+		      __entry->geni_se_m_gp_length, __entry->geni_se_s_gp_length,
+		      __entry->geni_se_dma_tx_irq, __entry->geni_se_dma_rx_irq,
+		      __entry->geni_se_dma_tx_irq_en, __entry->geni_se_dma_rx_irq_en,
+		      __entry->geni_se_dma_rx_len, __entry->geni_se_dma_rx_len_in,
+		      __entry->geni_se_dma_tx_len, __entry->geni_se_dma_tx_len_in,
+		      __entry->geni_se_dma_tx_ptr_l, __entry->geni_se_dma_tx_ptr_h,
+		      __entry->geni_se_dma_rx_ptr_l, __entry->geni_se_dma_rx_ptr_h,
+		      __entry->geni_se_dma_tx_attr, __entry->geni_se_dma_tx_max_burst,
+		      __entry->geni_se_dma_rx_attr, __entry->geni_se_dma_rx_max_burst,
+		      __entry->geni_se_dma_if_en, __entry->geni_se_dma_if_en_ro,
+		      __entry->geni_se_dma_general_cfg, __entry->geni_se_dma_qsb_trans_cfg,
+		      __entry->geni_se_dma_dbg,
+		      __entry->geni_se_m_irq_en, __entry->geni_se_s_irq_en,
+		      __entry->geni_se_gsi_event_en, __entry->geni_se_irq_en,
+		      __entry->geni_se_ser_m_clk_cfg, __entry->geni_se_ser_s_clk_cfg,
+		      __entry->geni_se_general_cfg, __entry->geni_se_output_ctrl,
+		      __entry->geni_se_clk_ctrl_ro, __entry->geni_se_fifo_if_disable,
+		      __entry->geni_se_fw_multilock_msa, __entry->geni_se_clk_sel)
+);
+
+#endif /* _TRACE_QCOM_GENI_SE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

