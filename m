Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446848;
	b=ZjYDEA+0e64727qAZB3BCfTgMTrGHSumKYL558M9ky+miqcrZaXhdVQ2rFeq5Xxgj0lE
	 luFh5lXWlEsQ8wDEHLsXEQs3SZs5JRJMAqc6JqLEZZ2yOFqiFydCxz7jvkKDOzin5uL7N
	 Q2ahHsn+Nvsr4qCwnpcVbpAChTxqpSc43nCKI1h3JQWpwlprHxI5j+/FU7N3dXCpIdIiG
	 sZx7Vx1v0vpL+ogHga0/QJeQqQEhtZaBkuBaDjfzSvm/t2uncJl6oBhWrBgBTv14tsm+H
	 Qz4bTL6SuRiVMyEsHZIOBd6lshaVYPLGALOKth1VQA4+ZCJFbr+MsAXldTM7+Zz8AhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446848;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gCrBj/L0nVk0Y4rofc9IruZOjajTmVyTiEHWsaHrV40=;
	b=ZrlAuyKbf5VGrTEdC2bCQgsg3QE43OyHG6Ia4GQW13k5PnHJOphibZjNmcsd2RhUcKfi
	 xijd36l4l808FYdQVSa06KwbHOsf4vnRoQfr5LM36hvAFhdWf5h6bJ9rgRJZ+grm86clA
	 ylTxZvjcaE3T9LqAcLeaHUsNqwE+mzvcqh4VFsi2DyWSJDk9wV/GpDgzNw/kUvbzgSgE4
	 IST5WZ48QgtUrX+BhWKPlOcBvg0suTF4ljIblpslkNDmgXTbY8CJnPidFSi+dmWZo31Uu
	 GCdBFNAZC4/SD0CkeVc1rB1nCWtyMh7ce1q/mWDvlvMWFWNTv9v+db5uNWFFOwZqUwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeizNkiE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B8606A31C;
	Thu, 12 Nov 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeizNkiE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EBC1F00A0A;
	Thu, 12 Nov 2026 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446847;
	bh=gCrBj/L0nVk0Y4rofc9IruZOjajTmVyTiEHWsaHrV40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeizNkiEanCwVfNBW8cDUMRCoudYoAXgDzGG5RkrrJX052IikEJOfbSPZ8VTo93Au
	 s5b5pjHSKOo9Jis0XUbivT2BCOehjwMgcHPcGIlvS0hf4EQGK2FrqE15Flv6CueGkS
	 bMzxFEGRRWdp6knvGp7UthDL59bjCaOAWc3xBQYH/ONPH+AHUvdFUofvM/Ch5thLBT
	 N8db2pKn8zRZdodgl4gAv5Cer1af3EBUJLtEF+7vMYtnGXL/XLU3u5xcd+xf3rsaxY
	 sUxaa3tMk5S/924Ua6ewi81UG/wHNzZZzjcbQFaWswWuqEmgsLkXAW4Q8tMt94EJCp
	 fbOwV6bkDKFww==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] tracing/eprobe: Fix 1-byte signed field fetch in get_event_field()
Date: Thu, 12 Nov 2026 10:27:24 +0900
Message-ID: <179444684450.345731.8324000135791531252.stgit@devnote2>
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

Because the kernel is built with -funsigned-char, plain 'char' is
unsigned on all architectures. Reading 1-byte signed trace event fields
via *(char *)addr in get_event_field() therefore zero-extends instead of
sign-extending negative s8 values.

Use explicit fixed-width integer types (s8/u8, s16/u16, s32/u32) when
reading event fields.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index f1590c9af6b2..9defe86f4e8f 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -334,21 +334,21 @@ get_event_field(struct fetch_insn *code, void *rec)
 	switch (field->size) {
 	case 1:
 		if (field->is_signed)
-			val = *(char *)addr;
+			val = *(s8 *)addr;
 		else
-			val = *(unsigned char *)addr;
+			val = *(u8 *)addr;
 		break;
 	case 2:
 		if (field->is_signed)
-			val = *(short *)addr;
+			val = *(s16 *)addr;
 		else
-			val = *(unsigned short *)addr;
+			val = *(u16 *)addr;
 		break;
 	case 4:
 		if (field->is_signed)
-			val = *(int *)addr;
+			val = *(s32 *)addr;
 		else
-			val = *(unsigned int *)addr;
+			val = *(u32 *)addr;
 		break;
 	default:
 		if (field->size == sizeof(long)) {

