Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446866;
	b=Ua+R+VQxtl1jfNKOm0AKJnBLQzTfRPgld6hAb+Kmlk8AQmuKZjT5YR5dgQulds1d1uby
	 eRJMu/Ukalyp083DimwhAh5yoYtsYlvLSwnbz2Al4n4gJ4MVhEeUxHHZLMf0G0rEooz3s
	 Y19UKwkV1+0/TS72IM0ehWZrD65dKPmyVBdU4iGXN2wP3pXQH4Q5UC6HuwY7Y3UtnO5UA
	 AkyAyryTBk9CR2d2yktEhqvIMxF54WIzeRMCRZgAUflCh5lYB+IyTKdzttmXJ78zeHave
	 SzcJq7lzxdrW1nbZDNb3hC4Fkgqw0DXxHtYyKaE+vajBH4UltaGQrYwZ5x5oj1N9uNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446866;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=unvx1VFYGWsifku3oQ716Tf0It8oPujG+MxSVrmrUyI=;
	b=FL7RQcM/iiMb1dNfh8GkwCSUJD25wOT6vIpkyYCqwCIbVME+tIf2zcGUo2Em/PxS9nc2
	 2iwLMAYu+5G9I2Kb3aqBNpvwf56PBKAdwGiPohL7uPXq/4fK4mxg0f1vU6fpySsevMgsQ
	 xG6+rhDpOvG2eOCp4NHr/yRVjmU9CnDz7sJnYiIbs+sk0A2s1um6GOsiD3aYoyAC/DDpN
	 bUcGUuskvGN2iGJ+mOawXSKz9ECQ0g9EnMBnhTSkvqq9csu/83NqLk+y9xRMUrUzzcUZj
	 ORPmIPreJVFbCSAwNfFg5+zQyeGlKhNHvqzciOk5hsX/aXMvFy0P2Wxgys/QIsVwpHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMb9mwDj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA1606A31C;
	Thu, 12 Nov 2026 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMb9mwDj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD691F00A05;
	Thu, 12 Nov 2026 01:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446866;
	bh=unvx1VFYGWsifku3oQ716Tf0It8oPujG+MxSVrmrUyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QMb9mwDju0TL+A/igiyQJTy2GRU27rwPRsukNWYZxYeauYOn9SFLBQOh1ErIIEeHQ
	 Jq6BDGgzeQtcxYKt7pkVpHnY5JSfrp90Ib7YFEMJJ3RcSj9+85Kr1hQThEqkCCMAP8
	 Rs9nhNKNlxpTevtWIUyGDRepwgDDHVI8tCm0fVrvshNY2rSjGseHKIeq2/J2GwtE4l
	 PljJAsfYL7IkhLTyLMVgNU71mQiQ9A9q6Fblq5lciSbOQ7STg6tJJyvPbl5j2+rZD1
	 P56n9l7bNWk1cMRXfB+PleQhf16nh/yZY3zFjHMt2QbavUH3QomXhvujR5wsUwEb0U
	 XFWUX5+PL+Khg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] tracing/probes: Fix user-space dereference string array store type
Date: Thu, 12 Nov 2026 10:27:42 +0900
Message-ID: <179444686231.345731.5654223261824375730.stgit@devnote2>
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

When finalizing a string array argument (e.g. +0u(%reg):string[N]),
finalize_fetch_insn() advances the instruction pointer to a new slot
for the store operation before checking whether the preceding operation
was FETCH_OP_UDEREF. As a result, user-space dereference string arrays
with type "string" emit FETCH_OP_ST_STRING (kernel memory read) instead
of FETCH_OP_ST_USTRING.

Check for FETCH_OP_UDEREF before advancing the instruction pointer.

Fixes: e65f7ae7f4da ("tracing/probe: Support user-space dereference")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 232d1deecb20..e98113808257 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1953,6 +1953,8 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 
 	/* Store operation */
 	if (parg->type->is_string) {
+		bool is_uderef;
+
 		/* Check bad combination of the type and the last fetch_insn. */
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
@@ -1972,6 +1974,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 			}
 		}
 
+		is_uderef = (code->op == FETCH_OP_UDEREF);
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_IMMSTR) || code->op == FETCH_OP_TP_ARG ||
@@ -1992,8 +1995,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 		}
 
 		/* If op == DEREF, replace it with STRING */
-		if (!strcmp(parg->type->name, "ustring") ||
-		    code->op == FETCH_OP_UDEREF)
+		if (!strcmp(parg->type->name, "ustring") || is_uderef)
 			code->op = FETCH_OP_ST_USTRING;
 		else if (!strcmp(parg->type->name, "symstr"))
 			code->op = FETCH_OP_ST_SYMSTR;

