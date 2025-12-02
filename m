Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987E221F1C;
	Tue,  2 Dec 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688129; cv=none; b=cfUGOrfNr/06tNRMTWVBH7MIdEiCLpKloEC5Fzu3UAVAdeDv9ZRzoMw12kISgwPbNkFqdsuMCBY64UxaWqzd7w+sjp8QoHzAmvJL80Nbesc5A2wmUCCNShDLwxRxtJ+lrL9AufSJAuI+bUNUiHeGytP0j9W8f8MVXjF0uRcDujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688129; c=relaxed/simple;
	bh=J8TL+3mxbLXKjPFPQ/aAESq05/Cj4cOpYiou4IDrcWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXTT6fSGHTCkZ4Xiy5nel+7+eajYnJRFB9XAR0wB/tlq2YK83b9v2SkUgY8b7YWyotcnsf3KntJ9YoMkwPwIjDAsP/dElRU6jN8PH1RgAxAJz0bqFYZ/xQ+qZfh7NvYrpdVvCC/3B4VLs9M2fNw2ua2ggamNdLraliB/DVkbEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=muMAZ6/J; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="muMAZ6/J"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2C9mcI018597;
	Tue, 2 Dec 2025 15:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0l9XafqGiDqnvKfvyyGs8i/OogX/klcHSY1nwLf33
	UY=; b=muMAZ6/JfvDliy4Zfy2ttaYQ0POhLXaTdXk4UFfLxHsIwJ0g5xO9Iy7WE
	uUXmUR7srhwJ2dWf2QZh9p0afrHLzonlHbbXzr5PexrFMzMpn/Mj8vBsUkdtW02y
	n8+yY2cZiUmWzGWyVk32fgL60xLMpe270uuFIvlVY+1JowDtNONcOGa4YhBhvg71
	BFCueHSh3H+juu5CWDIYUe5M+rW87IP8IyxR7/KwOQLDfWmZf4AosHmE5H98Xzr+
	xPjOvehDGLdbTU3ajyD5SmrsF0Tpmi41RkKFE0Qa2E8+idYlK85cfm7LJUnFgN+O
	pthZIiRU6ft3Wei+WVj720EaAfAGg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqq8unh3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:08:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2Eekcu010237;
	Tue, 2 Dec 2025 15:08:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arcnk4xun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:08:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2F8FcU49348972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 15:08:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9448E20040;
	Tue,  2 Dec 2025 15:08:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5745D20043;
	Tue,  2 Dec 2025 15:08:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 15:08:15 +0000 (GMT)
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
Subject: [PATCH v3 0/3] unwind_user: Cleanups
Date: Tue,  2 Dec 2025 16:08:10 +0100
Message-ID: <20251202150814.3505869-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a2JqpcT2Q7pWQP2JEY1eweC3g2cRpOS0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwOCBTYWx0ZWRfX3EOal0AsRDt5
 7KHCfeLuGFqgqZam43AiLh8INDOI48XyiHR/pVtKXk0Er0dtuLZVEmqwGFlVXdLkn4oVKAX0B7j
 lJgG4uf3sUBxUPTI7nAO3vmu+AjuT3nb6bQA3tkpOI5tfRM60V9gG3y365x/FsFSQG5uYMDSrAp
 oXvHpZhhGCb9f68W1wWp2qcnG3L6uCWQYbJbUN4iqd0BdJdMs/eGaFfMbzSiCKfoygfr+O/8jrv
 /lLpAeO8YOR/oDhmZjbmWAPCnYDR5y9diinnZMxZIUet25V8IRUgngSW6bAPfQ/rJMOvIcdU6S5
 0CkAnshqDRDChLH8lXLn02emvrKtO0N/xasiEDMDVp4So2zmMFYLbnuSnRGfAigcAtt1ntRRVgm
 KTM3SPcj+W0tLwUc2WeGwkn+w7TBjQ==
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=692f00e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=4i9mbmJSOeA3QhmOqjAA:9
X-Proofpoint-GUID: a2JqpcT2Q7pWQP2JEY1eweC3g2cRpOS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
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

 arch/x86/include/asm/unwind_user.h | 31 +++++++++++++++++-------------
 include/linux/unwind_user.h        | 18 +++++++++++++++--
 kernel/unwind/user.c               | 12 ++++--------
 3 files changed, 38 insertions(+), 23 deletions(-)

-- 
2.51.0

