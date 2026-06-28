Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D50535292A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782652378; cv=none; b=UbHRp3MuJf7+MortXm1Qr9MJ1VscX+YgK5+MLsO1jsRxF53xNwpdBEf3L3kKbOR6NLN7Fp5SFoP/hfU+X6Cwclo+C2jeeOLphxcnWGGksbr/VD/yxP6/HRcaHKkUM0GhY68WPYBt553rWEpfi3dbnhlryHU3B/XLpbkGv3ZTv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782652378; c=relaxed/simple;
	bh=ktpAjQPKAIgwBoR2WZC4zLyFO5Rn/PHAzmEEYM+CUrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLoZICsqtXNs2NOZ3I9p1zxz8Yj+CzgA5Bczwoa1W+ABC0hoG1c6KXxYYXQKQquuhL8uBwg0kpW/TaP+8Arkv6hsNBEWY4iupfl+F9fCWQ0qTu7YpYNeKeCvG+aWDSDO6kXJEoNKa6rXshnq3DqjL8KgJtoh5/uMqkI9PVpzYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=JgyGEPDX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="JgyGEPDX"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ee88fce572so8951626d6.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782652376; x=1783257176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9OFengU15XCkRdG8cgWxOjQfjFNsonkolVp/uPcF0E=;
        b=JgyGEPDXitKBfl25EUZzk26fdxYjtomHlhPTpg9URihyOCYrJlyCz1ExnFWrW/xjXS
         NYA0yNn7kuCkzL3mmhxCPjlqPYbNhXsWvhpPhQR1d4OLQrrPQW3DNYUsG+LXzG87blI3
         OXyYHyAlsPEVb0QjsUtqMCctjH2idih2NCYevrPo1TvCJUkuU/ypqMpLf+eyM4nnLSTl
         K5sjOZRkx3pV4ei4qp5ZqHmYCquEMnuaujOAqASeif+eL5mk0WF+cqTemPzrL4ysF+9/
         6NOFjcNABgV8hGk1LrJg09vPgzgFte3o/LdTrWbJ3fzl5wo1lJAOCaLiJaVnUg6d69k0
         LlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782652376; x=1783257176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9OFengU15XCkRdG8cgWxOjQfjFNsonkolVp/uPcF0E=;
        b=ecv3CNzEqA75AvI3+NoGjFXfHCVa7i+ssgS4xvpBQaS4xcHhA35cDitJOYdt2bG6/6
         ir9PJf2LUEU6VNzooFThBaVlzsVle7sch+ZBkxOBnt0aQa3YCkXo+n67QJRCMqlS++zQ
         BJZ0yMgThgpEqhOd6W+5bjQ63qJgHIAeKHGIlyF1AyRGdSIWjmjSfiK4lm21ePwdJ616
         lllrOkPYLOzIiAKQ7FlcRWERiSEmgm200PaiyjMefE2k9fB5U9NRymr2AEZnR9TksV6I
         DNTv4zkW2GY2OUW5SCdND3pqrxq06fc1JhvY0HBsfmFcPwvqb9TK4Tpo1hlKUA2TERIR
         nlfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNRuzXiqr0tgVboqrrt1tYwzP7DlWsPEt2ty5OLrmUElwLdJmF2bu7e+lPFBt5q1dB7kHfGL2zIWUsDSo0dtOlDqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBA4TtFGpkXC5JSw/ysYFDn5IP5iCgB2Q6auiJd/I7fijG2DF
	GsfCX+kU5HQZAdweEgT8PbO+FZvEoQeWfaqXoj6h3ieRpx+0ildfcTWi9EAQgubJW1k=
X-Gm-Gg: AfdE7clI+H/Qh12gcXC/HkTbrfw4cpQ8hBXnHDHD8uPUvsS0apULGI8U+SO02ko7Qz7
	dOP9dsPnMfowoXJTLOcl41WWg0HZcMsBZMtHgJK1K9V8xXKQ4JEFfG3BpVYYoRNfaoJbD1XsxJA
	3nlIaWsu3zJnme2jxQcN32duetJqNaPoCYO7WKBBPZqRhATCR1xQTsxFVJzsPihFywqZ6n5Sjc6
	uR5MZljCorAlHir2owtQQM58sz8xremoOL9PZMG6FyBK+pyFwGzRLIYxOX6CAsVGdTcf5I1agAR
	cTAoSpClGYpezXo+rV0B1FVVsPhhtd7hy3SqaJMjFE/GifRLvr7oaRMf6UXmfXkZg1+KLhps/cy
	uXt75mdEpvRWPYClxZLZw2HM2yCgNiH31TGdtqsUGM9kvImxL1SN8s074WZxW9BVD5TuF5ek6+0
	OXaLik48Zp6EAdfWpY
X-Received: by 2002:a05:6214:3286:b0:8f0:b75:c4ae with SMTP id 6a1803df08f44-8f00b75c65fmr4689516d6.9.1782652376613;
        Sun, 28 Jun 2026 06:12:56 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8df7fbdc9cfsm277603596d6.20.2026.06.28.06.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 06:12:55 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v2] tracing: reject invalid preemptirq_delay_test CPU affinity
Date: Sun, 28 Jun 2026 13:10:22 +0000
Message-ID: <20260628131021.2208632.6a5c6c959813.preemptirq-delay-test-invalid-cpu-affinity@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

preemptirq_delay_test accepts cpu_affinity as a module parameter and,
when it is non-negative, writes that CPU directly into a temporary
cpumask from the worker thread.  Values outside nr_cpu_ids can set a bit
outside the allocated cpumask before the test reports a normal affinity
error.

Validate the requested CPU in preemptirq_delay_run() before setting it
in the temporary cpumask.  Invalid affinity requests are reported by
the test thread and skipped before cpumask_set_cpu() can touch an
out-of-range bit.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Move check to preemptirq_delay_run

 kernel/trace/preemptirq_delay_test.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index acb0c971a408..69e5238737ed 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/trace_clock.h>
+#include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -123,6 +124,13 @@ static int preemptirq_delay_run(void *data)
 		return -ENOMEM;
 
 	if (cpu_affinity > -1) {
+		unsigned int cpu = cpu_affinity;
+
+		if (cpu >= nr_cpu_ids || !cpu_possible(cpu)) {
+			pr_err("cpu_affinity:%d, invalid CPU\n", cpu_affinity);
+			goto out;
+		}
+
 		cpumask_clear(cpu_mask);
 		cpumask_set_cpu(cpu_affinity, cpu_mask);
 		if (set_cpus_allowed_ptr(current, cpu_mask))
@@ -132,6 +140,7 @@ static int preemptirq_delay_run(void *data)
 	for (i = 0; i < s; i++)
 		(testfuncs[i])(i);
 
+out:
 	complete(&done);
 
 	set_current_state(TASK_INTERRUPTIBLE);
-- 
2.43.0

