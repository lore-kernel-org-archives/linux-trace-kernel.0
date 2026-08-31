Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851514A2610
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194227; cv=none; b=efJ3gvzrxvLG273mvM9O0h8YlYqfKWiEStwNfmOxm76L0UTt1xFFBDdTHiYgUUcuVX/qNvTh8NwXSU+rf2vvEgKqsUq1xwplBTvVmf1sNxENjxSWUMA+4YtiSDxQ6MHiHGfm7NG3APBM8v587ESORxVK6REVpiKvaseo2OumBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194227; c=relaxed/simple;
	bh=g8lTclxGhOqcW7CZT8rYnXsAoNxsoFJn/wn4jG/TwCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwwj97S7ECSqJrIneiim29MB/Cxp31AahNS7vFrsisN8GIcRnUp7WdIhxLFAWh5rTnK4NkhIWn5DnEMsasPb9UwljMA6zRzZFFzHKQcQYCBG4AldglQgQB9/Ilr9aOrqqAS0DccFP8vPVNd7aCpi65Rwmx/S5/O0JDb5B3+MXw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DK2aeLA7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dRUumj0X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DK2aeLA7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dRUumj0X"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VGPUbe4073479
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ut6uHPVnRZtHbF7GE08rnRaLAQ7S+8eEO2cEaVL+cVE=; b=DK2aeLA74JW+pIG1
	c6cmkYEo5OXLMQn3L+rL4pcK0UJ3CNSePGvqcWGlugJ9HTx/Y4z5j1O8e15DyNED
	s9ymK9LF+y6B66SxDclNwx2+ZWEkL6Z/Byh+Zhucw/uNpctePU0VPvXXOTl2IL9L
	9pep2pOIXhinPtAtnnrE7ACfm6CP6HtsWPTmvSfQVtIgnLKf+I3fAv5wGOfzoCXU
	4l8x03qulqsQwfcIf1hetqhOuEVf7P8Fnh6T/JMzZFD2j+QvQs30vzTeTMTWEXYL
	wdMW2U0zCRXYZouVJpv5J3+Ab6k0jLqbrmd0x1o1hz2V3PmO2Xlx5FU4wSHjF7U9
	Dszwng==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdd4dr207-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:37:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1c18c775eso60736a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788194223; x=1788799023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ut6uHPVnRZtHbF7GE08rnRaLAQ7S+8eEO2cEaVL+cVE=;
        b=dRUumj0X6UGHtuL8q8XL573trLGOUNGqQjDhNS58dRLJ5UWz6EsbJHgGKokGvR3Dnj
         IgrCEWQk/Udrw4uA6Ep59afStdQulXI8lvluXz4TGGx46nFQlEazIC7Mr6DKpe6dZUH7
         ZIm5wKTJuaRqhnplrxcEefvqulCGjYCrcp9+37XkxhRoHJBTPP1ZWbqENfhqc1ghuqnl
         pRln82zqQ/CpFPKjeBTUsPQ53kHrzNyGNnBzt/2eQvCGy/AIYloecgiVm5fMUG+WXxJU
         pfu5wYgKwTv9yvaKo1cscQhfTQpLZYYkyIIyuugXuFqQiszBpor1OZnSjSbFyGD3ieRo
         vG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194223; x=1788799023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ut6uHPVnRZtHbF7GE08rnRaLAQ7S+8eEO2cEaVL+cVE=;
        b=czG1WJf96IdzmRC/6SXTRapaA6zHeMNQyFN3eNVx+GRNKSnsmJUOY/2NhxAUpncyS/
         Xt5RfsfIzovAHe5fvD5u8PXPLbjgjwU076HOhAKGQqq9XXDtSRBzt07ZvHhzy/akSt5S
         Hk0jlzNiWq2tyySB7Yv1jWaoSjARGe9bZ6PR9NIWpA8O3xOF7wo2PUKHIM3nGX7A36zW
         F7m5LtoEmMGgRor7XidB0eaVU7y52UnFANX5kgd+wmNYsY8L/6WSubrWiie8BwRrEHXP
         /UHVN0ZxKxR8naIuCn0nXCt8F48QREQnvDO0fvg85P8f3yNrYnG+2NBqDKIepAiwtaJH
         ffmw==
X-Forwarded-Encrypted: i=1; AKwUvBwdfkgH8abVNEpzPsAwILyThUT81R1u/Q2CSO8KR2tGuh86PiVZggr86V3phdnJpq4Px9W5M/0MHO5bBBBSBW+/IRA=@vger.kernel.org
X-Gm-Message-State: AFuF++ke0cNOpIKSkTUI8eCMy1pE5UwfjBPEocjWVk8s4z+U3XkYGZ/p
	IyMhB6AfI/7kdxQypdUvTSOUAid6BdXJBZ/pPStd0mXxj0zhQWWIIqZVGpSrf8v/3iVmJk9U8Wb
	yx1xMQUCXV1RPy+6K66ryP36UG0cMgg0IN9OgB+vFoRfOud27MGsoLdFEyXqp7dejadtx6z7f2h
	HC8zJfU1A=
X-Gm-Gg: AYBFou16ny9CLlqm8Ggc+V1nsx8Argum63Inzj8HavYY7xAuTJK4sIO/OruLkRdwPa+
	UvURuM/S5kXPRRr84b5S3nP2q9KU1PgUXiHGjxZEuPoVJBF32chKQvNeWtN1WQa4O6UUkT2C2M6
	KDi/YBQY/ZatIiKVu9kiJ86xLMjqcbKQdBqCQlDltmt6IIcifDLJqMa9F2fkwpWTepZUJc5VVO+
	QiTyXYJE51qUn46o5gDcUQwq5LnmQV/Jx+TtjlkVfsHPXgfLRv2lTth5O/9Lex0YckEuDOrJ7i2
	cfrG9tTIs1l6og8FL6Xt6k7/mW9zwK474XfH6sgzwR9eBSVMb2ZX6aIDGbPOr7qwJme0JPxRdZ/
	83Q0+N1YH18ctH6ZyWRDI5sHmgpgRXUTCJA==
X-Received: by 2002:a17:90b:4b89:b0:398:ba46:1d9f with SMTP id 98e67ed59e1d1-398da87f3c7mr6908988a91.13.1788194223166;
        Mon, 31 Aug 2026 09:37:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4b89:b0:398:ba46:1d9f with SMTP id 98e67ed59e1d1-398da87f3c7mr6908939a91.13.1788194222565;
        Mon, 31 Aug 2026 09:37:02 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75fc49sm271260a91.12.2026.08.31.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:37:02 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 22:06:37 +0530
Subject: [PATCH 3/3] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-add-trace-support-gpio-v1-3-7b0fd0d0ddb3@oss.qualcomm.com>
References: <20260831-add-trace-support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com>
In-Reply-To: <20260831-add-trace-support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788194205; l=8161;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=g8lTclxGhOqcW7CZT8rYnXsAoNxsoFJn/wn4jG/TwCc=;
 b=qIyF0AogGLy/cItIN5o+gWvmcoYLfQBlnAt8/4it3KRK2v9FmAlJ/eGfNjatn7OevoNdmgXkI
 qRmSnawlCwpCf+vb1ToJCKMGQ7haT/QEPYXVu66KL0nbyx/EDlmkIo4
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=b9qCJNGx c=1 sm=1 tr=0 ts=6a95adb0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=aSNI5RSwOxee8bqK_isA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfXxWr3FHmzGJVQ
 S176baWtlh9pO9R+D/Pc2gxt6rQO0oLOFOiNy78nFmzcb1iNmwfb0DCNkGF9CacXr+TMnbFATuE
 GNb9cYiK21M93Rybop1KFLXYtA/7jqBnn0HZZ6UM4ynHgGLouwbxmxO/2z9RhKrKnb1j/T/D3FA
 thOXnp4b9Qh+oMm/CNo2lxszWAmm/0q17LRDPeU29+rcTHy1ibynTUPgZnQKxfKk+U3z5DwxKa0
 51V8tlLJoMn804LW1nCTNpRuXUb0MMLktsl4vhDxdZW9cGGz8/3vI0dLNxW8VLDkl5S00nWs71m
 QPvApUvzlkvH1mRN9ydgZ59TAWPWYBi5hUUXM5HPKOmDr7EPLJiycbzw0DzI7vGfLt0YcoTfhFM
 TvJOC85k0svS7WdGhMtCncBqfCWH/a4eg+vi0vJsvY2nDaTLT+nJTRK0uasIDMbMGZDA2ZJhylI
 l1dUSvoCmg68Iy52HZw==
X-Proofpoint-GUID: GkllZwwW8xnZrobBCxy0Z3LsHQyRRog7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfXwBDdtnG4+ltO
 3CvUv02WBU3Pp5Fm3coR/1DM4bSqIM0pzqTaSG+0SSQVswUe3YSB4lGr+Zhz/pmIIqa0mg2xnaU
 LEgxgnEhfXNHV0hn05HKHL8EVO1JRIw=
X-Proofpoint-ORIG-GUID: GkllZwwW8xnZrobBCxy0Z3LsHQyRRog7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310143

Replace the remaining dev_dbg() based debug logging in the GPI DMA
driver with the qcom_gpi tracepoints, providing structured runtime
visibility into GPI DMA behavior without requiring invasive debug
patches. dev_err() calls are left untouched.

Tracepoints are added at the same points as the dev_dbg() calls they
replace: channel/event command dispatch in gpi_send_cmd(), error and
top-level interrupt status in gpi_process_gen_err_irq() and
gpi_handle_irq(), event/channel control state transitions in the IRQ
handler and gpi_process_ch_ctrl_irq(), completion event handling
(including the no-pending-descriptor and transfer result paths) in
gpi_process_imed_data_event(), gpi_process_xfer_compl_event() and
gpi_process_events(), ring allocation details in gpi_alloc_ring(),
already-in-state checks in gpi_pause()/gpi_resume(), TRE contents in
gpi_create_i2c_tre()/gpi_create_spi_tre(), and TRE queuing in
gpi_issue_pending().

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c | 58 ++++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index b09354a73b46..8e7d25a46147 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -684,8 +684,6 @@ static int gpi_send_cmd(struct gpii *gpii, struct gchan *gchan,
 	if (IS_CHAN_CMD(gpi_cmd))
 		chid = gchan->chid;
 
-	dev_dbg(gpii->gpi_dev->dev,
-		"sending cmd: %s:%u\n", TO_GPI_CMD_STR(gpi_cmd), chid);
 	trace_gpi_send_cmd(gpii->gpi_dev->dev, chid, gpi_cmd, TO_GPI_CMD_STR(gpi_cmd));
 
 	/* send opcode and wait for completion */
@@ -797,7 +795,7 @@ static void gpi_process_gen_err_irq(struct gpii *gpii)
 	u32 irq_stts = gpi_read_reg(gpii, gpii->regs + offset);
 
 	/* clear the status */
-	dev_dbg(gpii->gpi_dev->dev, "irq_stts:0x%x\n", irq_stts);
+	trace_gpi_gen_err_irq(gpii->gpi_dev->dev, gpii_id, irq_stts);
 
 	/* Clear the register */
 	offset = GPII_n_CNTXT_GPII_IRQ_CLR_OFFS(gpii_id);
@@ -866,8 +864,6 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
 			u32 ev_state;
 			u32 ev_ch_irq;
 
-			dev_dbg(gpii->gpi_dev->dev,
-				"processing EV CTRL interrupt\n");
 			offset = GPII_n_CNTXT_SRC_EV_CH_IRQ_OFFS(gpii_id);
 			ev_ch_irq = gpi_read_reg(gpii, gpii->regs + offset);
 
@@ -887,15 +883,14 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
 				ev_state = DEFAULT_EV_CH_STATE;
 
 			gpii->ev_state = ev_state;
-			dev_dbg(gpii->gpi_dev->dev, "setting EV state to %s\n",
-				TO_GPI_EV_STATE_STR(gpii->ev_state));
+			trace_gpi_ev_ctrl_irq(gpii->gpi_dev->dev, gpii_id, ev_ch_irq,
+					      gpii->ev_state);
 			complete_all(&gpii->cmd_completion);
 			type &= ~(GPII_n_CNTXT_TYPE_IRQ_MSK_EV_CTRL);
 		}
 
 		/* channel control irq */
 		if (type & GPII_n_CNTXT_TYPE_IRQ_MSK_CH_CTRL) {
-			dev_dbg(gpii->gpi_dev->dev, "process CH CTRL interrupts\n");
 			gpi_process_ch_ctrl_irq(gpii);
 			type &= ~(GPII_n_CNTXT_TYPE_IRQ_MSK_CH_CTRL);
 		}
@@ -945,17 +940,10 @@ static void gpi_process_imed_data_event(struct gchan *gchan,
 		struct gpi_tre *gpi_tre;
 
 		spin_unlock_irqrestore(&gchan->vc.lock, flags);
-		dev_dbg(gpii->gpi_dev->dev, "event without a pending descriptor!\n");
 		gpi_ere = (struct gpi_ere *)imed_event;
-		dev_dbg(gpii->gpi_dev->dev,
-			"Event: %08x %08x %08x %08x\n",
-			gpi_ere->dword[0], gpi_ere->dword[1],
-			gpi_ere->dword[2], gpi_ere->dword[3]);
 		gpi_tre = tre;
-		dev_dbg(gpii->gpi_dev->dev,
-			"Pending TRE: %08x %08x %08x %08x\n",
-			gpi_tre->dword[0], gpi_tre->dword[1],
-			gpi_tre->dword[2], gpi_tre->dword[3]);
+		trace_gpi_ev_no_desc(gpii->gpi_dev->dev, imed_event->chid,
+				     gpi_ere->dword, gpi_tre->dword);
 		return;
 	}
 	gpi_desc = to_gpi_desc(vd);
@@ -1064,11 +1052,10 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
 		dev_err(gpii->gpi_dev->dev, "Error in Transaction\n");
 		result.result = DMA_TRANS_ABORTED;
 	} else {
-		dev_dbg(gpii->gpi_dev->dev, "Transaction Success\n");
 		result.result = DMA_TRANS_NOERROR;
 	}
 	result.residue = gpi_desc->len - compl_event->length;
-	dev_dbg(gpii->gpi_dev->dev, "Residue %d\n", result.residue);
+	trace_gpi_xfer_result(gpii->gpi_dev->dev, chid, result.result, result.residue);
 
 	dma_cookie_complete(&vd->tx);
 	dmaengine_desc_get_callback_invoke(&vd->tx, &result);
@@ -1100,11 +1087,8 @@ static void gpi_process_events(struct gpii *gpii)
 			chid = gpi_event->xfer_compl_event.chid;
 			type = gpi_event->xfer_compl_event.type;
 
-			dev_dbg(gpii->gpi_dev->dev,
-				"Event: CHID:%u, type:%x %08x %08x %08x %08x\n",
-				chid, type, gpi_event->gpi_ere.dword[0],
-				gpi_event->gpi_ere.dword[1], gpi_event->gpi_ere.dword[2],
-				gpi_event->gpi_ere.dword[3]);
+			trace_gpi_process_event(gpii->gpi_dev->dev, chid, type,
+						gpi_event->gpi_ere.dword);
 
 			switch (type) {
 			case XFER_COMPLETE_EV_TYPE:
@@ -1113,7 +1097,6 @@ static void gpi_process_events(struct gpii *gpii)
 							     &gpi_event->xfer_compl_event);
 				break;
 			case STALE_EV_TYPE:
-				dev_dbg(gpii->gpi_dev->dev, "stale event, not processing\n");
 				break;
 			case IMMEDIATE_DATA_EV_TYPE:
 				gchan = &gpii->gchan[chid];
@@ -1121,11 +1104,8 @@ static void gpi_process_events(struct gpii *gpii)
 							    &gpi_event->immediate_data_event);
 				break;
 			case QUP_NOTIF_EV_TYPE:
-				dev_dbg(gpii->gpi_dev->dev, "QUP_NOTIF_EV_TYPE\n");
 				break;
 			default:
-				dev_dbg(gpii->gpi_dev->dev,
-					"not supported event type:0x%x\n", type);
 			}
 			gpi_ring_recycle_ev_element(ev_ring);
 		}
@@ -1409,10 +1389,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
 		bit++;
 	len = 1 << bit;
 	ring->alloc_size = (len + (len - 1));
-	dev_dbg(gpii->gpi_dev->dev,
-		"#el:%u el_size:%u len:%u actual_len:%llu alloc_size:%zu\n",
-		  elements, el_size, (elements * el_size), len,
-		  ring->alloc_size);
+	trace_gpi_alloc_ring(gpii->gpi_dev->dev, elements, el_size,
+			     (elements * el_size), len, ring->alloc_size);
 
 	ring->pre_aligned = dma_alloc_coherent(gpii->gpi_dev->dev,
 					       ring->alloc_size,
@@ -1437,10 +1415,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
 	/* update to other cores */
 	smp_wmb();
 
-	dev_dbg(gpii->gpi_dev->dev,
-		"phy_pre:%pad phy_alig:%pa len:%u el_size:%u elements:%u\n",
-		&ring->dma_handle, &ring->phys_addr, ring->len,
-		ring->el_size, ring->elements);
+	trace_gpi_ring_info(gpii->gpi_dev->dev, ring->dma_handle, ring->phys_addr,
+			    ring->len, ring->el_size, ring->elements);
 
 	return 0;
 }
@@ -1542,7 +1518,7 @@ static int gpi_pause(struct dma_chan *chan)
 	 * client needs to call pause only once
 	 */
 	if (gpii->pm_state == PAUSE_STATE) {
-		dev_dbg(gpii->gpi_dev->dev, "channel is already paused\n");
+		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_state);
 		mutex_unlock(&gpii->ctrl_lock);
 		return 0;
 	}
@@ -1578,7 +1554,7 @@ static int gpi_resume(struct dma_chan *chan)
 
 	mutex_lock(&gpii->ctrl_lock);
 	if (gpii->pm_state == ACTIVE_STATE) {
-		dev_dbg(gpii->gpi_dev->dev, "channel is already active\n");
+		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_state);
 		mutex_unlock(&gpii->ctrl_lock);
 		return 0;
 	}
@@ -1703,8 +1679,7 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 	}
 
 	for (i = 0; i < tre_idx; i++)
-		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
-			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
+		trace_gpi_tre(dev, chan->chid, i, desc->tre[i].dword);
 
 	return tre_idx;
 }
@@ -1797,8 +1772,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 					 TRE_FLAGS_IEOT);
 
 	for (i = 0; i < tre_idx; i++)
-		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
-			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
+		trace_gpi_tre(dev, chan->chid, i, desc->tre[i].dword);
 
 	return tre_idx;
 }

-- 
2.34.1

