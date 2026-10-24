Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859193;
	b=T3pjC8X5SgcbQXVYRLtivsCNZ0G2RIxf19msTUlSg8IpuOFj0+5JulwIQOuhoXD/pgOc
	 yAwBVyVAt0zchsMRZvsL8Qwn+4zIEEnEveQzyE/T6MvB+Bo5ca8le1xiKp45pZKlfxp7U
	 h5tWPnePRNxZ3p8hx+9JvQpBesMieIXozHg2MOASE1bzEMeMKtHi9cGhCyTAradFbuxCT
	 khiKziBnWFM+K8vOBW3CJsu+D7mpA+81fiaPcQFk8yIoLLwzgFoOLaDb1/j1sX48PMDXj
	 isejLyOAncJM87VBnKoDqKTvfw27IHAp9Xiki+jeMPDqhMITCBEIFvDgD7kfioN84VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6hnJgBFdglAF6dXEFA5rs8hQOCYXKV182Qh4+QI28p8=;
	b=Hhl5Dm64/IRXd93na+Qkyd8bnUUWQMYuHRjVenfQOI7w6YrtrxRnfazSZJadS9pNHPM+
	 +JvkQGxLYdqJyAKu7RIswXhKIO19gZy4eXMejUZAg5wWUGTYBrG2CFRn5NIjDNoiqbgqn
	 kuzP2vAAr7/icIbt4XKuUKlg004rIy0Q9hPC+ciGN+3YE6ne5FmK9inCU13kd4dAPvMAd
	 PugJgSqlP9LXJSSScS1RdEdT2N0gZgFydL+r3YHFXnPKOuy8L3CTgxxrg+5wqZ6c9ecyQ
	 XDfZCmS6IY8RRq7V9YfQSzKGnGqCwe5IkP+vdrHSRtMECDRVUvqDBqwIW7Fk3YuMNMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUoFkCqG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530F606A31A;
	Sat, 24 Oct 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZUoFkCqG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C11E1F01828;
	Sat, 24 Oct 2026 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859192;
	bh=6hnJgBFdglAF6dXEFA5rs8hQOCYXKV182Qh4+QI28p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZUoFkCqGj/1W7Gazqyzv1edq82rcqS5GL0yWnb1rZwOXD5zM5dkI0ibUv2hgMe/sL
	 4C8WUzD9bzkMYmlzENGkHHkMqzgrASOs4TMv5ePchAudr+e+0kwF8fuNlELkSxZYop
	 HKuFjCpjHAjvBDJYRzarwsH0mP7C7Br/MFlvwJX7fYiqDJ4TjR1IMKokQzVYxeUlLE
	 uFqoKIX317XIsV7NPX+SitxfzHuK7zJTZ+b4hL4eDX7ELToNOkWgci24LWbmNmsu1D
	 PsiC4A8Ft+juyYtqGCzSpCvjQ1bss1udxaL8ywWWdKgXRhuJxcY1NVfESGkxsjIS2V
	 LQbhtZxPDUkmQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 07/10] tracing/filters: Skip second character of '&&' and '||' in calc_stack()
Date: Sun, 25 Oct 2026 01:26:29 +0900
Message-ID: <179285918908.466249.18270745423264950845.stgit@devnote2>
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
index 96eac7ccd488..e734d8664444 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2207,6 +2207,7 @@ static int calc_stack(const char *str, int *parens, int *preds, int *err)
 		case '&':
 			if (str[i+1] != str[i])
 				break;
+			i++;
 			is_pred = false;
 			continue;
 		case '(':

