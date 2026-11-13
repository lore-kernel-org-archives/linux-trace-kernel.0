Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558583;
	b=fKru7bpjPCn0y8a9uJGcu4bWvXqY7M9EetOapUcQMuHTqPC3Nov4PORT5csHUYyISeVC
	 r0s00NQwj1fGt927ijHuv2gnLti2BqwL5ZiJopYkkI6V2fbOBu1YlGP31fvwDruq1hLDD
	 wvy5kLK1spoSADJREiCLuwn+dz1azNM5L3kUoL/pAoIrcOrwlvsqtzjw7VaGc1qQAf0ew
	 x5reVDAxg4KZ+FQd4or6Wz0DsVpNZNmfdgaC8hKWa2RttKbhNNEYRBh8WMKsfgdtokYYZ
	 uUA5Toar/P6nZwitjKYrI0N9t7UJr37VByCxSUrN8MYonk22wS3EzAZthDl17AnELog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558583;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ESAOSHwV1sJ+u33AYgvznc6YkXyVPAxBVehtrkMeBqk=;
	b=iEb4R0DxJlh+I4dF5EB7aT+SyDrWnjtWSoEW/0chIdHbCg/VykPoRzAWg6NSxRdbZHnp
	 /fG0GsuRtZcYS50zWyQEZmfxtg3N41gvRVunYgguZU1YjT8+JRJELDxhQBm76/i+Zei9j
	 Tthytc83ek+OSfDP/3vn9jwEizWBlbGP4hYPewDiIHU6fAR+oDZced+DqXTZnE9JSqPzg
	 hJvnP3TpoFvbKOEJOQJbhTQFz3eCquHmYbMprJrR9nIiCqI5qtGip6bWSnz032dsLfNqJ
	 o7I+guiF/2JwjN1cCfmPhLmoUhTzN/+HQtihKwVJoykoM13tBSqqNgC5RwTUV/BA3RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hxgc4ZHg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F560A5BD7;
	Fri, 13 Nov 2026 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hxgc4ZHg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119701F000C4;
	Fri, 13 Nov 2026 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558583;
	bh=ESAOSHwV1sJ+u33AYgvznc6YkXyVPAxBVehtrkMeBqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hxgc4ZHgZ/Jo273il5ZJqXAnvina4JWC4afa8n0ShLsVCOQohaDiKag2PByPnM+cy
	 VYfNqkwjud/a0zFkk9b0vZEEQMgEP38Hd7FJCWoNoGlFKSFpYiinVwuIVYHnUT4gbL
	 M38tA1czlmw+I40qGbVTc/69+XjwE2VoOppZSgcijDJlaKyTmMngFJs64QJto/NoUy
	 yP3dfxvpEyqaM3RJ19sTpUmCQZXfmBMh1jiFObKvYxg5iTNhJrmiXe20jvS3EHKQf7
	 5booaKeNtSfD/GVFBHdaGQfn/FZ6gu9lafQVQxgE+knyCwIVj9cnycmpjNooyKtDg6
	 0qGObEu5zP2yA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] tracing/probes: Reject empty fetch expression for %pd and %pD
Date: Fri, 13 Nov 2026 17:29:39 +0900
Message-ID: <179455857970.403392.7144621224332277048.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179455847934.403392.15146485751358774349.stgit@devnote2>
References: <179455847934.403392.15146485751358774349.stgit@devnote2>
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
index 65dc5c19deae..691735277c08 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2438,11 +2438,17 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
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

