Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9932A3C8;
	Thu, 11 Jun 2026 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157598; cv=none; b=IC4sZDldnGZjOlxXV3eSasmKRyxN+9plV+7H5fbvqRojV8TJxlh1DhYh3iUoWcqD+3jS8+y2N7CtY6uKxxCn2+BUzbSU/t2h/ve5VTvISnhSXtuZx/QW3MFrZJXH0W1tGcRcJfJZ5F4+XupXbi/4DWPzoYisVzt16oWqXtZhmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157598; c=relaxed/simple;
	bh=6L/q6dP9lWy/R4rAm0cuefHfRwGS//KTuLkVK3OgBVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8N+uAgT/6YBeLv2P+XbSnXqzfJGdIMbq++kA+zxLY0XtssuRPOgsouGHH8lM3BHKs2HE/195g44gulYkW1etNNigne0Iid2JigR27A+iX9SKryG2/89NULwZpn5qSKx08tSZioJcN/1qxlTrTr1FOr9uvlBjKc4WjqmjugrDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACXPdbTTipqvyxFAQ--.9346S2;
	Thu, 11 Jun 2026 13:59:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v5 0/3] tracing: bound histogram expression strings
Date: Thu, 11 Jun 2026 13:59:42 +0800
Message-ID: <20260611055945.22348-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXPdbTTipqvyxFAQ--.9346S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zry3Wr4rZF4fXryrGr4kWFg_yoW8GrWfpF
	4fu3sxGw4ktw4Iyrs3A3WDZ3Z8Xas3GrWUJwsrGw4rKry3Jr4jqFWvk3W5uw1ft34Iqw15
	Kr4DuF4fCFWUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

This v5 starts a new thread and splits the previous expr_str() update
into the preparatory lifetime cleanup, the ERR_PTR() conversion, and the
bounded seq_buf conversion.

The series is based on trace/for-next at 8970865b788e
("Merge trace/for-next").

Patch 1 converts the expr_str() output buffer to __free(kfree).
Patch 2 converts expr_str() failures from NULL to ERR_PTR().
Patch 3 replaces the raw strcat() expression construction with seq_buf
and returns -E2BIG when the rendered expression would exceed
MAX_FILTER_STR_VAL.

Changes since v4:
https://lore.kernel.org/all/20260521022817.38453-1-pengpeng@iscas.ac.cn/
- start a new thread for the new patch revision
- split the __free(kfree) conversion and ERR_PTR() conversion into
  separate patches as requested
- simplify the unary-minus seq_buf conversion with a single
  seq_buf_printf(&s, "-(%s)", subexpr) and keep subexpr manually freed
- keep the seq_buf include unchanged because trace/for-next already has
  <linux/seq_buf.h> in this file

Pengpeng Hou (3):
  tracing: Use __free() for expr_str() buffer
  tracing: Return ERR_PTR() from expr_str()
  tracing: Bound histogram expression strings with seq_buf

 kernel/trace/trace_events_hist.c | 92 ++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 35 deletions(-)

-- 
2.50.1 (Apple Git-155)

