Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C58336885
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566414; cv=none; b=aS5inuGSrZ+HbPZDXOuK9LIbbRTic7X4X5JL+8eYDwBpaT7zoZLl5PTXFymn4e3SLRaBPuAdDlpL5v7iwFcXjPaWWUa9WkBcIb64N+8q4tlfDkGqQ1OAF8TlX9mzDm09bhnMlAoBymufa0wEzP+l4iGsgXUBbh3bc3K8KjtcAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566414; c=relaxed/simple;
	bh=nhlgkVfDWgn+TRcBARa7NMZ79rHyudShi2Dvyt2IBC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6W77xUebcsjrMlrTHL8hT0VHyF3bXtZA7vsWvZGro1QxsEMf8Afvwfj3W3tTpodxrif3R46qw+5+EBbLNcrTga6mT7l6f96JaWupWtJ4rKsCdkktgqdMO8u83ZZAaR3uyUOdNYnw7DUd97AqJ488a82hqlOWCD3DlN+atR5Smg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7e8O3pt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PBxZAsME; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7e8O3pt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PBxZAsME"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5cRmg2202230
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wVKsegk5yrtLSMKIfMnOH6O9mKt5aoYLnvSKHe6uEls=; b=H7e8O3ptyCiRYvnz
	CHWpfvPUSZi4MbtHWTJRZ2OTdMgTLwIuyn4gNLtGGwsdK0wkX1eJ85HKURz8o2Lk
	K/+q55vCdZB0yTR0T7RXfbQcn3SJChxmTuS7zL1AuUByAc8CvmLEWQCf9AJdu3V8
	8I9kxpQ5y646P3xydkOdMi0dG29H0kdaAIi+V7ynfCJjc1soMtQe7hDi9VB7Y5s6
	JV7Ag3O6jyo+/yMByzWm8cHbjzOo+82kDNy66aTZ3CJBGSoYfwFmGnU7HCK/VgSX
	tTG3Y6iLARQFivAkpyGHTO8x7FJh6x6T6E35+efp5c40aTCYW57wudV/4NMjVJ9+
	ilFAkQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuyhqb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36629e48023so5653950a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 23:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778566402; x=1779171202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVKsegk5yrtLSMKIfMnOH6O9mKt5aoYLnvSKHe6uEls=;
        b=PBxZAsME2TdfefAVv57aNMOOOgQDfXo54v3PtG73h866yERZgxInHrd9XJLSlQc45k
         VT1pi3oAYOLAznRP01oajlK52Zil5mbXRA2fXEcbQ+WcpY2eNxE/DKljXfLjB4Pka2Vk
         rDR3X0WJcNW21K0xXAxdVOfOljTZEZIekIvVVnfJ9IqrVqb7vv25iOic1N3IWS4CIrGf
         AK+VQJLpx6tN+Q0+xrwFcWY8Rc0iQVq3SwYpU84i4G8BNTnd84gUGIPyt9nKFF00BaiY
         hfdQr+evhBzX4Zjg2ndT3bJjybP542wSbktPmq10wdaU3b2tAqM/paVqi2uYpT9xq9Mn
         ApKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566402; x=1779171202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wVKsegk5yrtLSMKIfMnOH6O9mKt5aoYLnvSKHe6uEls=;
        b=gy8mObdKm+kb/SZktQSOk/XvrrFw2hjtveRyGzkHD3VOUtJxw4yDe3ch1hX3nbwR5k
         5QyZl1P2P8b6FkM69imUytXBjYm892V4hhj+79HGWR6pDxAKoEYO0fiKrkmjSwvRjQX/
         Ke8+wXOtP7M7HDjli0ErDOifitjfCB3RlNwtMDR+FaN3jN3xDAxJQ9yIRENQUc8eqmFb
         lnJaCKCFneGWagwFFv1nK3GnhFX+VSMvKQXTRqWlm0rkQFjeWjBdH6jvCjNqR1x4hTPd
         87MSc3baK+OQOj0+Gp4MiEjYCuNy/EP7x5e9SUPVw3Hg8a2NnJjFin60vk29CeyyDDBZ
         qJXA==
X-Forwarded-Encrypted: i=1; AFNElJ+o3RwecGht1tgjb2ItOgOG2TYX8bHt2LXetF+Cx1YV9O5lpLBpTOR8BTKhoZDGWUpT0GkCD2X8VNmla78pXOnukzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLTk9+soEUlHR/fcNLFfGWMwH+ILhArGq7hnuy6Hj5HRTkvGBO
	zHrEw30tasK43n0SWC47q/y4ogEb0lebZuj088zUJ7zghC2IfJFp2CdZR+TtHx2t0M/IbbdvdE8
	NI4lqWC/yvsQmCBGXpdzUYQSXxx80IuBleMKUf5i8+0NokL/Rdy/mQaVF64XjrLV+q+ybA/50s7
	0=
X-Gm-Gg: Acq92OERk2nGI1wmyuyUV+tJMUkGwSVGkuhoQfZodIPWs8XiIq2SOBmlT9BR9tCVTlk
	V6mMjQV4+o/v/lJPoFnqWLUEVNK4eEl71EJQcSyEM/yGpo3IJwlzeFHjPRSCPSyE+NkYb9PBglr
	3dAMClYA8Sbie57S0NN3K7UZbv1ye2Yc9gG+8ucBndJr+/ht4IIr0jSAUVwCRWt3ecbd8ReTmhn
	tF0O/Tpi+2FOXHX6ZPg0i7Ulq7ESbHKg5FYrGh32vfYR7sxDwApVR38lw45pImoPi0zXxbwky3+
	jrhnM+2NT21Jy8xs81HG06z/RaUk0F1LwDAkyVWRlrTVSYfljdnF9lz4vmwEw8IYvQigpqSpi4o
	fI/oKWw1zBavA1RszSH3jcV3pbbL48+zUuWsS5lMu4uKkZdrBISo0mfs=
X-Received: by 2002:a17:90a:38c5:b0:367:c442:3f24 with SMTP id 98e67ed59e1d1-367c442412fmr8907708a91.19.1778566402262;
        Mon, 11 May 2026 23:13:22 -0700 (PDT)
X-Received: by 2002:a17:90a:38c5:b0:367:c442:3f24 with SMTP id 98e67ed59e1d1-367c442412fmr8907668a91.19.1778566401523;
        Mon, 11 May 2026 23:13:21 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b00d2131sm842518a91.1.2026.05.11.23.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:13:21 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:42:52 +0530
Subject: [PATCH v2 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
References: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566392; l=4051;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=nhlgkVfDWgn+TRcBARa7NMZ79rHyudShi2Dvyt2IBC8=;
 b=I3gkvz/NlpoT0yJ+STIDXSejHUNnROwikLsZy6Lbj+6h+xssUg9KupkfdlUmyGUc9Dq0HFrAT
 pyVvYnkdu7CA83BdwtT78TLjGAEYppDcULnJASYHAZm5txpikDA0dVL
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1OCBTYWx0ZWRfX9LUIr+DhlELs
 vJzx62Cq/JSAxXugEtDcSvD8EJwiCqfmmY/yX4wNAUtPb9x6SHILqhGW8ISPolEE6+Z2MWWeTwi
 T7LGPg3H2j64k4u6mb3zLWtwC1Vc5BaXvyQDPYU3h8i2UwyfeCDzZR+1VKaSeC893K533ppx87y
 oxvOX12jdAjLd7+dDRMyHGrSyid+3UQdb/JtinskIh4dPEUTUjIqcNaJqK7FnhuU1F5PRDuy3j8
 tBTsEfAgV6C6Xc1Tbvw1gbV/QiZb+Ykf27B7ze1dsziwjYEUYn8Y9nQItANsSAkHAgJhCzGWZlJ
 VMEriXjFYCIGuCeLcyxI4Hwa5PjR2fupwyHtxkcqbQo9nAEGNaqTJ2Y9mu4Z1z6bPjFzBEU7P9t
 /T4B0dBelLXjWsq2VvI6HhnwwgFkPZliGdpImFKP1ofMyXqV82IMWXAeBHCkOpfOwdrv80ot+ij
 /ZVNA/jy6kRjsQi1WQg==
X-Proofpoint-GUID: UvKdzGVaz277y65LnUH8EjWtNHrd7tAu
X-Proofpoint-ORIG-GUID: UvKdzGVaz277y65LnUH8EjWtNHrd7tAu
X-Authority-Analysis: v=2.4 cv=Y5XIdBeN c=1 sm=1 tr=0 ts=6a02c503 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=uI40SpaImk96dJ2R2O8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120058

Add tracepoint support to the Qualcomm GENI SPI driver to provide
runtime visibility into driver behavior without requiring invasive debug
patches.

The trace events cover clock and FIFO parameter configuration,
transfer metadata, interrupt status to be making it easier to diagnose
communication issues in the field..

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v1->v2:
- Removed TX/RX data tracepoints.
- Updated commit text.
---
 include/trace/events/qcom_geni_spi.h | 103 +++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/trace/events/qcom_geni_spi.h b/include/trace/events/qcom_geni_spi.h
new file mode 100644
index 000000000000..5f39dab47e4e
--- /dev/null
+++ b/include/trace/events/qcom_geni_spi.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_geni_spi
+
+#if !defined(_TRACE_QCOM_GENI_SPI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GENI_SPI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(geni_spi_fifo_params,
+	    TP_PROTO(struct device *dev, u8 cs, u32 mode,
+		     u32 mode_changed, bool cs_changed),
+	    TP_ARGS(dev, cs, mode, mode_changed, cs_changed),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u8, cs)
+			     __field(u32, mode)
+			     __field(u32, mode_changed)
+			     __field(bool, cs_changed)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->cs = cs;
+			   __entry->mode = mode;
+			   __entry->mode_changed = mode_changed;
+			   __entry->cs_changed = cs_changed;
+	    ),
+
+	    TP_printk("%s: cs=%u mode=0x%08x mode_changed=0x%08x cs_changed=%d",
+		      __get_str(name), __entry->cs, __entry->mode,
+		      __entry->mode_changed, __entry->cs_changed)
+);
+
+TRACE_EVENT(geni_spi_clk_cfg,
+	    TP_PROTO(struct device *dev, unsigned long req_hz,
+		     unsigned long sclk_hz, unsigned int clk_idx,
+		     unsigned int clk_div, unsigned int bpw),
+	    TP_ARGS(dev, req_hz, sclk_hz, clk_idx, clk_div, bpw),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned long, req_hz)
+			     __field(unsigned long, sclk_hz)
+			     __field(unsigned int, clk_idx)
+			     __field(unsigned int, clk_div)
+			     __field(unsigned int, bpw)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->req_hz = req_hz;
+			   __entry->sclk_hz = sclk_hz;
+			   __entry->clk_idx = clk_idx;
+			   __entry->clk_div = clk_div;
+			   __entry->bpw = bpw;
+	    ),
+
+	    TP_printk("%s: req_hz=%lu sclk_hz=%lu clk_idx=%u clk_div=%u bpw=%u",
+		      __get_str(name), __entry->req_hz, __entry->sclk_hz,
+		      __entry->clk_idx, __entry->clk_div, __entry->bpw)
+);
+
+TRACE_EVENT(geni_spi_transfer,
+	    TP_PROTO(struct device *dev, unsigned int len, u32 m_cmd),
+	    TP_ARGS(dev, len, m_cmd),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, len)
+			     __field(u32, m_cmd)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->len = len;
+			   __entry->m_cmd = m_cmd;
+	    ),
+
+	    TP_printk("%s: len=%u m_cmd=0x%08x",
+		      __get_str(name), __entry->len, __entry->m_cmd)
+);
+
+TRACE_EVENT(geni_spi_irq,
+	    TP_PROTO(struct device *dev, u32 m_irq, u32 dma_tx, u32 dma_rx),
+	    TP_ARGS(dev, m_irq, dma_tx, dma_rx),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, m_irq)
+			     __field(u32, dma_tx)
+			     __field(u32, dma_rx)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->m_irq = m_irq;
+			   __entry->dma_tx = dma_tx;
+			   __entry->dma_rx = dma_rx;
+	    ),
+
+	    TP_printk("%s: m_irq=0x%08x dma_tx=0x%08x dma_rx=0x%08x",
+		      __get_str(name), __entry->m_irq, __entry->dma_tx,
+		      __entry->dma_rx)
+);
+
+#endif /* _TRACE_QCOM_GENI_SPI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

