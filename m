Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462BD3FE35F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336115; cv=none; b=GAul0QO4gNFLMAobNSrHVGnn5ZBHRLvUtzG7tR1Ci1pEUeqfDyuDEumjLWbswvUp3WPPHqEY93THDeF7EtHfIHkmqjWe+gFdWhEZa6glSOr+lnyuBmJ57Fkwsv5XS9x1HWH0m6+0/7s01nIci0hZ/Wj5PEgvFdUBScG4nePpelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336115; c=relaxed/simple;
	bh=fl9EwED73PSgJJCwBdFVscInLhRPadpi2XolTd/PCWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbTrT3qVWJPzNq3W3UPPhz8X1wLBIBeMGB8lmV4/df5evGIcwafE0z2vvbP45X9M7aRp+p6rd7J+txQahbZqihbtj9syG5GEPA5zIcE3xqFW9a814Fpqx0qjzayBlr1tBgWPcuZMm5tZs7+ukCVN+AK+Ov3Whh0zD2vxBjWmZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PCLxqANH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=auMlPMVq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PCLxqANH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="auMlPMVq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxFbK401628
	for <linux-trace-kernel@vger.kernel.org>; Mon, 6 Jul 2026 11:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kiuf3gnCHyoS1seKAT+Sa1HPJHi5Ew4owfLTVCGm+i0=; b=PCLxqANHFwyGX1Iu
	oXvjf9ls/WkWmnY4QiLXHoX4DOclgYNB/snl3HGc2Y6V2HcY3nye147wJocYbNgp
	76Cq3sthzJEYq1D9fN4cSuHL1hsqijSF7SZkkSPmb6L83kK06tCU2qvSf3JUZ7px
	giHdTUhkgc6Wrlle6P/EcRyCW28VRxlxFyO/EdsMuIw5D3X5hqHBFGZgoiQ+xMOt
	OU4xitShKQxgtJ2/WMlkna+6eKTb83uHNIwSsM9EIs21g8AmQ7aLdF++zpG1lr9v
	6eIkVO/zk+LyJGoLHepCr/asy+xWB9ByCJR1yD4J7wXS7aqz+IBy2up64o0DPzuU
	vhQ0Pg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gr965-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 11:08:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so16856325ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336112; x=1783940912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kiuf3gnCHyoS1seKAT+Sa1HPJHi5Ew4owfLTVCGm+i0=;
        b=auMlPMVqdEKusJrK9tvb6Wyyryq2katKCVSAcMaaYys0QyCk/iCJiIa6PtaswLScpa
         YJyuime7+qyjUbxlNO6DRxkvpaUsVScabfaFB7iOcqIsoIM+9IFEmlOE0+xI6Cv1wU/0
         PwVjyOoCYXoUhCIH3deHlpK1l/fmmrSKRfi/Uu5kAPuQ5QwOglIM35z2bV0/ZRKkBOHq
         o7AbV5F7gquvscdvElxuS8a8AcquDpc2BsfISVD9nAxKA6+/Fh6F3aEDYR4zahgeh3r3
         7WLgQHYpuXP3qoaMmXE2388OhUQrzXCL/mm23kKLJKDDMJ0C6s21lVjXVFZi24dr4cvz
         Hdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336112; x=1783940912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kiuf3gnCHyoS1seKAT+Sa1HPJHi5Ew4owfLTVCGm+i0=;
        b=WWK1XvYPbTUsRAcLxAFhnElKPed/k+RPMGvigf6RhPwWeyn1252AbSzPslMAkn+SXh
         VQimEEvkBjH4cOEUf2OeC71p82vFQHrYIyolzPyE/HAtehVtGNwRT4HmJNmpZTxrZwlo
         wW5p/SaVnPcy37zJk0R9a5A1aKAhCnMewSvhyDPrB0vQYgN+l1DgdJWOUruGgvw9rQ/s
         owJtbt2OGep+3O05akKbZDrNDFhoGuegWi+JRUnocfmh9pvUhEdXcUTlvkvMGF5ds+Sf
         fTuywPbCV6eG6O5079TcNKtEpRQ1lD6Im9zX/Jas0A1p7f+Zu+wGqEdevCBmn+FAz3GS
         FtDw==
X-Forwarded-Encrypted: i=1; AHgh+RrUL4OlThRt58ZPSN8WLJW/jZZRdQ2Tfq77LkAmJ1Bi9Jo1ViBQaNKbE0+nHoFxCPEuWaQMGElRPV7TPH2sjKjj+lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWMnumjlhROygf67TBStPl+dJIJQAiLXqe7IWnZAhqQI8J3xz
	vEboloshcDJ/c6ApFwrdqrYlWf347h+dseH7F218VQDa9P2KIukHX0IqJ/qlMzqWZ5aGcEyCkms
	Jnf+b1+KoijY3Xk5tTe7+Crki9XUqr7CPBEujniWP38EQRI63cQigy+Md0xpd44L2W/DD9b54VB
	Q=
X-Gm-Gg: AfdE7cmdYmJxkzKXQSr3yQVCdMcW3LhPNSrHEYCvpzyHoIGobQKVnioMa9hsfeSsleo
	VJe58mqTnFxpvuvRgg7ot5+Ucog7kGdw9TycMxR4E7BCszA/XcGizQMHCj9n4ww96zRYHcm0AlS
	+2+Wlg3KQ8S7NC16OuwCPHEslvx2KriHfV5UOg8jXpy7ycx2Gb5K+dfWDhs6TGfGeuJBxkuxWur
	k8zqfUalPnrDo7vLbUIqQOIPQRc49M/LhUgIaqwmaBwSgxrb+gh0Mh2rYxHW7ihr6n5lCDz9mS0
	HL+pqlDoaoLIioA2sODNWj1J8rFqExc5Jp6thzd5w6GFeTulXhpQfSFpv6Mw9X9Gbnw1BxClEdC
	F4/QUo1hXHbnxiZp0t1ishnuksOwEZ2YjuYwOLP6YYTkN
X-Received: by 2002:a17:903:98b:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2cbb9e2fe63mr92388915ad.19.1783336111517;
        Mon, 06 Jul 2026 04:08:31 -0700 (PDT)
X-Received: by 2002:a17:903:98b:b0:2c9:cb1b:64d6 with SMTP id d9443c01a7336-2cbb9e2fe63mr92388465ad.19.1783336110816;
        Mon, 06 Jul 2026 04:08:30 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7871285sm47730685ad.64.2026.07.06.04.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:08:30 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 16:38:12 +0530
Subject: [PATCH 1/2] soc: qcom: geni-se: trace: Add trace event support for
 GENI SE registers dump
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-add-tracepoints-for-se-reg-dump-v1-1-48bd08e28cf2@oss.qualcomm.com>
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
In-Reply-To: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783336101; l=13696;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fl9EwED73PSgJJCwBdFVscInLhRPadpi2XolTd/PCWU=;
 b=miIxqZPuXjUwj4BKEyxrotd72Np37P+ppdljllcfy38LlAXK5sJPlj7SP6YBtWKkA4Na92bM5
 U7IcYwlj38IAC4taEpVpSBOw/FZlmyFBGbIxpvFNkKBuopZkJxlHeM8
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: hpyoVTUDgRbSC5oJ21ubD-8tMpE8HO4w
X-Proofpoint-ORIG-GUID: hpyoVTUDgRbSC5oJ21ubD-8tMpE8HO4w
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4b8cb0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=LB4RwR69Xtfn_yaUxnMA:9 a=ecEcETMdv5OSLH-Q:21
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX2wwdxbY7DzI+
 7VFh+Bm+8hbSNpPxsrIVb+/wm9z3L6Kf7bpNOGxPJClD6wSOs3pisDl/eCT0vAwUAnRz5GHtPRa
 7GOCE5fYYryBwn9GKFokKfJu3mLEHGcLvogs9GFjthhB0lzO5aN8w8NsdXSLL2NkHLhTuNkdihH
 xED6x7ldbCbXmTf4W4bpxro4vB14z00G++KYwl5HhG1x8O2fjuT+YnW3BXtV95CQhebgsyeh6Ei
 IEim/esGBD39MGM1cuGa4oGwuiDSj1FIvJftJZpm3ulo4Xf/dVmd8K1jdpmD1wBj+V6FXLVNYF0
 +7Xe8bKsfZcjvrMYsS+UduyAi4nOvJ1OpIxJFtcPaC5+3Ly9Fg/WuDsxNX/G/1PCpQA742MF8bu
 Nc8VErl1BjkmYaHxlxkegf7Y34pwKLiCXbvgMpSWTOg7epL3qN4KBJJVMrHLOJfMl3Vl+FijP9w
 qdUen2OplHbF3p1otKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfXwwuq+hNKRVTb
 pUZbSRCVGFTiVzVovLLk0bNCh/MpNLwwy/MpZR4j8oa4uov/H6OUNPZFb7XneP4vyKC6eP0WjVP
 mx18vIO0uKBu6FeXOmF6ppQUkSKavlA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113

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

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 include/linux/soc/qcom/geni-se.h    |  38 +++++++++
 include/trace/events/qcom_geni_se.h | 157 ++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
index c5e6ab85df09..58c84b5fb3c2 100644
--- a/include/linux/soc/qcom/geni-se.h
+++ b/include/linux/soc/qcom/geni-se.h
@@ -81,13 +81,17 @@ struct geni_se {
 };
 
 /* Common SE registers */
+#define SE_DMA_IF_EN			0x4
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
@@ -98,6 +102,8 @@ struct geni_se {
 #define SE_GENI_M_IRQ_CLEAR		0x618
 #define SE_GENI_M_IRQ_EN_SET		0x61c
 #define SE_GENI_M_IRQ_EN_CLEAR		0x620
+#define M_CMD_ERR_STATUS		0x624
+#define M_FW_ERR_STATUS			0x628
 #define SE_GENI_S_CMD0			0x630
 #define SE_GENI_S_CMD_CTRL_REG		0x634
 #define SE_GENI_S_IRQ_STATUS		0x640
@@ -115,15 +121,41 @@ struct geni_se {
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

