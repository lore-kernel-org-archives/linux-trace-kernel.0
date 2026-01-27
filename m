Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F728DB54
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503797; cv=none; b=GOMM5aLgbAeqQMWoKyz/BwINE1IeEx/dVLjrdRSIhNWgoG7VpxLoKjEbkLM78fM96P9JN6Dueg/hE51+Sah0buIJay64baTp1/d9JM3Rp4tI1Cht/UDPrp6KMi6y2Yh2+YCBedNXpTiymVxX9aCsyyRHJHtQhJ7NgOwjRp37aWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503797; c=relaxed/simple;
	bh=KAJyO/ZXjG+CcNmRU6xipK0P5eY4O8H2vWS8Ky8MuJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHDUXko+09lvOYrgOYT/m3h31TJk1tQGOvNTWBInhXzbGCrJobsF8kN4AtV0jmhyVLyBQkgR2+UMveH//akRMr5U0yjUyo/th7EPxrzXGtCMTiR6cQdX/OzjK9K1eTfz+WlF+UuBT/g5x+yRtBivX4tBht8BM9XuGyAMWvyEpT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OklNz1N7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OklNz1N7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R80wxA010200;
	Tue, 27 Jan 2026 08:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7BW2B0oj5vV0SB/qPMLPRTv84HnFd61cq1LOXf3eY
	KE=; b=OklNz1N7QS0Nj24Mb1CpeK7kuGf62oBdEwIiaGrLcAHBfETuP/OmAFf2C
	BZrQzJ73ENcfUacE/arGY0NVqHjJJkeGTjFth1IkIqE4BSf8TeZ/oG/1lQ9d5xJz
	yo1JfuMSBQ72YNYc65y5+DjwADxgLN+ig2clxSC/Tcb3p7+USIYFpjFOdX+ZkcsA
	5DWbzrduR/v/ydPQP/qkX60JJkKSgQjWirstZS63cKLpupNkrqykrwkqzbVFZMz3
	OH5gLdMvkr3Z3m4V8/6SeT9AH/EOZcZGI1ToJLwst+hE+1Gse2MHk92RgOS5Jsi0
	7UEl7CuWJCf17829nVIjWhdRLFViA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtca01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 08:49:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60R4HtC5018239;
	Tue, 27 Jan 2026 08:49:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41qqfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 08:49:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60R8nTxF61735406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 08:49:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F70A20040;
	Tue, 27 Jan 2026 08:49:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F40E520043;
	Tue, 27 Jan 2026 08:49:26 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.105])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 08:49:26 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev,
        Maryam Moghadas <maryammo@ca.ibm.com>
Subject: [PATCH v2 0/3] powerpc64/ftrace: fixes clang build issues
Date: Tue, 27 Jan 2026 14:19:23 +0530
Message-ID: <20260127084926.34497-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5DNcWl8SVAQjCoESUTSqNUI4HKfB6L_R
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=69787c1e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8
 a=Sn1wcNZhM9ubr6L8njsA:9
X-Proofpoint-ORIG-GUID: 5DNcWl8SVAQjCoESUTSqNUI4HKfB6L_R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3MSBTYWx0ZWRfXzl9dakQzjrqs
 c/5R05DFmgKQp3Fku95FmHhxzNG/19NnZv4rN4H+DgzEVCUWGXA6ZdtLKMX7FlDpyXbfkDmEJKg
 OLponKC4//3jiYz9hm8qeCi+GacK3O2nTZ64g0tdUIpnVOn5y9/R4RVb0CApOic1bfdvENpyx0O
 dOM6QhrcSxdsSVSk3jORJoX00r1SjumcCP3VZKP4pglOTvQN4uyQr0pDENXBoxYkXAi17LN60zj
 nhgnu4qDnc6V5U6Wnqdmh/Jt3eI7RW26TsJ2LqDFVaxVMMFucnOFpjGK2+ePEI6zhfsiwZwrckw
 bGk+EnW7M4yglVDU3QY8FQDObjiEKq8gQfUPZQ/5xI3fyoqXAsk4tjfHK1F61+9ohyCgW1aAD0j
 TAXwrLi6vRl4kTmv5XRZ9Vt4TqmHHCci5lzulxg6wZTXscm9t4zcyYWWfGaTDAitkOSMNan5x7S
 af8opU2l2FlT8RC6nlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270071

Support for -fpatchable-function-entry on ppc64le was added in Clang
with [1]. Faced a couple of issues while building the linux kernel
with Clang though. Patches 1 & 2 address those issues. The last patch
provides workaround to ensure, an open issue [2] in Clang with
-fpatchable-function-entry support, does not impact the linux
ftrace subsystem.

[1] https://github.com/llvm/llvm-project/pull/151569
[2] https://github.com/llvm/llvm-project/issues/163706


Hari Bathini (3):
  powerpc64: make clang cross-build friendly
  powerpc64/ftrace: fix OOL stub count with clang
  powerpc64/ftrace: workaround clang recording GEP in
    __patchable_function_entries

 arch/powerpc/Kconfig                          |  4 +--
 arch/powerpc/kernel/trace/ftrace.c            | 26 ++++++++++++++++---
 ....sh => check-fpatchable-function-entry.sh} |  0
 arch/powerpc/tools/ftrace-gen-ool-stubs.sh    |  4 +--
 4 files changed, 26 insertions(+), 8 deletions(-)
 rename arch/powerpc/tools/{gcc-check-fpatchable-function-entry.sh => check-fpatchable-function-entry.sh} (100%)

-- 
2.52.0

