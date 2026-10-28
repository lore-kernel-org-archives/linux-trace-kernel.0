Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148246;
	b=sx42sSvHAjVW7f505TYjgmf4bBt6R6/yzu2W9lK6Mageuq+JNuaXw+WlqoOX1L74yKlo
	 dR8E/I3R7nJ4+cfxdB5Hwh9G9xPbndaNGKHSvx8j0ela21dqzL4TutfMeEyUvoARpLYu3
	 cLgfQLXfrV7wO7tKX+gRnykOOFjzB724EHzOSmru9IZZn167OHESeMiIvOyp4ccDH0ScS
	 skjxMADRFSKihG7jPME5TuisEW+10HhwnfO8n1PTI3K0YZjY4+I8OTr6LkJUxmzf2b1rQ
	 C/vtObja/cMqGKSEb8DXnmmVNjfdv5hG10gfe3Vztet45B+ao3KhbNC7fLyd6xQ2KEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148246;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=usOWKzenmKiz2WH6LLtgCuOemrulNXIjys0U/h6pqN0=;
	b=UQ8w2mLOKtADOdVwo5CbK0hweVIrgwi6ejgl3bHk/YMBeaXdjahHEtGLQan9Z0TjZ5zG
	 zxkwSuicbbF7eoREvkgmRw4T6B75IEP9zmKD6BGqpqgTcIU06I3T/CK1Q5v1bzmIuveZZ
	 gn0rGHn4ow1jRUmv77d9UyUnDPKqG90DNz+99OVEWISckexRiQmLJk9kaAzta9/AVajf8
	 15cJJzrL9CCOQRHUQ6nFov/Wb6zM5IqJ+NrwxEkErQ7byD8MNK9pNBF5pD2tCtvgnYmHG
	 LHyxx1TcG7ewY9VQiMPHfo/s1LN4On8qZkpbr0rjGXOdy1wRUXg0myKgEKc8YmedymA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIeiWzjq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5F606A31D;
	Wed, 28 Oct 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIeiWzjq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBD41F01825;
	Wed, 28 Oct 2026 00:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148246;
	bh=usOWKzenmKiz2WH6LLtgCuOemrulNXIjys0U/h6pqN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIeiWzjqPXTFUjoc72IcrmysappGO8JntxQe3i6zXRVuH5TUHkWT6T8vCTOSWkT+V
	 XgPzrFejjLOtLSQNhh9k9ce4Ehap2KuEZKGTbR/bWMAsf3vbBDwdc2X4s6YSX4JRnZ
	 L12AARBRPaz+JSy7su6Yu8pqAN400ufod0rmFQNLR+Y6KrFqg8ldf9TQ5Inah0eonP
	 4RgY1iMjMcMfQCSwUGU9j8fdL/5NvyYgajfU79AGwAy5JG6OctHLksJbEQDT3Nomb5
	 W0M18gtI121JY6L1lu93UHdtzQPJ86p/2zQ1gxyXTmbj+qwLYo9oeYs+YrCaQyQLaz
	 AzDhTwj5aGCHA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 04/16] tracing/filters: Handle out-of-range CPU for OP_NE in cpumask comparison
Date: Wed, 28 Oct 2026 09:44:02 +0900
Message-ID: <179314824223.684037.4554950018476510986.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179314820431.684037.4147763044424284198.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In filter_pred_##size##_cpumask(), if the event's scalar CPU value is
out of range (cpu >= nr_cpu_ids), it unconditionally returns 0.

However, if the predicate operation is OP_NE (e.g., field != CPUS{0,1}),
an out-of-range CPU cannot match any valid CPU in the user-provided
cpumask and the condition is satisfied. Returning 0 produces a false
negative.

Return "pred->op == OP_NE" instead of 0 when cpu >= nr_cpu_ids.

Fixes: 3cbec9d7b93d ("tracing/filters: Enable filtering a scalar field by a cpumask")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 617bc3c0bb0c..3f56e234a02c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -759,7 +759,7 @@ static int filter_pred_##size##_cpumask(struct filter_pred *pred, void *event)	\
 	unsigned int cpu = *addr;						\
 										\
 	if (cpu >= nr_cpu_ids)							\
-		return 0;							\
+		return pred->op == OP_NE;					\
 										\
 	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);		\
 }

