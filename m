Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148283;
	b=IaF66S9NlfQLAuR5XYdcXi8Xq+KZvjN5MJGizT83iU0TQf0ttCy5k7gsYhyBmRIGm0E/
	 7BOl/t+HC8Z/pRs/k8Wyx50UT5qylB8PGnIwC/LbLNvAlopEJC8Q4dJd0a4vEJk94KJiS
	 XIqIaZqawzeARvpMEWkLUESKBpuyMy50eXmCI7WvA+enkLbLUVjFKPOw+h30brHOIoWXA
	 NUoheB4YTVqw31OR9XY7T/11yp61E5Er8QZZ/LIsQ1u4G4RrYGieLFsjXek5Ignq9GMg0
	 d+NaVd8QiyPdA92CuPsGLhSUPZ+owIIm5NvLWbKLxJue4ImnI0QZaKQI0zcR80S8o9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kACJ7ZXaXHUkFBoUsoTZ6BZYp/kJP/DHJGEnR2BBz7E=;
	b=Bz5u0WE6hH5aFNQv+u9R969/5U4D+qIH3mn0202CpDDmS3JFQYEMJMHLRVAiPAvrsz5q
	 YKUcCCI3EnlEU7yU+WxynkGPiUrlaoUPwHoL33zffWDlF8WC2bzWQakiG7oIqEJddfrKq
	 wMGGEIQKa9Vnlqr6Qni39oPCwIBJwXolvReP4AFLFFuSrHr5qdDdWTTiwAAIFbzVv2nCl
	 KcoVv0ikjps3+3+hSt0Tcqgy1YdhYFw5WUxQcf6sKdxZRg/QIelCXBa3JykzOo99zagxO
	 dX85qm07RoqOdO0oW0d8vic9EziBkGzJTBTp8uvqNGfUgsRV7wjIdWpSYOxbHzC/Fsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tldq5/Bx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67556606A327;
	Wed, 28 Oct 2026 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tldq5/Bx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A631F01828;
	Wed, 28 Oct 2026 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148283;
	bh=kACJ7ZXaXHUkFBoUsoTZ6BZYp/kJP/DHJGEnR2BBz7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tldq5/BxTvPJhtrfEGKGTcRHiRDtETBVZtkpWEe25TBMvOWeJ2EwAsyP3xqr9fi5I
	 QcyxYReidt3XBY4jD6nFBDf8KtTtopAKmdfPvHBOJMP9D13Kew/gl1hgZCeLw2tTXp
	 lbZg3xl3PzdqWFRc1uW0jUl1Dsj+30UZTNKhNMj1y2td58tev15aAL1fdNrkcswrZv
	 Ik8hOcFME+7Uc8jai3oFcMmWnPXY6RtxWN6UTNLy1ByVLPBuELmCpSihpU4DWCGT40
	 dVeiXAqnS1s2Wq/hHRRso9FFGXXm/ae3hBY22BfcrGAVkMTw66s0tuIJ86h1XOAhQ7
	 JLUJpr5W7XpZQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 08/16] tracing/filters: Reject empty unquoted operand in function event filter
Date: Wed, 28 Oct 2026 09:44:39 +0900
Message-ID: <179314827916.684037.3528281616412050059.stgit@devnote2>
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

In parse_pred(), when parsing an unquoted operand for function events,
if the filter expression has no operand before a delimiter (e.g.
'(ip == )' or '(ip == && x == 1)'), the loop terminates with len == 0.

While an empty quoted string (e.g. 'ip == ""') is syntactically valid
and denotes an empty pattern, an unquoted empty operand is a syntax
error where an operand was expected before the delimiter. Previously,
this accepted the predicate with an empty pattern.

Reject empty unquoted operands by checking '!q && !len' and reporting
FILT_ERR_INVALID_VALUE.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Split from the monolithic function event parsing patch into a
   standalone patch rejecting empty unquoted operands (!q && !len).
---
 kernel/trace/trace_events_filter.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 170d51ff337c..96977eb9af85 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1874,6 +1874,10 @@ static int parse_pred(const char *str, void *data,
 		len = i - s;
 		if (q)
 			i++;
+		if (!q && !len) {
+			parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
+			goto err_free;
+		}
 		if (len >= MAX_FILTER_STR_VAL) {
 			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
 			goto err_free;

