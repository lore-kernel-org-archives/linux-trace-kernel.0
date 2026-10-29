Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237914;
	b=2dJ1KHWC2QC412FldcNUeDCMYiadMy9KSsDo2C3/cvg0TDdhxMBXNE2VDawt+TdeQUFe
	 yBla1AF6bgmAEFbMIhKEgwlRqN42v5ys6+gBdXXj0DyT9irpuC1guDH162mpTaz6nxlOq
	 hr/hpbU0OWIm/IMzhnACvv0m3LsOItEjzIR7qM7tzsr7kOc7jA3GhQ6Wu+GToGMqdR+KA
	 oM4wFcdn6Y6v24oKktt9GFOEx1bH2eyGXo6ABZbY/vkKl+RuuFyi+KTmp4ukfhVWN+w/Z
	 NVVsaD2jfidIXfFa+CH6BUPGLTv4eXfkp/Y2zdddCU7QpmCZJ9ZGfgHP+O6AYIFvomw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jxH03hHgKl65iUtHtrCqp+AM+yS+y7DQ8MSqObvXwUM=;
	b=b1BJDaH6APyLVlcK20i7J8/VjM0/pmLEqUSCPnOYR0YsqoFORGbwmBUvOxZI6+gZTAdD
	 V97fQ22SOq+ZU0Q3Jg0rsLcEqLa8S8lUvHB2ZVmxAPZVIMbQyOyMGqfzTAROU/EBLDeHB
	 VMmA0Amw5vLYf0xDnbz1AYCFbB7FTniELC15I3feAicxYkSUj8xzd2QVdsMRfTdgXiRgd
	 cj4FT4WNK04JW/iD7itdJi5qJXfPwyYYXw3p9tHKm9mpGQqq0HwxsNFg9TR3z6qt9rE3U
	 SdCyNlJYQLwZhAJxqKWzQgtL+iciwngpI7VeMXhoVgvAI7hKUpZ/KlBZr148/OnAkAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFKoL6rg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42421606A320;
	Thu, 29 Oct 2026 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFKoL6rg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6C61F01825;
	Thu, 29 Oct 2026 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237913;
	bh=jxH03hHgKl65iUtHtrCqp+AM+yS+y7DQ8MSqObvXwUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFKoL6rgip04vqGlz1xQe5yeRK8E1X1ldeCqTgW0cTVIgffjl1Ebb0Gcfpv2f06Cr
	 8GcFYIIkLBUMvDgR18g9afAs04TaLQTpVdoyvUhjalPN79zSDW6NADNk6FTbub5F4J
	 1wgLufQWsjQaCpwCNKEp9dE7Vuw6VgxSRuUyZQoZkt9yJ/HHSR0s8N7tGvabEfxt77
	 BDzs86rmxkPlIPdEnMwII16YipgZVcTNSLN54weBtqS7o1kRLSNHeclPkpk9ms/6/I
	 K/AbRJ/86SaUabAelrvNcyfRMWd4VEIR9+YP8LXst4+XOI35FtCZaieNKvSrVu4IiS
	 13DOF6e77X7OA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 07/15] tracing/filters: Reject empty unquoted operand in function event filter
Date: Thu, 29 Oct 2026 10:38:30 +0900
Message-ID: <179323791027.740114.822862076687011726.stgit@devnote2>
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
index 05579895c810..a645af9eb1f8 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1880,6 +1880,10 @@ static int parse_pred(const char *str, void *data,
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

