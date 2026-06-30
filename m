Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DE273D9F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799392; cv=none; b=D7RLuXeCCuxjVtXBA37AxxZiS/zy2seSmYalOf5lJzH7Hy3Uo3BZtO2tLMze+bTmAg36w9axS3tDHCUP025ck3i7UJ0nMM1wx21s9s3d8b4hfLfb0tjFltXTZ8WWtNWjAAQKeucssd5hM6X/C7WKXCzdk3NYW8GaU8RCwEtpF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799392; c=relaxed/simple;
	bh=SsMm0ZABx5wKE0RNJoBN1GlttY4OwMPyyO9ucW7m4lI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3Jz3OVc3j7NU8HQzyLyeRGuiVzBI05cNciU04CFaD26vNrnoraFH32Z9FD515keACAhbz/OcK5YWbTkHAx2bgzmBgSgyzfq2Kg1HHMlhJsuRbG4ePsFN6HGOdZPmhCX6Y4TJ9Qm/evFTFZ3bOYV2jq0JWGXbbrFHiWOSKTva8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=np7Fny/j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cJORygiw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="np7Fny/j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cJORygiw"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5cGhr1019374
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p5DD/knY0r+8MsNJLC7rflq2rFmViC8t0JP5VSOYGek=; b=np7Fny/jj7gf6WjX
	5jsYU65AC0aU+sLWv0T2YLHgusD6x/kq+xLsiSpvxhAaVta4fn2Pv1BPJYazYwzF
	2gYsYUCxlq6vYQqocebC2OL9ItrzQtaNtFT6wS/9KDKjGTsRGF5rQbAfUeHj2bBK
	OrSgbryQQw421L4WuD/2CnOjuYYsqY1hc1zsYxpTZAzR6rpHrKXRgwr7CNfTYHLR
	7xqC7rE4n7QD4i9C+jYZibXq9S1o7BmJJGKml92dzoOaTKauBJ2mHFOlT2Doj+pu
	zfK+Pd7awNkkSfhXlFP84bGsksQEXN33QNBFqBfE9xN4L0SURAtz/SMqwTVvGI6A
	8ZYMuw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f441grujt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845df469a26so3955154b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782799389; x=1783404189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5DD/knY0r+8MsNJLC7rflq2rFmViC8t0JP5VSOYGek=;
        b=cJORygiwKqMEc/rqoRgNfApKFhsH906Z6AJKZID07oPq+ot24TwZincP1WYE3a033d
         /ZTiA6eGM/vYTNifALIyNobQatlOZyzxKr2FDQTNcrMlEJEww46e0LuLdrPjVI9JOp6D
         DbliSaCmYuQ+t0sqvs8DooIv/BsBhr3ZqcIXAWw9atdOTKgjyvL8u6H4A+3JZ+VJm7Ox
         GRZ+tGQSynvh0XoGza8HrGsQVHPdetDabogS8g1kKwhgGVe8rN9s0NaYUTv1hRVd+GLR
         S9982TL/Y7aS68MWfVOquJIakUJHSrlOZZlMNKM21C6fcKqvugsdM4xcJiopDX96zRU4
         IASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782799389; x=1783404189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p5DD/knY0r+8MsNJLC7rflq2rFmViC8t0JP5VSOYGek=;
        b=KGrx9uxAg5PEKzw3lNT91bjzXkdxNi+S2siSiTaXuvs4qCvbhvGsyubj6kiiCyGD6B
         iIvS7muSSAjZ0JlBcwpGJqEVXzF8EgBVKbqUjldcFTGJ6T9FUYB/HDmrVRoX/K4szFsN
         x2HOdL5erm/J4m0t2lPSvY0SOVzcV96E92TLEzflKy4wMyjOv5Lt1V4KSghxWUi4Q2Q+
         DaKdyg2AxnaZeMcyG6tA9xXH2poCodaTqUEDabHHB3ga5LjQJ3gGerba3F9to7mblx/a
         bjcodkuAKPXYUZEMK5aNVo/aRpcVwN6ZUnrY6gA5Uvd0wolnUPESVceB6tBh8nSP3Zdc
         7LLw==
X-Forwarded-Encrypted: i=1; AHgh+RoxLZb9eAxjrwcUvZRK5/KKzfl8ebsiZ3cCiuDd4VWTx68k1hy8w8XNbQHLcI1cz+FN8d6BlAfQDlN7lnHDZk1zNB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUo8AnFfQC6vYn/vVTyubqfBYnoN/VzbjYwsRbVizucoWtW3Qm
	7YJE5T2kspJCB3/ZSagiZrxUIpS/F+Rf6wZSOwLawNp/eCK2L5DbMfZ63HtLUF8hiCjHRLBMQ9Y
	mGLeMmBCy/7cL+YkHTIMV7DzhlING37ze59Oj1Lw5UjlcE9S+jJ4rpFbJZ4aWJubd3R9a5bQNq+
	M=
X-Gm-Gg: AfdE7cm80qVR5pc8/dVSkIraA9ozHcy1MZMt6xe0de7jN/GRq5vwAEcnTzT+1tnALO5
	XQbqbcOhA7H3NhejsqVN3nH/EENQkoXLoykBgQVp3UHxCdm4+qUtEB6mvMTB7K77McV2bUXDux8
	7sL5o9upD7hPoFBw93Z1Rg5sPk3sUbXIPwCI824y1PnAE2uE0bKbT8Thw0rZP0+XQXlcQoK/bSQ
	r0e79qlxiUl5XdnmTZLY1ZnDRosQVj916NDyl0oq1fStNVy9/ElwJK7Wwu9B0YyXYILAvepx071
	/jemseXiARcNrOt616LZlSAyl1FrPsjo5IOvbjTfCTvWz2YBz+UTdUwSebWbDr6fixEFT3j98Y4
	BFOH6AZJ8CleB4uZOTWN4WFqylelY0QCOxaSsFcGNBbGO
X-Received: by 2002:a05:6a00:288e:b0:845:e08c:a4eb with SMTP id d2e1a72fcca58-8479f2c573bmr1799863b3a.58.1782799389462;
        Mon, 29 Jun 2026 23:03:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:288e:b0:845:e08c:a4eb with SMTP id d2e1a72fcca58-8479f2c573bmr1799817b3a.58.1782799388686;
        Mon, 29 Jun 2026 23:03:08 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a00029d3sm1112600b3a.20.2026.06.29.23.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:03:08 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 11:32:45 +0530
Subject: [PATCH 1/2] i2c: qcom-geni: trace: Add trace events for Qualcomm
 GENI I2C
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-1-474cd6cdbe27@oss.qualcomm.com>
References: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
In-Reply-To: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782799380; l=3195;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=SsMm0ZABx5wKE0RNJoBN1GlttY4OwMPyyO9ucW7m4lI=;
 b=UnmM8bgAUs7lt0XO04uWA1E17SiL3u9696UGM2pYGrmhR5SjAF9Bgh3i4OfnBZe9+/FU0eehU
 89iyhkqvsLiBQD+X7VvpZJMNy8WWrIM3LM2YL426fd54RveI0K2JUSR
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfX+ralmIK0Ieai
 pCs6zxCYc3QnlBXKz9Kkuq8cSjlt06LdOQAqoFTB8XxiBUJKLe84gkM3q88f2Ne2rHbV3xVaBnd
 IfYSn74XXVZxH3m7PMEPABfi+IVKLQY=
X-Proofpoint-ORIG-GUID: Jsjk3X32OMQRy0wSTx74kEATL5Hgojog
X-Authority-Analysis: v=2.4 cv=F8dnsKhN c=1 sm=1 tr=0 ts=6a435c1e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=CL0R8eYuxTG9Dar42d0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfXxOuxemfC8dsT
 gOlqojjKC7+qJfT3e6MwnDMcPWqUV3nCQ3JzLdaw+pLnFmDZYm6ME7F9d1CHsa9QHhmnGrXnj6U
 wgxpvusy7prO0OHtnVjh8TMdmx+iJhKCLcWojSsjHfSZVW0SjY9clbfksz40oInRlf11dsC36VN
 ODnSBv9NpJyT5gBwNgalI4jbBduWMRA2izvymvWoKM2s9/cGWE6n8EwquxB9xmCZuvkasTJVeyl
 psG9hZuu+WBa6kZK/GjHfVqtA5FPjFEMswDL+RusqQJDQOX6Ni0jUYKhlHV9wnM0+ob/A99Z5hu
 OM5bNdmSzZMl7NzXkJhzT8chA7OKUuR4YAISwKGIQjgI9mooqLb0aq/q5ZD+H6Du4dj0aPbVeCM
 N29n2Iw7QRJ/NSZ0dYpTbqGQC2N4jr5uFbRMJM6BtPJBQGtunkjVCbTK8RIdaWGUVOEj22gXDCk
 AFouYDnDD885C+8Ls/Q==
X-Proofpoint-GUID: Jsjk3X32OMQRy0wSTx74kEATL5Hgojog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300049

Add trace event support to the Qualcomm GENI I2C driver to enable
detailed runtime debugging and analysis.

The trace events capture I2C clock configuration, interrupt status
and error code and message.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 include/trace/events/qcom_geni_i2c.h | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/include/trace/events/qcom_geni_i2c.h b/include/trace/events/qcom_geni_i2c.h
new file mode 100644
index 000000000000..c7e7984f3620
--- /dev/null
+++ b/include/trace/events/qcom_geni_i2c.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_geni_i2c
+
+#if !defined(_TRACE_QCOM_GENI_I2C_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GENI_I2C_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(geni_i2c_bus_setup,
+	    TP_PROTO(struct device *dev, u32 clk_freq, u8 clk_div,
+		     u8 t_high_cnt, u8 t_low_cnt, u8 t_cycle_cnt),
+	    TP_ARGS(dev, clk_freq, clk_div, t_high_cnt, t_low_cnt, t_cycle_cnt),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, clk_freq)
+			     __field(u8,  clk_div)
+			     __field(u8,  t_high_cnt)
+			     __field(u8,  t_low_cnt)
+			     __field(u8,  t_cycle_cnt)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->clk_freq   = clk_freq;
+			   __entry->clk_div    = clk_div;
+			   __entry->t_high_cnt = t_high_cnt;
+			   __entry->t_low_cnt  = t_low_cnt;
+			   __entry->t_cycle_cnt = t_cycle_cnt;
+	    ),
+
+	    TP_printk("%s: clk_freq=%u clk_div=%u t_high=%u t_low=%u t_cycle=%u",
+		      __get_str(name), __entry->clk_freq, __entry->clk_div,
+		      __entry->t_high_cnt, __entry->t_low_cnt,
+		      __entry->t_cycle_cnt)
+);
+
+TRACE_EVENT(geni_i2c_irq,
+	    TP_PROTO(struct device *dev, u32 m_stat, u32 rx_st,
+		     u32 dm_tx_st, u32 dm_rx_st),
+	    TP_ARGS(dev, m_stat, rx_st, dm_tx_st, dm_rx_st),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, m_stat)
+			     __field(u32, rx_st)
+			     __field(u32, dm_tx_st)
+			     __field(u32, dm_rx_st)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->m_stat = m_stat;
+			   __entry->rx_st = rx_st;
+			   __entry->dm_tx_st = dm_tx_st;
+			   __entry->dm_rx_st = dm_rx_st;
+	    ),
+
+	    TP_printk("%s: m_stat=0x%08x rx_st=0x%08x dm_tx=0x%08x dm_rx=0x%08x",
+		      __get_str(name), __entry->m_stat, __entry->rx_st,
+		      __entry->dm_tx_st, __entry->dm_rx_st)
+);
+
+TRACE_EVENT(geni_i2c_err,
+	    TP_PROTO(struct device *dev, int err, const char *msg),
+	    TP_ARGS(dev, err, msg),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(int, err)
+			     __string(msg, msg)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->err = err;
+			   __assign_str(msg);
+	    ),
+
+	    TP_printk("%s: err=%d msg=%s",
+		      __get_str(name), __entry->err, __get_str(msg))
+);
+
+#endif /* _TRACE_QCOM_GENI_I2C_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

