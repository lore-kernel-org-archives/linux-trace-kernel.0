Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C58345740;
	Tue, 25 Aug 2026 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677129; cv=none; b=ogfnTSzKVTAYN1TnEM7gxFpMbnTwo1WdQ2kjXY1YzyUP4MQvqG+mVKMXBQWyt2hq/49MvUOuHLphvMlno+HkMinBVnz8bYMYmkvWzCsw8LVWUHfStzEZyhX+hmUVyMLQMdLwA/FIDlRa0pESCK0+wkXq+aaiRcFBQ0tFJsgqeRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677129; c=relaxed/simple;
	bh=99w3wOFb5w6HW/xrlbCVXthet2PKYtYKUEaV+ZjCndY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuVxfoB6aRYFZT8LIfLgvTv59huCEcfn34XnsAIiiEGP5a9o5KhoHGkv5/rHb1NOKPZiCnQQPyIxfIMi2yFu+O9RgPa3hrUepx6LoN7bZMEDrVooc7RtrUM5hBiL8/vNYfQ3OSgYWy30TVG7U2i+Gpb89A/bpe9iXEAsM1V8BLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M6kj0M4r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M6kj0M4r"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEYkhN1118047;
	Tue, 25 Aug 2026 16:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3JfgqG2o/vywg3+mt
	5vghBY1D5IwkWy+5SY+1jh6UCw=; b=M6kj0M4r4ecxwtTZaAwIgwk9QLXohwAt0
	/NQwNRNAY3TZDBnFGiYoVK4p8j9amCfdNgCQ6tMmKe+KTBxMSlorud6lFFbZJFhY
	DXqYyovjiT6L7dtePfPVrBrgmRhORSaao2wkcW2U2hmcmPchH7FlXJSPSGrNnN//
	NDIJ4M/oH3LFZD2Hpwg2ALuKeoxWwrAHwVigUU5F/iCPSgOv1+cCsyJNC17pv4Wa
	ZHXXNC1nBah4Vlhj+CVhv7t4w0L1dZcibJoxK7aaBqhayDa3vPnJ/kq82WxW5ndL
	OBM9lgfu3zxJfAaUrO0Lt63yG03euMBDpnjM8skQPO223BO9X89Vw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73941h8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 16:58:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PGuGqM023730;
	Tue, 25 Aug 2026 16:58:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragd4dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 16:58:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PGwf5k45810026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 16:58:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A3A12004E;
	Tue, 25 Aug 2026 16:58:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE032004B;
	Tue, 25 Aug 2026 16:58:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 25 Aug 2026 16:58:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id E87041624DF; Tue, 25 Aug 2026 18:58:40 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] ftrace/selftests: Change non-unique test symbol to init_once
Date: Tue, 25 Aug 2026 18:58:40 +0200
Message-ID: <67ac21cd214ec9371276df9ba790e9832cf328d4.1787670777.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787670777.git.agordeev@linux.ibm.com>
References: <cover.1787670777.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oIEdb3RxQilDwhfP4QwBtt77HocaKNWq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0MSBTYWx0ZWRfX9uiPNoMPNqsA
 lUdTc03cE4kTJKZW88wHOPEl7+0AqCqoB1k4VnN3tpLLTvkeNWBB5vk3NCKF2tfgr45F+xX0mIZ
 IzMfUSvwA0X9L1KVZCSqbILnKDX2mLPG2EnDmk9SNwzDt/87HXMhbZM6luoqPGjZJ13F0Th2qoU
 ZtBJChgwiWt1GYtktc79V5CE2xjbRHZlXr1PYHXa+9fSlVDpjz8GgtsQWoqW46OzPDmf3kARrv1
 hwYzj/ZLp31GSZS/gyEHlg89EWQdiXDvjBjrJ2fkaWJRgiBFu2pXYCIQAbbr1OSHtybsyBPKwmJ
 Py742/yDFbyS8hHC77z6D/gsfu/4NAllWcwW9UAcKdTS8L2ofxt1kTKiy33KlSe7z5EJ2zA9lMf
 bxQhJtcleLbgliY3qz0kD1ZYEMDBMCT0bs8k+HlMF+AUOzIrA0h/bTsodXWWMV7I1ukNEDT6cVi
 0qK9RwWsWnD0Eno3PIQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8dc9c4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=eIpQDs71oAkVvSjDqUcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0MSBTYWx0ZWRfX2v6NQVJD+odY
 xdFztU/MFZvhySeWVX4ppag9fUqwGU0FbfdqB7ToZmD2K10OsO0gwGvx1CGPezCgcQXE8/y2xEg
 Br9AYfrF72omlWcJfV0YyRG7RQwi4hk=
X-Proofpoint-ORIG-GUID: oIEdb3RxQilDwhfP4QwBtt77HocaKNWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250141

The name_show symbol is not the best choise, because it often
appears only three times on s390 in kallsyms, with two of them
having module annotations [mdev] and [i2c_core].

Switch to init_once which has many more duplicate instances
all in vmlinux, making it a more reliable non-unique symbol
for testing kprobe registration failure.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq=
_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq=
_symbol.tc
index 07b1177c1634..03eb9e70b438 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol=
.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol=
.tc
@@ -3,7 +3,7 @@
 # description: Test failure of registering kprobe on non unique symbol
 # requires: kprobe_events
=20
-SYMBOL=3D'name_show'
+SYMBOL=3D'init_once'
=20
 # We skip this test on kernel where SYMBOL is unique or does not exist.
 if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' =
]; then
--=20
2.53.0

