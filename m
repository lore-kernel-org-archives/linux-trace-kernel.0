Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917489;
	b=t3tmorRAmmw6YJUA3nz8vJEQb2ZaxvcQZMs0mtBAVAcnzbN84/KFXd6KgVHhm81dNrfM
	 7YHKc25Zk/nS+CqDF+50U5Q0jzYMbC+zhyU89wiXaoRzyK6qEFwd3KKm1myd1fUqSRtrp
	 6By/uMewZyuA5sdnLLydK2IteVOfeaL38VWoDxw9Jt8htGSYyvtITAxE+rcu0zq7SwsAV
	 dI3pyq7ipSu8UGHfGFYYwh7o0+iUFLXQqP2edGwJK3P6fN27+hBzDdgiw8Cllru1ppWgl
	 ghqKesZoaB2nVe2E4I2zyTB03xwZKiTMYEWRiUP8q3f6UMXM++QxAMJEz0ImShuMauw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=C8Xxi7bZQzmM/AkVA4VJC0W2kmA/p+zpIG7MTLL7AX4=;
	b=UllIwNIwbbtpbRhIlc4OAHbOcX1JdtJl6aBYxtnJ8GvTFFI/JKlZvInCrbg2P9QVVBNE
	 7NHkuBI9AlYNqq8wR4NXClkPXFEr8+RicdHjnd4/b3IXB9A8gIKPoocWJansxYjhTpYM5
	 W4jjMokixnDZy5b0Yqf+UWNAnylHxLaDGbgy5R9+toqH9PUq3jGj1DhVpPPu/eoC9U465
	 j5gpp0HgErxJpmduO150X+Nc2IGSc0WnJQ7VxDBPAqtcaNtb9X2JVtJwJ55TuKe7EdAgI
	 jBxCjN8jLFlkOTabhIAxiaByRwpdlMIx5wJuC2R7PZ8gwfiauigvjCTyitqvBeOIMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfnjNNAL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D439606A31B;
	Sun, 25 Oct 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfnjNNAL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2791F01825;
	Sun, 25 Oct 2026 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917488;
	bh=C8Xxi7bZQzmM/AkVA4VJC0W2kmA/p+zpIG7MTLL7AX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CfnjNNALz91Gf4FGXxeDJWcf40YAYP26khtWxG8tr0bO0CrjE98mfyopqYt7Nt6It
	 zHIiJgvzlaKmJOkLfmtCavh86hojZkXH0l0EnWKiwx/foW/Q3pzL5LqDXN+nkNSaks
	 018MPWtOjxWvVxmlCrnCMNjFZLU59GgD88ueXVoIKjivKKRnBCWy474pCsP4fx31SU
	 CmtG61m3IBaD9aejpFuAeXkv1vBNbc2yIw9NvIFZ2Wp6vtvckqyKOsgeL9iEiv/U58
	 MUX4J1dt7fEQOTvWJbwFUtLha3Q7Iht0nyY+isQMyv3iIcU6rD4ZiCeCMXFnqtH3cM
	 jUywMtPMJs+XA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 6/9] tracing/filters: Skip second character of '&&' and '||' in calc_stack()
Date: Sun, 25 Oct 2026 17:38:05 +0900
Message-ID: <179291748555.492959.3275503783612449972.stgit@devnote2>
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

In calc_stack(), when encountering '||' or '&&' (where str[i+1] == str[i]),
the loop sets 'is_pred = false' and continues without advancing 'i' past
the second character of the operator. On the next iteration, the second '|'
or '&' sees str[i+1] != str[i], breaks out of the switch statement, and is
counted as the start of a new predicate (incrementing nr_preds and setting
is_pred = true).

Consequently, a trailing logical operator (e.g. 'common_pid == 1 ||') is
counted as having 2 predicates instead of 1, and any subsequent non-space
character before a delimiter fails to increment nr_preds.

Increment 'i' when matching '||' or '&&' so the entire two-character
operator is skipped.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3bd0b47a627f..bcd37fd6c109 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2208,6 +2208,7 @@ static int calc_stack(const char *str, int *parens, int *preds, int *err)
 		case '&':
 			if (str[i+1] != str[i])
 				break;
+			i++;
 			is_pred = false;
 			continue;
 		case '(':

