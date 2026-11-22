Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309314;
	b=axSdxrLRDmVpG2Sea0V4nxdEqJ63X5S101mHcUodU43wl9sN7P5KEoWn62sBzuVcIxTX
	 MkEP52oZNGz4t7Wr5pPFbrHLLgwBa7YKWijxdDuV8kbU8SdOMAad0zswJuhh/wE9KC5Xt
	 xIpE2HJSWh06S/4e+X7fHyuLUQ4btbFMq0/sqaBrhvaoQn8L8YPRqzNgeNQSz6Fh+Aic3
	 M2hPVdHZ5PQGmYkuXTAhTX/GYVFgqOefBBGXTwRr83FaDuonwibjNnutmKNRJFwUuPZHl
	 nfv+GW/ynOYZjrlXXpTr8NQV8/L6S9hGTZYlVSPQhHJnVmy9rrNA9E1VURP04MjX+4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309314;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TO2OayJ1Ir05pUCA7mnA5khhEAkASCecaweaOnkT+eo=;
	b=cjFCriBOrnhy93b/bRS2zIezTuy2fXa6MbRpm+fx/xe1OGbeEydD530pYx1VqoGoQFBQ
	 og48I6Dn7xY0nxSEVW5Qer+cFXmj+UFqUNprdoDnU0oQw2ey1NqhMigRvyK4udTVpfq6h
	 EgTfbWGOiQnN4wmejs0Yzq7YdOiPJteQgJl+HLSa7WxFpx3+v21RuN5Y9bJdzMH0oOTtc
	 bisX2dQzYMOp+0fR9sm+UMarwdGnPdUlN9C7+XET5eI+DhZJhAiEqpnlnzUWaY98DrsDC
	 afSCZeVPUNlYScL8FZwBEMK2dgE4LHmcs47GfuXHvIiTnABpOLGcUiA9NCazxC+2KVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jo0TgLG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F24606A32C;
	Sun, 22 Nov 2026 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jo0TgLG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79531F000C0;
	Sun, 22 Nov 2026 01:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309314;
	bh=TO2OayJ1Ir05pUCA7mnA5khhEAkASCecaweaOnkT+eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jo0TgLG/caA2i+fP3s7uTkuzWd+6K2Jh07WujIZCzAHT7Gjtcf8NoM1ENMTucSc0R
	 +IYJDehiye/QiHv9w6We6OfyBnYS3/c2tWAGVwnNCnt55hGSfWi8jNEge06dmaiq2g
	 wdw3UxnEyKlA62lPSI0lDGJ/S+ZIcziPAW9FN5c3Pfw00+svfovUGAFrtS+sz0L5hq
	 Hpu+eDNe2VQWD08qazcbE6cLO3DA8Qlq1qX5IUYdqbaGulAdklPOuiZEkQa2nlj4wj
	 61hE869LzHgtywU+oERqy7/jHSt53sBb52kPTNnWhpgJ+WK1ADyqkTyxsJmht+6bRI
	 hpWDx9xsDu6Aw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/4] bootconfig: Avoid out-of-bounds pointer arithmetic in xbc_snprint_cmdline_filter()
Date: Sun, 22 Nov 2026 10:01:50 +0900
Message-ID: <179530931041.109991.12049130742435464205.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179530928294.109991.3079999508446852151.stgit@devnote2>
References: <179530928294.109991.3079999508446852151.stgit@devnote2>
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

xbc_snprint_cmdline_filter() passes `buf ? buf + len : NULL` to
snprintf(). While this avoids NULL pointer arithmetic when @buf is NULL,
if @buf is non-NULL and the rendered output exceeds @size (len > size),
evaluating `buf + len` forms a pointer past the end of the @buf
allocation, which is undefined behavior in C even though rest(len, size)
is 0.

Pass `buf && len < size ? buf + len : NULL` so that snprintf() receives
NULL whenever the remaining buffer capacity is 0.

Fixes: dec4d8118c17 ("bootconfig: fix NULL-pointer arithmetic in xbc_snprint_cmdline()")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/bootconfig.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 280b7e73321b..9ae9a215b1da 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -587,8 +587,8 @@ int __init xbc_snprint_cmdline_filter(char *buf, size_t size, struct xbc_node *r
 
 		vnode = xbc_node_get_child(knode);
 		if (!vnode) {
-			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
-				       "%s ", xbc_namebuf);
+			ret = snprintf(buf && len < size ? buf + len : NULL,
+				       rest(len, size), "%s ", xbc_namebuf);
 			if (ret < 0)
 				return ret;
 			len += ret;
@@ -601,7 +601,8 @@ int __init xbc_snprint_cmdline_filter(char *buf, size_t size, struct xbc_node *r
 			 * whitespace.
 			 */
 			q = strpbrk(val, " \t\r\n") ? "\"" : "";
-			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+			ret = snprintf(buf && len < size ? buf + len : NULL,
+				       rest(len, size),
 				       "%s=%s%s%s ", xbc_namebuf, q, val, q);
 			if (ret < 0)
 				return ret;

