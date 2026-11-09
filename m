Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184134;
	b=z9d06Vb7df6o6n54jBYP05TAUb617592GMf0RU6q52dGarsFiCQmgsELMLm4wXYdelvo
	 zEOM60pzM6CBScAK22Un7qB5p07ys73BIluVBrypdi/wZv6ZrO2wqQSItfw6r00aPpUlu
	 wd9FzVI0ugOVDuEisawN5dVUfngdDlPCZaeP+dwOarPJkMESV/L4KHSeQZZC320F6Dh9i
	 mj3hbareXJ3geOoIUO5YT0Tsi2kj4t2FLYM9YU3LI/kMUbA4qt2oyxSU0Xb7RONGAjuGS
	 EgtMoTjMhRHGxcjgZQ5Xc2MrPQUkQfEWfJW3+ThHMTrE7wGI36KgCvWeXCTuYvrUV1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184134;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gCrBj/L0nVk0Y4rofc9IruZOjajTmVyTiEHWsaHrV40=;
	b=IhzINCA1oF6W+yH/Lb8kr/1ZeCYibumXBmXCoUbE6KFxMGmVYB4bRdcpSJZ6UZJGL1nj
	 vfnHVvF8e6GxF/dY/xT731maj43+OxTcq1AVNE6Bd6afepn5LQ8qEIPd7qxepWdP5N75P
	 mF4QkhZe9nrYlMa1E+rX6BnZwhaZFTdYBZovFqhxpr7/hrdYo8wzbpK/Vzh3axsdDG7d1
	 5GCMhTyOlOa9NHYpAqM+oxsMPgEpgxIZj9LVFX6XoDJ84lElGhei/WI+eENXToYyV0GZk
	 AJN4C343bkqS7EPLvy0F580WdYv0uPzvypiCNe1ISXgXTQm3EcvYGCxiob0sVyG7VtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdN0nqEH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32A606A33B;
	Mon,  9 Nov 2026 00:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YdN0nqEH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B1B1F008BD;
	Mon,  9 Nov 2026 00:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184133;
	bh=gCrBj/L0nVk0Y4rofc9IruZOjajTmVyTiEHWsaHrV40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YdN0nqEHYHW9IXIIsnukUYR498thAEYe0E3NNUWCEYGQcnBOQtjqQwbcKU1x6hb99
	 4E0S9MMwiMpPuaTwelBuoTh8hR8g7bvfF+hwuPIcLcJZZo6IzItRD0bLBQ+tVrxnUX
	 HTjFJU79GhZmpQ2QFSJe3QH5FCsF6adP2129vmS/OO7WBS8C7HZKUEK32sxI6CazEV
	 I0Q5ZaMTRB6Az2Sq//9Hg3lF1iPe6v+ks8z1NyTn9PQxfji2Xh7JTxJ8RSHvTAfTKS
	 8Qy10cEg6u8Ri03JlMRSss977NeDMO/OLWw7bgisz5XPL7Kx80LlgPhW/QRdzeuelS
	 dYt81GL4H1aYQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 05/12] tracing/eprobe: Fix 1-byte signed field fetch in get_event_field()
Date: Mon,  9 Nov 2026 09:28:49 +0900
Message-ID: <179418412989.227715.15975346868609035820.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179418408457.227715.1485179201014819821.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
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

