Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA991EBFF7;
	Wed, 10 Dec 2025 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765338012; cv=none; b=COwtvlie6m34PFvBfn0OyMZPuxbYXzvnR8LEEl+XJSFmQIF5C/E2uf1CEi69ftvZvpwCM9XHs6gQkDtQSntENMyya63/Qu+3MmBH8ULhk3KLu/uLEvJx84aLMlZAiVUATB8cM6SWs6l+tAKtwEp/Re9+g0sGcxxCZcNGdJds+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765338012; c=relaxed/simple;
	bh=d3+Z9QI4Fat1zf9AVlcnS36Clj9EQi6kZjfUiOOp7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRI4CdOXfT/xJYDpnUGrDW32f8SaqVVCPgDN6s/TodGTWCPELW0Y4UvR+n6nQ5Uap4Azh7oySlMXlLRtl23zyWiQQV3+zvioi2GJXyEzomPAWUdtjiN5lYbeq1cre4r5lkTq6YnSPIJEBGNYiLIaMf7KzRvxSqF/X2U5pulTsis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CZdw3fbm; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CZdw3fbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765337974;
	bh=Ih4qsXYXzbmqZmYwKjv+HkfkNVFRqg2vrf8OlGDQeU0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CZdw3fbmkgqx9ePJtaBU7FH01M6D7tg05eSP+5Yq6HiazWy+I8mSF5LrMii1583R8
	 wylRxnmLDxE/eODjEEp2QwBjEXlKsvlle9R5u/lKlXMUMht3+DSOEeHZ7QTmmuii88
	 A9Mri+AqKze9kT3W37JB9/7FxGYpvBNPtLr6YDeA=
X-QQ-mid: zesmtpip4t1765337958t0f4f8bf1
X-QQ-Originating-IP: b8H0xMwdrFopSz3wihZ2Nb+4B1ePX3HiK4h2CdDoOko=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Dec 2025 11:39:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5845895000841717394
EX-QQ-RecipientCnt: 7
From: hongao <hongao@uniontech.com>
To: naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	hongao <hongao@uniontech.com>
Subject: [[PATCH v2] 1/1] kprobes: retry pending optprobe after freeing blocker
Date: Wed, 10 Dec 2025 11:33:21 +0800
Message-ID: <C5E6295166D4EDE9+20251210033321.2895692-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MCHGquX4Y4hoT/f4ti2e6aRfCzt3nz+nuG6lzKW7g5ie22ZfCdBgjgZb
	Ysp0mA2btLXA9nn49cnhDODzhiNLclpfeuud3Cx7AECkHPQD/B2xFtt0BM2jEAKXimOaIvx
	vwUHS68tyNOMR0luzsNc2n9vNQQuUiWVyqLGeINtDOm3FjbWRjooWGp2q5i7SeF+9ohWy30
	AdKrjUwhwtWKHbwdpMPYdLqpHKB4S3N+IWRHyHDKIVF/7ddbN39Amfj/quPtIQHNjX6dYNo
	0dkJMHlivYxvEbzk6HgKknshcjkudEoPxbUnzpdEmzmzqSF5Csw6sBpF4d+g+r+pwh/QBqV
	6oaBgKGktDg7O/cwbRNGo3FET6xftUFID44csEmQBloRyvnmTdQS9KTdnBSZK6xoXqRooQ3
	sEg0TfKMOgdSPYs2AW9AdIgPiZqLdF0u9LzrKUf/WccpB5jRgBVDEVPwNmlDELDMcZVwjGW
	yD3RlMIRRGaT8LdQxSgMzSoFXj3HUPN98Qu6+A4+/GA8UsiEj3odj8x/PPcTN0XnjCBSUhV
	Zyoraj50D+MZ+P3zQ2KCl4vD/5VLm3ZVwreuw4+xzyR4ITwAAaIW+r7PXCOUpVAhFcIWUKV
	IQ7O4DKpz80oBigyMM1iY+fuGsuvRxy15oXCauSEA0CeNqNYpn2iuRm/Nj7LM25goWyz48T
	+xuAZF6w/iWLzeKydFMvapbkUYzYnwA4bpIggbuISYvrP59S1rhPtXniwhFuHfXMoYqIH5H
	YGNa5zga/iU161DXxbFUYIxJIX4SQ9buhfzVlFTaBPgIfOqMGJXwXrbtojHVnabtKQKbQ/g
	mYvLbF1JnK7oQSkNBT6yYwOPJTT1kvTOtu+xLxq98c/rrAD7ZJiNmpmHzwOMjgM72G4F3co
	UObq/UeLUVG8agjNGK7t2qgHYsrQzhLZh64JzuGLiiVb3SIUVMvjzHtKzhCDMIt18r7P5xu
	bk+gRo3oalDIB5e2TiRp3rTFezAglM12pMmSjhj5Bvw97Nna5ojJivSxJ3fhotUJ6M8aO46
	zcFV0RyT6Tr7q9VUrBWvVs7F2leOqglMCMZRvHrZ9+UAEMwzcJc7lT383pGADHQZyDzKExk
	cUGvkdCQQGEf8AeHYkp0tqU/rKKIs54KqSiBFrtSZQGOiUKhceY60pe3d7PH7OvsDttTsC3
	idvI
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

The freeing_list cleanup now retries optimizing any sibling probe that was
deferred while this aggregator was being torn down.  Track the pending
address in struct optimized_kprobe so __disarm_kprobe() can defer the
retry until kprobe_optimizer() finishes disarming.

Signed-off-by: hongao <hongao@uniontech.com>
---
Changes since v1:
- Replace `kprobe_opcode_t *pending_reopt_addr` with `bool reopt_unblocked_probes`
  in `struct optimized_kprobe` to avoid storing an address and simplify logic.
- Use `op->kp.addr` when looking up the sibling optimized probe instead of
  keeping a separate stored address.
- Defer re-optimization by setting/clearing `op->reopt_unblocked_probes` in
  `__disarm_kprobe()` / consuming it in `do_free_cleaned_kprobes()` so the
  retry runs after the worker finishes disarming.
- Link to v1: https://lore.kernel.org/all/2B0BC73E9D190B7B+20251027130535.2296913-1-hongao@uniontech.com/
---
 include/linux/kprobes.h |  1 +
 kernel/kprobes.c        | 28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8c4f3bb24..4f49925a4 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -338,6 +338,7 @@ DEFINE_INSN_CACHE_OPS(insn);
 struct optimized_kprobe {
 	struct kprobe kp;
 	struct list_head list;	/* list for optimizing queue */
+	bool reopt_unblocked_probes;
 	struct arch_optimized_insn optinsn;
 };
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index da59c68df..799542dff 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -514,6 +514,7 @@ static LIST_HEAD(freeing_list);
 
 static void kprobe_optimizer(struct work_struct *work);
 static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
+static void optimize_kprobe(struct kprobe *p);
 #define OPTIMIZE_DELAY 5
 
 /*
@@ -591,6 +592,21 @@ static void do_free_cleaned_kprobes(void)
 			 */
 			continue;
 		}
+		if (op->reopt_unblocked_probes) {
+			struct kprobe *unblocked;
+
+			/*
+			 * The aggregator was holding back another probe while it sat on the
+			 * unoptimizing/freeing lists.  Now that the aggregator has been fully
+			 * reverted we can safely retry the optimization of that sibling.
+			 */
+
+			unblocked = get_optimized_kprobe(op->kp.addr);
+			if (unlikely(unblocked))
+				optimize_kprobe(unblocked);
+			op->reopt_unblocked_probes = false;
+		}
+
 		free_aggr_kprobe(&op->kp);
 	}
 }
@@ -1009,13 +1025,13 @@ static void __disarm_kprobe(struct kprobe *p, bool reopt)
 		_p = get_optimized_kprobe(p->addr);
 		if (unlikely(_p) && reopt)
 			optimize_kprobe(_p);
+	} else if (reopt && kprobe_aggrprobe(p)) {
+		struct optimized_kprobe *op =
+			container_of(p, struct optimized_kprobe, kp);
+
+		/* Defer the re-optimization until the worker finishes disarming. */
+		op->reopt_unblocked_probes = true;
 	}
-	/*
-	 * TODO: Since unoptimization and real disarming will be done by
-	 * the worker thread, we can not check whether another probe are
-	 * unoptimized because of this probe here. It should be re-optimized
-	 * by the worker thread.
-	 */
 }
 
 #else /* !CONFIG_OPTPROBES */
-- 
2.47.2

