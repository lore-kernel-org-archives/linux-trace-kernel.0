Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866515B11E;
	Fri,  7 Jun 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750210; cv=none; b=iTvkfRcqDuFnvZC3KHVok9rxZeIhXUbsm7pcSBq/6YuzcgiaomuimjV/YdKkCWgWOPAL1SN/PHjEp4LIgDwmS/Hjubu8LhfTXvd1GirF78ac5YEQFWGu0Eu+OlcGbWEHdQakt8jfp7WI5LeXNXnTGP1gxZrof99OWIIcHNO5bWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750210; c=relaxed/simple;
	bh=I+5QaYIykDUxkM+AktFs0YaLfJqsqXs4Jnxrc3yWOTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PopiWwBMuRPzl4kVIao2ILRSVMykrtZtN71064WnM2DQWR6bKLq+ScPtkvPxbdQH53cP6zDmTF4W04rn0aszs38Epk7CZxjiE/8ZGFQjPYEBTaU3wDdZbCJJtB6l5LYSaj3QWaMN8aph0NKONqG/7AhHmw7Ga2cz2BTEWtCHk7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rtNSPQ+l; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rtNSPQ+l"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717750199; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=03my5rSzWoozmJ4G5TZgDpCn57NCoB6M9R5muxRkurE=;
	b=rtNSPQ+lt4Tx5wNlhs8y5TMJ5WhHkwiO1aM0HIV9JXUn5WubhSs1JD+yjGdWP5FfwwfP2eNdmFfelW3SiDilVU74hhW5TFsP9Ju/z7HaIWsru+OWVjUBOPPzqpdA8Hc2WMPsGhbt1NH5c3F10pPZtl/YQXS4i88xRmhY7F4TESA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W8-ctpw_1717750198;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W8-ctpw_1717750198)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 16:49:58 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] function_graph: Add kernel-doc comments for ftrace_graph_ret_addr() function
Date: Fri,  7 Jun 2024 16:49:56 +0800
Message-Id: <20240607084957.64715-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added kernel-doc comments for the ftrace_graph_ret_addr() function to
improve code documentation and readability.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9299
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/trace/fgraph.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index a13551a023aa..4ad33e4cb8da 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -872,6 +872,12 @@ ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 /**
  * ftrace_graph_ret_addr - convert a potentially modified stack return address
  *			   to its original value
+ * @task: pointer to the task_struct of the task being examined
+ * @idx: pointer to a state variable, should be initialized to zero
+ *	 before the first call
+ * @ret: the current return address found on the stack
+ * @retp: pointer to the return address on the stack, ignored if
+ *	  HAVE_FUNCTION_GRAPH_RET_ADDR_PTR is not defined
  *
  * This function can be called by stack unwinding code to convert a found stack
  * return address ('ret') to its original value, in case the function graph
-- 
2.20.1.7.g153144c

