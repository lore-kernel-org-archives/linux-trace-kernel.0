Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C94CDDF7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779961; cv=none; b=LTQyUgUKZbMiMVbKc+8gyi00PUyByRaG5RKMKBTuENBs0QFkc67Lk4ZQnBUvN4L+g51FYeA+i0ZOp+3vqBdaLJtlHay+9+SJqr/dRJSoOOG5J/JZDuAaiiBfPvwV+76oBoDxHjPz3BDegRQiHIUfMoQ9PzszvnesTP0JngUXrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779961; c=relaxed/simple;
	bh=dogAdoQ/QCkQb5GhDzIyOp6UYu9xwRLxOLzN5HnPoIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UH8FbLtTNwsoo8u8NZnpRaWCiWEdxl/vVk3I6ZzsX64TxEJBXEd7tmG+3/jgBEu9XO9ddKl3v6jMSFWEIF8/SV0bUKG7Kl+7K/yh8iSRXGrPM5E9u0lRyuceL4shjg3PpGroYWAo+Kv/tB2yNYJ29OG+ZI0Z+zNuQmZ5WSziZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gfCCPMna; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JU6uTaDN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfCCPMna";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JU6uTaDN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE06SM4178750
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pujGoTye8c8
	YObD45SWJzA4GPFiLYw7N42q3MidIndo=; b=gfCCPMnaNXdaKUY2Kf3BnL6i30m
	hPMuG2IFctl2aGrE80RioybPYMSgnsdUZnN/Bo0nqfkQ5PlufDHalBSJTUDkgJOQ
	UA+poj+spUeZh02UNH5cUN9/acH6AIyPtPrhjbWzYEbU9l8uF6dUrv9afOCZxYsT
	lXjPzyGe5RBe2lgquOgw3IuzlaOc3QdSnVJYQNh2TrD09u0Kqs4uv6TIPAonKBOb
	uQnm3qF3hw8jRxJVpe+OP0dgP1Asp9JDrc8OpPWDA/Ox9B+7/NXrV4AAOQtipfDu
	1VGipdvDlaJFqED8Ng19sJuw95FnwgwO2Baz//12Bn7DigzynoeWehTP+XQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0nm3m02m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:24 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34d80ca2184so231579eec.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790779944; x=1791384744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pujGoTye8c8YObD45SWJzA4GPFiLYw7N42q3MidIndo=;
        b=JU6uTaDN2AcdXl38uB0FpK7436H7tJTapsGfmPpyMcgZ3zGGSoB1a9SzfecMLU1Bvt
         T10Dl9qWBTrjLg0AEFgfJndTi2DHwts3cHY8VGsxOspxcHlpdLdqFdQOJd3mVGiJF+Is
         gd3Brh2GJakZQjToqtBhNimFp6F/sQKZGfov1niVkuoAbE3IDe/hgik9m42y7bCBP+1j
         MH/nOQNEwQK5cct8mC0vdTYrW9CO8dLAiWFOVI8yINb0nTbU0DuBzPbMQNBzd34MIzkY
         E9eGnzw09yX+wXUtP8qZxzxx1dLr5McLLdECh6zde+xHaDqGmP9ZiJM0bswwnY31LB0m
         txIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779944; x=1791384744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pujGoTye8c8YObD45SWJzA4GPFiLYw7N42q3MidIndo=;
        b=lYaIiq7vdtpJ6N8HazstOzu2yRPPuRPILkeoxfiNDQSM74coo4/2GbjmcbGHrfzE7J
         3Dlklfs/H8bcsRoBs3HLfOKuqfyj4vAwtHmBM9SHyW06Cp/IbJn9e3y2iWSr0rfG7XHB
         l1Kvt6ywQtJPkZ9h35YIgQ7+n6VVl+q692ND035oXfVXk06KYXhG7jA4avBBu+Pcdqlh
         TEjQhTF2mH6xTp7HZjArSFlmz2saihhkMP8pmEockTsJ9ShAsAUtKuRs0sMzBJ4io8dZ
         cdrZmLnov3yCP8t5ATF9VpsYqB6meVCmyaOaZIfev4RMQkDZ966rAtEBMYHVF294vaRu
         oH8w==
X-Forwarded-Encrypted: i=1; AKwUvBxITAv+N3Gj+60D1myvrHbmTUQ7Z1th4CqV74klyVcrCwIgPMKrgCXc0Xf4i4iLcDA2lumN+85lEseHC5d5WSk49G8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwsKwM4Zcyim/OPsyE5bvtJQ2Jz0iXTZ4oi687H00P+TdBrWUo
	eYuagBe4MTl0MlKfNGOoXnZ+UKqXqVfPogd9RtDhRs4YFUGkNwuv8icWVRqNd1ZlqCJLybd7HKg
	dQen5GW3sYxCnWNEZL8urnU9oK88Ajr0nvuyVJCaAS48d5nc8bE6CuIEpwVrTLHpd49pmiWgnGH
	s=
X-Gm-Gg: AYBFou2QONUePx7MTfbKXJc9xD+gjo80Brc/oD2p0eTaAzwoaXlD1b+AXvRnGA5GD2D
	Rw6U+6aE3w63GmNa/QE0AYcYUkHmxZZI1CnrNubyPKMYtDdXK/8U/BtRpDHrjIv2xZi9JvqY3Z5
	Nr3h75wq6/Ha3QUu9UpI6Ig+CkbCBk+XkiHbj6vbGVsjWbzDFNWaqUzM0neDtY2ju0tlqs4iVtW
	QPzHxPhZ2N4pxHxSNW9d+5JM4np78v9zgKsiY+gsJYFDuJNOZHiC3nls0Wxttpp47xynb2UrbnA
	UHoAhbbZ5UiW96kYobzfYOJUjvqckwejaTHohnm/OiDhRTsc/MdHPBX4ew9+2KiDZz9w+drnWhH
	GO9Y7WPIk/rMjyK7VsXxcXdCnGAejXXwG1EVJjO/51I9WCb1rem3de6k=
X-Received: by 2002:a05:7301:6192:10b0:34b:2362:90a8 with SMTP id 5a478bee46e88-34cdc4c0558mr2042929eec.19.1790779943560;
        Wed, 30 Sep 2026 07:52:23 -0700 (PDT)
X-Received: by 2002:a05:7301:6192:10b0:34b:2362:90a8 with SMTP id 5a478bee46e88-34cdc4c0558mr2042887eec.19.1790779942856;
        Wed, 30 Sep 2026 07:52:22 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm4524609eec.18.2026.09.30.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:52:22 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [PATCH 3/6] trace: qpace: Add tracepoints for QPaCE operations
Date: Wed, 30 Sep 2026 07:52:12 -0700
Message-Id: <20260930145215.3380977-4-georgi.djakov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WN3EaxctB4IaYkg-uo74An8jcDyp3gcl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfXwB91/vc09Or6
 MnOEZmzsrAUItvaL1TnRnD9biAziW2uerPwoYtjB060O8tQoyzzWWm9wLfVhYEDiInMU5kjrSfO
 BVKIeJMeorrENdt2bp6ZK+LUbgr++UbLficiq6HG1ZmMiRbEV1vyNl/AguOvRhWIh5vWFaBoolR
 Xff3v/vV9B5GYdPzj6fLKLNKE6JJ7rp9VTTytDf3btaoMeIRiP/o3Raw/3EsHky6u5FTEsyvaTG
 gu4BlQbCKZh08VeLnSqNBJW9JEdZcUpdvowpkilazcyYmFtfda+Q4yhMp6XC/OcXEdqfepZT+ED
 PvoWxbh9gfJYMzt/jx5Ou+vpHoggSLm/jTSpKfBvVzdK/uWxeBlSu5XTpeA0gkfat38DlGUMIcz
 GaN9DipCd55BEmVBef0xaIfVB2rBGPRg630rIn7oUVYR/jd+DUo7GWp11gXqQ96ELRMVp6zVxqw
 MvY1J0Wp7+q3FJywe/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX+ayS65FqoUAl
 1fSLF1c20WJ5s64UkuSrxUjKg/mVbi6Y1VKI7xihvkSYMmjrZWWXtrxZbjE7j1CiaOWhxf3YvK7
 Ugs3Wvigk9hL1fMZrdwNcnE17VcuBYE=
X-Proofpoint-GUID: WN3EaxctB4IaYkg-uo74An8jcDyp3gcl
X-Authority-Analysis: v=2.4 cv=fqxJ914f c=1 sm=1 tr=0 ts=6abd2228 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=TOX0-C0EfqkpjbOQ6sUA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300059

Add ftrace tracepoints for the Qualcomm Page Compression Engine
to allow performance analysis and debugging of QPaCE hardware
operations.

Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
---
 drivers/soc/qcom/qpace.c     | 12 +++++
 include/trace/events/qpace.h | 99 ++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 include/trace/events/qpace.h

diff --git a/drivers/soc/qcom/qpace.c b/drivers/soc/qcom/qpace.c
index 69aa14b7c477..f5b21ffbcbff 100644
--- a/drivers/soc/qcom/qpace.c
+++ b/drivers/soc/qcom/qpace.c
@@ -23,6 +23,9 @@
 
 #include "qpace_internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qpace.h>
+
 #define QPACE_REG_PAGE_SIZE 4096
 #define QPACE_CORE_CACHEINDEX_SIZE 4
 
@@ -310,6 +313,8 @@ int qpace_urgent_compress(dma_addr_t input_addr,
 	if (ret)
 		return ret;
 
+	trace_start_qpace_urgent_compress((u64)input_addr, (u64)output_addr);
+
 	urg_reg_num = get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;
 	stat_reg = qpace_urgent_command_trigger(input_addr, output_addr, urg_reg_num,
 						algo->urg_comp_cntxt);
@@ -338,6 +343,7 @@ int qpace_urgent_compress(dma_addr_t input_addr,
 
 	ret = FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
 out:
+	trace_end_qpace_urgent_compress((u64)input_addr, (u64)output_addr, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qpace_urgent_compress);
@@ -356,6 +362,9 @@ int qpace_urgent_decompress(dma_addr_t input_addr,
 	if (ret)
 		goto out;
 
+	trace_start_qpace_urgent_decompress((u64)input_addr,
+					    (u64)output_addr, input_size);
+
 	urg_reg_num = get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;
 	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_SIZE_n_OFFSET,
 				urg_reg_num, algo->urg_decomp_cntxt,
@@ -381,6 +390,9 @@ int qpace_urgent_decompress(dma_addr_t input_addr,
 
 	ret = FIELD_GET(URG_CMD_0_ED_STAT_SIZE, stat_reg);
 out:
+	trace_end_qpace_urgent_decompress((u64)input_addr,
+					  (u64)output_addr,
+					  input_size, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qpace_urgent_decompress);
diff --git a/include/trace/events/qpace.h b/include/trace/events/qpace.h
new file mode 100644
index 000000000000..3f0ccdb8f206
--- /dev/null
+++ b/include/trace/events/qpace.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qpace
+
+#if !defined(_TRACE_QPACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QPACE_H
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(start_qpace_urgent_decompress,
+
+	TP_PROTO(u64 src, u64 dst, unsigned int size),
+	TP_ARGS(src, dst, size),
+
+	 TP_STRUCT__entry(
+		 __field(u64, src)
+		 __field(u64, dst)
+		 __field(unsigned int, size)
+	 ),
+
+	 TP_fast_assign(
+		 __entry->src = src;
+		 __entry->dst = dst;
+		 __entry->size = size;
+	 ),
+
+	 TP_printk("src=0x%llx dst=0x%llx size=%u",
+		   __entry->src, __entry->dst, __entry->size)
+);
+
+TRACE_EVENT(end_qpace_urgent_decompress,
+
+	 TP_PROTO(u64 src, u64 dst, unsigned int size, int ret),
+	 TP_ARGS(src, dst, size, ret),
+
+	 TP_STRUCT__entry(
+		 __field(u64, src)
+		 __field(u64, dst)
+		 __field(unsigned int, size)
+		 __field(int, ret)
+	 ),
+
+	 TP_fast_assign(
+		 __entry->src = src;
+		 __entry->dst = dst;
+		 __entry->size = size;
+		 __entry->ret = ret;
+	 ),
+
+	 TP_printk("src=0x%llx dst=0x%llx size=%u ret=%d",
+		   __entry->src, __entry->dst, __entry->size, __entry->ret)
+);
+
+TRACE_EVENT(start_qpace_urgent_compress,
+
+	 TP_PROTO(u64 src, u64 dst),
+	 TP_ARGS(src, dst),
+
+	 TP_STRUCT__entry(
+		 __field(u64, src)
+		 __field(u64, dst)
+	 ),
+
+	 TP_fast_assign(
+		 __entry->src = src;
+		 __entry->dst = dst;
+	 ),
+
+	 TP_printk("src=0x%llx dst=0x%llx",
+		   __entry->src, __entry->dst)
+);
+
+TRACE_EVENT(end_qpace_urgent_compress,
+
+	 TP_PROTO(u64 src, u64 dst, int ret),
+	 TP_ARGS(src, dst, ret),
+
+	 TP_STRUCT__entry(
+		 __field(u64, src)
+		 __field(u64, dst)
+		 __field(int, ret)
+	 ),
+
+	 TP_fast_assign(
+		 __entry->src = src;
+		 __entry->dst = dst;
+		 __entry->ret = ret;
+	 ),
+
+	 TP_printk("src=0x%llx dst=0x%llx ret=%d",
+		   __entry->src, __entry->dst, __entry->ret)
+);
+
+#endif /* _TRACE_QPACE_H */
+
+#include <trace/define_trace.h>
