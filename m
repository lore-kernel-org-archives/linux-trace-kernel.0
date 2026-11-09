Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184160;
	b=JHH/vFf4BnT76joRCr3ShNEO5D2i0ft8VF3U5xwSSseWHdZ3LWe+Lhlp2kDmSfiJ630Q
	 OwXJOkyTxiC5G371covb4u/tT7L2jHea8WWBp3UbfoSD5AfHvINR91nivS8XcjcF0Ibmm
	 ESPtnPhhiSKYRnGj+bSaOJoCxQX1Ap+Ln2+iGHAYJDgy7ladIwf5RgM+aYvmkqZKdZBoF
	 xOViQUsbxgankBSz5tcBJp666gI2Khh65VhcQfRQl8wfid3n4YDfl88CVHqlG9MTrIEwm
	 yYPIoqOi1+vWq9bkBUKdNRXxZ/HyWxHE0hC2i2aFLF4TKTUu+N2BKrOpExYjuWDxywQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XRPWfGfm5Yn8zmo9Cv2LdMZex3kKYuexClHqAB/Wx1E=;
	b=l3TpTP3cn7tjSqqrk3YciAG7TjJUUPRod1QenmH/Wh6mCNBuKWDJzA52Mb/NhuouwIa6
	 L7cWHYPwgLJD9E/WH3BhjopjtHhab/NKhKuVJP9yLoI+eSRbyEk11+kJL+rtw5gbxIfPC
	 MUdJz9cPWvT12y31KuGnsiVihrreXm9iA75LNaW/d8pH8SZTs4lk1tPLCylKx9vj8IqP7
	 kYitPpNErjbqmfYZ1Xs8n5BgQgROpm8Oxm+y1xRDvww5cMFxtN7ReniRU1eNpODHOn9pI
	 H0F4hi9V8PpYVriGnM0eGe4dOPyRw2DFbG1LyiXTWEu7Yb24Og1veAadc5kBcjB8cjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzhITUwe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEC606D801;
	Mon,  9 Nov 2026 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzhITUwe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF96D1F0089F;
	Mon,  9 Nov 2026 00:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184160;
	bh=XRPWfGfm5Yn8zmo9Cv2LdMZex3kKYuexClHqAB/Wx1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NzhITUwembBG3q5Qi6P1fAXudrtoaKQ8Kt9Z0CRGWGQnezw/xnDxWYs7QMfcNLIfv
	 6RfInDWC9AR8UD+2hGynhS4+ZrME7b/GtVwr+x3ftSzLLZTQGVoWGkudCB0sT6nwMd
	 xysmXq5Z4KCPVpgWjoBFV1M0dW+m7ENSiQX8MS9jFrMmeRNtU1T/6VBScaDjbVS7XI
	 7WZGhthoCnnR7YV/PnJVjPShWrk9gTBst9hyUytJh05+DhVMXSEbUgCAhd1NdfreQ7
	 uc7wfhHxx0YtbIJ0psX8o+JnKRiuwxsBJcMLXoPvvqL0yBtcyCjSl8s3IYpA0h8bqD
	 trcFRF2+Wz2/Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 08/12] tracing/probes: Reject array count on non-dereference string sources
Date: Mon,  9 Nov 2026 09:29:16 +0900
Message-ID: <179418415672.227715.15166570338029977087.stgit@devnote2>
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

The runtime array loop (FETCH_OP_LP_ARRAY) for string types requires a
preceding memory dereference instruction so it can advance the pointer
address on each iteration. Non-dereference string sources such as $comm,
immediate strings, and eprobe event fields cannot be indexed as pointer
arrays, but finalize_fetch_insn() still accepts an array count on them
and emits an invalid FETCH_OP_LP_ARRAY sequence.

Reject string array counts when the preceding operation is not a memory
dereference.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e62acf05a8ee..0f544d415153 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1986,6 +1986,12 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 			 * For the symstr, it doesn't need to dereference, thus
 			 * it just get the value.
 			 */
+			if (parg->count && (code->op != FETCH_OP_DEREF &&
+					    code->op != FETCH_OP_UDEREF)) {
+				trace_probe_log_err(ctx->offset + type_offset,
+						    BAD_STRING);
+				return -EINVAL;
+			}
 			code++;
 			if (code->op != FETCH_OP_NOP) {
 				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);

