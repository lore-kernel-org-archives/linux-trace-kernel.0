Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7E83859F6;
	Tue, 23 Jun 2026 01:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179065; cv=none; b=LgfnxqPC2ZUXUylW+2iWhVV6vsklver7KhJCkvR77MSJRKU6NlCZj0D/J+rtGOcdhVEEDiv9p2GWi+OWHip8CYpQIfwBiM8J7JQpoBWGvhz8twPkW0V03XSWr6Gw4s5yQ9f95GkDFaCpJu57kp4YJuKgo15Ps6bWDILK19NA+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179065; c=relaxed/simple;
	bh=z5s0hhTM8vrbPMEgU+zBo1ewxn60O4m9EDzvREP6uOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSLZ3XE0ClV3mVVuuF5vUoDF3RNJy6vsekLHBlILdFFeGCC1KPGIxoLRRVIm76wW5qbZnTpa1DtbT61wG3dH4lL9+2MLgsH6gFa87aQuZyTTDDvEQ0QNhMx3+mQ5NQ+9TP6iMdxuL/Lj344gx2wCJfdSyToZ7MpaWPZuBuenrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHZ4LHCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHZ4LHCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FEA1F000E9;
	Tue, 23 Jun 2026 01:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179063;
	bh=AqItfMwf8lSN3YOe0I7nNutx9lrvFmYXMpR6tugTZzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JHZ4LHCHeIs/wCU+VXQ8X8JKTG5k4GcbNlbT0uu4DGxVRAoVsuKUqVc6JdDDvfE4I
	 BJ334oZlPFoMvGc/9XICh8hHK0bdbi4WItIX7pf+3RKWz4SUwA/wJIJyr1NkHnst3y
	 uMEs3pUiMUMredh7PfUIUrAklevcIG36gT1meJ5Q663Lp9Wr6bUMPvizfC5hltsjoQ
	 WwMrG+WS30HlEuTSzLh4hWdd4tQrTb2dBhX5BmHZg3+wGEatYpvVqNVQZ9GahPYkyj
	 A07uLBA5J39lw4o+o/EutpEkTp3byd1GUHtPTlaKf94UTJa8+khR7fwVnn+bbeBmx+
	 fcIdGP/pqW+lg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 01/10] tracing/probes: Fix double addition of offset for @+FOFFSET
Date: Tue, 23 Jun 2026 10:44:19 +0900
Message-ID: <178217905962.643090.1978577464942171332.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178217904992.643090.15726197350652241270.stgit@devnote2>
References: <178217904992.643090.15726197350652241270.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since commit 533059281ee5 ("tracing: probeevent: Introduce new argument
 fetching code") wrongly use @offset local variable during the parsing,
the offset value is added twice when dereferencing.
Reset the @offset after setting it in FETCH_OP_FOFFS.

Fixes: 533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace_probe.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 98532c503d02..502fa6da5949 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1241,6 +1241,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 
 			code->op = FETCH_OP_FOFFS;
 			code->immediate = (unsigned long)offset;  // imm64?
+			offset = 0;
 		} else {
 			/* uprobes don't support symbols */
 			if (!(ctx->flags & TPARG_FL_KERNEL)) {

