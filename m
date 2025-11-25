Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146EB329388;
	Tue, 25 Nov 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089080; cv=none; b=bcojzXU5Im1jbPkt8EfylNLUIOCSsb0SozhrI3DSbozDgfQ5RJYXlmjg/K9u6Je5vbPOEojuFdSU86Rx34fa+1puhCB+glu1Q2ZXKXL/wxE+F5ncVSzMQCvqyL1iBBoKG9RHe3R53PXvDj3+VYT/EOPvCnXoxdccf6sg1XiSsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089080; c=relaxed/simple;
	bh=qAmOPB+j8H1jJ52Od9LJ2VVq7/wmQpPgwfJQ3ZOIuC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nT/u5DlFnciLhiNKePc4KxVQfFVgaf2+bcZMVlgmpjP6hpVj9mQwsLdh5sUi1iZ6D1fUG5KQxYhMgyqjoOpT6KUznVCTQMg++qPyTzbFI/uc+79U/DjLdQ86Fv1GEvNZ+qBprFVPfvwzl7hcrLkiAcUG3RBFoJkFqYpU9CnIXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h/rWXbPX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h/rWXbPX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APFlSYa005323;
	Tue, 25 Nov 2025 16:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AnuL6hNlhZkQojB7tJ1hrcU0HBkuPtj5iQvLdTKhm
	4Q=; b=h/rWXbPXvMfKWOV1UHVpy/yaG204DGqhlqv2lSImnCxiMzE4Z5Fb6sQdl
	IJkuvZnVP5com626gBijzlYEU8jmUeokWzaVIsb/UoG9DwxLG9wZv7XsmQ3s1VrC
	7+gp7ms44KRkFHl+cGIFsjwj8De2Yov6zMwvFne2PFsXq3+Rnl++2I8sZa0JRk4k
	vwU98LXEeO0Y2tVgMTADt1lwi7eyo3/uyYLq0IRMC/AZK+H8MV4d49aSCyvbuyIX
	gp70qnaXjxTX4IZth1/WWDXmoNzMK47DchbUzjRVz6lmkBSsax/11vTkn3kJVvUz
	h5l7K+sgIm1pbhwytDmdxWAl5AfzQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4uv6t9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:44:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APG1bnQ019014;
	Tue, 25 Nov 2025 16:43:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aksqjmugt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:43:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APGhtli29688138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 16:43:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 725CE2004B;
	Tue, 25 Nov 2025 16:43:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20E0D20040;
	Tue, 25 Nov 2025 16:43:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 16:43:55 +0000 (GMT)
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
Subject: [PATCH 0/3] unwind_user: Cleanups
Date: Tue, 25 Nov 2025 17:43:46 +0100
Message-ID: <20251125164349.2592874-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX0ON63+wNYhpl
 7mGjhnJVlsGB4gK3Pjb1AEWciS/tVhjT4hOS8IJ2SrtDK+S1uojEYHeO+IuLuisXqvIdfQfi/fk
 5l1VX4DofnqU0Ya2kAzo2K/ROiItZMCnfRMov0I2wz26Xnp02cfyfs4q1ST69Os+lGVzJwKOOVT
 wsNGspqTs75PgEvGVE/6GduyKBBlWgAsxtw5Gr3IbTvkhwpPg90PVCw3lAOcZKRrBG5EJVUDa+I
 yq1gQVvIf4wbO4lfyYvGq3WoUea2JaguuttzeYywQjMmgzcTFktc6bnQ/U7Hny7UKVTFBTFBepx
 LPLDfAnEUHgxwTi0TnZjOuXBRrc00cxXXb5GgHzZqTLer+pD/eDtbBI/2airUwgGbaNT0vX6Eg2
 XMYaAFA9+l2AtRHKsuw7rpPwJud5sw==
X-Authority-Analysis: v=2.4 cv=PLoCOPqC c=1 sm=1 tr=0 ts=6925dcd0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=4i9mbmJSOeA3QhmOqjAA:9
X-Proofpoint-ORIG-GUID: psTRydtv0L7Bdr-KFulbyAoBXMinKRvO
X-Proofpoint-GUID: psTRydtv0L7Bdr-KFulbyAoBXMinKRvO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

This patch series applies on top of Peter Zijlstras' latest unwind user
enhancements (and perf deferred callchain support) on his tip perf/core
branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

Which has already been merged to tip/master and linux-next/master.

Patch 1 enhances a few comments in unwind_user_next_common().

Patch 2 gets rid of an ifdef in unwind_user_next_fp() by moving it to
linux/unwind_user.h.

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

 arch/x86/include/asm/unwind_user.h | 28 ++++++++++++++++------------
 include/linux/unwind_user.h        | 14 +++++++++++---
 kernel/unwind/user.c               | 12 ++++--------
 3 files changed, 31 insertions(+), 23 deletions(-)

-- 
2.51.0

