Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CCC47013A;
	Wed,  5 Aug 2026 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935996; cv=none; b=E4wGC6Q5S8mc5iawD3m1vmFWsiksE25T9ILazaI7Ry0NEvPMeb4E+lJWuZzyltKl2sBrTzu1WVdCBgahV1VRWsslYOSi/johtmLzjXykVV72NvSxKzo9VjyecS8iB2g7vCoz89ceYyK0jHMpJn+0R/pjtRmNXayNTevrhpU7loQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935996; c=relaxed/simple;
	bh=7SSn/eHx9DBm9e/ciZonBoZ7MpWdg1Bs5jWyn6uwsBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXo0ZMX6Oyk3Ffk3BQ+Jrta8h7b0XYtfvrjZsy7/wIGlK0NkfeZPJuEybU8xyiXcnRYeahhZeyByTHVCyhDJzDlmZBgLqGveCxJqi8lf1DjWzqUHmpaH8QB1iZG6wRFS2xQd3hc3lsdg4wf/RQCwMituNLZK/9nzHfaJAtPLEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DlZU5QfM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DlZU5QfM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHnJs3724707;
	Wed, 5 Aug 2026 13:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=r9tp8f63V8MVF39cPBB9Ef/Krl0yRvEborCTSeWgo
	w0=; b=DlZU5QfMoz+l1GRUEpQ2A3d9DWY5GzA1MWDZ3jqjY/+/PFhJUR6khdPyw
	eVcd2Xv1aaGehxGRRJ2QQ4opqZsrBkBIMUJH5wru1ZtwNWZ5DxDgd68rcNav5qsp
	BVmnbjrJ5o+pJoqzn7WMeUDJU7xgxHufl7ApJIvVDnkl8s1m1B3dpE6kk8SjEz9R
	D1BB4ZiJ5zol7kvreSX74w+q2LvlGZKt0qVrfHsRp87PUMX++RJNSRSjr0wGG3ae
	9uiG7WQQquSNkHwoXg0qlshBygeMiZcFbuld1/76yJw+hnj0tJO3Seqil88oqB6M
	X9aDE91O2x8UdXJzWpG6veKxUU8Fg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gatk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:19:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675DBHFE002463;
	Wed, 5 Aug 2026 13:19:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6sx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:19:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675DJkPZ51511644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:19:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C09FB2004B;
	Wed,  5 Aug 2026 13:19:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E80120043;
	Wed,  5 Aug 2026 13:19:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 13:19:46 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, sumanthk@linux.ibm.com
Subject: [PATCH] uprobes: Skip breakpoint installation on non executable vmas
Date: Wed,  5 Aug 2026 15:19:04 +0200
Message-ID: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfXw3FDzfBAk3Fm
 P8tvZ+zA/W6Ak7ylMdYDIGWYSwaejPEA3ZY/gSwjjOdTicFyLeMeEzOxhojOW/8bHiu4nCj8lDl
 g2mOLfY+CvPdZRqMu5XcRYd5NDv5XsnQ1AP9PPanOqkDT4QzGzh+LU/N81bqupPDqEKjk+6V1Kr
 uzR8nfaft/qHdZoH4ktgFQ92ErFL3dPMEC7NJ9L2E0v6SbAHnQgWh/DCna8koA20D7K2xEInLz4
 3Lip/hPRhUFrUEbTlOWZRFbJ5u4gs7FbprmnMyd4gKa7VaFVppfSrmKsmzvZqlER+XqgM5ITTii
 DwFlOYZG3WcJbgDK/+4nzRJ5kHPIRZePq2XmhkGSWHuNPhRz70rpN3QBWJmOnh4NQNnkdoHZMe4
 PBAdkEt9b9EQzJz1S55RmHj1sdTRFJl8PsALvMS0gkZza+VMMOC8UPD3pRlcP5F5Z7frR8uUh8i
 qt4Ozwmu776qpQL9NYA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a733877 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=rEqGk-WHAAAA:20 a=VnNF1IyMAAAA:8
 a=Azb0KeSeonOynWWGDFkA:9 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: -q6khzYLWKGBT06kzF9sww4MkKV6xWQ0
X-Proofpoint-ORIG-GUID: -q6khzYLWKGBT06kzF9sww4MkKV6xWQ0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNyBTYWx0ZWRfX5A9AfjClI1he
 syft5JN9z5SNUM98D9RpxOP1asPj+24J7fEMFvftiyYTbzw9z72zrZaLCu7tf0Hjh5sYfBbUGAF
 oAgAxX29w2H56vnGiQGHQLWPiPnwEhc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050107

bpftrace  -e 'usdt:./testprogs/usdt_semaphore_test:tracetest:testprobe {
printf("%s\n", str(arg1) ); exit(); }'

expects a semaphore increment of 1, but semaphore gets double incremented

Test program:
https://github.com/bpftrace/bpftrace/blob/master/tests/testprogs/usdt_semaphore_test.c

Reason: .text mapping and RELRO mapping resolve to the same page aligned
file offset 0
01000000-01001000 r-xp 00000000 5e:01 usdt_semaphore_test (.text)
01001000-01002000 r--p 00000000 5e:01 usdt_semaphore_test (RELRO)
01002000-01003000 rw-p 00001000 5e:01 usdt_semaphore_test (semaphore)

valid_vma() currently accepts both mappings (which contains executable
text and RELRO mapping) during uprobe registration, since both have
VM_MAYEXEC set. This causes register_for_each_vma() to call
install_breakpoint() twice for the same underlying uprobe offset in the
process.  This means, update_ref_ctr() is called twice for the same
process, so a usdt semaphore is incremented from 0 to 2.

Installing a breakpoint for mapping without VM_EXEC and
updating usdt reference counter in that case is not useful.

Skip non VM_EXEC mappings in install_breakpoint(). This fixes semaphore
double increment as shown in the above usecase.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 kernel/events/uprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6300b216012c..9e0bbc3cf401 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1155,6 +1155,9 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
 	bool first_uprobe;
 	int ret;
 
+	if (!(vma->vm_flags & VM_EXEC))
+		return 0;
+
 	ret = prepare_uprobe(uprobe, vma->vm_file, mm, vaddr);
 	if (ret)
 		return ret;
-- 
2.53.0

