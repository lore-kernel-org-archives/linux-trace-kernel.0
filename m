Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52013D285;
	Mon,  6 May 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005372; cv=none; b=ClNtmXPHvfJ1Yh+oWcXH+1/WvZdMT6EsN00SHvOHs0uIRADiFmM+dHy1NwhSccvfmsl8f4cC3tznUcDYj+0RH2gKc3gO0TVy8+N1afv1M/f8ngPdFAod6IuGFrDNZRCv5y95AUZApADiBRLbSAutBlA0XCog8cc5VPNQSUaWv84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005372; c=relaxed/simple;
	bh=CnTWZ3+KLYBBjQOHiJPtTabL4E1gVt0f3at8gtesFaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=sM/9Mi+cMpz0bkbRYZW2J2UoJG3L6fH3gfcelVCpV8tb7M9/ZUvbFlo2TjXfoUCi5z6hD7r05S9IvwAdIURL8VBtfY7QSr2UiGwUUStFhABIXF/LgCIxH6Zo7wtizGVoPfIk4k6S672Co+sKtzrwWCoFA70KgbtEN/5dfzUhUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J7Z2UaaD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J7Z2UaaD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446BhBPr027135;
	Mon, 6 May 2024 14:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=VF+
	VhKRSNkGh0wQg8mWK8KrHSpHVekHCRFc58SagL3s=; b=J7Z2UaaDyQs0ktGVUyM
	+Eosd3jssd08NUNxsWk5qp0YWCI9aoRhpuLFrhNW/fWJb0mcPB02lqWWLHyrgmWn
	2T6xWmACS5/uTNBBZvLMMHozpoV6ICiEwgrkGSYJugXUbDF3l8B9eRnov0btLCgl
	7nWg+7JfsAlpStzrRbyJwVEJkFnz6+OUx+355TsrTP9TZR9hLCw0dubyipz6falw
	xi/nQY/bGg0uGx8clpkD510+zA4K3+Y7Eh3l3pHskTEgKgs4r5DcimuICvAVZ8rY
	6mxNz5YfRBqFs0T/kEd1NMunoHTFGzWudAwOf3jK99gFlfUKFMLJ+Cuv3fPM0Z+F
	qWg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxvv70ja4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 14:22:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 446EMZ3l003055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 May 2024 14:22:35 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 May 2024
 07:22:35 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 6 May 2024 07:22:33 -0700
Subject: [PATCH] tracing: Fix trace_pid_list_free() kernel-doc
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240506-trace_pid_list_free-kdoc-v1-1-c70f0ae29144@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKjnOGYC/x3MWwrCMBBG4a2UeTaQhlbErYiEXP7YwZqWSZRC6
 d6NPn4P5+xUIIxC124nwYcLL7mhP3UUJpcfUBybyWgz6FGfVRUXYFeOduZSbRJAPeMSFIxP/eh
 xGQBq+SpIvP3Xt3uzdwXKi8th+g1nzu9NvVypEDqOL07lW5+JAAAA
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        "Jeff Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TQdIgoGh3J3twTPHlJEwNHBqY9egLs0k
X-Proofpoint-ORIG-GUID: TQdIgoGh3J3twTPHlJEwNHBqY9egLs0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=704 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405060099

make C=1 reports:

kernel/trace/pid_list.c:458: warning: Function parameter or struct member 'pid_list' not described in 'trace_pid_list_free'

Add the missing parameter to the trace_pid_list_free() kernel-doc.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/trace/pid_list.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 95106d02b32d..19b271a12c99 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -451,6 +451,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 
 /**
  * trace_pid_list_free - Frees an allocated pid_list.
+ * @pid_list: The pid list to free.
  *
  * Frees the memory for a pid_list that was allocated.
  */

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240506-trace_pid_list_free-kdoc-e2bf15be84ee

