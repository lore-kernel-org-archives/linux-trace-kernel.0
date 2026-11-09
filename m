Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198545;
	b=OdW96j7Sm7LwMUareXZ1IlM/hrhyJE1NXPs2hUjkMa3/NMWzRzDCjpvkvryGBAS1MZlN
	 7Pd0PAjPTob6LbWKFFkx/zETFK5kw/Fjq8UhtA0os6s55Rv3GKoP2T7931pfypMGbWMz7
	 6aZKU8kdv7breyhe892QYW5TxPIa6bwHCgiYHzVdOnCyZqiLnY9SoimrIpOPA0V3iVOSN
	 EEzGq3nR9/borpkEbp7Rn8Tm1J/jVFTIsLgQ13sEmVeOVFoGwunA+lbrDV++2WjbjUQVJ
	 oVNL51PJZaH9vDlQUm4ZJVzRsRILDCR5SP6yZ3Gmtqsl/ExDMEAqA30fqfBlADc3Xtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198545;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YinLVCB272zCZhaLp1JXqYOKewerXPhjIseqOpD+YiE=;
	b=2yDu5illnDxQITV4Deoc2SUwLIC6Q50ZccT+7BwLAl/WAmD2qPWHoHE3tU1Xmo0dAuEH
	 WHoqkKqkaThQgDVlBTn2W7/yFB0m/SlqtIwKs7wOKxj77pqHeu9N+66Wndf5plPq4ckFh
	 2AhKSAmA9clxrLWRxABz8zbqsx0YLyGVoTqC6osz76j9x5gyI+t87he1zRcjauHZT/70k
	 aSBEnvO3qnrIiC3upTGMMQ+wN2lrbzF+lX8bvuMRIUYq8zIYCkidQD6dt9w2G43oE+mc/
	 /aiauVeyioLoCm9DSeyFHrBtNMgtE08OE1B84ddJ300CZdmoKmnkej0njgqQE4/1FyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PndTn7bd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="BD4/x6xK";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEC606A325
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 04:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BDEC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PndTn7bd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BD4/x6xK
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K5Rl3222727
	for <linux-trace-kernel@vger.kernel.org>; Mon, 9 Nov 2026 04:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YinLVCB272zCZhaLp1JXqYOKewerXPhjIseqOpD+YiE=; b=PndTn7bdSIB2ywNp
	tbpG1qfMBE+N3Z/ucjZsyfmfNv6RzUFKTZV8Y/cSDhgutKOpMlCigAovbw0v96Aa
	rYTwurmauA4tp6O3ttZAVfrIObr6860UXYGjr4dwMJQP2Utpv9+eFBl5AY9o7wjF
	kU5pUhmR+njneL+i/vy0jWwj1+faTEIHAfZE5W0vl+eZBF1IRVtKpVfuNqWTe28m
	Nc989BgdNGERx+B7ph6u4Dmvm88BTNC7GyTHT5nJXHHO3ougH2dE+sjG741fdcuH
	d5X6Y+4KDb8xn0xGNgDmhG1HSK628bwOqBynPUrL4mkd7o33mFqoq0bxid8hkHrn
	YfvTlg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsv734jxu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Nov 2026 04:29:03 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-14373747468so610765c88.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Nov 2026 20:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794198543; x=1794803343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YinLVCB272zCZhaLp1JXqYOKewerXPhjIseqOpD+YiE=;
        b=BD4/x6xK0Rw9q27K8tX1iIhPwmYfQzjQ74ijfKuYY7SCYQQB4NK7UZVtApI5+YlnaS
         h//g4M+7oU977Qtbkvl5Dk+ajylGVBJP3P1wydaMeq9CJ5fHhCBLS8p83SW/3PAAwiSa
         d8X89WMDbOd9WqlI1czVF+7pIBO9NKySpVbFIL9u+1Q6UZSWu0/CvEQA7D32SrB7hWXk
         Zz+Y+UiCv8Ud0TAslYop7mfHvY+T0QzzlU9ftGA5GIVk3ovhBY6rs3fVM2swvxNY/kWA
         WYCXuTWhDqd2LhdSiVNzemDnxKXWaq81+l74TB6RyA1mjXWSURbcB01IqsMd+11EL59W
         t2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794198543; x=1794803343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YinLVCB272zCZhaLp1JXqYOKewerXPhjIseqOpD+YiE=;
        b=dqMZJZTycDF8CcP3WLfFVaz3RWVoFy8KQejhhDvCp/wabQoCGaM7c/hBONZhmfJWWy
         O9x1mEarxghKTA8I0JuEcMbMYfzD3871yu3fJjNU7vnIrdkJlM+jitX4wUH0UW6X6gO3
         O4xMFJCK9/uD2fjZv/KV9wdRbuplcYrn86x7vTeWqOf3vYpucZjaNI8f6TTQ2Y3wHeUC
         hoacaVsfQLuRN1moQogNH41UxC6jD2NeGq0CIk2Uj0pCkTDmoTUiP/tBlVIOcS6IDM+j
         nBDSwjxS/PexyqC4XiI7dpXg9Z+kd6xcdfR9wGslgkQy2d72Q+oksPmi4N1HeULNFSF2
         gFRg==
X-Forwarded-Encrypted: i=1; AL+hErFYPixZXA6Rnw17iiVpHafF6+W8hOJ8p8yKYMC4IlNi61/apR0o2dK6xPGcMfPycanKIkX/1LS5lenURkiGLamSvRI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8h9/1ybFme0Gpl/KRbBpCpjJDVQ54/Knjmaz0Xm1UKfTSA6FUq
	MtB59Ne7U3UAsvT+jjE/XMZq81X+ERj5rSfzPMRiHuM0L1sIWFRVgYaUKtghV2Be3Hkz0KO43Ty
	JvfXK0wTGEWuT4VFs/Az2J/1f+pWW/tXTKm9l9HdrLXM8IHkCBPEqvYo92t0O63dY1FenY2sC77
	k=
X-Gm-Gg: AYBFou2f0A1+RYU4SXgyDRHGotsRnRVQ7tQMsW1kWa7/R7pdq6ysXJUqCk6tGjX2nYq
	/x++/PcMq7c8rB1zv9eNgbyeUM/Q9jZWiMw1g6C/Exs5b+rs6G2rAVuIxY7o8ohnc+j7mF7aLEw
	I9jA5ZkhITRZ8VqF2/fK8o0N/RIbX2gv34rCXSDmeSZJB3VxG4OIOtADFE5+B5d2RiTpTsppSVK
	H64EnvjarZtOiqHr1lJsIPDn86W6o5txaNkCSGUytpbgbguQk9wYm6UZPlnoReHY5xBXHCvCXHU
	R4nql6r9B3+LKhKVw7QzF6Kx9X13s+/nZ7ODAEeW0QfrTgoGvqzyeiWTmyAcABJo2jpHXT4kl2N
	39o+jCwDrkU0UBxnbxaFncw57vVD0IlQRNVS2rUz6NSfa0rihSYSboDu4U7sQaAdPwo4ynZWelq
	2DH2Rihg==
X-Received: by 2002:a05:701b:2505:b0:144:fa57:c617 with SMTP id a92af1059eb24-1b39feb35d0mr4624582c88.34.1794198542464;
        Sun, 08 Nov 2026 20:29:02 -0800 (PST)
X-Received: by 2002:a05:701b:2505:b0:144:fa57:c617 with SMTP id a92af1059eb24-1b39feb35d0mr4624546c88.34.1794198541784;
        Sun, 08 Nov 2026 20:29:01 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3773ea50asm8995525c88.23.2026.11.08.20.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:29:01 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 09:58:49 +0530
Subject: [PATCH v4 1/2] dmaengine: qcom: gpi: Add trace event support
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-add-trace-support-gpio-v4-1-85ed08134917@oss.qualcomm.com>
References: <20261109-add-trace-support-gpio-v4-0-85ed08134917@oss.qualcomm.com>
In-Reply-To: <20261109-add-trace-support-gpio-v4-0-85ed08134917@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794198532; l=13550;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=RCDyiWvE+s39SxOj8u4EuxJgt4YOGurcTa+cAKEU+Qs=;
 b=sirVCppMS3nY2U8D8yAiwFeZBqwUVpoFg1Lky24dBBVexl+vWSIXC8mmPPNA6AyBIepyMfEPh
 9/9HD0B8A3YDOfpLH1D+PNQUhk0LEhfPeHWIF4X9LwPF+wsBuUxO10m
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfXw+GZ4d1WWQg5
 /5tIG2qycIDrb8JBbW9/HoQVKDnjB+p0F5O7H/yZQgyBvpRlq8UAUnMfWgHpAMkQ9+mNAJnJ5/u
 iJM1zh5NkhhHA+eMAV3tksc1wJRla9w5JHs70hi/g5HIIXZ6PlyxmExtjaHAjBzRJUuFjAaUKwd
 VYanHFvetbLJT63K883GfiNumQVBZ2rKL3WaO+AqhmIv6QIkvDKGjQhI07WMgibV3J5CFMXeR64
 BJkuc7YWu278q3v+Ug7X9SBDUKxU8jdVVyt02vAWfJXoiwNE3rBdqCoZryQstSrQRGmhxPtoS6I
 ohLVYWivQWSPqo4kcSOSWs/lTqTOMjADDm5ScMp+8CjWySMN1u6/0rLFkRR0njw4//3SD+b6W1Q
 3ApSAILKNEuLz+cQSsNn6YZbXlowNZsHHbonE0yL9/BACJSInweF/4ISeTlB4cwD6HfoGHT1FtX
 CEbPfqQz8974ZvNIVWg==
X-Proofpoint-ORIG-GUID: pP1AvpHDEkk1LzR1abMITh73p5zlaXz5
X-Authority-Analysis: v=2.4 cv=bcb+w+PB c=1 sm=1 tr=0 ts=6af14c0f cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=xW6vXSLyD36WBg2rLTUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxNyBTYWx0ZWRfXwnEXrMe1GjBL
 Dzi+egK8vHawg1NT84TAADGt5Ofcf+OtrUd/fsXX5nr0nPYpg+U+wfDwfElneur2YS9/C9Qs9tU
 NxV7szSV08DzpFeBmy5hoLXyshOONmM=
X-Proofpoint-GUID: pP1AvpHDEkk1LzR1abMITh73p5zlaXz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090017

Add tracepoint support to the Qualcomm GPI DMA engine driver, giving
structured runtime visibility into GPI DMA behavior without requiring
invasive debug patches.

The events cover channel/event command dispatch, IRQ type handling,
channel/event control state transitions, error IRQ status, completion
event processing (including the no-pending-descriptor and transfer
result paths), per-event processing in the event ring, ring
allocation/programming details, already-in-state checks for
pause/resume, and TRE queuing and contents.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c       |  11 ++
 drivers/dma/qcom/gpi_trace.h | 320 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 331 insertions(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index c41bfac65ddf..fafe6ac848d9 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -17,6 +17,9 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
+#define CREATE_TRACE_POINTS
+#include "gpi_trace.h"
+
 #define TRE_TYPE_DMA		0x10
 #define TRE_TYPE_IMMEDIATE_DMA	0x11
 #define TRE_TYPE_GO		0x20
@@ -683,6 +686,7 @@ static int gpi_send_cmd(struct gpii *gpii, struct gchan *gchan,
 
 	dev_dbg(gpii->gpi_dev->dev,
 		"sending cmd: %s:%u\n", TO_GPI_CMD_STR(gpi_cmd), chid);
+	trace_gpi_send_cmd(gpii->gpi_dev->dev, chid, gpi_cmd, TO_GPI_CMD_STR(gpi_cmd));
 
 	/* send opcode and wait for completion */
 	reinit_completion(&gpii->cmd_completion);
@@ -773,6 +777,7 @@ static void gpi_process_ch_ctrl_irq(struct gpii *gpii)
 		if (gpii->gpi_cmd == GPI_CH_CMD_DE_ALLOC)
 			state = DEFAULT_CH_STATE;
 		gchan->ch_state = state;
+		trace_gpi_ch_ctrl_irq(gpii->gpi_dev->dev, chid, gchan->ch_state);
 
 		/*
 		 * Triggering complete all if ch_state is not a stop in process.
@@ -841,6 +846,7 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
 
 	offset = GPII_n_CNTXT_TYPE_IRQ_OFFS(gpii->gpii_id);
 	type = gpi_read_reg(gpii, gpii->regs + offset);
+	trace_gpi_irq_status(gpii->gpi_dev->dev, gpii_id, type);
 
 	do {
 		/* global gpii error */
@@ -968,6 +974,8 @@ static void gpi_process_imed_data_event(struct gchan *gchan,
 	smp_wmb();
 
 	chid = imed_event->chid;
+	trace_gpi_ev_process(gpii->gpi_dev->dev, chid, IMMEDIATE_DATA_EV_TYPE,
+			     imed_event->code, imed_event->status, imed_event->length);
 	if (imed_event->code == MSM_GPI_TCE_EOT && gpii->ieob_set) {
 		if (chid == GPI_RX_CHAN)
 			goto gpi_free_desc;
@@ -1043,6 +1051,8 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
 	smp_wmb();
 
 	chid = compl_event->chid;
+	trace_gpi_ev_process(gpii->gpi_dev->dev, chid, XFER_COMPLETE_EV_TYPE,
+			     compl_event->code, compl_event->status, compl_event->length);
 	if (compl_event->code == MSM_GPI_TCE_EOT && gpii->ieob_set) {
 		if (chid == GPI_RX_CHAN)
 			goto gpi_free_desc;
@@ -1887,6 +1897,7 @@ static void gpi_issue_pending(struct dma_chan *chan)
 	}
 
 	gpi_desc = to_gpi_desc(vd);
+	trace_gpi_queue_xfer(gpii->gpi_dev->dev, gchan->chid, gpi_desc->num_tre);
 	for (i = 0; i < gpi_desc->num_tre; i++) {
 		tre = &gpi_desc->tre[i];
 		gpi_queue_xfer(gpii, gchan, tre, &wp);
diff --git a/drivers/dma/qcom/gpi_trace.h b/drivers/dma/qcom/gpi_trace.h
new file mode 100644
index 000000000000..e0c45e888ec3
--- /dev/null
+++ b/drivers/dma/qcom/gpi_trace.h
@@ -0,0 +1,320 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_gpi
+
+#if !defined(_TRACE_QCOM_GPI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GPI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(gpi_send_cmd,
+	    TP_PROTO(struct device *dev, u32 chid, u32 cmd, const char *cmd_str),
+	    TP_ARGS(dev, chid, cmd, cmd_str),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __string(cmd_str, cmd_str)
+			     __field(u32, chid)
+			     __field(u32, cmd)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __assign_str(cmd_str);
+			   __entry->chid = chid;
+			   __entry->cmd = cmd;
+	    ),
+
+	    TP_printk("%s: chid=%u cmd=%s(%u)",
+		      __get_str(name), __entry->chid, __get_str(cmd_str),
+		      __entry->cmd)
+);
+
+TRACE_EVENT(gpi_irq_status,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_type),
+	    TP_ARGS(dev, gpii_id, irq_type),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, irq_type)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->irq_type = irq_type;
+	    ),
+
+	    TP_printk("%s: gpii=%u irq_type=0x%08x",
+		      __get_str(name), __entry->gpii_id, __entry->irq_type)
+);
+
+TRACE_EVENT(gpi_ch_ctrl_irq,
+	    TP_PROTO(struct device *dev, u32 chid, u32 ch_state),
+	    TP_ARGS(dev, chid, ch_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, ch_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->ch_state = ch_state;
+	    ),
+
+	    TP_printk("%s: chid=%u ch_state=%u",
+		      __get_str(name), __entry->chid, __entry->ch_state)
+);
+
+TRACE_EVENT(gpi_ev_process,
+	    TP_PROTO(struct device *dev, u32 chid, u32 ev_type, u8 code,
+		     u16 status, u32 length),
+	    TP_ARGS(dev, chid, ev_type, code, status, length),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, ev_type)
+			     __field(u32, length)
+			     __field(u16, status)
+			     __field(u8, code)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->ev_type = ev_type;
+			   __entry->code = code;
+			   __entry->status = status;
+			   __entry->length = length;
+	    ),
+
+	    TP_printk("%s: chid=%u ev_type=0x%02x code=%u status=%u length=%u",
+		      __get_str(name), __entry->chid, __entry->ev_type,
+		      __entry->code, __entry->status, __entry->length)
+);
+
+TRACE_EVENT(gpi_queue_xfer,
+	    TP_PROTO(struct device *dev, u32 chid, u32 num_tre),
+	    TP_ARGS(dev, chid, num_tre),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, num_tre)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->num_tre = num_tre;
+	    ),
+
+	    TP_printk("%s: chid=%u num_tre=%u",
+		      __get_str(name), __entry->chid, __entry->num_tre)
+);
+
+TRACE_EVENT(gpi_gen_err_irq,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_stts),
+	    TP_ARGS(dev, gpii_id, irq_stts),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, irq_stts)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->irq_stts = irq_stts;
+	    ),
+
+	    TP_printk("%s: gpii=%u irq_stts=0x%08x",
+		      __get_str(name), __entry->gpii_id, __entry->irq_stts)
+);
+
+TRACE_EVENT(gpi_ev_ctrl_irq,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 ev_ch_irq,
+		     u32 ev_state, const char *ev_state_str),
+	    TP_ARGS(dev, gpii_id, ev_ch_irq, ev_state, ev_state_str),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __string(ev_state_str, ev_state_str)
+			     __field(u32, gpii_id)
+			     __field(u32, ev_ch_irq)
+			     __field(u32, ev_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __assign_str(ev_state_str);
+			   __entry->gpii_id = gpii_id;
+			   __entry->ev_ch_irq = ev_ch_irq;
+			   __entry->ev_state = ev_state;
+	    ),
+
+	    TP_printk("%s: gpii=%u ev_ch_irq=0x%08x ev_state=%s(%u)",
+		      __get_str(name), __entry->gpii_id, __entry->ev_ch_irq,
+		      __get_str(ev_state_str), __entry->ev_state)
+);
+
+TRACE_EVENT(gpi_ev_no_desc,
+	    TP_PROTO(struct device *dev, u32 chid, const u32 *ev_dword,
+		     const u32 *tre_dword),
+	    TP_ARGS(dev, chid, ev_dword, tre_dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __array(u32, ev_dword, 4)
+			     __array(u32, tre_dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   memcpy(__entry->ev_dword, ev_dword, sizeof(__entry->ev_dword));
+			   memcpy(__entry->tre_dword, tre_dword, sizeof(__entry->tre_dword));
+	    ),
+
+	    TP_printk("%s: chid=%u event=%08x:%08x:%08x:%08x pending_tre=%08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid,
+		      __entry->ev_dword[0], __entry->ev_dword[1],
+		      __entry->ev_dword[2], __entry->ev_dword[3],
+		      __entry->tre_dword[0], __entry->tre_dword[1],
+		      __entry->tre_dword[2], __entry->tre_dword[3])
+);
+
+TRACE_EVENT(gpi_xfer_result,
+	    TP_PROTO(struct device *dev, u32 chid, int result, u32 residue),
+	    TP_ARGS(dev, chid, result, residue),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(int, result)
+			     __field(u32, residue)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->result = result;
+			   __entry->residue = residue;
+	    ),
+
+	    TP_printk("%s: chid=%u result=%d residue=%u",
+		      __get_str(name), __entry->chid, __entry->result,
+		      __entry->residue)
+);
+
+TRACE_EVENT(gpi_process_event,
+	    TP_PROTO(struct device *dev, u32 chid, u32 type, const u32 *dword),
+	    TP_ARGS(dev, chid, type, dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, type)
+			     __array(u32, dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->type = type;
+			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
+	    ),
+
+	    TP_printk("%s: chid=%u type=0x%02x %08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid, __entry->type,
+		      __entry->dword[0], __entry->dword[1],
+		      __entry->dword[2], __entry->dword[3])
+);
+
+TRACE_EVENT(gpi_alloc_ring,
+	    TP_PROTO(struct device *dev, u32 elements, u32 el_size,
+		     u32 req_len, u64 len, size_t alloc_size),
+	    TP_ARGS(dev, elements, el_size, req_len, len, alloc_size),
+
+	    TP_STRUCT__entry(__field(u64, len)
+			     __field(size_t, alloc_size)
+			     __string(name, dev_name(dev))
+			     __field(u32, elements)
+			     __field(u32, el_size)
+			     __field(u32, req_len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->elements = elements;
+			   __entry->el_size = el_size;
+			   __entry->req_len = req_len;
+			   __entry->len = len;
+			   __entry->alloc_size = alloc_size;
+	    ),
+
+	    TP_printk("%s: elements=%u el_size=%u req_len=%u len=%llu alloc_size=%zu",
+		      __get_str(name), __entry->elements, __entry->el_size,
+		      __entry->req_len, __entry->len, __entry->alloc_size)
+);
+
+TRACE_EVENT(gpi_ring_info,
+	    TP_PROTO(struct device *dev, dma_addr_t dma_handle, phys_addr_t phys_addr,
+		     u32 len, u32 el_size, u32 elements),
+	    TP_ARGS(dev, dma_handle, phys_addr, len, el_size, elements),
+
+	    TP_STRUCT__entry(__field(u64, dma_handle)
+			     __field(u64, phys_addr)
+			     __string(name, dev_name(dev))
+			     __field(u32, len)
+			     __field(u32, el_size)
+			     __field(u32, elements)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->dma_handle = dma_handle;
+			   __entry->phys_addr = phys_addr;
+			   __entry->len = len;
+			   __entry->el_size = el_size;
+			   __entry->elements = elements;
+	    ),
+
+	    TP_printk("%s: dma_handle=%llx phys_addr=%llx len=%u el_size=%u elements=%u",
+		      __get_str(name), __entry->dma_handle, __entry->phys_addr,
+		      __entry->len, __entry->el_size, __entry->elements)
+);
+
+TRACE_EVENT(gpi_already_state,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 pm_state),
+	    TP_ARGS(dev, gpii_id, pm_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, pm_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->pm_state = pm_state;
+	    ),
+
+	    TP_printk("%s: gpii=%u already in pm_state=%u",
+		      __get_str(name), __entry->gpii_id, __entry->pm_state)
+);
+
+TRACE_EVENT(gpi_tre,
+	    TP_PROTO(struct device *dev, u32 chid, u32 idx, const u32 *dword),
+	    TP_ARGS(dev, chid, idx, dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, idx)
+			     __array(u32, dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->idx = idx;
+			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
+	    ),
+
+	    TP_printk("%s: chid=%u tre[%u]=%08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid, __entry->idx,
+		      __entry->dword[0], __entry->dword[1],
+		      __entry->dword[2], __entry->dword[3])
+);
+
+#endif /* _TRACE_QCOM_GPI_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/dma/qcom
+#define TRACE_INCLUDE_FILE gpi_trace
+#include <trace/define_trace.h>

-- 
2.34.1

