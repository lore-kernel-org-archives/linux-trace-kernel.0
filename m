Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54201C4A13;
	Mon, 16 Dec 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334412; cv=none; b=hq2Pf6cIqIL4oaTMUOt/RLDEES7teO19lgqhqo3kS9qJX2m9oqMowFVzWhHHV1WxS0dIOjaMbdaB+3eqq4js4QCSCXaReOsGoRBF9U89PPeP17GoSodJGzORVwTFICxMWg9IjcQ/bY6Q+/D+btIrWNXmWsgIu4cChhw1ewgQjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334412; c=relaxed/simple;
	bh=LunzrpmbejVkiQrfRXYT+k2sd24HYVljLsHBAxGqlL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKvfEm6Eu5++oVR0j7cGThGAPBDRPh2nxgvGYnKrvtLR/og9E/rlOWf/d1PDaFP26B/lo0aQioQtNBVV7BrudMEupDTKSHSahSMzwwLUF4k0xr6HZw+w1v0SxXZ13S2xAzHBXUw2rbu7mEeWZeAOrjl1YfYutsfL8SEVNDd63SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG5l4qi013864;
	Sun, 15 Dec 2024 23:32:42 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43hadq19h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 15 Dec 2024 23:32:41 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Sun, 15 Dec 2024 23:32:41 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Sun, 15 Dec 2024 23:32:39 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V2] tracing: Prevent bad count for tracing_cpumask_write
Date: Mon, 16 Dec 2024 15:32:38 +0800
Message-ID: <20241216073238.2573704-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675f60b1.050a0220.37aaf.0107.GAE@google.com>
References: <675f60b1.050a0220.37aaf.0107.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6qO6Brv-bjy_kDgcp5vYHbP6zBz_C5VO
X-Authority-Analysis: v=2.4 cv=INT4ChvG c=1 sm=1 tr=0 ts=675fd799 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=RZcAm9yDv7YA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=ifPpds2xWHkUFzapTN4A:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 6qO6Brv-bjy_kDgcp5vYHbP6zBz_C5VO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_02,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=694 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412160060

If a large count is provided, it will triger a warning in bitmap_parse_user.
Also check zero for it.

Reported-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0aecfd34fb878546f3fd
Tested-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: use KMALLOC_MAX_SIZE

 kernel/trace/trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814..109f301549b8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5225,6 +5225,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
+	if (count == 0 || count > KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
 
-- 
2.43.0

