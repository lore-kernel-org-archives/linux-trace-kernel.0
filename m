Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92603DD51F;
	Mon, 20 Jul 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544269; cv=none; b=p1yFCvmVtPZ0LNxyx1CK0hI4AGWzius1B8ni4heWEokbZRbfVmQmYI45WKJ8V3QWSYDNN2NU1V/5n/IS3kIexV3GyDLrVoaZG5t+EuP5JY0IxzfNYk+RFuJ1HMu4XA3KNTl5HsXBfdOhnAyNwgmnV1uMTiWgXALmrvr92X8LmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544269; c=relaxed/simple;
	bh=y7erpFLEoigXGEjDGYSA5IoLhQSJjlvvgwFFcRRwNd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f502d9evcWwWw0dZ4r8EAzLL1C7tD1Knk72KBRfKohTtSZ1GZC9A5ELETfscf59ewrMU44dL+wFVilLapXUi9YI5RYf/W6bwMgSal4afHzTR9y1MY2GcLuZ/AOhVoRYRn2xFo/8qqz+VUeBlDIfLkiJCWMga5Wu+1NXrwAG+Mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mx1vKqSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mx1vKqSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A817D1F00A3A;
	Mon, 20 Jul 2026 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544260;
	bh=MduZI2Ivb5+yMttRcwHzJDmifVQ4du5CTOPuXPV95RA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mx1vKqSvpS218k4P+slszmAHyBNfMeJCFPNTjvcBr77y+dEysRCoK/Q5LXPIWR3Os
	 03+tfClgnDVSn79Fkuq3Sud7+SS1OREWPL+UGWgtloJJpHvqg2iNdtH5jOfGuJshiZ
	 4JGQN8TyPmTSAuvmrOCGSmO9s88Vq+B6/4BSuflrLGGDokLiZjgFVWg8BD0Lsgfzeh
	 0IddZ6fP00rinqqzCOxbdQma5kHkHrqw0fzvlRP+XpNmWOzyu3Uz5Od7ZleYaN6bnZ
	 HAljP9Sd9MPs7W9gBHQjvVNRIuZ/iMlDMK8smu35KWsxl7bjSfDt0X8WdDsUZEVBRN
	 WYUxkQP567Kjw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 05/10] tracing/probes: Cleanup pointer arithmetic in store_trace_entry_data()
Date: Mon, 20 Jul 2026 19:44:16 +0900
Message-ID: <178454425622.296567.16952341966130280432.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454420994.296567.10239174745865301350.stgit@devnote2>
References: <178454420994.296567.10239174745865301350.stgit@devnote2>
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

In store_trace_entry_data(), edata is cast to unsigned long for pointer
offset arithmetic before being cast back to unsigned long *. Cast edata
to u8 * instead.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index eb7be3725e85..4899aa5f9230 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1246,7 +1246,7 @@ void store_trace_entry_data(void *edata, struct trace_probe *tp, struct pt_regs
 			val = regs_get_kernel_argument(regs, code->param);
 			break;
 		case FETCH_OP_ST_EDATA:
-			*(unsigned long *)((unsigned long)edata + code->offset) = val;
+			*(unsigned long *)((u8 *)edata + code->offset) = val;
 			break;
 		case FETCH_OP_END:
 			goto end;

