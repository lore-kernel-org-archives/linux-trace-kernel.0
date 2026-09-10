Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91358E2DB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789066281; cv=none; b=G88HAHyie8p9V5GFnVTgqG6XkfZKifiDcKo2AD7caIcQBwaGItRR6Bq8yqFr+2JoC/BbeCj+KFJece+kRzr24h9XeE+LS3JQQ9Yz2oSjA0pFRJpjKuy4HxR98+0iMkEdQL7MoLrwdb/dsUjcMEAKCCbLI7cm9fgAiLxBMc/l4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789066281; c=relaxed/simple;
	bh=c9hUQ9kAAl2b2IbncqDZq1k2ejJxuc1g83EyvfAIkis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmV891wLw+LdiB/M3hhEEo73jaGEZ1H68rm7lFF8MaKAygtPwDS+wr7CppAUjOPHUpq8pV89Hy7yMyguPBSE16ALw/EoFBEygnBvAFOvOWwYvChibK08iwkTsmBVbgj2MIfTIR0v3nZX1OBNp4dTdEjR7Suf7y3NKTYDQpnIna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZT+QHQOL; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZT+QHQOL"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90cc107c451so328716d6.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789066275; x=1789671075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=ZT+QHQOLa6RGP+APk20ltNsal1w/dCUGd4vqqbR6Hed8n7USi7jymaRnDPfJKzWjeR
         YddlC4IFv24U8i/3lE+gBq+f8CzWloCFwVLnzxWUX6sRQyS8B/44SfOw3UQ50QN39jZQ
         1U1Rdjlv5nTN1jGfRs25YlzkPcs6ZkqLYAj4AnmtdaqD545UdHrNXOg8JVAKdcTgNUXa
         bARuoRzSU4qm7HSuRhPOpBtmazV0NRsBtkyzCOD3E1N0N4q0335UD1u5+q6DI57z1C3U
         k4D/pLxaeBOA8D5QRkH6BDIH+6N76IaFQ9YDMnXc67aMXaL0B4ygBBXqV9OCddN0CgIv
         oNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789066275; x=1789671075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=twz7P/UgrzFqFrDTfXn+06wBF94/L3aT/pnjRwe1Smk=;
        b=UBSIorr5yraavQakye+kkDOLgCjq5jrqcBrW0gq41cW0LiuQaUoBPvxRYnTnJiRXdY
         f+zIG1TLCjNaRJp6KCfkEdpWWax71Xu81gCiY6TbagYYyzNYgAQtmQph63dfvbHWCGTI
         gjuH3L52/EZ8AuTLZxIU2BQ7YuW32X06X67NgLuRqpdJT2nrqZO2eszK3WKpBooqRKVG
         17PPMffm9Kumc3RcaEpN357WTtnjNWjekNh1xYs+XBCy1Mlwph5zb3IiD3ECEEicn2Ye
         QxrJ+AL6+d/VO/FnxF8ZIWhamZFsa7FN10VglaRLr55dHWODVtQ0fCi+LG6MVORQgbU4
         Dhpg==
X-Forwarded-Encrypted: i=1; AKwUvBy8q2MiFy2EqP5I1+lJlxfFmZ+nXDaxtkZ/YxlQuHVJ83snne6TLg+Gu8eQiKyCtf+DXp7PnccpHmWMAeR+TeRQ3wA=@vger.kernel.org
X-Gm-Message-State: AFuF++mGgnswn+GGlP8fhtHuSSavPLhC/n4qq4zc06+nX74uiRVUTddD
	OK/9Y9KuuNoTV/HH59id06OtH2sdHm7LZCMua7dFKdNOUpHqG4GFL82CtuoccH60ciQ=
X-Gm-Gg: AYBFou1R36G685S4feMmEA4ZqQ9tE73QO7HDg6BJAJ0xWxt/FGFBOw5u1ibmY/98OjJ
	GmjCWhUpvIYLegvp1PfYyl7PURgV9uZZSri9+AsVGtPIfm6kod6V9p01WmdrCA3uTFEenNQjQ0T
	EbZm0yIagSDdw0l4oH5qtMvk7k6tbP8znlBpW/BuTraavHbkcghCQryYF2aVM1T0N0jYuKqpnUY
	yOVfwnXm0bwln9lrCJF9n7frULATLtnu+Q0z/GR3iy2Bm/4YRWFWx8KlTtVKdqmPR9ioo0Ap5tQ
	29hahNnSBTdwfIit+qg7NKIw8hbcIebfgks6dZTm+A7MTnjtZAvxBKYtP+gpyKgdRBbULF1uCUI
	l7wOGFXKnGMngQk/CjXACeBvXL65PMzI2gWb0YHoMDRDazjtW/8EaWFB2e+9pU/7zOHnqP0QD81
	nq/olYwKsW5txUERL1C0rFk8LBf47uO6knTf3vvqPTryVa03XwZ//scqzXQLi+ZwifozjJcT8fO
	dWwLN+0F2vekfrl8Fy7DKWhjnjQsSrgYXg5mFMsHE/7z3lOVJEWUisl
X-Received: by 2002:a05:620a:269d:b0:939:6de9:208b with SMTP id af79cd13be357-939ea2b3827mr16779985a.48.1789066274997;
        Thu, 10 Sep 2026 11:51:14 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f184f5sm49053285a.15.2026.09.10.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:51:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 10 Sep 2026 18:50:35 +0000
Subject: [PATCH RFC 12/13] rcutorture: Bracket Tasks RCU readers with
 trampoline nesting
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-rcu-tasks-preempt-qs-v1-12-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2

rcutorture's tasks flavor models a Tasks RCU reader as "any stretch of
kernel code", and rcu_read_delay() deliberately preempts inside it to
check that a preemption does not end the read-side critical section.
Once preemption outside a trampoline becomes a quiescent state that
model no longer matches what Tasks RCU protects, and the readers would
report false too-short grace periods.

Have tasks_torture_read_lock()/unlock() raise and drop
current->rcu_tramp_nesting so the reader models a trampoline, which is
the thing Tasks RCU actually guards; the deliberate preemption inside it
then continues to be, correctly, not a quiescent state.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/rcutorture.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..df6dd708cea7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1144,11 +1144,17 @@ static struct rcu_torture_ops trivial_preempt_ops = {
 
 static int tasks_torture_read_lock(void)
 {
+	/*
+	 * Model a trampoline: with CONFIG_RCU_TASKS_PREEMPT_QS a preemption is
+	 * otherwise a quiescent state and rcu_read_delay() preempts on purpose.
+	 */
+	rcu_tasks_trampoline_enter();
 	return 0;
 }
 
 static void tasks_torture_read_unlock(int idx)
 {
+	rcu_tasks_trampoline_exit();
 }
 
 static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)

-- 
2.55.0

