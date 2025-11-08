Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5100171C9
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762635885; cv=none; b=GUaQ/wWWgEKK+oji36q0rYQpvXBKw//chUF87vs/4RX+rBi9QsGQiWvnrSVA4XbXig6bqeAYjhYIN34p5xQ5RCnc1dMR1gX5nZkqPUls/5OsyFksWaitoiCBlXRvCWCQ8gzPhYeYeMGsA8SJ/m6mEPCJYxL9k7OKvY2f92L+OLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762635885; c=relaxed/simple;
	bh=XxsRkBAjDlCndCxnEpH/bLgQmY7MYpTkzjLvwK48umo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG6vP+FEHOznWjkevUvOFywYAzdmOq6K2StPL3KVifDDF4ucPGHK34kfrN8uF8AmHl0qtWLTVOieGAojvFuTypwZcYdJ3Av6KAgdQpefQiFUYt3EH2RgmsyCtbnS7O48v4yr9GAFi8RiybBu54jLBSYkjTADhxXdB4nqLZISPXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FP4eH8BW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FP4eH8BW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8Kk39a008281;
	Sat, 8 Nov 2025 21:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+fM+DhMyGkUHUPGSY
	NbFNB/dmrVdpMApTZvQzH5CcJg=; b=FP4eH8BWueUHw3URBojRLPxQoB7Ub7dTE
	PmXtgmPFE+sM9fZNPGlo8lnTXQnmTN7EWH/t3ctbsJaK06513PqESrCydXDkagXR
	o1bWXxJ/jLhOCjAh10pWTUQ3VRdB/38T/Hqg1bfNyKChuuwz+9Mij7AzJD2Y2UPC
	DOZM/fbsW2eVb2e2jElgh6/CyQTe5FWaXJqyXPtVFyk/ERSpnNdBS/9VMBZgqDzq
	uwZ6QcgmHBHtKLOeRI6l/BIrG/sXaCTwm0yro42zkTdmGvOitGSVCxpvAL+PMSkd
	DZQoN6a4dm3I18A+6e0paJR7B/DUmcd+cvxg8gk7lwLNZ/55TITNQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk7tf5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 21:04:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8I419L021491;
	Sat, 8 Nov 2025 21:04:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrk871t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 21:04:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A8L4Fgn16318948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Nov 2025 21:04:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEFFC2004B;
	Sat,  8 Nov 2025 21:04:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AF9820043;
	Sat,  8 Nov 2025 21:04:12 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.99.186])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Nov 2025 21:04:12 +0000 (GMT)
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
Subject: [PATCH 2/3] powerpc64/ftrace: fix OOL stub count with clang
Date: Sun,  9 Nov 2025 02:34:04 +0530
Message-ID: <20251108210405.2375472-3-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251108210405.2375472-1-hbathini@linux.ibm.com>
References: <20251108210405.2375472-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX8ztZNdLPqbMF
 ZFBxVelXW1dta9J3KqhQkDmzut05gdI3RDCl5JiRbkKUDzHLu9+zhot3rCgRIaJ4VShTDq6V9pz
 LTYMU7XjnhIUwqh+/k4u2pRVn6j/VD0kUTQyL8woZGZgPo+jwQ9ELNvisl4m/QUM71F/AqYYfx1
 j3BhCZLwxmwqpy0X5A9zCEXe/+QuaUJOGXfAFxXGzzXi+1kp/8r+l0Z8gK70aVArgeMKGdwDVsK
 a4Z6nGejFj/4ObGvDdkhE0JUjqPMss08wAQ8LWUi/NcQ8Ek/4/fZAom64/2siygv4f2T24iHYhs
 iRr7Uoo5jLOpbUzz9udJMwqvkwbQ0KPScex6y12A/ewKJUiJGmZQ07d67hMeHhhEi2WWXTVt4Vm
 uFmBMd94UwG57JuyloFnvSXDpvnjkg==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=690fb053 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=_5KToPWuY_tjwTr7hf0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: nOJm6e4pw_gejLF9cJ6muhTlNzEZ9zBz
X-Proofpoint-GUID: nOJm6e4pw_gejLF9cJ6muhTlNzEZ9zBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

The total number of out-of-line (OOL) stubs required for function
tracing is determined using the following command:

    $(OBJDUMP) -r -j __patchable_function_entries vmlinux.o

While this works correctly with GNU objdump, llvm-objdump does not
list the expected relocation records for this section. Fix this by
using the -d option and counting R_PPC64_ADDR64 relocation entries.
This works as desired with both objdump and llvm-objdump.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/tools/ftrace-gen-ool-stubs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
index bac186bdf64a..9218d43aeb54 100755
--- a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
+++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
@@ -15,9 +15,9 @@ if [ -z "$is_64bit" ]; then
 	RELOCATION=R_PPC_ADDR32
 fi
 
-num_ool_stubs_total=$($objdump -r -j __patchable_function_entries "$vmlinux_o" |
+num_ool_stubs_total=$($objdump -r -j __patchable_function_entries -d "$vmlinux_o" |
 		      grep -c "$RELOCATION")
-num_ool_stubs_inittext=$($objdump -r -j __patchable_function_entries "$vmlinux_o" |
+num_ool_stubs_inittext=$($objdump -r -j __patchable_function_entries -d "$vmlinux_o" |
 			 grep -e ".init.text" -e ".text.startup" | grep -c "$RELOCATION")
 num_ool_stubs_text=$((num_ool_stubs_total - num_ool_stubs_inittext))
 
-- 
2.51.1

