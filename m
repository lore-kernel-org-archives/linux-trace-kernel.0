Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3B33C508;
	Thu, 30 Oct 2025 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817071; cv=none; b=eiRnXcuGsJ8fvdfIZNGfCqI4RhEkdwQf9lFlzH2hygJYfFHzoZyBh2G+Vb/064PvDNfM3eOHMR3et6iQVCnX+kAn5rbyXeU+DJy/HG+I4c+u5nY5N4ls/KnL0wp9F4jHC9wB4AFge9iqTBPdwkkjx4wDQDs00GF0UMFotH5ffYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817071; c=relaxed/simple;
	bh=oUB+sD5yx5ZAX5JF0pnkETiyFLc1qLtAKKqzfO8IB8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofQgZ4JFjofmYt3mYY7flJrsbjI2ELmMnXvZvyvF+JHtkLY+5FpuC8D7bFCj6IHFTLeWl71nunVx+RIpn2OH9CUOf84XzoGyeZSsG2jiqkGkvbs5QUdsDnesCrOQfqXn+T4mvYT+FtsWDVxuydBzlF55MMuQS2ncA3xurLHq/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PrRRfsQl; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PrRRfsQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761817030;
	bh=aa/J/XV8kBv69alA986NlaRArmTri8lBsHBy9uZepLg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PrRRfsQl8dP87IrzWSxlvV6nDaXZ8W8/sueYPvCvp0FA/JY2POa1SRN22II/NyJJG
	 YHJYikUTuFxnRuT+Je+ZfMmGNivdjARsYomPeYzL7lNJtGztN3dx72OKRSWFhbJS14
	 rmU4mhEIN6VL0oes5scIq34F0eLaJTukhFfIbqGc=
X-QQ-mid: zesmtpip4t1761817013t68fd8e7b
X-QQ-Originating-IP: e4iOiRtAzvXnquixMijU3xJVd5hMxKG2dj69EuObgqg=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 17:36:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9801769780485720308
EX-QQ-RecipientCnt: 7
From: hongao <hongao@uniontech.com>
To: mhiramat@kernel.org
Cc: naveen@kernel.org,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	hongao <hongao@uniontech.com>
Subject: [[PATCH v2] 1/1] kprobes: retry pending optprobe after freeing blocker
Date: Thu, 30 Oct 2025 17:36:44 +0800
Message-ID: <2D68B83E59A24077+20251030093644.430507-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251029130247.fa760b2f35f01a91c9e80eee@kernel.org>
References: <20251029130247.fa760b2f35f01a91c9e80eee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NULd4DJcKZL/csxGXBqur5OyI7ikDWXDy0UX82JZVdMl9sjhmmj3cblP
	Eps5PBooxGJIuBLNprt5f+Ebwbklf40mpD0QGr8Crzp3oGMktf0whjaiRzHuYuoZN0wr00y
	0gWq1gWbwnt2pd/5ezfzK/C0DDJlvrmEJUjfczSV2MI2UNHHk+2ErWxWW7iG44BagJ8qkPc
	h7A32N++P8q4RNd144FUPAZ73BqzNu7TQamaigD+qKzoh4TITlMejb9pZuMO38laC+hmj5s
	jg62awu8pS+WsoRnEwdrBSDj0BL99Vx/GZbxKLS8/kThgQJAdPUm8t/D5iQLRn2qjpddhQS
	tHx9OfCl/BFSxUyb13OJAqGJI5VWcvHBZMw1qipW0A0JTog5UAZxG2RpnFByFnkCF6Gb94M
	dyN3JfQq2fhCRe+zDZLDfn6fq+cPiAtKtVYw4f/CCsqBcoxi1td2mEEjwK8I4QDJIAHacgR
	VBELPPfqSTVFYXdXq0pJpYv7DeNfJXis1RBzHElrxP5IfV3A1FzTu3YJxd3uKHoy245Xenp
	yYc1bQv17Mfv+xGP3Njqr79UZYWVwpmOIlTJnJTFWzMbh0id4rwPeHxfvf77NZh9MFWgQf2
	Ad6JLvlhbZW48f3pMjJeObtHqT7skAeP0MZIcxVn1yp6Szy07WeoIR3IVviZYhUW+rfM5PO
	nvHrKdnydhed3elfAyEQwx4O6wES/kDAbBvfKdiCXp6qxOLB1iY5kwIlKtg2pUS20NMqK/a
	4AjLm720rdbRm1mSYjz0hw8szFXEC253+NsLyDQ6ZajtsEmnX4QNGzhqEGUBOOgkPy7M/tP
	+1B8aKtnPB9GA1lQ530HPWqNalAFcEFS88o8ixbX7mXL5RStOTDpPZVUrNgen4yuqemqMVo
	UxksjDL5sswSjpcwKQJTmmNhOW1YdyMRhGSyVgGQsKYt1DIvuXDBKAsmqCBgknyYVQ1ecsv
	k6/i81UEPKhSwP2ZHgpn8HwbdEb/TqED7MXvLZlVVDoKBWN4UX/znVm2K
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Thanks for the review.

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

