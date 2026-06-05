Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C879495526;
	Fri,  5 Jun 2026 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647165; cv=none; b=ltSaW4Y3swIDgCKeYZFU0K8YTaQxkkJivlOOd3HLCd5TySbELTeHE06sQcTm4S7PZhEZEexIeeBUJflTSlSubruTslgU4LE2xqIykDBAKmPAXTkA7cQ4I5IQcOCxdZ4h1p6pX+OSxglrQd6s1Yq2oY1F4lPjyAslr983c9wUmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647165; c=relaxed/simple;
	bh=SPrQ82EoyqeFxVyGSSzXEVkQhKmGpCGdwd76gsY+DYo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uGIpE92QPjx422haHmosWJmhmCJisIm+W4VY62zA2fFhCr3oPNLYFP4uEZxMiL+Gu6cttLB6t/Ja7X3xOZvQlZb7/sdVGSMsdg918ntQp2WRanTNu+g+qZsFF98j4yQ2qVkUEttSYkqUUe5E35qqOyqIWs7N4jRXWn9OluW9dbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4MDYTyJr; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4MDYTyJr"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=P/UmAPiytFwTrNcuTVo3jJjbv2ahSKmBzmXyOw4Hkt4=;
	b=4MDYTyJrcl90mH7iy0GfzGrN2z57Rl8+Ya9qZdl/QD3SKlaFbUfMPTFLlVGBQM31LsUVVObXW
	Mu99kjn6PeXQduuN6CAbjGtDbGIIRw7ypEyw+ITckDDkCjW98n00F15qwuZAi+Q5PORMJBqfcYW
	KbV13tO84tWm4jNvE2OeTNM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gWv9N1jV0zmV8b;
	Fri,  5 Jun 2026 16:04:40 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A2734055B;
	Fri,  5 Jun 2026 16:12:32 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 5 Jun 2026 16:12:31 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <david@kernel.org>, <qiuxu.zhuo@intel.com>, <bp@alien8.de>,
	<akpm@linux-foundation.org>, <rostedt@goodmis.org>, <linmiaohe@huawei.com>,
	<nao.horiguchi@gmail.com>, <mhiramat@kernel.org>,
	<mchehab+huawei@kernel.org>, <tony.luck@intel.com>, <yi1.lai@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: [PATCH] mm/memory-failure: trace: change memory_failure_event to ras subsystem
Date: Fri, 5 Jun 2026 16:12:13 +0800
Message-ID: <20260605081213.154660-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

For historical version, commit 97f0b1345219 ("tracing: add trace event
for memory-failure") introduced memory_failure_event in ras subsystem.
commit 31807483d395 ("mm/memory-failure: remove the selection of RAS")
changed memory_failure_event to memory_failure subsystem. This breaks
the backward compatibility, some user programs rely on it.

Change memory_failure_event to ras subsystem to keep backward
compatibility.

Fixes: 31807483d395 ("mm/memory-failure: remove the selection of RAS")

Reported-by: Yi Lai <yi1.lai@intel.com>
Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Closes: https://lore.kernel.org/linux-mm/CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com
Cc: David Hildenbrand <david@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 include/trace/events/memory-failure.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/memory-failure.h b/include/trace/events/memory-failure.h
index aa57cc8f896b..7a8ee5d1a44e 100644
--- a/include/trace/events/memory-failure.h
+++ b/include/trace/events/memory-failure.h
@@ -1,6 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM memory_failure
+/*
+ * For historical versions, memory_failure_event is in ras subsystem,
+ * some user programs depend on it.
+ */
+#define TRACE_SYSTEM ras
 #define TRACE_INCLUDE_FILE memory-failure
 
 #if !defined(_TRACE_MEMORY_FAILURE_H) || defined(TRACE_HEADER_MULTI_READ)
-- 
2.53.0

