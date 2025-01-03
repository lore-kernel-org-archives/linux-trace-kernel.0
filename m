Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7E148832;
	Fri,  3 Jan 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735897043; cv=none; b=FOJ2YPxXhaFDJfKPHXVXr5BBi1oMtObzm3wmVhUk4WNVz0k4J0hCWyTT0aENw1aqtvfRudifZx2lggmSFCQ2ikX1mO3mlkn/Syp9KH4sy1ZxlpWrSRg1YldS7E1mcwWYVNR/e/kFBCcrJzIK6XcZpEtdicHVSHqONjdMS1fGmYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735897043; c=relaxed/simple;
	bh=SaAQ9+CP1WXbg/Tv07CdjFRATWRPeasDDkQQk4soTLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a3HkyQF9ZDNrMU3aUNDh9PjdW7vWbtVUYHokyIhe2ERrXLDkz1YCPXIJJEYcYErB2cy7GMdhxJ0mL6Xztv9C0n86z6dXn/L5oOs3B6mVaL/cM/qRImqUmX0xfRX/JVS/Kh0Q1gGqMuAMaP9KZlWkFSnM4q0cxOw3hWxkmHry/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F3Gp7JK8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F3Gp7JK8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Nvxw6012268;
	Fri, 3 Jan 2025 09:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rlXdp+XmeCZl0WscPjfF63mX3Z6CUNT9vGwS3I24j
	bQ=; b=F3Gp7JK8yWdlXonPxAaHvl8Dgoc2Yxl5f52cb132ZZxcBkr59LvmSoEFJ
	OSJ+ZzN8kSOIpe6BxAPsJ1cliA7C9QjA3jbV7XISsKlThdQNqTskXAk8x5IfqqQR
	fyR5W0XN10gCrMZhsBEzwWvLSw7vTVa5LQMa1L9sf5MYgYIj06EYVzskUYKiULSL
	+Kqt4Du1E6Y/SRTm0YqNk3RR3zeKfdLr2S3S32nVP7yuUrZwCCM/puv9K3A9Kf5S
	JQQrSze7smqftWscfczu0/5DpAF7uUOJpcnb+rc9D5VeH3aCI7ZyD1vGtfWIjv6E
	ADu48qra/BHmdZ5yMVqWK8ZC8pXRQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43x4xh1pfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 09:37:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 503779Ea027024;
	Fri, 3 Jan 2025 09:37:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43txc25ekt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 09:37:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5039b7v548693608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 09:37:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5751420043;
	Fri,  3 Jan 2025 09:37:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF7F820040;
	Fri,  3 Jan 2025 09:37:05 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.222.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jan 2025 09:37:05 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: sshegde@linux.ibm.com, mark.rutland@arm.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: print lazy preemption model
Date: Fri,  3 Jan 2025 15:06:47 +0530
Message-ID: <20250103093647.575919-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TT2dA042V90G3pjG59wmdNWjwnlav1kJ
X-Proofpoint-GUID: TT2dA042V90G3pjG59wmdNWjwnlav1kJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 mlxlogscore=555 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030082

Print lazy preemption model in ftrace header when latency-format=1.

cat /sys/kernel/debug/sched/preempt 
none voluntary full (lazy)

Without patch:
latency: 0 us, #232946/232946, CPU#40 | (M:unknown VP:0, KP:0, SP:0 HP:0 #P:80)
With Patch:
latency: 0 us, #1897938/25566788, CPU#16 | (M:lazy VP:0, KP:0, SP:0 HP:0 #P:80)

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f8aebcb01e62..b6e40e8791fa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4122,6 +4122,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 		   preempt_model_none()      ? "server" :
 		   preempt_model_voluntary() ? "desktop" :
 		   preempt_model_full()      ? "preempt" :
+		   preempt_model_lazy()	     ? "lazy"    :
 		   preempt_model_rt()        ? "preempt_rt" :
 		   "unknown",
 		   /* These are reserved for later use */
-- 
2.39.3

