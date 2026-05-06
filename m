Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B82E48BD58
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088597; cv=none; b=FRsdIPxVJhoiSLQVUCDFX38hER0FDRzjsIJBtplyz7/EPDpn4b/Cw+iLYZYGA3sG00AJ7STOYalNqB1hSjOMW/4u3IYGKBvovVai/1xKsW1sZfYHoaMIzkw1GZ7YiXcO7W+xZSkc24IASE81u3zFSBu/63ojg77GPV17Q7Tw++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088597; c=relaxed/simple;
	bh=u3bJeT3eDVmlNrUBwxjO996p7ZSnVqK4Iw+5gr5vR20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+eAhT9msWLC7b6+y5qbgTaE5pzL9CBuiB9ezP2f1oVCKA9nfyi3MQo8nBmij57nftVj0l+F+DXSG6d57Z/xdl/mWFtNmeilO+nVsJup9rX22GSiGmNUXb6q+J4260gO9h5kY2Y3xmeAUFLipPfASHDUQ/iWe8lparKL3+YxvVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KWs6V9lH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QyvP5pcN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KWs6V9lH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QyvP5pcN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646GiahU3524220
	for <linux-trace-kernel@vger.kernel.org>; Wed, 6 May 2026 17:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NdAyBwaa85FOCAnUpY3giPygT8RfYNiQT75Hl2udw94=; b=KWs6V9lHOkExU3DT
	U9pOClt4EElte/pNh2n+5Mfwwka+aDxBJi7jKQpuan6NLHZe3z1I79AdBhGRtmrV
	p0frV6mCH0eudz3WSlVgYKIpS8IHDPQ3zguWE2DMSUhFMdPuUGbzG32o41R6cpwk
	QJm4NjpDIvgXg8+kWE27zo0IVUrSEYCEwm87GJaS5h3L3GXFwSA1/sG41zNiK0I5
	l+L1gVK3WGK1/JeuNOfrLnj/cyKAIx/Ro66aG8ogFFoseYKvne0x6p1LL7khY3MJ
	u8gYJW8eS/nNSLYC9DE7TTMv0PXAYbmWVQDBM0/MqFE74+Dwg23OZw5HW/TQ4mIF
	R5rq6A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jwsp4h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 17:29:55 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-364ef32a758so10552096a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778088595; x=1778693395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdAyBwaa85FOCAnUpY3giPygT8RfYNiQT75Hl2udw94=;
        b=QyvP5pcNNbw5GGbxRkScwo2+AlXP1bMnnQPx1UBlbWMrJ9YAhRbPnZa6l3v9oHO88m
         yZssT+w9tiL5ABmToLqFZbymlk0XDMf98nZOucxo7G6hnbW5HIYzMNQwV2KxTBOKf6t0
         2ZjXypymMwe4HDE6hq0jK0er5737osxOGyefjMbHrdzZmk+Rg1drwBQ/W+RklyCOjIye
         RNa4qNe9bqpT4CCl5TKS0gIxyWLkOItJI091joUtQBep50bj9ots8MG6AFKA+Fzke50O
         DjYpOamaMbBFU9lM3dun6Bs6kdxXwr0IhqQqb56jksB6ZGuDNBZI4chZE5DxViUyvIGg
         rdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088595; x=1778693395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NdAyBwaa85FOCAnUpY3giPygT8RfYNiQT75Hl2udw94=;
        b=kcn2F8+UyAbGQ07Vtx35XQ/kewjBonFVdR9gha8xPbhvLXyavzA9odiY3x/yH1GlUr
         Z+6AsIEevGREsfobuKPh1NhotIWMqMMIBNF4/Bm6X4586vVMDyPY/7sc1gRHLHf9uTM8
         jE3MNMh43zd6aPQL8XqzU6xkkiwRXr8w0oq7x9npusRZ35tN8jD5BDS8xv5kD0yftXqG
         bpwbMHC1XsvgdopBXiFIwv0VzUdE9LVwBzYPBvzt3cdyI0P70AkbEk2KcrA0r8goCYJB
         qvP3YCAI2IIWrSIiY2z25XjEfViV74+RTA2AccWnbq3fCKTtfR6GtY19X+q0YV41T0jx
         LHoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/l2ZqbLG9O56DyCOsTWpjrmM+9rMnwZVZVVIli7ahF/LbMdai1tleWURiLZBKQ4lPUBvWJMH9MKBTxub5EqF/z6Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxnvbaR31WbUmw74mBG6vdDaPp6660lVvvA7d5Y8g3mFD83QR
	nSdSnKODizzAQSLPQ57jC3OYZNnTeioOhg014Ii74hrbn2OKtu71GXASRTdR0L5kHIqVUTQ2YvC
	WX65qzrFmFQRUaYPhevt7UFcQIEVJkGOVyuXtzEf1ppNNWEpYxxQKzfyrDMBwKZsOu8/SR+wWYH
	w=
X-Gm-Gg: AeBDietRMnPsrpHBYJ4IDnatmkY+iZDysi+W9cFpsVOn559mKGAGHOqD1EFZPRG8qWf
	fLArHDsw1JwO97JJRCZv9IdVpkdOf5SEINRT8z8r2n32PFDsyLWMZ6dTiUo8tzEtG0N45qmtv2N
	HxI8WUXJBYy46bCtR0Y0OLGALuNYIJr2W2SnfP98fn6q+p1q+Pk8Oc3cSJ7mbU6bHL+lF2yBZUc
	iFpIBLEGnilLpHwjp3VmJABg5aDo26cIuKrJuY3V/1N8B4BX/jRBMpCkp97kGUG9UT9IlSb97r0
	MBXu9JRtCUm4KJF9frK4dSagfluF4ASItoQ/pm4Afw5cEYeCHPPllUGIBET9m+ayhPvPkpA9zXK
	gKFccA+1hpZFHGbgf8GpLG0wSL5AK+X44DdzmNSeXlArkUNmWnLIDbzGEMGea2tnNfg==
X-Received: by 2002:a17:90b:5683:b0:361:45df:f5 with SMTP id 98e67ed59e1d1-365abe8a5b2mr4800233a91.16.1778088595138;
        Wed, 06 May 2026 10:29:55 -0700 (PDT)
X-Received: by 2002:a17:90b:5683:b0:361:45df:f5 with SMTP id 98e67ed59e1d1-365abe8a5b2mr4800196a91.16.1778088594566;
        Wed, 06 May 2026 10:29:54 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365c25f8cf9sm3370143a91.4.2026.05.06.10.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:29:53 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 06 May 2026 22:59:42 +0530
Subject: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-add-tracepoints-for-qcom-geni-spi-v1-1-c957cfe712d1@oss.qualcomm.com>
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
In-Reply-To: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        "Mukesh Kumar Savaliya mukesh.savaliya"@oss.qualcomm.com,
        "Aniket Randive aniket.randive"@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778088585; l=5434;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=u3bJeT3eDVmlNrUBwxjO996p7ZSnVqK4Iw+5gr5vR20=;
 b=di6BH35HrTFhQUZWuiJyNXlNW/guEVk92mbrMTwu+l0/jOJy2pM9BkL55nWXQGJWNvd4Im9Vg
 A+wduBf3ZftAhxC7CRwNeG6TNY+7P3LOVd1dZf+6LkkpAZPg5mJi0u3
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=J4CaKgnS c=1 sm=1 tr=0 ts=69fb7a93 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=T3KqLDxVtFGtYd1-cMQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3MCBTYWx0ZWRfXzZaFXLIbzS58
 wyAL4y8vPZGop8/Y3gUOc72pDG+nzlVPz0MSTpdKCqhHOHz1qn319EXG0i0NNhtuoaBKA8jawhD
 qa1HB6bzCL7eQTxLOtvDYpRzCa9X7G7EOFEp7NGkHi49+PlBviQvqw6Pa/+w1PfWX2NtSGIB+Kv
 9XZPtQkH0Zl8pmH60wrW5oeaMo4HnujuJes+UFEkg90aKGtb4hWUZIjqZiWR0VNFKzEvhzojyna
 TvjMiIwn9jrtLOmVnkA+XOeUmspY1hw+OWHNlzDA392hXkDsU6OL54uytW4GZHqcX1hZUUwdQeJ
 KpTOpqFAqW5u1BZcJt/ig5Y3tbCQbaOZ/NM/XaSmb8MGj/qJNb2wZAwSvSt9vMtacW9uYks5UkL
 zUAQTJmRRJ5aGyjq3EgdIUjuy4ARvX/QRODfqZlGUJXdIzxIbBEJwcS0WLqnGpHjwlvG+jZW+xW
 yf0wPXgPQcWHDNSgMqQ==
X-Proofpoint-GUID: IKbz810mBMP91syETaXjFydZkKXWpEdG
X-Proofpoint-ORIG-GUID: IKbz810mBMP91syETaXjFydZkKXWpEdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060170

Add tracepoint support to the Qualcomm GENI SPI driver to provide
runtime visibility into driver behavior without requiring invasive debug
patches.

The trace events cover clock and FIFO parameter configuration,
transfer metadata, interrupt status, and optional TX/RX payload dumps
to be making it easier to diagnose communication issues in the field..

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 include/trace/events/qcom_geni_spi.h | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/include/trace/events/qcom_geni_spi.h b/include/trace/events/qcom_geni_spi.h
new file mode 100644
index 000000000000..a2e6ff9df520
--- /dev/null
+++ b/include/trace/events/qcom_geni_spi.h
@@ -0,0 +1,147 @@
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
+TRACE_EVENT(geni_spi_tx_data,
+	    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len,
+		     unsigned int tx_rem),
+	    TP_ARGS(dev, buf, len, tx_rem),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, len)
+			     __field(unsigned int, tx_rem)
+			     __dynamic_array(u8, data, len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->len = len;
+			   __entry->tx_rem = tx_rem;
+			   memcpy(__get_dynamic_array(data), buf, len);
+	    ),
+
+	    TP_printk("%s: tx_len=%u tx_rem=%u data=%s",
+		      __get_str(name), __entry->len, __entry->tx_rem,
+		      __print_hex(__get_dynamic_array(data), __entry->len))
+);
+
+TRACE_EVENT(geni_spi_rx_data,
+	    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len,
+		     unsigned int rx_rem),
+	    TP_ARGS(dev, buf, len, rx_rem),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, len)
+			     __field(unsigned int, rx_rem)
+			     __dynamic_array(u8, data, len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->len = len;
+			   __entry->rx_rem = rx_rem;
+			   memcpy(__get_dynamic_array(data), buf, len);
+	    ),
+
+	    TP_printk("%s: rx_len=%u rx_rem=%u data=%s",
+		      __get_str(name), __entry->len, __entry->rx_rem,
+		      __print_hex(__get_dynamic_array(data), __entry->len))
+);
+
+#endif /* _TRACE_QCOM_GENI_SPI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

