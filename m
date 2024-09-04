Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6E14658B;
	Wed,  4 Sep 2024 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433175; cv=none; b=SfXS4hD1yvT9FFPvnn9arLB5edC/f9gktbYG06Q8lfsN98bnj0osbrfXtqaPl+vi449Kc3mFQNkHXsbvk4xE8JtuCMtLBVzZG9qPGpCrA15uCOwQlyNJPJ1wNLLgpQICK8ZXKdx3kDQ1j/+DgL46gQpRiAehkKkkuaXdFPIp8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433175; c=relaxed/simple;
	bh=AsMuNK/VNzs25P4UhqW/dLed5ignnKTo05pw9tsVZa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LE4q0+50oPRunZX/7a6MTp6lNDIoP2gDL/cemQ7srnapcpcdhNFAYiICeKX9w2cgCQTAqJV33pmIJC5yXtang3O2IkNbVG8WB3JaddPUCK/uU3TEuiB/dl77Gd3O7cRlD4d4rY8MXEmErhVRtKaNsB3UXsESTDyW66eXOKxQe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XRkl+CMF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XRkl+CMF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4843iuH5018346;
	Wed, 4 Sep 2024 06:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=mVK2+Fis+uDCY
	4mWrAvexyW+a1YkyaPfuIanqLiNr1Y=; b=XRkl+CMFn/T1A0R3i//RvgwmEGnXI
	n/R17HQ15BLsnSpf7FKRt2XIWUF2BNBMWx/T7g/PYEIEbab420oCk1T9Q7ovV8+X
	0i11y90lV70GMjxCBrT5v48ZBXtcfitTcOZyrb9yDHK+ztXEI6w8Ixp0HrCr9/nT
	NDzjDRrm4qfIAY2aJmlOeD53wZx3JrCpEWFkXMkiVPUMq5iFciyw4sR1qPC5Ok2S
	0MHlCxslgLIJiIhTubFD8OSuVm7tRbV1UmJgQh8CCgaPOZeDbFuJTUF2aWeicaZr
	DPDNHFYQvHG13xVY6/n3mk/kaX0nsFRVC37ycC68eKLCNwKifHM/e08Kw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqt1ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4846UagY009148;
	Wed, 4 Sep 2024 06:59:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cg73p5be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846xJLI54395384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:59:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE41220043;
	Wed,  4 Sep 2024 06:59:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B037320040;
	Wed,  4 Sep 2024 06:59:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Sep 2024 06:59:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 796EDE0297; Wed,  4 Sep 2024 08:59:19 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5/7] tracing: add config option for print arguments in ftrace
Date: Wed,  4 Sep 2024 08:58:59 +0200
Message-ID: <20240904065908.1009086-6-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904065908.1009086-1-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3JImOn-JiFtlDj5augIhilK-2ps0LxBs
X-Proofpoint-ORIG-GUID: 3JImOn-JiFtlDj5augIhilK-2ps0LxBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040049

Add a config option to disable/enable function argument
printing support during runtime.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/trace/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 721c3b221048..8b9b6cdf39ac 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -242,6 +242,18 @@ config FUNCTION_GRAPH_RETVAL
 	  enable it via the trace option funcgraph-retval.
 	  See Documentation/trace/ftrace.rst
 
+config FUNCTION_TRACE_ARGS
+	bool "Kernel Function Tracer Arguments"
+	depends on HAVE_FUNCTION_ARG_ACCESS_API
+	depends on DEBUG_INFO_BTF && BPF_SYSCALL
+	default n
+	help
+	  Support recording and printing of function arguments when using
+	  the function tracer or function graph tracer. This feature is off
+	  by default, and can be enabled via the trace option func-args (for
+	  the function tracer) and funcgraph-args (for the function graph
+	  tracer).
+
 config DYNAMIC_FTRACE
 	bool "enable/disable function tracing dynamically"
 	depends on FUNCTION_TRACER
-- 
2.43.0

