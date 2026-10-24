Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859165;
	b=G/tLgC1X3M++/f0k+INf/Nm0KQ6NoPsNs+gpbipjGxz2ILNRyECfCdhqqrhARfwS8R5f
	 Q9Est/ksY/JZeXA6j9balTBqM+tIyPeYOz/PTdWOy5icAYqMhnQMpmkCnU7NiM7u+c64C
	 ca66G0IrSTft9K2mAoD1XBvxEMTrhYpU5uAMCYqhBe7usXDrzu7CmexJhO6yT0gdhBS0J
	 ZxCTmSIkQxsbECFXpCqFZqOe9oiVklOWi5lTatMLlr5GkEQ9Vz8wxZrKmsocj8pdaoqkm
	 4ggP+qM5Prf1czLlASI0dJcw0rW6EZgm/2WwbiPAkxu1dvuFaiVpKjssPUlDzgSE3kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TBimbwroIx2OTPTGvBjQy4VhvmlUpwRqE5PO0gwaMTc=;
	b=sylUkP5cg33zfmVwbshdkKrbi2h9FonRer5BM2H6mj2tFLgRz0liPaxnQLDjFa0MQfy1
	 JQtOBwi7xdk+R3EFyfxS5+phdNzBGerR1FuGLO5HtKR7PgBkxX/OvzVZw4Z+5NBsDVcxc
	 jCUBth1V4lRJcjbHXu0vCEfdISW8muFcP7ZYXNbj2OX8XW+xRfJxK76IeqVzjqekteFzY
	 rBl470/cXqfAeQR5Y5IprpPoBT03rvML6asBnPcksp9z8tgPC4McuAYXt8AQxE0j0k3LT
	 gJ35DF2lsmW1pbcaxw9VNsG14i5x/h4HxBMbNsrHlts5ufO8KbuNlP6uAatfUe8b5EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH8kniEl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44235606A31A;
	Sat, 24 Oct 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NH8kniEl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730011F01828;
	Sat, 24 Oct 2026 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859165;
	bh=TBimbwroIx2OTPTGvBjQy4VhvmlUpwRqE5PO0gwaMTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NH8kniElpLfFguNp8fKdKaQG8XAaMIJxQFjn3LyGGNEFjj/fVkT6Dh6470BZWotwK
	 6RdGY8qEJiX8NzFSFr4AqE0ForYJU9JdaOh8eDFiUJEggMPhpVeYEqIEAjyvkXAamb
	 dxt2RUunT9Wd901wWRiaNk3GDXLksGZk1FzZ1n8PL9nAJb36u6Lk2/b4vJ0beShtNd
	 tEJU/PWKVNU5JEUTIQTzCOuZsJn86zD0/wR7L4epAxzWL2fuLN0gc4kh5wH48UAAGQ
	 4U8SNo7oqfL9qi1F/Tb9jkks4vakdzrQmkIIYCY8FtpYRFIKqbnHok+7F8ShB0cK7Y
	 PwIbBIi8TfCpg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 04/10] tracing/filters: Handle out-of-range CPU for OP_NE in cpumask comparison
Date: Sun, 25 Oct 2026 01:26:01 +0900
Message-ID: <179285916115.466249.16061782430177051612.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179285912318.466249.7425922682086130057.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
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
index 69da95f42541..d9aeeec4ed91 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -762,7 +762,7 @@ static int filter_pred_##size##_cpumask(struct filter_pred *pred, void *event)	\
 	unsigned int cpu = *addr;						\
 										\
 	if (cpu >= nr_cpu_ids)							\
-		return 0;							\
+		return pred->op == OP_NE;					\
 										\
 	return do_filter_scalar_cpumask(pred->op, cpu, pred->mask);		\
 }

