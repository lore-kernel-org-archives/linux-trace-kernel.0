Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2F3E0081
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091314; cv=none; b=rkKc25OKQBr8zK2e3oSR4r/LtxPIycoTOIzA8ncF71Jc7xNI5mI/EqQ70aEzGt+YiXx0H/oSENDiibX0a+NffK9E/7FXPua9ftuBsV4YcVawifxaEpH5NnwMlOwThuKRLRnA3uFjV+L5lCi08GY/BFIA4c4Zgn/u9wurokZ5ZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091314; c=relaxed/simple;
	bh=5QeoQ8TXJ2eWRKCulVJNBYD2hW0MNG0GXK/uGsHOHF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGZKPf+8xaU7tuFDwWOaL18dlH4BZmAK3xUYV73FTE6+9YdO3bmzC0KqENdAYB4UirmWKJpqHiZqgRJEwXQ722d0w1lr8HUWRiwXPMiC7fFaL5O7f1/ko3dbBtfwkcIBUEV4mS/DxUgND5iJgX0xYgYLGdJ9CjKNTUs7co5S7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgJ+5XTM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ihvs00Qc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgJ+5XTM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ihvs00Qc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663D5dpp3195080
	for <linux-trace-kernel@vger.kernel.org>; Fri, 3 Jul 2026 15:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	68zuQffoeICSOePaMqdl4NB4vCyqD8mj3IAHDnfcNUk=; b=hgJ+5XTMVyqXw9Sy
	VnmE8sRX6T/JPLnWfQBb8Jd6cLisRnw6d31hwIvGrCGEVgAhFjpTJy1R0enEtK9N
	l52vx+MD+hkfnUm5zAsUdHiDxyF/SLP+ERrYXR0PT5FLQdH5H4T8LayXDPBGb2CX
	c7PLTSRO8jmOpnu4O1civmMrnS9sbdsbNOVJHy0+IGSGT4d0Y2x1F8Gx7MRsjozY
	UwyqmSTsfLre2/v8Xgh/Dji8OUXkzPzU77vGk2a50LF7MeKxiSRfNK8GD1JnV4AR
	wf5iutX0VWcpyKFyKmy/4QwyuYkqnWkBGJEoSAJtdPskgETMB2AvcuDjZOaNUeNl
	AfQQYg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jyspqy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 15:08:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8924f4d0a4so960581a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091308; x=1783696108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68zuQffoeICSOePaMqdl4NB4vCyqD8mj3IAHDnfcNUk=;
        b=ihvs00Qc/y1y19noa8hXr2E7S4zBJ3pEEOaBDtrsxx8tM4MQr9WVv0GQWycJ906m5w
         1snUqQ/j0eSbBnkU8IBdKry1mYnjrsFG19Bm5JCR/QK46fGgoK8BTNviIps3f7eOj8O3
         92Z9iIwpZO+wN7YJu8lHD72BuQuqvmUgsR7KBh8kdrVqtba8OoHp3bzwVUuRmYQ9tqNB
         ovaOzIFH5bADNDH6uVavWLqk4uKaitwXKfMv3JEAzSlkCpc7Q6XzPAXFjaN4Ym/ATeqH
         IG6cSQrAPUKWESr71jNhcMKS3p1JdZTAW6dictlpXA/xno1fTqViYF6UIUn+vvqGVF42
         TDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091308; x=1783696108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68zuQffoeICSOePaMqdl4NB4vCyqD8mj3IAHDnfcNUk=;
        b=qRfIQDW/T9Vcn/2FLiZkuKVtrXtAgEbc33pfLlAigBOdcEUwFlSM7emM0dwY0broK/
         R3+Sz3If74uhCuL5diie72iGUqqoGgCxXhy5Jwf7dOtgE/8DP0LNo1jiUwxcP6cGgxvq
         ELLO+DWuuP82dWLi9rqWr17INb88yMgDFrAzNX9TdfzcwlGzlyIQQAw9xi2shCuyFukU
         OFen3Gcovkud6kxBu4uQ7Xb+fVIHRNVkngb5wRZCAHoNgiKMbezM1EsiqNyiYj3GNBWG
         qtPBr2BmnjlKHEtP5DuqWlSj72tCHVawB32RxMaZ6mPHurTXtxjgvZ1ht82uQbJWOdwv
         0DDw==
X-Forwarded-Encrypted: i=1; AFNElJ/MfsrDC43DEbYFQBzbi5sYnziUlbfqv8T6JZVEZvf0fskDQJWZDkXQ/eBrDJoxaFSVg8tWSCNLsbBJ6Lwh4i7J/Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYUpeytUcj2NYN/PNjKiVIBOEJk3gXCw6olD2ZQCDH21gSej8
	c+ip/vS2SNZxxS8t/U30dqAe74Alf7kniBvTN2hdPhb9KLEqXc7nQL1C3bK6YdQYrRx7vP9orU5
	fVl89j4NUPkZigH9QVWd6grtD1f3FhI6nrvpXXgRkb3Z0Kk2/bhmKoI18Q70DEkHeRVd9hA7wbn
	g=
X-Gm-Gg: AfdE7cnX01ZtQVYGlTUDyorULY1DPEi1XUGnmDSLZsjZNU2WbwdDWuwPNQc3TrrNbYU
	rHF7NBfzxRQbCN709tZmYZidTHmHXL2Q6/77kszSyGOg3NgMoOUs2yL00Xzw0Pd9+qAwcT3HspF
	/tdNoOqTjrA43Bq4rvoSMogK+05rWzu6GPJARWsu0rofG8wC55zvm3P+2bW2bQwvEcXIJ4lFt8W
	/Xd4NOPy2iuXEagZIfjjXoupTLNlLuFhksiEdH/DIilgZpcu1DP+XuCEdwzhXn3lVE5AqjJgN06
	/HFbRM+T9Bu+k8+5qSfsky6Povqg5CHpG/bmuq5kU5mV9sStt0YLQSWI1sl0TTujkQcVefwke9F
	vjmL6rPId+ttLLBXRK5PnfHz2rAKWwCiihYajDa3OrLeE
X-Received: by 2002:a05:6a21:6191:b0:398:7ed3:a001 with SMTP id adf61e73a8af0-3c03c457672mr276011637.2.1783091307554;
        Fri, 03 Jul 2026 08:08:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:6191:b0:398:7ed3:a001 with SMTP id adf61e73a8af0-3c03c457672mr275943637.2.1783091306833;
        Fri, 03 Jul 2026 08:08:26 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm37007808eec.9.2026.07.03.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:08:26 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 20:38:09 +0530
Subject: [PATCH v2 1/2] i2c: qcom-geni: trace: Add trace events for
 Qualcomm GENI I2C
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-1-e8bf8b178290@oss.qualcomm.com>
References: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
In-Reply-To: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091297; l=3246;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=5QeoQ8TXJ2eWRKCulVJNBYD2hW0MNG0GXK/uGsHOHF8=;
 b=TRAW3IelPIMSyF0NYXNPzhAQLEYVuT27+/yMOfHFHYswg5RHanAQrpiyP7cEqxbScnUhXmEmp
 lOtJuvK39/lCUrh8ySv7Q1k+WlFwibwotS/qC6ZCCHBbaj70J1678Ay
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX5zu9rNjpTjhL
 6Fi/2bSsBZyZRJyGA3cCklF9o3/Lsl7MZWccTDx234s9pD0rfcoQg6wizLT+E34NI4F8U0wU5kl
 rRmOIxPUw5VBBm8HlhV54+LMXxtb2VadE8VNtNjnZ0HXMu66mw7eWkbCeeNhUlfo0/ohegfA35s
 3in/oOSVYF4cdJzNhAFQtyQ1LfsxpfvU3GGO4g4T3m2+1vSfbx7nTkKQM+zimH0yravTi+GLJ/Q
 mcHIRu+eBkeY3X1cWTA1e5jt40043+BDfwAknANvmq48xClvLq0eansqF/KV/oCHjMZKjNM4JEf
 s/yRyNgxDf1YrQragPfWPIAPP+PJsG6Cp2S8SsJLeODUt9B3uuORjwTwTkOuw9E9Esp6LSZjr1G
 +6bnYhzJZiYPefhpeE7QcAxSczzVkSrDRQSc9nJ/UggOlNjTDLjxq1qJ9pD/shVHOr/ahmRdhos
 UQnd/vNP+X3+DDewZKA==
X-Proofpoint-GUID: a7zuL1142jx_hcM9OJqU2r_K13ZkCpHw
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a47d06c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=meVymXHHAAAA:8 a=EUspDBNiAAAA:8 a=CL0R8eYuxTG9Dar42d0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: a7zuL1142jx_hcM9OJqU2r_K13ZkCpHw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfXyLg+7ldP95RB
 mp6y/F65aptHxIoVvZ4HVVveksHo6nMqhBzdye+l7TmeSBEXJI93dzyUgXcWJqTsI9G3aPeOHQj
 8/yrvC0Kpkl5W3GPzTd3eHJh1f1klsI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030150

Add trace event support to the Qualcomm GENI I2C driver to enable
detailed runtime debugging and analysis.

The trace events capture I2C clock configuration, interrupt status
and error code and message.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
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

