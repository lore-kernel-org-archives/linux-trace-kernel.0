Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A030BBBB;
	Mon,  1 Dec 2025 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593688; cv=none; b=Ny4dMFtDNoPtCtGzoxhZJAakQnrYLmoQpkDPaG1CovmGdIqdn0iL9Dt70c2CxEAN1kW1V44TranBKVXT/aSJwXZTfWZinQEV0QRBDE0JMjkn8yEUDbj8B5ue8L01QM+8yq0Bod7lvi0NQqUBvxqnLjluqg9/orzeLYX0Kh7m5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593688; c=relaxed/simple;
	bh=d8TS/kySh6+jpUGphOtoKjGCFpxIkoiKzLwIPG3Pddk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IokG7Lgntq1FNN10Huj+OGwLqacL88kMvrMYAY9oeN1ghCx+6lllUSQsP41gTo71O2DC+DeboWbIMFgBsZpwrNso9aguu8KcA5eaJzvKLbd+PIpdSQlsaqhoJBttgsky4vIuneoCbb983WZ2XdAVqhQytoDfNHqHSTGqYCkVPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MxyT2L4v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MxyT2L4v"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1ChnMb018597;
	Mon, 1 Dec 2025 12:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4apeR6TUCQNXYVcXzGTQoWp/mqzhfEluuJayQLooi
	xc=; b=MxyT2L4vSku23Jbzlzl+ORH6CaByWxleX64Ne6TaR5o/bJW14Hi0PS1J9
	QOzok9Z5enFQ9U0P5ULCAEyOkyW6EdA89bAa+xn1D0vqjI5z7I+3nrj7qPNbE8zk
	GgO9cnd6EmkJV6cHKUBIgG0Dws/5guZXeQQus6q7n+uI0DN4wmpw0fCwf5gl/FLO
	ZdeejZJY8HqPL0qT5MO3M1Nh38B6HdEKzqPLPxeWQ8qgMcMQdV8SKhtyRFdpSblv
	sJ/ujoF+TdgyBYvoAglJGt+cem5YScXep0ru3naD4akm9iWfcO4VVs+noLb3snN6
	FrEMvgSXhb3fa9p9UjTZCs5qPRP4A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8uf362-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:54:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1BlxHg024111;
	Mon, 1 Dec 2025 12:54:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5s6kv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:54:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1CsIYN18940286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 12:54:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A56E22004B;
	Mon,  1 Dec 2025 12:54:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A9020043;
	Mon,  1 Dec 2025 12:54:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 12:54:18 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/3]  unwind_user: Cleanups
Date: Mon,  1 Dec 2025 13:54:13 +0100
Message-ID: <20251201125416.1239568-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lvx7_zqEnawxUlf37MmqzCzGPyzKXrnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX/vXXjxv/7b+P
 IQhMkK+DK0DuMOOjiYpgIUB9uDO0XlPkwLpeAILwRfUfGy7HVc3nsJDlL+VHacpaxpj1YVczI7/
 T2T+oMqZwWnFgR6dH0RRt4LqeoOZUvpS71PDU7KwGQbB/2uNyXPpaq/HNT7te2mjFQqwDH9fRyL
 9ykzkX9oD5Z0v7MxD4BUsWhaOFmnKazlw4e8JFAoiqJjO4wF5cPkmm7kN/WWLOwXiu2XscQtWUz
 x9cNdqBy8L3imqMvTUb+L/79Xja3VZXrYHZb1niiZKsXJ2HLGYsA0rU9PHoNS/28G4zh5hsJdTi
 crY1q+pKaGbGWS3CumxQvQLCHzOjcsCmNEKx8l45zBDGZIkiMc+yCsBxcOCn2UDzlE0pyxfU8tZ
 pFQlKQBgs0XNyHXcVE0zxZ5vIl+boQ==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=692d8fff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=4i9mbmJSOeA3QhmOqjAA:9
X-Proofpoint-GUID: lvx7_zqEnawxUlf37MmqzCzGPyzKXrnH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290008

This patch series applies on top of Peter Zijlstras' latest unwind user
enhancements (and perf deferred callchain support) on his tip perf/core
branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

Which has already been merged to tip/master and linux-next/master.

Patch 1 enhances a few comments in unwind_user_next_common().

Patch 2 gets rid of an ifdef in unwind_user_next_fp() by moving it to
linux/unwind_user.h.  Additionally it provides a common fallback for
unwind_user_at_function_start().

Patch 3 ensures the x86 unwind_user_word_size() implementation is
available whenever config option UNWIND_USER is enabled, as it is
required by unwind user in general and is not specific to its FP
unwind method.

Regards,
Jens

Jens Remus (3):
  unwind_user: Enhance comments on get CFA, FP, and RA
  unwind_user/fp: Use dummies instead of ifdef
  x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER

 arch/x86/include/asm/unwind_user.h | 29 +++++++++++++++++------------
 include/linux/unwind_user.h        | 18 ++++++++++++++++--
 kernel/unwind/user.c               | 12 ++++--------
 3 files changed, 37 insertions(+), 22 deletions(-)

-- 
2.51.0

