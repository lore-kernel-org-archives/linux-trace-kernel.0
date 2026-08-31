Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5F4503EC
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194218; cv=none; b=MpCBnxihm9+tbU/sdhS71adcisl+5IRGn6F2PzMdHFk6tSLRmpY78CkYPfFotJ6CwBd36TKPiaog/rJRK4Pgl88RvAOTCHmOK2+6/F3IN4KfwcMrV626RaoRpXcUotz3LZOitgKdSfZLJEuNrDoC1IFn6B9a6wegPC7xCFn9isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194218; c=relaxed/simple;
	bh=UEdUJRDY9H4+0GuHwhSoACVAk/wqqFOFObA+tTHfnnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRE16TmO1OMVsnM3ayyCyZvQ5DVv0R1AtG9KkSMAmPxOZMLt+LERm7qw+d8X5eEmBz431Kn+T2f3zwlJvX4KyQYSSnnZzzYO/d7yKRctUlxwvJlzkua0oWNH8Jc8LyvfMb0ASfLApCzhKkimgdBvM+4t0O0rGV1AMfXMKJy1M+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZqvZD+ib; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b3cWk4b3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZqvZD+ib";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b3cWk4b3"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VFqDiG4079238
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8nCufShizWqApSyu/hCbdpwpYCeP+qWNQHyYW/PYcyY=; b=ZqvZD+ibiZL1Mwzv
	0BBiOrBcpozQbzr95Z11H8sCwGPh/47Hho2r1SiHW8pv0Io3q+MW7fUBCi0ZE7NK
	25L9R3SRGkAGfGZ+j613KtswBhfczRLZeWZyh41gDRP2knP5GAzQR0Lgx6yvfb2X
	4MublWHApoVd5dzv+flJeRPZ+P4bHMysj/yyq1vqVFeZ4wHsH2IG5tTmPVE7l4EG
	+4Mme8nkX2ilDW3KIS7DvbsLSmE2PNn+YX4QTxYj5++B4RhCXLVjqglycIVWxrgR
	x/bN0UKJBRK7tfHDPQiraAsAUfwmwqonawClOFhj8qkQYNpRTNkyG+b1S24Hcb1A
	I7NlmQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb9x5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:36:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so719000a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788194215; x=1788799015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8nCufShizWqApSyu/hCbdpwpYCeP+qWNQHyYW/PYcyY=;
        b=b3cWk4b3DQPOIh1oLNwnjkeGuMUkVH+ow71Rze7b7qpaP595i1j95ry2TWL7O7+bk5
         RYIFTbcPkPCy6prbBRNG3uS1My/6Ng5521h0vu7RFqi+D6DL9hoXfKBAwb6wq4ZCP/g8
         WnZg5Cym15hRgq0lYyrYLtn/UgPAVEEfXCe7uMvqHD0s1ykPxOUkW/Sz0a+E7SIKEHk9
         mCxGDJM9BZjE8jMfSrrxDwZBCGgzxQ1N11grT1iix5hcscePS7fhFHTXDIguadBFpNDh
         UL955Huu0/5x8L7E3H+0PmSzwcTpgnZcKm38kVynCHtc1Qx6RvjetM0W5ume6WePnF/a
         UlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194215; x=1788799015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8nCufShizWqApSyu/hCbdpwpYCeP+qWNQHyYW/PYcyY=;
        b=WPozGwG+c5+NSvg7FW/117qdd8bIKUyqbaD6iOy+iwJ89Cr2G+o8v9xkZPmAnF8vg2
         aRcwlA4PNXrvbJLnj0QdzkgyXI9YaZVc0oTpPo/iWMBIpZnVlIbWkP+bb99xOKdDE1RV
         bVX5bQNQ6s7nE5ctjFe2BbSwXqfvrK2B0T11IsFWyb9r4ySfLU2qblON99xN41R8eMG7
         DT2DuLnzEeHFGbI4PMeqqAUZx3ZtFNAcT4tpU5ls2tPO6FUoLN5BjaN9siRoYAMAU1qI
         5FU+WyKgDIrvW2tZFZESPF77EtP8RU1qvm+KfzsUQ7KJfQEQp7k8b6dvT7kmhlbpe/6N
         kdcA==
X-Forwarded-Encrypted: i=1; AKwUvBzviOruQSx/d5FDeCMZVC/2aqpY+bkwZXo9DabUGcoqc53CXqn6OOxqFyLnDHiSqx584aHiGi0kLrGBfM2WZyKFylk=@vger.kernel.org
X-Gm-Message-State: AFuF++k7s/TUWDtJ4NAkgQHyyu5JoawdaBvW3ECSh9aw11MdG4YH/XOT
	ntIn6APh2LsHvtlC69oYFegHPD3VymDmNMCAHTB0SOGiEQogYLnNnl7744IQmUTNr1quTWUcYKX
	+Ftlt/fYzO6bG/G+gb6U+dcGgs72iIGk71tJJLMKU9ER8BM30CSQxv5fiR6fUwHPMJEUN45AO9K
	E=
X-Gm-Gg: AYBFou2RnpXivR1VA0WRLe9GgdiUL6HvJPeIHvxxQvvWwQY6DML/qEwhfc0IHWdqQzB
	VC9RE8Jd0vs5S0nEBMvaBsgRq00kszCl5E8r2tWoZOqbmWgk2cc5y2I8KV32tnOi937opymp0+Q
	bOxRKYYcJo4067i4KFtiLie+X90YP0BmIgJGoAy5rJjWjIfh7/bqZuKYg5MAs/JJYNNEBCI4mD9
	wvcnVG4pLZymkOCF+jVSInlZsqjqHNFIinnE8NcBCQdhOY+rRW+UBHIVjYegf9Pj23uR8i53dg2
	u0qWdpTXuN94ZCnaqMlXc2+gyUKSLB5M0l6Gd1g6VsFZXhUYmnpTvEPbEVaQAjZxx6oqn85CqUy
	nSnCw2z6ZY/xe3qM4xtv2uhl8IRizn1eG2g==
X-Received: by 2002:a17:90b:48d1:b0:398:9bd4:d13 with SMTP id 98e67ed59e1d1-39907e4aeb2mr2834609a91.18.1788194214668;
        Mon, 31 Aug 2026 09:36:54 -0700 (PDT)
X-Received: by 2002:a17:90b:48d1:b0:398:9bd4:d13 with SMTP id 98e67ed59e1d1-39907e4aeb2mr2834531a91.18.1788194214064;
        Mon, 31 Aug 2026 09:36:54 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75fc49sm271260a91.12.2026.08.31.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:36:53 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 22:06:35 +0530
Subject: [PATCH 1/3] dmaengine: qcom: gpi: trace: Add trace events header
 for Qualcomm GPI DMA
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-add-trace-support-gpio-v1-1-7b0fd0d0ddb3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788194205; l=10756;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=UEdUJRDY9H4+0GuHwhSoACVAk/wqqFOFObA+tTHfnnw=;
 b=cQ9JLNes62buicXZqKs24pgKFdpQDInc4Cwuc8OXaJ13HNuF34aLzE+z76E1vGnaDIqC4lOv2
 rzhamwhLO0bDzNTOrMwHY2Zzfe9kibB2H7nZ80+VKUsmDdmMkMh0WmV
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: DzZPTI4KjMh_JPHfXCMzEkBbT6vNH3yu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfX3d4qm1jIT3zh
 QZFUdtS0kmP16YLoQikf9GN99pDK/DN7A0/WrdCPJ9Uti+hongR7ldWgWFpThok7Eo0f1XZyojL
 rtSBNOHSnhsylRb6j925/5MTwIYCGSJmCSp7cfOQXNDZKhVNOLBPTugLB6oRGOkbUbDVqIi09vU
 e1sPJtp+eK4WTQveKU+hgIVhInIuOX1R/7/S7wilJl4G7k5zFQap5dlSFA5tZjLYu73sypVGBiJ
 pvIt2aCFG+zPZbZwLq5cq/T/HfF1/TsZNsrnmds9YHgCs+FunBdLF0k5m9lVpFM2ci1v/vBKt8p
 Gqmxs+rxnoZttcX2kYHQMCDGAuz7+pyt4H3gdVasAqYpuYEfXu9qZSmGN6W8knSEUb7E6eyffb3
 P8FLNgEjMK1u/d4AJVLab+U5EI/H19z8LdMzFyL7CPNsrVr3besvPK4lJ7+uZTtzt6JwuaPbK0W
 8f1HpJ66YGLnw+ngWUQ==
X-Proofpoint-GUID: DzZPTI4KjMh_JPHfXCMzEkBbT6vNH3yu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfXzyWLjDbiNk4p
 XdmpU/Qj6eBJLLjqyQNI1etZWAhO1SvZxuHSzRaOl0J/TVVHrTVvJc32DK99Ub+uy8vXh3tfWXb
 NOAJqNl6+Dz03DC81OBvzwUMXC22VZY=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a95ada7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=E82JpRapckMa8tCxcIoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310143

Add a tracepoint header for the Qualcomm GPI DMA engine driver.

The events defined here cover channel/event command dispatch, IRQ
type handling, channel/event control state transitions, error IRQ
status, completion event processing (including the no-pending-
descriptor and transfer result paths), per-event processing in the
event ring, ring allocation/programming details, already-in-state
checks for pause/resume, and TRE queuing and contents. Together they
give full runtime visibility into GPI DMA behavior in place of the
driver's former dev_dbg() based debug logging.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 include/trace/events/qcom_gpi.h | 313 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 313 insertions(+)

diff --git a/include/trace/events/qcom_gpi.h b/include/trace/events/qcom_gpi.h
new file mode 100644
index 000000000000..5474e762f4b6
--- /dev/null
+++ b/include/trace/events/qcom_gpi.h
@@ -0,0 +1,313 @@
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
+			     __field(u8, code)
+			     __field(u16, status)
+			     __field(u32, length)
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
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 ev_ch_irq, u32 ev_state),
+	    TP_ARGS(dev, gpii_id, ev_ch_irq, ev_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, ev_ch_irq)
+			     __field(u32, ev_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->ev_ch_irq = ev_ch_irq;
+			   __entry->ev_state = ev_state;
+	    ),
+
+	    TP_printk("%s: gpii=%u ev_ch_irq=0x%08x ev_state=%u",
+		      __get_str(name), __entry->gpii_id, __entry->ev_ch_irq,
+		      __entry->ev_state)
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
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, elements)
+			     __field(u32, el_size)
+			     __field(u32, req_len)
+			     __field(u64, len)
+			     __field(size_t, alloc_size)
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
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u64, dma_handle)
+			     __field(u64, phys_addr)
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
+#include <trace/define_trace.h>

-- 
2.34.1

