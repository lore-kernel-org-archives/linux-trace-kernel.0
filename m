Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726533B6D9;
	Wed, 22 Jul 2026 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700676; cv=none; b=RCD8qpJCBpZzgAhLhNKn/LaMGxPWmU7eQpztkMweDKA/3Z5v/m84lj5N9v0EIyb/SWQ0Oqx05wvas0kMSP/NES5cTL4ZRFB5lavyW5z87XrP8B8SsU6kI05XswXwyGss4qOfFDkdDs46hgDpJGuZWONdql7iPNsh3aPNwasiUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700676; c=relaxed/simple;
	bh=kVpqv2ys/VmxqmMlz8ypA077Gu9SAZcMU6X9kTILj/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQtMYAdrLQqXmovf8s6Dv5jYcLA09iUCBL7ruQtAp8cbDHrkJbH0Ma7gqzDR3YP13RVBnNmXsZVAT/RcxLjINicaOlepm3aAAdOrkdGScS5qufbknTM0KDQyjf2+IajZ0rrvc1oHlNTi7p9eszEd4MTglpItb2DmOFPcdxZacA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1d31ca48859411f1aa26b74ffac11d73-20260722
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:77552aa2-0d14-4594-bfe7-5735971d64bc,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.3.12,REQID:77552aa2-0d14-4594-bfe7-5735971d64bc,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:e7bac3a,CLOUDID:9dc8ec001a67094a633bdf1ec246e811,BulkI
	D:260722141104DKHVM1LE,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d31ca48859411f1aa26b74ffac11d73-20260722
X-User: liqiang01@kylinos.cn
Received: from cvdaxia.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1835406399; Wed, 22 Jul 2026 14:11:01 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH 0/4] tracing: fix histogram and injection buffer overflows
Date: Wed, 22 Jul 2026 14:10:36 +0800
Message-ID: <20260722061040.112747-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The histogram expression and trace injection paths derive allocation sizes
from unbounded strings or field metadata. This series bounds histogram
formatting, validates user-event field declarations and injection allocation
sizes, and protects dynamic string growth.

The first two patches validate metadata at the producer and consumer
boundaries. The last two tighten trace injection allocation checks, including
events with no user fields.

Li Qiang (4):
  tracing/hist: Prevent overflow in histogram expression strings
  tracing/user_events: Validate explicit struct field sizes
  tracing/inject: Validate entry allocation size
  tracing/inject: Prevent overflow growing string fields

 kernel/trace/trace_events_hist.c   | 89 ++++++++++++++++++++----------
 kernel/trace/trace_events_inject.c | 34 ++++++++++--
 kernel/trace/trace_events_user.c   | 16 ++++--
 3 files changed, 99 insertions(+), 40 deletions(-)


base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
-- 
2.43.0
