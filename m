Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184178;
	b=Jzj9vZg9azQ3yspAa+f24RVQU7gh9Fd/NRpAmvr5xNjGHT9y9NtkmovSF+6o3yhQdpZ+
	 TBhWQoYzyVc83PSKJ6xUBAZdcPTFvwIHn/1/yESyGLGUsSTc1+N6lNpQvaBGfgJXv4ruW
	 30/LUp+GxFnqddWH5SwteIJE25MPy4/YZDOUUnjkaEBDsTNSmU+3sbgGlln4FAJPt5Y5s
	 kTlyf4kQEuuviKkF+VvM2wNBotea3tBt5EOQuOM+gnMjTmBOQ0FCRJOkOGe8L1Xy4OSDe
	 ifIyJsml1E+2EWLlNzDx/1xn/6YfURh4nEZRDGJ1BJkW921guiWZ0IgbuKXmqFePQBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184178;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6a0Z6nyuyBsfHABultW9tj7jTuhqOSr/F6lhJVbRuaY=;
	b=jNMake5aILW381Tj4j4iFF7uYcLkOaZqVLCO3bqYPReW+qk6w5peVpm0g3VoJzf+NiVg
	 huCBTAleKPRKcjWSq514hV4NBWeujFJdJiA+g8cNoT8n7M4FlavgxfwNZKcIECz1iX6u8
	 jrO1a6UWr7gWzOFtMCPPmX81RQTgcsc06sU4yLCozxSKK2joUgc0yQkmdkHiEaR2+5o8L
	 8q3oa8og+LYODb8R3JiIiQwi+O4KgQ2OfBz302mNr4MmmWedhD0Qb+UyZmhHvsjidyA/r
	 GwoqkDJPy1iUHx0fqnFUWVKwBJW2cxMLujpx/q9f2jEEOj1e0g8wU75whxUUIiVd8HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yti4ohCy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EE606D81C;
	Mon,  9 Nov 2026 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yti4ohCy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33781F00901;
	Mon,  9 Nov 2026 00:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184178;
	bh=6a0Z6nyuyBsfHABultW9tj7jTuhqOSr/F6lhJVbRuaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yti4ohCyHRTquqjEVbaUze7eLLrfW8i6s9FhgNGfUt+4B6ClidjY9oad+spZajBoQ
	 wN3Zp7YCZQoBoTeoD9aUyw9TZ/kG0Ir4u4quXa6BpNPVe7CZ9j2wNzXy8xBi40RvZt
	 vJCtzNYV2CqcUuqEn3ROdYHzdVWPMvMQ5/gErsFgNlwUMfKKIfxO2DUjwaDyR4OH55
	 fgqxCuPVfQXis5ktzrSJ5/4pRUbajXEJ8xaxe7w09xC4fI0Yx5YaMkCIx6PSgZU0i4
	 XGX4Z5ApwGa1ecS6THY+5swUWVtoxsCHF/CEq2oYaK4MPfg0Oee3yDv5gYOb4xYV8A
	 Agf+MG9YShcNw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 10/12] tracing/probes: Reject empty fetch expression for %pd and %pD
Date: Mon,  9 Nov 2026 09:29:34 +0900
Message-ID: <179418417434.227715.12236366534299353963.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179418408457.227715.1485179201014819821.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
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

When an argument ends with :%pd or :%pD but has an empty target fetch
expression (such as ":%pd" or "name=:%pd"), traceprobe_expand_dentry_args()
still expands it into an invalid nested dereference expression. The
subsequent parser failure then logs an error position pointing into the
expanded internal string past the end of the user's command.

Reject empty %pd and %pD fetch expressions upfront before expansion.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 67453d0121c9..6e4fe9f6c722 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2434,11 +2434,17 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
 		if (!tmp)
 			return -ENOMEM;
 
+		arg_len = strlen(argv[i]);
+		tmp[arg_len - 4] = '\0';
 		equal = strchr(tmp, '=');
 		if (equal)
 			*equal = '\0';
-		arg_len = strlen(argv[i]);
-		tmp[arg_len - 4] = '\0';
+		if (*(equal ? equal + 1 : tmp) == '\0') {
+			trace_probe_log_set_index(i + 2);
+			trace_probe_log_err(equal ? equal + 1 - tmp : 0,
+					    BAD_FETCH_ARG);
+			return -EINVAL;
+		}
 		if (argv[i][arg_len - 1] == 'd')
 			ret = snprintf(tmpbuf + used, bufsize - used,
 				       "%s%s+0x0(+0x%zx(%s)):string",

