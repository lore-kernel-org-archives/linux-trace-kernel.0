Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC03F1075;
	Wed,  9 Sep 2026 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946237; cv=none; b=MSOCgjPpDrhheIGXGzn7RPjxL4qgeIrz61dDpGDYPDz+endmMCiJUeCQPpBNj7EW5zrgmRJEPkxRMtvCWpuxVVPiWauVvedLDPdA0meMTj9ZpEoQ81uNWepd35GtKv5J5rVsNwEOLopkNLD3BejzCiJnHNA8g3I82jNDo9CmKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946237; c=relaxed/simple;
	bh=Uy8+fa3cDu11VwKyL+MkTAWtr9qRvo3T55ynaHdO+DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUq6fBhz3WspdMGE+fJf52lG/4/HMQt7r4AZ9u7ISaNZ5A/XGuV+4WCRQQA0HyKRN1dAgnf+CZ8ZxSH/IaGAr52qwD/5fxo1GpAInbLR6wKvMt78kQLiCox7alYG2iSdmPYHvDuj3fpq7gA22JvE2veQEX5oBpAwssz6pWgi4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OONcIadS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OONcIadS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1d7F2126182;
	Wed, 9 Sep 2026 09:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2+5prjKPMANylfWIFutZLxvCEaQqhpeANJvVheqI3
	t8=; b=OONcIadSGHKzrBWHjXsBOwtUKhny3nEgAO9qKBbikKSd6nWZnL17YIwU+
	SBrPArJxcgue0+Zd/GpsBkJxwdanom9oFE7k8p/JGb+RNXxVRGDBEIeRdMaIo/xd
	KiXP9AWZpQTSzyiQUq1Kgfj9ccJlXo8wCGlVx3WWisqgGoknudw+QekJ9EDgkAdQ
	Q+PnSuJgT+k+MQJRRkuXNVLrIBp07rhGyf7mBJy8xK4kwrVrBAeFQYVnTh2OTWVR
	CrQSuGfUbD6aPdQbtc5qCTThGGJuVx4bamSLSgLqY9D9TGSrrmbsI6UO0g0ltwzJ
	Uv41ndXHVwjETtC4IMKAPGUN2VGHw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj8cknp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:30:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6899QGvc020749;
	Wed, 9 Sep 2026 09:30:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw9jey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:30:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6899U5U152101456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 09:30:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A05C20043;
	Wed,  9 Sep 2026 09:30:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C42620040;
	Wed,  9 Sep 2026 09:30:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  9 Sep 2026 09:30:05 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 059DC160DFE; Wed, 09 Sep 2026 11:30:05 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc
Date: Wed,  9 Sep 2026 11:29:53 +0200
Message-ID: <20260909092954.2200558-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6pSV8Uo2XJFQeN7f1gTIe3kPkKM4nOwj
X-Proofpoint-ORIG-GUID: 6pSV8Uo2XJFQeN7f1gTIe3kPkKM4nOwj
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa12720 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=8iogyDQ46Larf4JUBJoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwMCBTYWx0ZWRfX2JGVe8HRpP1I
 K/pDg858DJMLTsRUFKvRMLCudfChvnDdqgogP0MuE8xaNN5xUK87Mmw9/t/8g3BMQAP1bItL4Cm
 Filo4f7WHLhVzcorLvAcImoScIc/sFU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwMCBTYWx0ZWRfXyIvu1WNtEaJ5
 gyVVCSbbWtFCXH9tC/rt0ynHRMQTnKwdY2V2W09dW1aHx06fQCaif5wWMbKwDKUJKYyRwKNypGt
 +7Nh/AlMmxXaY+WrjOiqNK7jJaF45TwAKnwdUTuAZ0mRIJdk0MIGXYbO9mUdBGPeNyFuviyZKzV
 qpHkGer9RPuWGjSuBixOmYmH0d/fHmTi75M8bMJdh0J/Qt9/zCA4tTaEdVmJMekKTmChjH7gF6N
 KMl3BoQw8Yavr9K+ktSOAr0bNnk/HwVXDrkY7zYH3CmSIk0y6ToqEh6GDQhBaObqoE2aK7pTibb
 QyFLNB+9uritXQIqUPvmGblYDI+zZf8LW6sgE8nF2nRK01ilmF9EsLlNf9yQY3MWNwxVCxYzYFY
 gF1iA40eU9erwUgTT7x1Irw2vTyok8DuJvUYqvz3PP/5b3cWRoJMWxNPj7d4R1MLd/j5ZwIdXZ2
 NZE1UXy/MaXAcSSBrng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090100

The current regex also matches symbols in modules, which makes the
test fail on s390 where name_show is present only once in the kernel,
but also multiple times in modules:

000001b1401cdc20 t name_show
000001b0c05e6c40 t name_show    [mdev]
000001b0c0495f30 t name_show    [i2c_core]

Fix this by changing the regular expression to only match the function
name.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq=
_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq=
_symbol.tc
index bc9514428dba..07b1177c1634 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol=
.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol=
.tc
@@ -6,7 +6,7 @@
 SYMBOL=3D'name_show'
=20
 # We skip this test on kernel where SYMBOL is unique or does not exist.
-if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]=
; then
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' =
]; then
 	exit_unsupported
 fi
=20
--=20
2.53.0

