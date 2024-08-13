Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDBB1991D2;
	Tue, 13 Aug 2024 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549622; cv=none; b=VXPR7RbeL91yljF5MnC1X4GKI/EavYTrQFqLsTC8/iw8c9rxYxrqLJEXhM5cM4ac096U+Oa9na0Dkdc9uoz2+ZmbYvE9wsX05LfyKy4LyLgAr3qhXBzE8AOWdP78UFBl/tBOeYbra2UcLtArlvB5mWKsUGAuwjsRoEkvJXH96PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549622; c=relaxed/simple;
	bh=DYwOX3bvc2I/Wodi76K+HqyzxK2YKkr2FDXmZ7RYW28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhuoLdjO4/9uWoz5MLgAdUZLYV7EeimjPPbmaeG40LeEsF4lfUKZGj4V8ZkP19tLMbOMc8FaaeKQ7q05wNyYhym742di8Jb3EcGr+WBNQ6s4gIBzfPMB7tZEdDA9YigadAf04bdZSHWbZ0+XYQWOsrHC5kk3mwb+1IVX+IvlBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WjqKJ6D1pz1HGQj;
	Tue, 13 Aug 2024 19:43:48 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DC9E140134;
	Tue, 13 Aug 2024 19:46:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 13 Aug
 2024 19:46:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <naveen@kernel.org>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <mhiramat@kernel.org>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 3/3] kprobes: Cleanup collect_one_slot() and __disable_kprobe()
Date: Tue, 13 Aug 2024 19:53:34 +0800
Message-ID: <20240813115334.3922580-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813115334.3922580-1-ruanjinjie@huawei.com>
References: <20240813115334.3922580-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)

If kip->nused is not zero, collect_one_slot() return false, otherwise do
a lot of linked list operations, reverse the processing order to make the
code if nesting more concise. __disable_kprobe() is the same as well.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/kprobes.c | 79 ++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ca3fa8652c49..98d71a5acb72 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -206,29 +206,29 @@ static bool collect_one_slot(struct kprobe_insn_page *kip, int idx)
 {
 	kip->slot_used[idx] = SLOT_CLEAN;
 	kip->nused--;
-	if (kip->nused == 0) {
+	if (kip->nused != 0)
+		return false;
+
+	/*
+	 * Page is no longer in use.  Free it unless
+	 * it's the last one.  We keep the last one
+	 * so as not to have to set it up again the
+	 * next time somebody inserts a probe.
+	 */
+	if (!list_is_singular(&kip->list)) {
 		/*
-		 * Page is no longer in use.  Free it unless
-		 * it's the last one.  We keep the last one
-		 * so as not to have to set it up again the
-		 * next time somebody inserts a probe.
+		 * Record perf ksymbol unregister event before removing
+		 * the page.
 		 */
-		if (!list_is_singular(&kip->list)) {
-			/*
-			 * Record perf ksymbol unregister event before removing
-			 * the page.
-			 */
-			perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
-					   (unsigned long)kip->insns, PAGE_SIZE, true,
-					   kip->cache->sym);
-			list_del_rcu(&kip->list);
-			synchronize_rcu();
-			kip->cache->free(kip->insns);
-			kfree(kip);
-		}
-		return true;
+		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
+				   (unsigned long)kip->insns, PAGE_SIZE, true,
+				   kip->cache->sym);
+		list_del_rcu(&kip->list);
+		synchronize_rcu();
+		kip->cache->free(kip->insns);
+		kfree(kip);
 	}
-	return false;
+	return true;
 }
 
 static int collect_garbage_slots(struct kprobe_insn_cache *c)
@@ -1725,28 +1725,29 @@ static struct kprobe *__disable_kprobe(struct kprobe *p)
 	if (unlikely(orig_p == NULL))
 		return ERR_PTR(-EINVAL);
 
-	if (!kprobe_disabled(p)) {
-		/* Disable probe if it is a child probe */
-		if (p != orig_p)
-			p->flags |= KPROBE_FLAG_DISABLED;
+	if (kprobe_disabled(p))
+		return orig_p;
 
-		/* Try to disarm and disable this/parent probe */
-		if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
-			/*
-			 * Don't be lazy here.  Even if 'kprobes_all_disarmed'
-			 * is false, 'orig_p' might not have been armed yet.
-			 * Note arm_all_kprobes() __tries__ to arm all kprobes
-			 * on the best effort basis.
-			 */
-			if (!kprobes_all_disarmed && !kprobe_disabled(orig_p)) {
-				ret = disarm_kprobe(orig_p, true);
-				if (ret) {
-					p->flags &= ~KPROBE_FLAG_DISABLED;
-					return ERR_PTR(ret);
-				}
+	/* Disable probe if it is a child probe */
+	if (p != orig_p)
+		p->flags |= KPROBE_FLAG_DISABLED;
+
+	/* Try to disarm and disable this/parent probe */
+	if (p == orig_p || aggr_kprobe_disabled(orig_p)) {
+		/*
+		 * Don't be lazy here.  Even if 'kprobes_all_disarmed'
+		 * is false, 'orig_p' might not have been armed yet.
+		 * Note arm_all_kprobes() __tries__ to arm all kprobes
+		 * on the best effort basis.
+		 */
+		if (!kprobes_all_disarmed && !kprobe_disabled(orig_p)) {
+			ret = disarm_kprobe(orig_p, true);
+			if (ret) {
+				p->flags &= ~KPROBE_FLAG_DISABLED;
+				return ERR_PTR(ret);
 			}
-			orig_p->flags |= KPROBE_FLAG_DISABLED;
 		}
+		orig_p->flags |= KPROBE_FLAG_DISABLED;
 	}
 
 	return orig_p;
-- 
2.34.1

