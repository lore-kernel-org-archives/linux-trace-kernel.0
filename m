Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D681862;
	Wed, 29 Jul 2026 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284893; cv=none; b=KeObJFzaFq6FMNBssG6LfX64OwwAKcKt8yqOjluFylxWH+cujIqgjxITjVwopw2IahbGZ+48WHigmJ1ZCBezwdg4a/uGG2/MsGPxbZiOOKnF/I3lPBswQ+eze+KryUbEiAoy4DKhP3XAGR6wNzuUOCrDA6Jkb0D+EHDJUHha2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284893; c=relaxed/simple;
	bh=a+hZxuvFRPZ7ZbEkU+xDHLS8Z3q5N5kXPm/pbfPFVZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJN4E9gj4O5fgm8pfq+y059BiM5OKjtnhyXQfEsso5Xz2pQTgRhH0ruSORvR8ZRODpAZOuRBD2DF7FcwDkZ7bHWEOss4Ngk8KhN/hq/9iahV0+tRNWAAFYAlb9wWF5Et53kzvMk2Lmwdm5FUcDEYk+GxC2HRckYkwY8mIhnIP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOpQRu53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOpQRu53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC211F000E9;
	Wed, 29 Jul 2026 00:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785284891;
	bh=m8TvUx6M6Hg7FbTl7Wkwe3DNlTRDm6WOwra9w0aa+HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOpQRu53FHR+eDxKxiQdPKKxIM+Q5YImN4GnK2cxHTNaNLdq2x+DE0pDosvPWnmSN
	 zYCw9zzexaqSsG63qLNJ4BtSd2pEYXa5ZQfAYv8tuWlxV71PnRqetgy0ZNxUBSUH1x
	 G0Vbo9qSzLP4t8ss73i8pKbcFE4vTXLmX9m49I3npGnknIaZQSaTXHfvwuZlKq6bww
	 V6g/GmWeise4s0ynyxqeAByOfgI8DCD6CyDdbW7jRXuTNajaLJhe5ZentmSWyr2Vk6
	 0hOK28IieLP/tpcQHD8PTs3/BiVwhmkQZ92q8QZGNtJcLf6fCInv+Lheixt8T37/Qk
	 ae2jYW2GKgaDQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing/filters: Fix false positive match in regex_match_full()
Date: Wed, 29 Jul 2026 09:28:07 +0900
Message-ID: <178528488779.124250.5571741156199253769.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178528486942.124250.10437463913796837242.stgit@devnote2>
References: <178528486942.124250.10437463913796837242.stgit@devnote2>
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

regex_match_full() calls strncmp(str, r->pattern, len) where len is the
target field buffer size. When len is smaller than r->len (the filter
pattern length), strncmp() checks only len bytes of r->pattern against
str. If those len bytes match, strncmp() returns 0, resulting in a
false-positive match where a shorter string in a fixed-size field
matches a longer filter pattern.

For example, a 4-byte static string field containing "abcd" matched the
filter pattern "abcdefgh" because strncmp("abcd", "abcdefgh", 4)
returned 0. In this case, @len does NOT include '\0' because it is
fixed-size array.

Fix this by returning 0 (no match) early when len < r->len.

Fixes: 1889d20922d1 ("tracing/filters: Provide basic regex support")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 6385cd662d8d..2b46ca536045 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1027,6 +1027,9 @@ static int regex_match_full(char *str, struct regex *r, int len)
 	if (!len)
 		return strcmp(str, r->pattern) == 0;
 
+	if (len < r->len)
+		return 0;
+
 	return strncmp(str, r->pattern, len) == 0;
 }
 

