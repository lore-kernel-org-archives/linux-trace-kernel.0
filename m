Received: from mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7E3346A0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136755; cv=none; b=sSYpMl7ptdgAjZkXOjA7hnHR45nXC4z1PODynT6UrvsiSUbHiAFNBF1gx2yVYrvcToEE62ISfFXkDkxQtkq7rLWfMaNV0hT+JqvSriHlLb0GXjnQPkJ1l9pD6uo6YHx+nkb1yhScyuZ3rZjwpJm+NBraaBKaAKDRnP0LVZmoDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136755; c=relaxed/simple;
	bh=LIh/S8T5o/CU1HWeagMhA13QdCfh/QmlKPI5N+uayiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2rpvAdAP9nQIvPp293YA2qkVF7SA9DN9Zm4zueqef4oKHw+SyT7SHz42Wvg6eThx+T3UbE0L8uxBPtUKTPJKZkXOwNgJ6/Yubu97/F1Gd8VYwyAgxDf56aFcbgNndBaG8wYJsuQBKqGSfqjDp8ZLjVVMJch68Sx78NF0Jeoax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dSGBPJzi; arc=none smtp.client-ip=91.218.175.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dSGBPJzi"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LIh/S8T5o/CU1HWeagMhA13QdCfh/QmlKPI5N+uayiY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789136751; v=1; x=1789741551;
 b=dSGBPJzi3Qdd85NnnK36mPRG1BRaIikikfSQLugVR2kYjv2H1CLHTftUZ+ej4CJyZFRLXZVv
 yUPChdfWd471k3z+wm/uMn9MeFGwLsVUqBypeVBkIkXoVg6MsHO1NdOX8X5xS85om9uVaBmke08
 LCPQUFk4uYEqrKxRTB1EQKug=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d2f3ea6285dbf305;
	Fri, 11 Sep 2026 14:25:40 +0000
X-Mizu-Trace-ID: d2f3ea6285dbf305
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ftrace: Use rcu_assign_pointer() for tmp_ops filter hash
Date: Fri, 11 Sep 2026 22:25:12 +0800
Message-ID: <20260911142512.19344-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tmp_ops.func_hash->filter_hash is annotated __rcu, but
update_ftrace_direct_mod() assigns hash to it directly. Sparse reports an
address-space mismatch.

Use rcu_assign_pointer() for the assignment.

Fixes: 50b35c9e50a8 ("ftrace: Use hash argument for tmp_ops in update_ftrace_direct_mod")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609110704.Q3M5vCDV-lkp@intel.com/
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 53d5db60bfa5..673a54fdf392 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6675,7 +6675,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 
 	/* Enable the tmp_ops to have the same functions as the hash object. */
 	ftrace_ops_init(&tmp_ops);
-	tmp_ops.func_hash->filter_hash = hash;
+	rcu_assign_pointer(tmp_ops.func_hash->filter_hash, hash);
 
 	err = register_ftrace_function_nolock(&tmp_ops);
 	if (err)
-- 
2.55.0

