Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237877;
	b=e6STUm2YR1qrTNxBSl2OdwEVP7SJVAKabso4wpFwqVULLq5pYtCfVcQxVWwLMWlQ0mMg
	 KlOHS5XLTw59xKDnyPTEL0I3tUtyO7Y68lgfSyBYvafoMAR6mne6hTRIpfBM7VY9BwRbj
	 CxytkBsie6QNR+edleOkzWYuwqlWvtV0p0uNgTZOxSS4vVFDmqSaoLdMq4gvftscHknEu
	 NZoFMts01JUCEYYmRMNQ8+zNxRYBouL0ETVUNr0ApTE663Q/pGyQG3/wOfzTs0laFPDjC
	 0aEBao+Gezx7BDS0GhGCGd2sNFZZgFKHd/+jEBY5TJ3HIYJrYYlN1k5xlFgWopRRCww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yYvMb+bZRk6exQgCTpMeUm9e0xS/yor9fbBepbrtbbo=;
	b=XTkjCN6qKckYRjCi2IqTLPohtxSoptUibjGFuGEUu7TI0cDatGyTAbF132xsaGq4MQA5
	 Vd/Okb8mhIqUSD211P188Y/4saiwdSx0cG4oPmDcLR8pQNIxRa8LxOlCwes7RFD9Xv/JU
	 UIbr2Qptf1kGdxue/qV5JSPbiwjTeCc6U4y7D73DN4hrpOeDXMnoQcJEMeKNG7n9f7Jgu
	 9bW1beJTXNbnSVMHnHkntkAmaIpqGAQSfuUJb9BMD7KEPLfQRACo3VMOchXg9iHKsUzLp
	 5vx1+3GXiaAdv7VobONgQrQhKUwMmX7lNTqgJhbmOjJXQx0hy1WogxF3kkfUuIrDNtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKEIUh9p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F06606A31C;
	Thu, 29 Oct 2026 01:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RKEIUh9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EF61F01828;
	Thu, 29 Oct 2026 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237877;
	bh=yYvMb+bZRk6exQgCTpMeUm9e0xS/yor9fbBepbrtbbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKEIUh9pefQvJ6+YvZsnZdqZIkkDDWa/8mM5CHsWYYntp/5+7HePQQKctoPNQHjxu
	 hmEfuyrSBhVL5HmXQhOSniNb83vpgKl+ggGFq09m5Hv9oGprFvIF/Xb18ROk/JxmNI
	 Cfec5oStBkdnLvwbF6GBzKCAxtrrHrhjI8ZNe15a+0kI8RucWWcBuN843IgTwOfSLi
	 mHG8wIaQR8LxX2fC0R+yZbq0twAtheFgbDvEUNy6PIgGbjfNRwFsvkiudBPj3c/tzr
	 wSQ/T9jeLMK7VIlfFqa21FNImyZLCpUwY5iaMVdry8CwXuzK5B1jg8YAYlfvyH921M
	 g6bSbUf0HU39g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 03/15] tracing/filters: Handle out-of-range CPU for OP_NE in cpumask comparison
Date: Thu, 29 Oct 2026 10:37:53 +0900
Message-ID: <179323787340.740114.14434420599496956193.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179323784538.740114.15323117974242744566.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
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
index b35ecb01697b..3f0c73819365 100644
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

