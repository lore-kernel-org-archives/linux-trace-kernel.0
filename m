Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389532C94A;
	Tue, 25 Aug 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677129; cv=none; b=Mq7ofwXDQWlkaKMuxTLYyK5/1vC7cUj/fee0Ek+Vwx0rEFTFmHsTAmMzWmzGEvnkDv5jh+I7qpw4fE+6nOdP+JsKdsz52KZ2Y6sV6T9T0s9gXS7yBFZNHnVH3GpEBvIC9g2hE9877ABpwY9d5Ywdlqx+Z7YTtaNcySkxds/jyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677129; c=relaxed/simple;
	bh=/i6fW2eut2JA/Ezrah5O3Escx0UeZsRqkqNhiOHHKD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTUDe6bgCllGmerM2ojkq9RKZ1NlPnlqPgl423uG9ZlET/AoPKd0sTNsirZ8ZkPWzZqJtUXgaz14nqhPvi+e1h0NwkiuVOPvlwo/yetiFRbMg120q72JPQXzolvEILo61RX1LyKackdzLsTZtlQiBVeugOx7tlfP0brEOptK8tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ALABVuIe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ALABVuIe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEYYqN3461720;
	Tue, 25 Aug 2026 16:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Bk8YTgTwsfOPumtaC
	gZJyDFtw/ajHTXOzex7qL1BHP0=; b=ALABVuIesQDgnAEFtcM/5Pe6hbUAsX8i/
	liGxm2HxVs8VECYh6uHnmVyaHqUqLHd8IxH3ouqPKhDmWd4S8CqAcqXXsysf3/9t
	Rswz+dGkk2z36ft3HtKSBvRtuhGnn7qeXnbKpxHwkmfIOKEWJvYrHVHtpMWrxTss
	qj1vUqs/u1fvqHqeTur9ddmQHg0PRZp98Y6/3N6ZYzr1I3U0AgjuxFViY73LQzme
	33NWn8Mk7KhEhigF1Qe9U1h9iwYIKVWLXMtBIIGEkMiZJaxKtCoxZiipkAZg0VYe
	egvyVh0y7EBWJBsEnk1aDcWM9uV2PWmn6o26jqax2e4bOGDcRn4hg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqsfft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 16:58:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PGuGEH008370;
	Tue, 25 Aug 2026 16:58:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh56qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 16:58:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PGwfki45482400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 16:58:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2574C2004D;
	Tue, 25 Aug 2026 16:58:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A0EC20049;
	Tue, 25 Aug 2026 16:58:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 25 Aug 2026 16:58:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id E646A160901; Tue, 25 Aug 2026 18:58:40 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] ftrace/selftests: Fix regex pattern to match vmlinux symbol names only
Date: Tue, 25 Aug 2026 18:58:39 +0200
Message-ID: <24e1b434124b2ae34482f4eed1f6bc51fa73419a.1787670777.git.agordeev@linux.ibm.com>
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
X-Proofpoint-GUID: rViuN_rVSiq1GIXKwBFT6LzD_NyEVok1
X-Proofpoint-ORIG-GUID: rViuN_rVSiq1GIXKwBFT6LzD_NyEVok1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0MSBTYWx0ZWRfXx3jU89ghF3Q4
 Tsqj/Me/P6N39re+rmM/xNycX/VATkUQ1eRQi5eZcTuGtcm6Pgsuv1rqNBA6ZD084HqVEXITHyi
 i61L9Osgn+TBvnEQPVPwAYqpt9Di5Ms81PmYWIcvXBIpcpmEThmKNWpdUCtevRxO+Mnn5NOcrt7
 IR6EF9zEoyu/nYpwaB9MgTv0GE3tHGVAtH1n3oDRf6BLbuVvROJRfRlNw07GUKYx9bjIMtc0SqU
 ucleGJHcvm+msR91GgOg/MhpkYQkJIszdoNDw49px46nocZhlssYml/PxyoaM5J9fHUNe2j8e8m
 KsBjvr2GLN7il2oFIXC5WUyJd3+GbFmGC8pmVE9nBDophM+/91yichZWJXj4/M5kH5LbSitqfp/
 3oKHifg0wmBylfu3ZZTJfPUvx8IQSbHPJcs/t73/gCCnVPeMTBDo1qaB3SQf0zMP6tJNdVkQFgY
 UkSVvkksI4V/3h4Z0Rw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8dc9c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=2Ay0O_eff3bmnNOoanUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0MSBTYWx0ZWRfX1B4CyBYeKcit
 n5LGmJw1/Cwy5faa3Yu1XKv/HG8IIu8mAhxTo5a78X5KYPR1lfoY5K0Gx2tyxcuEDHnmjGw04Vg
 NUqZoUdaCscSwIsyvY61ImCmxsoD4Ok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250141

Commit 1870ddcd94b0 ("bpf: Prefer vmlinux symbols over module symbols
for unqualified kprobes") changed unqualified kprobe lookup to prefer
a unique vmlinux symbol even when modules export symbols with the same
name.

Reflect this change in the test and anchor the grep pattern at the end
of the line so it only counts vmlinux symbols and skips module ones.

Suggested-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
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

