Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917462;
	b=CWxf3lrmIc4JoJoG7Zl0ban3X9/JTiV92TtAxRkQC/W7W9jXnTPrhsxhjG3BV5pmKvmD
	 AYPEQR2Mzvp65GRP/a8HUYxVjfzEhu05pen8EzTjRmsW/KbOw84UFaBPPxcK++dvnL/A4
	 B8bhI0Me8s0NYyzJV0TB+BXstZVkCUtyAbxoobDZSub6iSAPKstnMv3L7FuQiG0W6Q2Wb
	 83SZxUUdAkMk2fxHvLEiyUPfGhLLGOzNSReH83c10SYJ14mLeIM9DzsNznMJ6omnUhvOw
	 bZejxHqmTfxilLyorEfIl5ius9ikU7wPEv6ZnThBtJdqLE88sGv1CZs+Xe2YszzyNfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k+yZzeWmN+Botui1gF8I3aFdw9DE4ZEBx6z93ahO5IM=;
	b=gnLinIVSY5I3g9Lv51d3UA7RVnpp/Sc6vmyFRa+YakJ8p5raY7HKQ6FJC5AyW+2qgdVi
	 mxtfcRqbdvuQaNReONrAINKn3fRxbzp9wsb6KOeFA1hInIu4XS0Bnwcnt/gPw6rOraJl/
	 B0g5EyX7TaLBUBzarDOAPaB4cn2V/FdTGxf2U1BTv4S4d3gb71emGuEHLlKNcZ5hTn/Y4
	 OTIBqIRsiU91njcqd29NA4pVX7MYtK3mbH0ejOSvgS8uOjCZUOjqIDg3tGsQIpWY7hbZn
	 oh8NdYX1bxrTfZ77XjFx8j8+7bafwbyV253nt5If8HVhmVxa+cDueWR3Lw4jFNoHDzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOwnYKhr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B40606A31A;
	Sun, 25 Oct 2026 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOwnYKhr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BECE1F01828;
	Sun, 25 Oct 2026 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917462;
	bh=k+yZzeWmN+Botui1gF8I3aFdw9DE4ZEBx6z93ahO5IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EOwnYKhrMoieplFmTczWDb96lobIEXgBM3VrfxJgK2tndOc71f7oA/ASCWNsJaMfL
	 L7CsquplCRIWM5kLeoopx8eV01dvxmvF4UxOPypLazSlUPmpw4fig1f12uYGEt0Atr
	 V98o2JlWrOpHRtB/Fq+DKkYm9HGqtb2lO2IINC7ZzkvyXjny7HF58EyZgfkguR/uUS
	 lZ52i/ZXeIC5uQ6+JIbV5b318ci5e796MpbeYjK/W1DBrgofrUO2rjPVxwh5ZVDnzL
	 3dfaqag5RacLVtWQlFgwwyz0n+J+FaWCfJlBugIidNmsohGKp2VfygogsXJ9WELUwH
	 pz+vedSELgn8A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/9] tracing/filters: Handle out-of-range CPU for OP_NE in cpumask comparison
Date: Sun, 25 Oct 2026 17:37:38 +0900
Message-ID: <179291745828.492959.16820493379560534093.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179291742944.492959.11659339795290028998.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
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
index 54144ef9d0db..44ca7772ed2c 100644
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

