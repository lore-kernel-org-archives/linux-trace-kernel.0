Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520B27814C;
	Mon,  8 Dec 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209863; cv=none; b=WAU4XdX1H7e2wGnN4aUAWd9n2WtjEBP5S+/ax4edTeSXgzd7cwaqZMyh1WrFpVMMf2xaDDYzofO0tyHdHILx+HsymjgaUZ3FihcQb8C8vtJrOSikO++fa8WYHNmx0LmxFSEIwx2fkJKPCWAeSto3FRVt9ebU5bF9uEgpc0X6N/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209863; c=relaxed/simple;
	bh=dp5l60XTrReP8la+PT6nJZgMU2R6/k06t796gbWPYp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ko8aJT4h2rdrDxza6TH2XkqokW8EuFaGxv4Q+trSGN/rRmkyhe0IuQord3HVT/DpUT1hMHyqDcG0gHkuj1575sDyczrcCcAzNOessD2M+ts35ab4hil8HO+GRQt0xFm+89iprhqmZVLldyI6Jhi/2/hDR8dFqN4KaQP+zMeorfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PbdLgiqp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PbdLgiqp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B87mDEu014003;
	Mon, 8 Dec 2025 16:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GOzEESRAgsZLYyY7C8i+6rUbpFQ50lhPNTnZ2s0Et
	UU=; b=PbdLgiqpsrDwfqoj1YLaGoCG7oX/h8KZYsNB0p7a9jKVRKuh9GDPyzL2i
	dQxbKG1g+CFM2nBgm2BeANUWMDChCHR2Bd5upLOaxxuf4n8uNvxHsbkemwCfoy/Q
	/Fsjp5JtYrBwqq/taSpJxy1USprLhKQmMNE7Nxh7Kylefn0izRCa6myIBukNaq64
	zWmxeh2skKuohvY7aSPAOVmB18oOt4G3v5l8Nd/jhZMd8i2gvsdnaPl8iGpfInX7
	0v/JLwrpKo3l+QIzPFki5GVv36iBBKopXsPXa8chCRLc/ToxqdLuFICPiK3nVXjx
	i113Aa2eY6GHmXx3wcE1uYDBM11VA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avawv088x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:04:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8Eh8Jb028123;
	Mon, 8 Dec 2025 16:03:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xpjyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:03:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8G3th154722838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 16:03:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7B920043;
	Mon,  8 Dec 2025 16:03:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAFC220040;
	Mon,  8 Dec 2025 16:03:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 16:03:54 +0000 (GMT)
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 0/4] unwind_user: Cleanups
Date: Mon,  8 Dec 2025 17:03:48 +0100
Message-ID: <20251208160352.1363040-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9QdiDztt3c8plVYYZiA7STYx1B53Dkvz
X-Proofpoint-ORIG-GUID: 9QdiDztt3c8plVYYZiA7STYx1B53Dkvz
X-Authority-Analysis: v=2.4 cv=aY9sXBot c=1 sm=1 tr=0 ts=6936f6f0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=Uf53lhzMc3XAIpUgU0cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwNyBTYWx0ZWRfX4K0IadXN7SU4
 kspb+jk3yOsREuTGYwiJGPqZmmZOWGVYHqJbKnyIgxX4KFNfzDNU2+ZJsCYsNfypvfpFRIUuAek
 7VenqoEqRM3Ytb+CjxPGtGtsD7SY3Sya7lzNmy67PO09sKLjjpMMQOGUFxz57FDfTcR0Hm2sabT
 fzHYw0MGX3FNZqiqZhb582eAYnMCupInneTZvsIM6603M+DU/ScOFphhh+9Q9njkCrTjsLCTcss
 Bm1EA7vnr6c4ltP2QN0iOXa8e8LlnO9jN6eSGf9KUwgkfpCmjV/CqveTPJJ9S8GxDt4L2K/NlYN
 ylkQSuCnMAJ4NRV2XAYc1i6NSCiQkSwm9CaErhUa4rotE3ps6otf3Dq8QF/BTaXgZcmp8Tpn97w
 c/faO1luoU95avsMMTiFnzrs0sVoJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060007

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

Patch 4 (new in v4) simplifies unwind_user_word_size().

Regards,
Jens

Jens Remus (4):
  unwind_user: Enhance comments on get CFA, FP, and RA
  unwind_user/fp: Use dummies instead of ifdef
  x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
  x86/unwind_user: Simplify unwind_user_word_size()

 arch/x86/include/asm/unwind_user.h | 27 ++++++++++++++-------------
 include/linux/unwind_user.h        | 18 ++++++++++++++++--
 kernel/unwind/user.c               | 12 ++++--------
 3 files changed, 34 insertions(+), 23 deletions(-)

-- 
2.51.0

