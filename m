Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859156;
	b=LtOvkIai4xDliQrdJnaHQ0EhluJ5DetP02DdikhiuQHhmnO54x74kJUZ8jad8SM/2pU2
	 XAq1Q6UXi9DPFHMLxoomAKAio1Wero+LUmS4iMfmVrsAXecaNy/oN+aVTLAOntezgJVVM
	 zvlCjvSoQ0YnxIH4cdCY2FAcpg7/HeJNfL+CVZOInRbKeTCNwXyD3QOQM4ID0l7UR6Qtt
	 s0RwuRZklINZ87YpI/ahmJmKQNO7dN337/o4fQoceuO2qg8jUOiKIPHPTfO7J//2/RoNQ
	 WJ6z+5rs/6pmnFCzKEyXovs36F+CWzNFGtjIFJ0bwyaapm3GabwaVctizsTWXLm8oag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859156;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dX070Ewz6qc5pSc5W0pr0hTHo3VE/xkTK0rhCXuN9c4=;
	b=1nTN91L5ZYBcCuxIT0Hkj+o0V7+0GJ/SiqADS8y+BvNBTSEkCVTa9q5TWAvNdpi6wvp8
	 gh+0s4uPXlaM2R36hZNeKqyQMGyK6loys5Fptyn/FV0Fsvt8jUw6lHajMEEw0cYZ4rfa0
	 Y8o2FRJf1kwfrRRgiP9XKNR9JUOl26SdDu8mPp0wNjdKxXLS4obxKywJbjWH6HmYw//ny
	 u4l7IKypqLwgNZZbZ/9m7dsLb9qmUl2mf3pd+1Df9ftrS2og7btx8TSrGnOby7fCNR+Ka
	 8V3ba4wvxTOZg7vnunIr1uUUrV9ls8rEWL/a4d1XbgQfjzxLelQuessvWHQ6AsFcrQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIJvUOFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47754606A31D;
	Sat, 24 Oct 2026 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIJvUOFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C27C1F01829;
	Sat, 24 Oct 2026 16:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859155;
	bh=dX070Ewz6qc5pSc5W0pr0hTHo3VE/xkTK0rhCXuN9c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIJvUOFu69yVoyLVnTDtLpA6NUyYaSuZCbBYBWypd3if4KXt9g3uJ9Dfvk6421Nmz
	 pcDLj7GVwctBrZ4Sb0tsP4zAWMvvow3MHqC+gQXwpi4R1E2v1gcio34OIuaJrjDvQg
	 WZ64xIhcg7ci8j1xhV8p8lnRmr29Oz+Gf1zOYSp2gBekXhrQ4bpyITiyUSNLAnBdZe
	 LIz7urykTa8m68SnnlIEbQf9TthB8F4Kk6LDbdzBslINg626ugXx8GD0DvI53oR78E
	 qel+BsqM3YAT4fR0P0Nohv6paAicayymf+SHrXAjZj1jjO7dRniED8Nw85JONH00e4
	 jol3jz5QcZmcw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 03/10] tracing/filters: Check CPU bounds before cpumask_test_cpu() in do_filter_cpumask_scalar()
Date: Sun, 25 Oct 2026 01:25:52 +0900
Message-ID: <179285915196.466249.7067056297377577459.stgit@devnote2>
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

In parse_pred(), single-CPU cpumask filters are parsed via cpulist_parse(),
which checks against nr_cpumask_bits (NR_CPUS). When NR_CPUS > nr_cpu_ids,
a user can provide a CPU number where cpu >= nr_cpu_ids.

When evaluating such a predicate in filter_pred_cpumask_cpu(),
do_filter_cpumask_scalar() calls cpumask_test_cpu(cpu, mask) without
checking cpu against nr_cpu_ids. This triggers a WARN_ON_ONCE under
CONFIG_DEBUG_PER_CPU_MAPS and causes an out-of-bounds bit test.

Check "cpu >= nr_cpu_ids" at the start of do_filter_cpumask_scalar(). When
the CPU index is out of bounds, return "op == OP_NE" since an out-of-range
CPU is never present in a valid cpumask.

Fixes: 38c6f6808389 ("tracing/filters: Further optimise scalar vs cpumask comparison")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c2c35b4de85e..69da95f42541 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -695,6 +695,9 @@ do_filter_scalar_cpumask(int op, unsigned int cpu, const struct cpumask *mask)
 static inline int
 do_filter_cpumask_scalar(int op, const struct cpumask *mask, unsigned int cpu)
 {
+	if (cpu >= nr_cpu_ids)
+		return op == OP_NE;
+
 	switch (op) {
 	case OP_EQ:
 		return cpumask_test_cpu(cpu, mask) &&

