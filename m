Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446902;
	b=JFzgTZ2K5T93Z9s0m/tOntjtAPuM+lFFlI0BksOVuJQu8KjgrFgSyhdNYXIuIyNhHZvi
	 aFEW5vu5lNTdl3VqIXjZ8qo/Dkfiq7xcQtKoWLVGytco0DBiEfRXqsPjDqL8iL6Z6Jtql
	 zc3VzQNydqO8hB+qh1xnMgNfRZqoMHz0Tfybu7YcyMZvKj0rG2/Gt7/ajxL//ECeT944Y
	 xKkVBW1dTASFnCdsSmzHg/jYphrSdkxAC+tjxPaoVXIqYMoQe37IUGXq0gecgXNBuHzDd
	 MxNKyJ6icC6tHfTYvDdY8dztFybySORb2DCBi/fSFtfv8Diic+ihi9z14w61m/0MuWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PdZExvG0BZOdOgdAjYgOqhMOGgABh34fNpA//58IchI=;
	b=NeABt7oEEHlRVvEdI7ocETLMeABgswhL6qfPEIYw8k3+oo98Tk+kHcWS3VtTIKmRqlBQ
	 cQKt6CoF6hQd57eX0Q6oZttrjjN46AKtDC7hSAubpUXX57AHZ+dPEX6cAFDjSM5oy91kj
	 xoFyMcvyTf3zcFL8Hso4R1WePzfPSzRyfYenHiWm9NANwDf3pWsUvZgKRj1XaRUYCRA4I
	 qnz6r7OBW50+0CeD2QC43hX77s+ijtku3WK3549VpXQGhHDkeYcJdPpaYathCXpqgRsSQ
	 wN29DEpVn9XIbND4P63goU8/T5it9skz7FEwsys7bQtJO7ipfnHCOgrnIR9kG+1CM4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAcbLP6C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E8606A321;
	Thu, 12 Nov 2026 01:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAcbLP6C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F230F1F00A05;
	Thu, 12 Nov 2026 01:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446902;
	bh=PdZExvG0BZOdOgdAjYgOqhMOGgABh34fNpA//58IchI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAcbLP6CYpE6G61QbhYQTCVWNqHzy1KOzFTEnxshlqi6xpW0Z2JKeLCyL9j8rkx9m
	 +2oaCn0WIOiLo81HMX9chtMyE4fz3qmW9SvkhRiX9uzsokNVDJnizCdT0s7AEmFtc4
	 wAncrJMBKCbHQJUKnn19qFLW+rXs8I8rk1zrcCWonx1JP8OYnxxFU92+yK6Cs/8CRb
	 9SlgDyEcTg+Z3TBE7kUJ3eew2LKJar+n4APomy5vA+yaD2vX+wgSTCigPti2g3NOWl
	 ExFg1DmilV21qITEAKgzFFoVolOQyXKmXG11NPsQzu+PNg1L80VD70RClsrr2gUcxn
	 vq/XzEn66i57g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] tracing/probes: Reject empty fetch expression for %pd and %pD
Date: Thu, 12 Nov 2026 10:28:18 +0900
Message-ID: <179444689878.345731.3181785472635784583.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179444679892.345731.5271591537517106679.stgit@devnote2>
References: <179444679892.345731.5271591537517106679.stgit@devnote2>
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
index f0837db354a9..9f29b3333ff8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2435,11 +2435,17 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
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

