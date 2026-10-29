Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237905;
	b=wPd588K7dnfHCNTsKgPi3KqYLBwEx+pxmeX1ZmQ7lGC5QzZxNgrCD53KurWfH97nRmcf
	 6TyithE1BG3QvcRhEkzFLT/1vcnFhFekGPUyibbC4F4obnp6+DmHK4g6LT27Olfx56M5M
	 JpaJh2RMwtq6dp136bxU7D7QUT+nnOjBz98Msq35mh38TXIZk+wCOAENg4O7c6iGjCkRg
	 Ojz6DVC8kBzsEAt4oTs35thktb/0rarxvibJpB9Bb8UOAdWlE+R1gnAuwBhGoAszl9hCO
	 rAnc9h5r8RyBuO35UsWxItxjys1FKkaqRqOMbLJG6BiY436/vJROhX/Wpo/nx+bE+9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237905;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mo3vDer2b6IaJ3OLBc47/5xMW/U5AROx6LhDOyNRm+U=;
	b=GMSPkLPVuQ2XuME6EWGW6Z7DE7MfC1EdRl9KB4FcciVlyLRSJka5Sz5eAhDXIGF6tOi9
	 tjdPEMFxHdmqSXAxAt0nYD5rgUfn91+Y38VqqY5kXguX3D/0/PgrueWy8lmVTpToPmEC+
	 oPgWu5YnWo4MeacH2PS2pi4xDIhvyCFZ8tM0Kqb/RORE8CP90N8DYhg6ntPL8JC3uNTFG
	 jCWYop0HM6K/xW54MWqI3wb6x/mwbpoXHA24z5qkcDH/hkYGtW2XzeHDCXkVjl5ySickg
	 3F0PAKu4MNBelX6oUR8N5Mhdyy9nHEbP+uTJ+H5jsSEGSJR7iulFoAOnXWHefZ+QG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXNSg3vb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD03606A31A;
	Thu, 29 Oct 2026 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lXNSg3vb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F2F1F01825;
	Thu, 29 Oct 2026 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237904;
	bh=mo3vDer2b6IaJ3OLBc47/5xMW/U5AROx6LhDOyNRm+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lXNSg3vbrAgkBo3s/PbRZ/AaVsHEA86GWTPpp6T4u9t6UKkfOTWSZX/6ZzZuK6RnV
	 qsHpJlp+OSzdCkR0qCXVzKH6srkXb7PJ+Sg2ujyRS+k7b9eKqiMB0U+/Poy1Og6mAP
	 d0zIFd/BOXhmngT34eZgwXeyuyDBRN2I7rGD7L2hFG5+oo2hlp+Zmte8M10gAkmEpE
	 vKEnALfhVFxj/t1BDZvAxwN8Xwdrwt8jiHJXNrRdnNn8/R0NWCXOXFP3LycfBnINPG
	 y6enSErlYW7Vf4PY/TgOi5B++VHsg7kWQOe14UN1un6K3iT/rRjw7zHZdrBH1Ec4RR
	 l8X3pQvt4DJow==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 06/15] tracing/filters: Fix quoted operand parsing in function event filter
Date: Thu, 29 Oct 2026 10:38:21 +0900
Message-ID: <179323790096.740114.15868280894145147902.stgit@devnote2>
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

In parse_pred(), when parsing a quoted operand for function events (e.g.
ip == "schedule"):
1. The loop 'for (i++; str[i]; i++)' breaks when str[i] matches the
   closing quote, but 'i' is never incremented past the closing quote.
   As a result, parse_pred() returns 'i' pointing at the closing quote,
   causing the caller predicate_parse() to immediately re-parse the
   closing quote as the start of the next token and fail with
   FILT_ERR_TOO_MANY_PREDS.
2. If the closing quote is missing (e.g. ip == "schedule), the loop stops
   at the NUL terminator without reporting an error.
3. The loop started with 'i++', which was intended to skip the opening
   quote, but also unconditionally skipped the first character of unquoted
   function operands.

Fix this by advancing 'i' and setting 's = i' past the opening quote
before the loop, starting the loop at 'i' without unconditional
increment, reporting FILT_ERR_MISSING_QUOTE if the closing quote is
missing, and advancing 'i' past the closing quote.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Split from the monolithic function event parsing patch.
 - Allow empty quoted operand ("") as valid syntax per Steven Rostedt.
---
 kernel/trace/trace_events_filter.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a7a89e0f9b87..05579895c810 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1859,22 +1859,27 @@ static int parse_pred(const char *str, void *data,
 		 * Quotes are not required, but if they exist then we need
 		 * to read them till we hit a matching one.
 		 */
-		if (str[i] == '\'' || str[i] == '"')
-			q = str[i];
-		else
+		if (str[i] == '\'' || str[i] == '"') {
+			q = str[i++];
+			s = i;
+		} else {
 			q = 0;
+		}
 
-		for (i++; str[i]; i++) {
+		for (; str[i]; i++) {
 			if (q && str[i] == q)
 				break;
 			if (!q && (str[i] == ')' || str[i] == '&' ||
 				   str[i] == '|'))
 				break;
 		}
-		/* Skip quotes */
-		if (q)
-			s++;
+		if (q && !str[i]) {
+			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);
+			goto err_free;
+		}
 		len = i - s;
+		if (q)
+			i++;
 		if (len >= MAX_FILTER_STR_VAL) {
 			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
 			goto err_free;

