Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558529;
	b=N5pHzVxYuByqkcQslCI6imKlA1BrBEsmgHXNTfU/BCpcVMWkk9KyDVVUMuyhaBQkLzm2
	 cOXmmntgT4eLS9UV8Dk7Ec1hfOYr67QWAqtBEKRbddsMVXyK18zCiofvRVXJXwIu3jnkY
	 Yk2YfWrpbfBSjVUyGjAuQFYD61H4k+ITk30+vOSZ+1035PeWFstNYcLc36+uqjyFoW7Ir
	 z2VTQPp95OpejrBGjGl+bVvKVC5qfnaSgAaXC8Pp9T9YQkAvISHUxC6UZjbbWYkwD1Qob
	 2e0fonUQcwFNkIrYFcx36YIZEtOZ+Yi3LFu2KT0niBWP0akCbe3mcN6Zjq7vZE7Driw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gCrBj/L0nVk0Y4rofc9IruZOjajTmVyTiEHWsaHrV40=;
	b=MjVc62rD7EYux5qhKSIbMPhnPXQCLf3k9g70F5m+gFxrwmtClVT5Sd7q7dCpiRoKGHXl
	 D/NoHIcwnCw/B8oNwXyOzpxAGBHS+34JJ6P0/0zJ4EzxSzD2vT+G/DaGaGyHawaOMbXZs
	 dSNVN0cJi8eq2pAHVYW/4Forf42TP7pEO9k0q3gHCgnH5JU8VeBhUrBuTRyJ0cPufOYtG
	 wLGsWYyNLccDIksvqM1xpAMvzqNbz8GEb0FKe/jFwTBJ72y20Ue11U5Ie1wYYi3PBcaf3
	 G4Ud4h8RfFjYwF+V+R0DW2k0xv4R7kSNQU/s+rIweclyE/LzzdY2yPdknUtrXobLxtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCYqvV1X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A653606C98B;
	Fri, 13 Nov 2026 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCYqvV1X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B91F000C4;
	Fri, 13 Nov 2026 08:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558529;
	bh=gCrBj/L0nVk0Y4rofc9IruZOjajTmVyTiEHWsaHrV40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCYqvV1XxcwYR0dX00yvkMpJJEy1hvjfhZ1eHSHV8BPkj2n85BzJqzNNp3TZLD4kV
	 aV8697tUuM+H8ybdokN9FCKd+o9qiFhMhGDTQUd6wp3fLxeKyl7D9ZvFBvr/Kh9Xmr
	 GYnKZJvU3XRH71CM4NqsXZcSXPnAm5GZsvves/XxphU0s4Uf6FZCK8TukHSnldUIwv
	 q21o3gP6q7T2KkFA5OsAKpO7wFPmqSgRy3mNJWrTBF9wTuxTRpD65w3KeGYtB30HCl
	 mmwJxuStba0gv152+hbSeYNlQarSeS4kEuynSEuNxZDQ4uBBnsFqDbZTXB08nLYxHK
	 QM7N7a9cXuo0Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 05/13] tracing/eprobe: Fix 1-byte signed field fetch in get_event_field()
Date: Fri, 13 Nov 2026 17:28:45 +0900
Message-ID: <179455852542.403392.15666310371702309464.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179455847934.403392.15146485751358774349.stgit@devnote2>
References: <179455847934.403392.15146485751358774349.stgit@devnote2>
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

