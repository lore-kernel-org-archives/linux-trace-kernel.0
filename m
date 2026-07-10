Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D5381AEB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709349; cv=none; b=CFzhoVfm5LUkM/lhRhDcrYamN1cJxeMWkwyv42eqnESq5p8PfDSRlHafdtLO5MyQpyTtyFr5HGyLu6gC5lyi0m8oM4wWJFbbiePg8IXCcvNlCImgiNDj32IVxRyKj1rXC37XTZQZNKerSIqWNNZR3VVQTPkQWyFTb4Y/Z3AR9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709349; c=relaxed/simple;
	bh=gr6RUZ9hxy+1I2m/mmdzNKACzQpd8nNWzlnxnblV5no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AyNtPT7qXXyTRYPQrkXTZDzp/qlY0ZtfroZfo/aQ9/wHiZE1JxeuLlk4JP1IYZmFPDohVUGRnSchMOVTjkvwQer7gXCr2xnjApa7SfWTVrJlX9Eb7c+4DtCKaD4DevGDP8QbM/hncZlAwaH1rMQu8S3ZHNFTf3XE3sXB3XsDj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q/1TR1Tx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XV+1uHrW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/1TR1Tx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XV+1uHrW"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH55N41407281
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	naFUlDd2eGJFd8TbsLsOpqoH7nJVOascNmCm25gN4Ek=; b=Q/1TR1TxGGHQRcEu
	RmHSW5JNPBSdlOMxXeSh4dYnmaW2l9e/g0W+Xg2Afal1dQ6VYHbxnwsJji+NbiOQ
	mgJn9XljAlOUn4yanFkWGKJThO89+Uoe+btXtbiZaOvypBeHKfJ0JDP7Wa326lY6
	ePmkxAAPti65VycehOFdIEHvxzVvL1KEWLE1Ww7GhkLzD36VbkP1CFEnI0VywMK3
	E5Rdia57/c2drlGy+9db02LVSCbn4ge0kjnNlabmFFeI0vnj9AQ6IIvaIzi7871x
	LtrxHUbAYGOgIbVsBkjyAPShYDcceom2OFL/V4V4Ikz05/Arw0rk2KdVvBeH1qkb
	27xvNg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5fa22a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so2393372a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783709346; x=1784314146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naFUlDd2eGJFd8TbsLsOpqoH7nJVOascNmCm25gN4Ek=;
        b=XV+1uHrWv38j3xObGX13Y24nRGRMZHR/6ZMmP0q5G4fnFQEaE74gymgrOSw0YJqceR
         /ITWSQqSxHvdTrSgRlhstkN5hx+6sJJ0JsYI4tUKH+dq64efC0jkACFh9tliKdaOLF0f
         elCN/TPPtuuUuRFPswqG9HmvALrTbw4Zu1syDEOnxvSlJSbyjyTbO0qPmzlMBTohOn5P
         IhUu85s+efVL7QYfpo5qb9i7C6NLPWT7OpINigM0ABwehl0lZyeLxV4aVzRtANaS0K2a
         mSyHHP/ZKa78AQrilfcxBVnwDdjCjuuoHMe4zSLAG4pQNzR5CfZ3YNqS0cSOw87jd+3J
         24Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709346; x=1784314146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=naFUlDd2eGJFd8TbsLsOpqoH7nJVOascNmCm25gN4Ek=;
        b=pQbrSuOABEzQpGnxjdGbNGKYg8ytygilRq2vLnqtrrGbLOEeGqEVBLFWij75Bylr6/
         c2POaao+esTtRemWP3YNLPrvFQjxQxb65peBMAceZRJ8CAWwAU8bWQD+NFWmuXFIcFGB
         eVmR9OrT3DvdJe7pixGOnhOzmF+F+QexZEYICvTJ5zWhnNsXLCShAxwCKxgRnhaKy1IO
         zG1BAlOTAb/6A4A0YivP2nMXtoXY/KkFE+SFrR+yIjTrVRMW0KZ1a+x/fzbjUb1LMu7d
         WPNS4dYJfRJeIqE6S+kYYp3PxTgKbHcXUw2b/f9gCkG6kK4jzwo3e068LMCva21N1QGY
         SiWA==
X-Forwarded-Encrypted: i=1; AHgh+RqxVPhOUE5fc2rEl95svuQ6REy3ermnaTLGCZC/BkEY9M08+3EsjB9+03G+rj1bQ4zy2H3Zj7/125pHFO4fHSTy+vA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvKpPzZPbNJM1iL+75Y6gAJfMZFPblAj9hBd045uA2mIQB9AQ
	Eix3dRZ5i/rTf4XKwchYKyDBth5H8IsBQu/ACONhbuBjTVM+jUSCh7IwlYUnpaAo2he5M/iuOT9
	bRXN522Z3GWfkR2yCpJKTW6ANN2bd8LAm8Wjc2YpVF3Yj3Kpc6acdbigQ3kPQQGCwEt0xPjb6vM
	4=
X-Gm-Gg: AfdE7cnfmOwlgPqcWFiSqwPZlf3x0HPnUfsAtbQB4Hro/EWsG5obFoX0ZkMHohxUQyb
	wZB8YtB3zGNd/c2aIlLcoE1UPWqCj50OxBcu2pBewcNDEuntS6dCPqmupPy23ylXBz91C0ag9Pp
	nCJyKbTtZ6Dr6qzSNkARrEORXYgyW2MkUoQPwzuY0hKEp+2XidA1B/iWAn5Zpdc6tNnrJboic0+
	z6JCl6EFBzSQSdWYYQkkSDk/RWRb7Z+nsvwjVL/qtyajiBCmhrVWaz7dAAleAz81s0pglI5bO7p
	9iArL2AT01wTTcKnN/e2rzb85Torkk4uu2hRlR8B2LO36NlgT29dklza85T9hLl3L7rYlEzHcwy
	E3r6jGN8Akg+lCAufxDy4fFGMzSrhzr7REl6PeFGnJa98
X-Received: by 2002:a05:6a20:258e:b0:3c0:42c0:702e with SMTP id adf61e73a8af0-3c110ba2a31mr218079637.52.1783709345521;
        Fri, 10 Jul 2026 11:49:05 -0700 (PDT)
X-Received: by 2002:a05:6a20:258e:b0:3c0:42c0:702e with SMTP id adf61e73a8af0-3c110ba2a31mr218049637.52.1783709344967;
        Fri, 10 Jul 2026 11:49:04 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm47226919c88.12.2026.07.10.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:49:04 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:18:41 +0530
Subject: [PATCH v2 1/2] soc: qcom: geni-se: trace: Add trace event support
 for GENI SE registers dump
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-add-tracepoints-for-se-reg-dump-v2-1-ca1e9ba62359@oss.qualcomm.com>
References: <20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com>
In-Reply-To: <20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783709336; l=13747;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=gr6RUZ9hxy+1I2m/mmdzNKACzQpd8nNWzlnxnblV5no=;
 b=Beio6gVVdnzL3qbyTUuBnNfqA0B2rhOP8WizglSZ/aypfJPGovlGleGu849aLmJrDFt8oiHcl
 G0eHaisX/taALOooHt62AILRytzY/FTgwofP11ChVI9JV21wUy7BI0i
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a513ea2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=meVymXHHAAAA:8 a=EUspDBNiAAAA:8 a=LB4RwR69Xtfn_yaUxnMA:9
 a=ecEcETMdv5OSLH-Q:21 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: Nh6mkLx0s7GETPQHT0lajs1MT_mRxeZE
X-Proofpoint-GUID: Nh6mkLx0s7GETPQHT0lajs1MT_mRxeZE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfX66Utgy1IDEFZ
 jDULRguh8e5lScuZFWbpd/bGFFQ1bAodnBSfu1BrBEnU+LC2WWIvEe0JYtp8uVxGAFs7dyvv6jV
 VkB4mkaFmIOe6qI4TJZAhpRORoiKKWQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfX83f7Clj+dkCU
 q52KCxwFQBaOTmkmjAuL4sCM3Cmurho3YiFYh+Hxb1VADdv5ZD+MNtpS1X/t2cOzI39uafvmOJz
 VBpEun6f2mnskfV5+6OMmtX4/cVScUrA9xOjhWeK9FyG0n0yDv7WyW1cSsZCaDqtcdNEOyz2gx4
 80dv8kvCv1DnkBNuBOfOl+dozcSiGdLXrsO5ju/gf5d5bV/LfId7/X5W5sZL3URIMR+uQc1W2vi
 zaht6cuCmZVFYu6Vz/qmoz6bvuw0OyVKJGhEorjXohRC5aa/Hry8G5ufYszH6u66Fv1GVL2hCm+
 7yoFF8ChwR0UrRL49CKaMm+kukpwScHYEmDchTM9PsIg/ucGrJzbmZ/pAmpE/QL9HR2D4y6McfA
 1pDXjAHN1bSYNe7Fxa8inNFB4oTyKpHt2Vf/axvxMkSlBcRcmppq6BZn2RbU4jKzVxO3kB3WUHI
 15amePDMDECU9zH13Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100189

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
 include/linux/soc/qcom/geni-se.h    |  38 +++++++++
 include/trace/events/qcom_geni_se.h | 157 ++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)

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

