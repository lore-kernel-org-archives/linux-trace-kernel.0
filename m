Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3551F3B47CA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092871; cv=none; b=C11q+1jIB+Z/o0QWgM0gGFDUCuT/ogEhbnUKfYPKpr9/j6Y6Twutrcl+1ER4+PAV8pHQaY4+65BBiNOTycZfBwENMIfSVCtS0GDLXYYhi2Bse3SByYuPkz48dJQ37cBggM2PUwkaeGw7N0fCqwiYvMVg2PeKaOP8bA+HzbfBzr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092871; c=relaxed/simple;
	bh=qEmT1Rmx7RHPnOZgI3LtA9YAa1PR17tEXaf2nHnPnzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJ4siqBOTwwWMQaGZAU2EYY+4nQWF1Qv54eQkRqfzb9B3qlgBl/+gS8aHCHGsMUgS5NGbpaHLpd6cgAQeIAAkN6/TmzCaDjAsOrZVWnLPSvikixdqGSVgprfQMMoF3ETpjgzqNRn43FQ7VkRj6M1FxQLfX/Bjx3M4P3lh2Y3r2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9o0wsi6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AbNRCsca; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9o0wsi6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AbNRCsca"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l8432679746
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 05:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PI7xn2cjFTj+zYignY/TKjzmfJi3VbH5Z2352n29s50=; b=a9o0wsi6ifDhmzSh
	pz1PorhHQfE5yOyj6Ox7DD0OmK0fcCKT0ARu/e8rIOVr/xm/IDDd1rqpYhtw8tHB
	glzHJKmERRcscZubF6OfZ6WPxWT4hj4OZgurPhO3OX6IALaz/qMzO46yLhPupqbX
	DBuS1OPnw31uBVRB3lj+rgvQ3tnhzGOFrmjl82VZyb6OXtnRhqowsSurQ3B4u4Sz
	FFO1YG94QlrajIfxQfVwjxl8I6Fb1gmNdcqVJ4FUDALC757IFyaVUn06UWqTeOWk
	019VitOoUsgOJ3PenFN5Ky4O9pK5qrBI7OPFcy0cgkmIxoueavT0YZ5o3/LiyHW6
	wo3F7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnuu2uk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 05:21:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso65188a91.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 22:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784092866; x=1784697666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PI7xn2cjFTj+zYignY/TKjzmfJi3VbH5Z2352n29s50=;
        b=AbNRCscaHtOc7cYCIuAK8owtGrpwnC6+gcd5qazFcHC7pRUjI14QIjpbTgsGnyzKRF
         z+hHQ+5N3NnUeONlsni/RCD9L/jpVywhrY1okktt+mytakJfR+cqfIsPSpVV7ntfEgnM
         H+44/rA1/EEwmTW3hFDpJU4bSDK4hQ6JC/BMpN6ECJek2m/DhLzYA/fNYj3daIs1pAeZ
         gfD/Qnkk2L9cVNJIgLC2zgeKyHFS2uNekz4YrzHYtVto7aJ7AgPD1hthRGm9jqqqeFQo
         2kPKotwj9SvMYiVyO8EYOgdWxEKFKQlbBTwGBxL7p0MvbB2Sd6iwClkL/YAatpq+42mW
         AUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784092866; x=1784697666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PI7xn2cjFTj+zYignY/TKjzmfJi3VbH5Z2352n29s50=;
        b=Dso1/FMesH+ktn4aG4ZSafSFl8YnLgPKhWEe9rb1T5Y7jhDBK077NwKiLX0GqXfBcY
         ZxMgcXMFDurFfl1tGW4q0A94Sh98uFwW4/uM8miznTHJsQMoSfzDqxc4kjNbTm5yZmms
         MEhZwzcAcwiSoVqyp4ES/0uAmWyWCaI6XZTGMBuiCwWJH7i6ZVyvRaC4jt98F8IqMtXL
         l947Ax/3k9LnMjgEqqnQ/3H3QZFFlap+SX5RTcQDDhKs3HMrKUSat7oNj7BdRkPC2DQX
         i0aEGJwq2+jY+wz7y8MlYqtuYLQAHBlJhs/RLKF5u2kS0gfz34pNxT3OrHExqg6tjgIa
         gXmw==
X-Forwarded-Encrypted: i=1; AHgh+RqVOssyOaiq+u4cd1h6KlTOMagqKW9iKgtxyqHjIwchBPubvdNdgXfAPMRdzrK1m4I5QIa4JSqZ/iSkTMtlUDFdYSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywFAycNMcszCWbaxA8OiTsRzdv+ob6ULGXOHadSWNwpGOCu3Qq
	8A3a1tqyTK2F1nQRheYj2MF7X8h/hQq9H6jBH7bAc01Gqhj0Qgp3zjIVhlyG8aHYS+5CvDR0cir
	3N6cGJEPDlAJZdOEmW/Ccdd2qC5zssGx23O82KeG8ANfZKB4jN7O8rQ4KE5BtPinhc4l1C0nBSG
	Q=
X-Gm-Gg: AfdE7cn2ysEb6qmK+CuumLN7L/pLw8YuDdltlIHn8K/xaAm+7SpSZmNxbmns/CaV3HB
	cQSSqLHeQ+3e8ONAhCgpbuEPceOq9oOScBtvn1luhud7+rKIHyXQcMmsSLGNp2kknWBi/9ZH9PR
	xew5nHmg1ERrM2FP5xuQlOvhI0+dUfvz2ru87eGIoU5cNcHKcS4s54NUln6YvtaupSp7H2bWa6V
	4ivWQgLpYa5r2GCgU/sDWmtlw65pEQUtjoG/RdBNnB52o+Zdhj4ZfY/UT62zRUGJK2y0o78Ge/5
	nIZ6mxYbQSDPZuJSn9qKwrF5ITodJeJs+MFiEwRQRPReuDE2ycMexEq6QvKqf9xiu2jAnnHJVXQ
	Ig6EAaBSMXYGJeyV8nSEWSsc5f1lOL6swJ3mdI6Oe7iiv
X-Received: by 2002:a17:90b:3a4b:b0:387:e0cb:7f5 with SMTP id 98e67ed59e1d1-38e17fab248mr6495594a91.41.1784092866447;
        Tue, 14 Jul 2026 22:21:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3a4b:b0:387:e0cb:7f5 with SMTP id 98e67ed59e1d1-38e17fab248mr6495560a91.41.1784092865880;
        Tue, 14 Jul 2026 22:21:05 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172e46basm2526092a91.9.2026.07.14.22.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:21:05 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 10:50:47 +0530
Subject: [PATCH v3 1/2] soc: qcom: geni-se: trace: Add trace event support
 for GENI SE registers dump
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-add-tracepoints-for-se-reg-dump-v3-1-0f787f93badd@oss.qualcomm.com>
References: <20260715-add-tracepoints-for-se-reg-dump-v3-0-0f787f93badd@oss.qualcomm.com>
In-Reply-To: <20260715-add-tracepoints-for-se-reg-dump-v3-0-0f787f93badd@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784092857; l=14647;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=qEmT1Rmx7RHPnOZgI3LtA9YAa1PR17tEXaf2nHnPnzo=;
 b=gz/5dt12vB/92OVQ1JVCEAEOOH20P8V0TgooaHEgXMZkDrFcQ6ZAahcTXOV+1uPRxZRhKvyq1
 mB3O45CezL+AbPXn092+5e9TTTJhMv8dQ3gwWY1grZ40wskEdhXEr01
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: ER_gXPKCO-jV2A3mmltQHOCmgydmn-Jy
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a5718c3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=meVymXHHAAAA:8 a=EUspDBNiAAAA:8 a=rDdGhCjhZGBWvw_hryAA:9
 a=kx6RazR-w7M1je--:21 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA0NyBTYWx0ZWRfXz99ANNxFymzu
 Y81Ze661dBW6KgOCwqRXD4F5JmbukJmfoNLyBWfwXrCfmT888fFM0rNIwnAd6HPGL8D5XI3nYni
 PwjT05tukmzjeb4uY5MmB3lXwciN/AGmWFNkYi6sEkvqJQCNMagQjCWJHZPjC+2rJpnoYHzChCb
 qIHIxhNQYdGvn5UCXit7hrArSWCPElvdxMA9c3Bl3ZXzE7F0utyiJyQ4VkQC3b7WuZgq3XxzwEX
 GOM0W+OU20MtpVNDzcO4corVfVwNHYPmhLJf4hF5A/3GeFRVsvdmt0Q7mIHrVsGHGYG/LzFWkmp
 e9D/8L4IxN5qGq8KNkq90zWKNmvlA+rFxXEiUwhF7sZoVxpNllxWkkdgs4LduSSETlplv+UTJgh
 T4jAJyipMrmSOWiu3wTz5UoQGWw34LzfsgBhKJPNEut/q4miihy1bn6adHXdMTAXH88ifEiL3qS
 5CZfMWTx8ONIik/akYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA0NyBTYWx0ZWRfX5kACb9f+RIDz
 7BcOoWJXCOS40xuFdYL4bk8WpDenJikIA2rqsRoueZ4UFywX4U6jRM5jMOHPfufmbfMem+NxME1
 pMqWZcPnUrgt9qffTY2pTfZc+iZWfwA=
X-Proofpoint-GUID: ER_gXPKCO-jV2A3mmltQHOCmgydmn-Jy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150047

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
 drivers/soc/qcom/qcom-geni-se.c     |   3 +
 include/linux/soc/qcom/geni-se.h    |  38 +++++++++
 include/trace/events/qcom_geni_se.h | 157 ++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 15636a8dc907..44bd730baec6 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -7,6 +7,9 @@
 /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
 #define __DISABLE_TRACE_MMIO__
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_geni_se.h>
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

