Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2561DA26;
	Mon, 15 Jul 2024 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053153; cv=none; b=atff0kkDEOkPoUqIzxDjAEN8nzFlN57wt2+6Va7Uhb/riCQzfkCIinoSkBxuBzoUSzGq2mexPhbSAaZWFSKI2a6Efax6GAVnMeQblJ/otQH/+xPl8hoVtC87AXuzKM+AVoDbR94gHR/lghl0MuzYe2cijDloMIbhBkALqO7KcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053153; c=relaxed/simple;
	bh=pC1w+ALRGs7kPNNJbbyZkZWJHS2t3SR5gx69wmxPWqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qGbXf4yjl5ttDzqo1IhUvSARswmNTt14P6KU2OBQRokyKXZqWL//x6dj7VILQ2zIRkb0/VlGlwB8jKvqQ1lAqvnDThY5TbVrThT4hZFqWnvj8Zy/ImCH92HLtppzUWG5PlZ0I7r6YP0GxYl1ATcTjj6rsX9qmJPjvASP1MfAIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nXfWxmUy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nXfWxmUy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FAhNKV013967;
	Mon, 15 Jul 2024 14:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U4bQ51Lzso+baqUS7hjXqt
	SMyWvEKmQn75uHbwijfWM=; b=nXfWxmUyXJ8VByjTR9f46hxlWXP892MW/WJm94
	rhZsxB1ei8zoG3nfxJTcucVFkneKUCAtE3MAWmXKwazi+0T3lrMWx/4MHWw7lubP
	7KvKT7RghJGkIDtF4Ir5LZ3jPgLh2+BsjZ1lj2ahuvo1XcScmTGl7BZhmBbJpLRM
	SJ9nplzdHGlSsrLy4c5D9R1IxT/Jike9HD3p4f7lTqnKnWXzjtOvpOoQzDxFZYrL
	exQmnLaOXqkcF2YiwudW1CtP3n5be0kOnccCSltdr6Yq8Q5P2WLFhhlU1q1ur17Q
	b/lBqhQEm3h8jDaLZpbaeBt1ywmv479dEdocR84TFEHlzl/g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bexncmb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 14:18:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FEIwtZ009678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 14:18:58 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 07:18:57 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 15 Jul 2024 07:18:56 -0700
Subject: [PATCH v2] lib: test_objpool: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240715-md-lib-test_objpool-v2-1-5a2b9369c37e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAM8vlWYC/32OQQ6CMBREr0K69hsKUsGV9zDEtOUj30CLbSEYw
 t0tHMDlS2bezMo8OkLPbsnKHM7kyZoI2SlhupPmhUBNZJal2SUtcg5DAz0pCOjD06r3aG0PeV4
 2VX5tSyEEi83RYUvLYX3UkZX0CMpJo7vd1ZOZFhikD+j2eEc+WPc9Psx8L/2fmzlwKLjAFrHKZ
 FrcPxNpMvqs7cDqbdt+EuXyZNcAAAA=
To: Andrew Morton <akpm@linux-foundation.org>,
        Matt Wu
	<wuqiang.matt@bytedance.com>,
        "Masami Hiramatsu (Google)"
	<mhiramat@kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9vhTpc8Z2jjAVuF_1KtOzrWUkjyEpM9Q
X-Proofpoint-GUID: 9vhTpc8Z2jjAVuF_1KtOzrWUkjyEpM9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150111

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- No changes to actual patch, just rebased, picked up Matt's Reviewed-by
  tag, and added Masami & linux-trace-kernel
- Link to v1: https://lore.kernel.org/r/20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com
---
 lib/test_objpool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index bfdb81599832..5a3f6961a70f 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -687,4 +687,5 @@ static void __exit ot_mod_exit(void)
 module_init(ot_mod_init);
 module_exit(ot_mod_exit);
 
-MODULE_LICENSE("GPL");
\ No newline at end of file
+MODULE_DESCRIPTION("Test module for lockless object pool");
+MODULE_LICENSE("GPL");

---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240531-md-lib-test_objpool-338d937f8666

