Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34A30F958;
	Tue, 25 Aug 2026 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677130; cv=none; b=ZvHOa5zCWCy+sFhtCER9W4tPk7jjCav63q+vH389zmuUg3JqGNDyr6aBzgP72f8TMGG3DoBWTRFlnxA6OBxhr1rydU2f0YMs2Cx6K2wRxj6NBpJIQIY9TkDD8cEoij61xyLi61XfJdf/4OtzfkGoWVD8myF7VTR1L1S78iM0npw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677130; c=relaxed/simple;
	bh=+jSRlRvuDSB7oQ/eh5Ne9Bz2+QbT3bEzcN7BVAlRYC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7o48KzGPVmRp36hbnpSgSBfLAW4GyHUw9u0YrvCNeVX6N9YWJjNw4kVxLHM7aRU/kllAbTjSXITnqFVl1sdx/31j/muwuQvglAESt/ZNSX5Mk0eHueHsHtI+JGbH5k8rMbjv00KQxfIvc9ZGnpNdDXkAtjFF/6GgpN0/7yz3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EggW78IN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EggW78IN"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEYpAG010494;
	Tue, 25 Aug 2026 16:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TeC+v8dnJeW5CfuXTzTO/YkBTn/fvqBYyPD3yAuqG
	gY=; b=EggW78INqAlZRGdB/+6bhqHdUCAFWbNVWlFZ2+KZupHRafyAC8umMnEvs
	s0wWp97zU1xMuBitYc+RW72md5RX+CXt90bzvlU7JnqSh0WCZJ+N/3rZm2tVOk0v
	QXiD9tbltjuqBHR47Yoa+82nQrOLB/FQvwf0kyIHQEvu616EZqiyAvHxZMQFl+bV
	r4SkuhIaL7M2duw/IhlClauCrIx85nu5ggSpt2JW9uc6t80ZcRun7X4tM5u27hl/
	ZqIisSAs/R/pXUF88Y/jxFwCgiUzuQhmBZYi5KvkOsbDeHPmMhfXwEHKNJyX1R1+
	iXVF9o4h3bTHbzHQhFdjfGzfkV9tQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726ehedf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 16:58:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PGuFcU008346;
	Tue, 25 Aug 2026 16:58:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh56qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 16:58:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PGwfRI46006648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 16:58:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F6BB20043;
	Tue, 25 Aug 2026 16:58:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D9B120040;
	Tue, 25 Aug 2026 16:58:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 25 Aug 2026 16:58:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id E52A11624D1; Tue, 25 Aug 2026 18:58:40 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] ftrace/selftests: Fix registering kprobe on non-unique symbol
Date: Tue, 25 Aug 2026 18:58:38 +0200
Message-ID: <cover.1787670777.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8dc9c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=6szxjtF-vNSU-QkfJLkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0MSBTYWx0ZWRfXxt0USznvKdj0
 7U7SY+cw2dPIwYTHVL1JKC7H8nNijPmQYfWppgVPqN39E4qNgN1Ljz4JPXKJM7bwaWGa502EyMj
 YVgyNzLabyx3IV6UEiwrXyeM5zmzN5M=
X-Proofpoint-GUID: x492vNWrJ1r08RdKRtn9n5v5JZKeSfoJ
X-Proofpoint-ORIG-GUID: x492vNWrJ1r08RdKRtn9n5v5JZKeSfoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0MSBTYWx0ZWRfX+66dpRVnjl3G
 0sL9lF7sArJv45JsL043rBWVeKOxw5F1EzmCc3xyH3mVMdIsgeQsDH+2fw/i+0sEg2QAhYX6OL+
 m3itWFkMIkVxLvxr7H5qkxUYhrdrp4Y+ZTAWWijbBVtGXBZNNNT40AQZGKq3ZI4GI0Se1Km44TZ
 wnfo5F0X+IP+EhFaVjPV/wcDsV7AY8BNGYCfAb02FbksG7VcMV/fyhiBIitXkr790sj0J+oH016
 iGM1kg92C+CSf36c3+TiuuTcrFffkCuRyca4845LzytWWctdH0YMGl9Z+3CEhKCqrngIbUasCg3
 5jXyBjiD1M+wqDQj2vIsQZGFYHG9lBC+3wEzChAIct5J4JR6Ch8ViTl3GjlQq+8aVfxUhtKtrOq
 XFjUvuw59WoTuUcYZrily8kBW5uclM9J2FtzT+Jkvug1TY+ZwdItu/Gvakr+6Zj5sbL0vYl59tk
 dA8TyIyj+EdidHzi+jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250141

Hi All!

Commit 1870ddcd94b0 ("bpf: Prefer vmlinux symbols over module symbols
for unqualified kprobes") broke registering kprobe on non-unique symbol
test - fix and improve it.

Thanks!

Alexander Gordeev (2):
  ftrace/selftests: Fix regex pattern to match vmlinux symbol names only
  ftrace/selftests: Change non-unique test symbol to init_once

 .../selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
2.53.0

