Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE683B9611
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281667; cv=none; b=kQW5g8Rx3mvepnhK5hDijAjlMkVsx22jU4aK2ED+sWkG7ZIiyLgzlcJZvFJ7dIwer5vxlT2Ww9r+IzrO0S0fCGzP87cugendvJYc3pFXNtHwEP2zsEpHcaA/PdNkTckJSpjjJvKXFELzpCtVxhuIWzWaAHexqsPGXwrksPskRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281667; c=relaxed/simple;
	bh=RwG5fnQARs5R6w5kbCyQKvg9O6oYvqfSlN2LVVEYuJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsAJnR5NXVy1KR0eVnFOdTRp7a1Fxl1tQCFv1dW9R+DNLdN3eQvjcSY1UDUjsNj8aggAA0pP8dQgtVIJzWAdBNoOhXgf0PQPBfhs5lUawCn/hFnSb1avPfxo0nvH+HYC9tud+ORoNqSShUlOR9bHbVMIev0mE32us2fCW2wZCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=VMd5LvXo; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="VMd5LvXo"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-673ee2a98b1so1288886eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281665; x=1774886465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1yJLLdEgvpPxSlPF3ztc/RqimnbBJ4reWjJi17YehI=;
        b=VMd5LvXoj5cWX3nnaIdXFw8G2NwaLVhk2MQYekXqwpVlAowqHDdW7wp/+b+jjfEJfe
         21x7C0he67HZpV4XKugi3SsEPFv05PFXyu8EFRvt2kFv41A5bRrgQFxlxgghAsC+Ftkq
         ahwphz5bhYsVw4U7m484wxKa575BVheyEd8IgMtPhnYnWzSbpkUY1dMrZZeo0AH8lbCC
         CdNzWNPhW2ox/wZzOGbwBBSNy5w9o+80pxktd8gbUUj/4bXSWq0bUdzOsn2LTgQWVaeW
         LuOYYBZuxcmoDSG7usgVSfSHUSlRV7zUQhQq/7cTA8QPc3Nq3QAUihyKkute3BnIgB8d
         0KDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281665; x=1774886465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1yJLLdEgvpPxSlPF3ztc/RqimnbBJ4reWjJi17YehI=;
        b=CNaqtL9azI4Y0uRYsdxtVgBgkpHI1yb/rTwaYZQDvaiZlPsmcaaxqNy76Y/4hKf68F
         95tr+rM+E9sknhbXJ84ANSL8xtLHJXCJxCIOpwAEfGkM2vw/3SckoF15N9VIXSK8HXJS
         LAXkUaiIwpiO8ZWnHlwAbGPG14Bu5WrqmU/bUZPUiJqrfjTaOF4OZmLLVopCBLQJgjhb
         uc9a4aWOMNZ1L6KraGxICFWW9ebv4voaBZUZInXkUrAXmmeN9hOC4cApgijhFmSX+RC6
         ZVeAP6Hdixoqby0SnLqWemOyI5gK8JhSvnArVszLGVOJVNC0mnAmv527MS6AfXXypGO9
         NciQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXcjuSRqUmID78tj47k/lLqBSCxi2q6E+liXitzj5teWJPoAIoqqZYbboHgw1+/rRcuCvQyDvq0H9ie165+dPfa2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpNYFnSbbphfX7tY5KJTU22dEVIeIxW6fbFOXuO88Ws87TU4P
	iQlMy+trw/+gmmq7pj2Qfs51HncbFRbPky9oUAh/8OMqLGya6xIRHilf3xGTONpaD0I=
X-Gm-Gg: ATEYQzyem60TRDwFRp3yud+22wNWxdSh1NoKES9F1x7hQKDicL3DxyD1LsUeRRb2ksN
	ODjHi5rRzvNfTtMF1oqvb69oHs3gaiqLFtZ+zJ/yS2eCmj9GiQdWDWZyJj2fa6YM2lMFaIkrdal
	8rBVeBcfEneAqiALMMBpvMkVhHzT1wuMCRY47kTnb1gsJL3k03V4/Zf5/Dq1rs5zJT7jLWJS1XJ
	OvcWbH+0x9AGRqT76D3iZ0fXcWZdTDG3JnF+wf8+oQNommNKM1pwJR+4nLYCzw2GcFeTxcAMPnd
	ZrrzAerOYLA4MwiAiiy757NiW8HpmXPXsPGHv9uUY3W99+6t0MvBMGYkQE+BfoZ/+ty1qLqw0Jo
	ufPFIYdZuXsJwkTYTHe2amK8o1r3ppjhr5RbhchhPcM4uXLUSgyXG41cqIl9nqb8qmvb8UuxQ1P
	XOlZUhqWH+Chs63GXl5+xHondjeZD0kHsxcCFzkkB3xd71lqfaggyQHgAvBTDKSfTDBA==
X-Received: by 2002:a05:6820:4b06:b0:67b:c567:eebf with SMTP id 006d021491bc7-67c22f0e394mr10655470eaf.31.1774281665205;
        Mon, 23 Mar 2026 09:01:05 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:04 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 02/19] kernel: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:21 -0400
Message-ID: <20260323160052.17528-3-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 kernel/irq_work.c  | 2 +-
 kernel/sched/ext.c | 2 +-
 kernel/smp.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 73f7e1fd4ab4d..120fd7365fbe2 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -79,7 +79,7 @@ void __weak arch_irq_work_raise(void)
 static __always_inline void irq_work_raise(struct irq_work *work)
 {
 	if (trace_ipi_send_cpu_enabled() && arch_irq_work_has_interrupt())
-		trace_ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
+		trace_call__ipi_send_cpu(smp_processor_id(), _RET_IP_, work->func);
 
 	arch_irq_work_raise();
 }
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1594987d637b0..cfbac9cf62f84 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4494,7 +4494,7 @@ static __printf(2, 3) void dump_line(struct seq_buf *s, const char *fmt, ...)
 		vscnprintf(line_buf, sizeof(line_buf), fmt, args);
 		va_end(args);
 
-		trace_sched_ext_dump(line_buf);
+		trace_call__sched_ext_dump(line_buf);
 	}
 #endif
 	/* @s may be zero sized and seq_buf triggers WARN if so */
diff --git a/kernel/smp.c b/kernel/smp.c
index f349960f79cad..537cf1f461d75 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -394,7 +394,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
 		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
 			sched_ttwu_pending : csd->func;
 
-		trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
+		trace_call__csd_queue_cpu(cpu, _RET_IP_, func, csd);
 	}
 
 	/*
-- 
2.53.0

