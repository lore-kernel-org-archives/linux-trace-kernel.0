Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148265;
	b=x19lYAJ18NDMj0e3XKqdhKOFxwC8zH7QO/9vvuHd/5ehGW9AFydkN0z+JZFJ4g+LWVyh
	 rHAALsI4wAxBNNyMniF3PJies6YJXmbd4loil7BlBAdgaNShtYx1EU7i+5sccnPo4zJXI
	 axapJR/4rG0gecGF2BW2VklHFetcHC95Wi8+TVNWRpWvHeByGZ8A8gXLyBF5KPMcmMGRN
	 NVHR1+Suygru4CVmsDtqqH14p44F2wjUXXy4L9wpEAzh4D1QujHAGnq0GAjVseTPh/dsr
	 tWtC+WmEvbB3pC/1rTjWSrFqBuFeJZJzon+RNLIDdvNL+bJLcRhr/1X74F0OntSKM1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9qaLBeCoOIl+OvSFopDgW1JD4zQoPNa1Eh24UPcQ/JI=;
	b=ujmhuDF6OudlzLLdEuC3khmVY1W6zKNSnEsMHS9VwFkhG+5W+H/PJ2wubnNXWu6mPEBs
	 YS6TCfEH6sZMnhSaSDJ6fycxuxF8FhiAtPAmtz97hBlMfrm9kg6IoZxFM8LxTyPcREQh+
	 buK1IE12YzbVt33hTMXfZoO4+sdbbRUE/pChmJkHOjplg4Kb9SmgyNisHtvSMP+bO5OTD
	 SlUugQtST7BIu+LQfKNTQU9QJPOK1+7kyiH7Bue4ZV3IQ/mtMequNoAuSXzQYdiWCUhGK
	 8isVObolhXa33cVe4gpM3eUPd5z/eyndfL5z2mZkxhuzbCvzrykdMwkjqk3Z8BgzE0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R40eMISi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6997606A31D;
	Wed, 28 Oct 2026 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R40eMISi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD57B1F01828;
	Wed, 28 Oct 2026 00:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148264;
	bh=9qaLBeCoOIl+OvSFopDgW1JD4zQoPNa1Eh24UPcQ/JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R40eMISiVdxdpfIP9D5tpA1U5XrKaR54eskFB+pH/E4Jq5494bSdwpHnyJjeIEUUu
	 g+G5se+bl4aQX3JFgCP9264wX8Upw8UtLyXXRWAWSWd4YJ0vSJ9AquT9h6+luL67T8
	 jc17huuGxN6F3b09N2BpxxeRU8EXnfoPmZqn4jt8chvroVIQvODGM8Ol05BJKwU8B7
	 Lwm6NN7ssq3j5Tv6dTx4ODgBQBEqKyqF52+58or6kuH4mmTo0naSGwnijKM/Rz8VjB
	 YWx52ZWkbGdSPt/WozZblnYfvifjINgc4dTF/hZoKBFgUQ6xrGeoDWPCzxcenhm7je
	 mO2/8mXatcz2g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 06/16] tracing/filters: Check for missing operand after operator in parse_pred()
Date: Wed, 28 Oct 2026 09:44:20 +0900
Message-ID: <179314826057.684037.9228661030047991277.stgit@devnote2>
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

In parse_pred(), after matching the operator and skipping whitespace,
the filter string may terminate (str[i] == '\0') if the operand is
missing (e.g. "ip ==" or "common_pid ==").

For function events, the loop 'for (i++; str[i]; i++)' unconditionally
increments 'i' past the NUL terminator, causing an out-of-bounds read.
For other event types, allocating a predicate only to fail later during
value parsing is wasteful.

Check if 'str[i]' is NUL immediately after skipping whitespace after
the operator, and report FILT_ERR_INVALID_FILTER.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Split from the monolithic function event parsing patch.
 - Check if str[i] is NUL immediately after skipping whitespace after
   the operator in parse_pred() across all event types, as suggested
   by Steven Rostedt.
---
 kernel/trace/trace_events_filter.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2554120ff6d6..3d2a075ec425 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1756,6 +1756,11 @@ static int parse_pred(const char *str, void *data,
 	while (isspace(str[i]))
 		i++;
 
+	if (!str[i]) {
+		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
+		goto err_free;
+	}
+
 	s = i;
 
 	pred = kzalloc_obj(*pred);

