Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAD361977
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 05:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930608; cv=none; b=Uf0C0avk5Q1GV+cR9HgC5WF/vlzizYkO5TR/nkraS8MrcLom6ByNIRtvnCvUPKo7RLVD7QHW93HSZtMcJ0BLiPsn781QhqKipDO80Bgohe1tTraHZK9RmMF+pwWPK2PrdHyGCNhOWap80nYUgf7Es3EOkirzVO4ip9CJvFiApTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930608; c=relaxed/simple;
	bh=Z6l42kmbZIdLCp5HS8lQr0U0ximrV+BKEFCMLwjPxeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bO0kfjxchQSYKmJBVAzhmUL6/M9dsjhzHD4newi9gaspFnJAUEX4j3lVaifIWPyBAY9FJfwBhyqRY0AqEN7Y7ENoQugQCF6oS+ae6LwkQ99nSBudU0QWvWLlxqA3ouUoUG8kMLVCjhM2pZ2HVnSvKyWSy/zXX62fzeOhH/ydQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K18kkAmi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kKA+mNaJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K18kkAmi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kKA+mNaJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6892U4ej639490
	for <linux-trace-kernel@vger.kernel.org>; Wed, 9 Sep 2026 05:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VHqBJxd6rqKL88lhmyF6Ow7x7erHmkPvtp2e7XDc4gg=; b=K18kkAmif3x1TjjK
	uJObuExx6LB+gE1we25xFO0WdKAUf4IVEzTENFu52Jb1MsyCSM44DY7TYy+6G9zJ
	9at74JJaH828qzvRnmzoGR3ykcz0RmOOpsmzv5cpenEjj21qmTVHsuDvte7VCHZv
	IVxLcv4yWgl+VpKA2J/lHj9ivAnhfnRoJAVEwrAHU7yrVHfVrhmpglxNMkeHW89k
	g/DA20UhVjg2x6aPEk6K8pU2aeGRwCeEKdjcULN3UPmKlO8Z3ysaRmYQEstHrZzN
	/Qgtk89c3vcq+YvcWaAxooZ2wtf07oUhhR/w67frXKVihz+KjOixto3jKQgvCKUA
	xJHI2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjxqj8g2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 05:10:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d7443e0f0bso82656565ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788930604; x=1789535404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHqBJxd6rqKL88lhmyF6Ow7x7erHmkPvtp2e7XDc4gg=;
        b=kKA+mNaJflHRdUzDe8XWOftUWh/MIj6lmwUo4y9iQVCdfy+Jzm20faVdeiCOMlunYW
         j0DBfaJ4mxQbGTMQ+QgEwbZkqhF8ipiRaWpw23utMBIDCex/nANjuizN+xY26OBfHhT4
         mq+6LZTwUvhAQizqg0QwypYABHbQWlg75cxRQ4gH0zDaB/DHXkg6q+7JFORr3OGnXfTu
         WB4fBkYJvyBjmLQUdaKzNMTArAWi5u1YVH/CJJrw/ltW8/T52fFQbOzihQr9lsISexJo
         wUK7ZNAapsUXvBkrIa0wiyScPc8Sza782ceWxpEw2cYEpfbjJEAPu0ituKsMn6ll0xr5
         sQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788930604; x=1789535404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHqBJxd6rqKL88lhmyF6Ow7x7erHmkPvtp2e7XDc4gg=;
        b=TzHgPnO4y+iSWibsW1oblXO60JJtoV/BIE8gOk+MZ8jDXW2epca6LLmcYEHjF9Hraj
         KBIDOVagyJYSrXDMati2tj5uV+Q5YMURG+eZPtKKkhknwMt0ca9XAuvubhRjb0g6cK9c
         KZBjdxinRAjSG8r+S1OTZxtGvTJvtkLV2JxqtQnGcUGo9QVaPJsthhRaPqUGiLZYjE/U
         7QTpI0Vci6qxXKavYBwCqHZGXacMGOQt55AGg2othlTV7XuhuB+FtJ9K9LtAkFzBXUp+
         AOA3732Goz6q8Z3I+D5XQcBna7iHdXr/1sDe8DCHT0aP1shmPMaEU+judyr/4KsE1sZj
         Ajag==
X-Forwarded-Encrypted: i=1; AKwUvBzqdFnhQ66TV486Knjbyu9VuNDkasMaoJep6MKKbmjheG69bMMa7tjmL+6pH8TTtlsPBVByWGsKHsMTFf9xPxa5/J0=@vger.kernel.org
X-Gm-Message-State: AFuF++mlqFk44k1TPExirJuKQ1q1OkUoXVaVcnOypDZCEn8rw8LrG/Tc
	SOC3+82bclwSYyJmJisyZ2/K+7tW7nlXEBiYjLndOjCcfor+jDOPD/LEI4FCbjchfDOGWq1PpOz
	rYYQP/NTpLiRWSFPCFSMDhGKauArsrweZJ/oLKzHACFTJEYZ9HWIDNWNNyRYxs2Ll3Au7StHYIH
	UltrT/a9E=
X-Gm-Gg: AYBFou1Lq1XUsncbudm7LLIHWFf6m9amuCeDgUtG6vwepPsrhO3GqJXKjQNT/eiIPwP
	WgNCet6XF+dvnhFYhuzY4H6LOAD9uk9+2Aee9QbX2ZhEC2ZoOr6kDvlVuBLeLikzkr4ppS+QIk2
	BhYAmgimTwOk4rPvJK5l6D38NMI4EfxmVlfo0QtFCbZNe5Dqzyngn8R5fbbVWfIEC+739k6qu7Z
	2yzXa2Z9Fo2y/VNhRmq1ckZigFT49MCSyRyzW1s0PUHMQB3b5Sa2wge/bz0EzKqtRv/6ToPYAeF
	BnjEAvZ3cZa47lFXPKS42AVpi7UvUISUEt/x6d/hCPAr5PgJkuBWi5EgMZZAZGUJR8qgBT1B2dg
	xfS1dF90+aN65Uo7QDiv62cBZjoH+idbwig==
X-Received: by 2002:a17:90b:4c51:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39b26204e5bmr46023234a91.13.1788930603976;
        Tue, 08 Sep 2026 22:10:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4c51:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39b26204e5bmr46023202a91.13.1788930603460;
        Tue, 08 Sep 2026 22:10:03 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338f7bad290sm11082833eec.14.2026.09.08.22.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 22:10:03 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 10:39:42 +0530
Subject: [PATCH v2 2/3] dmaengine: qcom: gpi: Add trace event support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-add-trace-support-gpio-v2-2-01f81739bb88@oss.qualcomm.com>
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
In-Reply-To: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788930590; l=3171;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=Z6l42kmbZIdLCp5HS8lQr0U0ximrV+BKEFCMLwjPxeM=;
 b=a+84aITZZeq5C0RC92obMoyCfcKCmGzAhKOA9KCHsw6rACt4jMGB9JuiD4f88JdjzLo/6cVrU
 s7f3Ek7nL32A1+19YDhjQ4AIKAWPVmYW1EyasXKpuf65vFAbstiPmfr
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: wjG7EJsEX7_PrG8s-hRu0SMqTpiUzdTQ
X-Proofpoint-GUID: wjG7EJsEX7_PrG8s-hRu0SMqTpiUzdTQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA1NiBTYWx0ZWRfXzh7oNpEHatXq
 DO1G8RlQxyKwZqmX34yiZLCbVNTzzBE6qTh9uijDsYZMJ5MRwNZZClNZQPPZ2x6rt4vaduMB1+I
 nZZcZhY//TvTaPChrazhcUWbLL7lHOIonHTplMQihceXnq4w7zryXBfzbBWA31OXenUz85jSNzZ
 ydJmNOaA3ZdAviMSJ2oDvWVJBjKClBCw9GJOUe0vDpSyQirw3+YsdFZMyPaDLk/Q2ZS5kc5L9IU
 MRaAICJhF4NCnZ6PFf5HpJ4A847EndndAXeodmE1kBEwfatTwJCtJVlr5/+lgUdpxwX7U12ba+B
 mFNQl3/tuPY/6NvXMy/QF0keAJwdQlwEG3Njnn3IGcYuyVPLz2GHXZOL6XYtx1rvlFQypZGFBm1
 jrtnL5L7hpLd3T8zBi7Yp/EGH+a3/9myi13yLlt7FcRZNlLOD7v+TF/Aby5ztpM58Q4OMBs/2C1
 ui4Fw3btqiIBMOYNe/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA1NiBTYWx0ZWRfX64m83Iq4lsbE
 Zj0yyn5q0Km2cnfddwp5CUj3sTTaoSvOSkpI0woZqGCTtxfOtx7MprbA/+M8KL3wp29ezzcqWKu
 +N/+zd4OMCqHGdWXEZk0/oQBzt4J240=
X-Authority-Analysis: v=2.4 cv=f/p4wuyM c=1 sm=1 tr=0 ts=6aa0ea2c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=vNIMIT6v7fynGdS8nZ4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090056

Wire up the qcom_gpi tracepoints into the GPI DMA engine driver to
provide runtime visibility into driver behavior without requiring
invasive debug patches.

Tracepoints are added at the same points as their existing dev_dbg()
counterparts: channel/event command dispatch in gpi_send_cmd(),
top-level interrupt type in gpi_handle_irq(), channel state
transitions in gpi_process_ch_ctrl_irq(), completion event handling
in gpi_process_xfer_compl_event() and gpi_process_imed_data_event(),
and TRE queuing in gpi_issue_pending().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..b09354a73b46 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -17,6 +17,9 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_gpi.h>
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

-- 
2.34.1

