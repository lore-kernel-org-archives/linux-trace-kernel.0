Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237942;
	b=4at5eWPMC5tUglrZDd3mRVAH68f6i0GokwQm3uBSnCL8sPaOV5fNMZLlWX5vsIS2iX60
	 lbO/UWN9REvqfxX6vzfibb+1wCEEFDdx/6YMrLnBbqPDiT8kyMQgjCzhn+1LBA1PjK0m+
	 8yzfmALEg2RkkKihYoz1eST0tVm9rQKv8JtwGBKt8nX92V0zkdlB5uPaJnlbp53yOPAjt
	 FME/PRtZatoKZBAlPUsMZG/MxiKL06l56V4Zrp5pi8tVjIyqVtu+YJ042UPtE13DW8ldM
	 6H/avHOw5Dq6kK+ogk6xY3F/4B8J/+27dXshr9OuWIWvZM3JhOTxi8gr8pf2iPErlsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hx67ukgl5G+1XLFCkrbBKxs6+lBIv4+lyhvxHggPIfw=;
	b=avCGwBzQtXXaeRMGO+XZMGWzNlkEccb1JS7mJV7T5aaI3xMPRcb2vYt50OnH3BlU7ptt
	 S3VelO1LesCcJcB0QolHha4aELWaQ6AOIehWIYFqUKRSoZI3QiFTm3WdfvMq6vj9DMu1f
	 uWKdvkyZ1iNqGVYmOtFXzKdTVaKLHZ1yMBr9lFXNilZad8P1PpBGkgljRafRRNhefrjgf
	 N6RyM2C6E5oWuamsn52ej+aNB3l3+aZvCGO42veRihhY2yv5+oHGF5jIbFAx+Zv9MyCqB
	 BhX2zLn5Ku4dWYwKQmK8AlDnng97Ajwm4jpgFZK9CzA/2KEvfnF+kEhcUyXsybvuMgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSqGalT1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABA606A31A;
	Thu, 29 Oct 2026 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HSqGalT1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3C21F01828;
	Thu, 29 Oct 2026 01:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237941;
	bh=hx67ukgl5G+1XLFCkrbBKxs6+lBIv4+lyhvxHggPIfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HSqGalT1PYR2YD1SZlmxj7Tscs5rMbGqVaBrYb0XbMyqmoAlP/yikZnYysWjO0qqZ
	 0wX8rsRAmDaalOJleD92i0HQs1tIn5Lsj3ZijKo/dKHb9we6aU/97TTXR0k52rY1Ux
	 tVQAhbdt3Me6DLmhR4kDegIsrT31sE3THmBCny107krmFXm+GepYMvsKOHq9fGbC4Y
	 F+uyVlLSNflPQSyZL9D++kPZDKULjqu6TmGlcVNFKoHbQcq1LPM4H/Avbqhr15bsIW
	 tn4P31JKno4SKslK33aDPFB57A69SGwuGTQdQLC6BkY75pSZB3ZvXlXcDUobPq1csJ
	 nouURUoiOwW7Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 10/15] tracing/filters: Reject stray quotes and parentheses in unquoted function event operand
Date: Thu, 29 Oct 2026 10:38:57 +0900
Message-ID: <179323793740.740114.16357488115964317102.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179323784538.740114.15323117974242744566.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
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
the loop only stops at ')', '&', '|', or the NUL terminator.

However, calc_stack() parses '(', '\'', and '"' independently to
determine stack depth and string boundaries. If an unquoted function
operand contains stray quotes or an open parenthesis (e.g. "ip == foo'bar"
or "ip == foo(bar)"), parse_pred() consumes them as part of the function
name operand, causing parse_pred() and calc_stack() to desynchronize.

Reject unquoted function event operands containing '(', '\'', or '"'
by reporting FILT_ERR_INVALID_VALUE.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4:
 - Drop Fixes and Cc: stable tags since this is an error log improvement
   cleanup rather than a bug fix, as pointed out by Steven Rostedt.
Changes in v3:
 - Split from the monolithic function event parsing patch into a
   standalone patch rejecting stray quotes and '(' in unquoted operands.
---
 kernel/trace/trace_events_filter.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 0a362ccb14ad..e91ec41bfd2a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1869,9 +1869,17 @@ static int parse_pred(const char *str, void *data,
 		for (; str[i]; i++) {
 			if (q && str[i] == q)
 				break;
-			if (!q && (str[i] == ')' || str[i] == '&' ||
-				   str[i] == '|'))
-				break;
+			if (!q) {
+				if (str[i] == ')' || str[i] == '&' ||
+				    str[i] == '|')
+					break;
+				if (str[i] == '(' || str[i] == '\'' ||
+				    str[i] == '"') {
+					parse_error(pe, FILT_ERR_INVALID_VALUE,
+						    pos + i);
+					goto err_free;
+				}
+			}
 		}
 		if (q && !str[i]) {
 			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);

