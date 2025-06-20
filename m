Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF72836B4;
	Fri, 20 Jun 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417940; cv=none; b=sifq8+S3veThqSMiKfnxcjoyIdmWmcq36PwUdUJ7xbgTx4UWXgOO10/osPh855Ilmu2NzNRLwd3hMETP5aF6tJbQDD89V3RD1CWX8dva2ilABrlAMkLJIXqhtO9+GV/opUosgSD9TSCnOEc7jrG5KoA5f+CrvZmtn7XklPLnrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417940; c=relaxed/simple;
	bh=WMxIjt67lfuwqeKRpfaOj1XAiUSOcn4mzIZSrhiNk7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qHBM2lQft+ML6ZPZUp7iFtF/NQuuc+SFO6wsrKBVK10ol0fEjVmcMWQqSa+1WUXdC+ARMv+qw/YmAjHWdCYJK9neTvSs6YxdO74v91AMYW1RlmKhrzjssvefEwBgdS7ok9k3EbHsEi3vGzxjKPbLuIDB8yTBbo8wvI7SnZla6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjjswfEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjjswfEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADA7C4CEE3;
	Fri, 20 Jun 2025 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750417939;
	bh=WMxIjt67lfuwqeKRpfaOj1XAiUSOcn4mzIZSrhiNk7w=;
	h=From:To:Cc:Subject:Date:From;
	b=LjjswfEM6Xe5engaFwt9Sfm1HxRG/5s0+N5g7hXm6nVvVoOEw4FmuW6Njhw118/yF
	 Y87+h3kKWBKOPkJt1bzl0oq8fRi3nWbX61Am53Yf8J+WJuAj7GccXP/2JPrsTltwIW
	 9fGywE1XG+4nO5bKs4UTHaAyRGcuFCJKS9SYtrW2rUv84m7zDvA9aL/EH1kDraPycx
	 fgrGDrLmA4ptelHhUPzOCBXbrnvF/1ReyiTo2iwHaXemhvs7KXUHMLsF88/nDUF5Qs
	 z4G7CqSTMJcofA5r2MrMSmECRWJzOWdQXQRJ2Jo3B9hIk+nOqXaHhRCEH4rRz6w8II
	 mPHouccUcPZgg==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Song Chen <chensong_2000@189.cn>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] kernel: trace: preemptirq_delay_test: use offstack cpu mask
Date: Fri, 20 Jun 2025 13:12:12 +0200
Message-Id: <20250620111215.3365305-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A CPU mask on the stack is broken for large values of CONFIG_NR_CPUS:

kernel/trace/preemptirq_delay_test.c: In function ‘preemptirq_delay_run’:
kernel/trace/preemptirq_delay_test.c:143:1: error: the frame size of 8512 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Fall back to dynamic allocation here.

Fixes: 4b9091e1c194 ("kernel: trace: preemptirq_delay_test: add cpu affinity")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/preemptirq_delay_test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 9b7037194663..331b49240180 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -117,12 +117,15 @@ static int preemptirq_delay_run(void *data)
 {
 	int i;
 	int s = min(burst_size, NR_TEST_FUNCS);
-	struct cpumask cpu_mask;
+	cpumask_var_t cpu_mask;
+
+	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
 
 	if (cpu_affinity > -1) {
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(cpu_affinity, &cpu_mask);
-		if (set_cpus_allowed_ptr(current, &cpu_mask))
+		cpumask_clear(cpu_mask);
+		cpumask_set_cpu(cpu_affinity, cpu_mask);
+		if (set_cpus_allowed_ptr(current, cpu_mask))
 			pr_err("cpu_affinity:%d, failed\n", cpu_affinity);
 	}
 
@@ -139,6 +142,8 @@ static int preemptirq_delay_run(void *data)
 
 	__set_current_state(TASK_RUNNING);
 
+	free_cpumask_var(cpu_mask);
+
 	return 0;
 }
 
-- 
2.39.5

