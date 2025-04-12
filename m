Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B0230BE8;
	Sat, 12 Apr 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744496346; cv=none; b=aTYnVC2Ahyh3RYZ3/wL2OvAPLRLaabqIp9WYaInROwRa6qh/LGDH2vvVW5cyA6R1ijNgrcTyP+2dPXgMdmmnYSRUG9afIBT8JJshHp3XeCt89KrcCwNGOrX/ZzKHRWMdq//UAd6pqURI23BUptzHs30B+t++9U/sSXE3mLQCzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744496346; c=relaxed/simple;
	bh=kuDzUPnqWpY0LD79GLgwgUxFC5auipRyUTvXSYUi+Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVC3auRTyM+j4EkRBGhFDQCKJg9dlGp7po+StH4ZzP+v3becnB+vxj5yOjBwizoul3Mu5i8zN1NLVlgocOZFtlzNhgKbPyfhN9rsWqMeXVG5o9kKEL9bM/y1EMeUvwWiZsbT6cQ8ZGKxRuHTy9EXhjR8EW8J7JnEC65EvJaZDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XzIN2DJL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XzIN2DJL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CL33nO018067;
	Sat, 12 Apr 2025 22:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=d0l23QETrR86BKTGbFZIBjSDN/xiASYRlseP/4Z2R
	Xo=; b=XzIN2DJLe4OZ0qNNLRZct1hgIJO8l1XPeDUFmXm+3D+V2zkXcTuceguep
	GUyE5WH1lrRA1y6muLuIKlQCtehzUTtHsXHXwgu3JPMINefEtvQy+SpHEcHnPGc1
	w85iFJ32kgissl9xGRLkFQ0bkrDevm51Uz4GUeE8VDI3mDA2nlgOMT13LpsWc9MD
	toViVae+fRHyE4YV8KbzLcRQV327m1qrPoxclAHUtPS/MuMjS+xTeSlbAuL0D933
	M0RDE1fkf+sFM7zRDyZZJBJ2V3rON1dH70RT48HilNNAdudyosvVxB2JRywwnHWY
	tyuyDJcpvp08vzwRJGddMvOUgbTRg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45yyrfgbv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 22:18:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53CJkYx5002378;
	Sat, 12 Apr 2025 22:18:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ygs7bc18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 22:18:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53CMInWv35521206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 22:18:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8CA620065;
	Sat, 12 Apr 2025 22:18:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 221BF20069;
	Sat, 12 Apr 2025 22:18:49 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.5.213])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Apr 2025 22:18:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/2] ftrace: Expose call graph depth as unsigned int
Date: Sun, 13 Apr 2025 00:10:42 +0200
Message-ID: <20250412221847.17310-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FM2qqSMySAtrzL5J-7TMtZvbtZAcDFsG
X-Proofpoint-GUID: FM2qqSMySAtrzL5J-7TMtZvbtZAcDFsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_10,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=973 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120170

v1: https://lore.kernel.org/lkml/20250411172207.61332-1-iii@linux.ibm.com/
v1 -> v2: Use unsigned int instead of int.
          Add a follow-up patch that changes depth to unsigned int in
          all events.

Hi,

This series changes the type of depth in all call graph events to
unsigned int.

Patch 1 fixes a size mismatch issue in ftrace_graph_ent_entry, which
causes trace-cmd on 64-bit big-endian systems to output a lot of bogus
spaces, rendering it unusable.

Patch 2 changes type of depth in all other events to unsigned int in
order to better reflect its semantics: it can only be negative
internally, but recorded values are always non-negative.

Best regards,
Ilya

Ilya Leoshkevich (2):
  ftrace: Fix type of ftrace_graph_ent_entry.depth
  ftrace: Expose call graph depth as unsigned int

 kernel/trace/trace_entries.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.49.0

