Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446830;
	b=XSttzylcc2fljwmH+v8ZsOxjb9Li2OqTt8fZasO1fULrxTXJTmj71dkwZTk4I645Nbpr
	 0N1OD79w+pZcKBc+g6QtdlFNhKbyeJqZvBF79bnr3XZa37aePxN9e4rOFKxmFiX6Uu9xe
	 +TZ3pfEJR2Ft0AxlXD3V0C4cZvEYWR5jpt5kB/nJbQ0PtFTjr+GVY3BsQ7mflNtmPFl5t
	 8X7zUb3wJGmJ/t5WbzsqxXA038w3iwP2c0E7VBBnonvBf3vvgri5+YjcbSA6rK9moI+3T
	 IPhbq2bKInnwSQJc4Vb3atax8HwE16sY9yGYOCqkyE/qCLUCMR6MKIggXrSaU//+Q8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3J8TZs6WUVkHX++6nhj1hS0OOjB3uzJTiefYPSZv9IA=;
	b=ct7igVl24/K7HShuPfQT9mBwbOIFwoHs15mik0raafXDqIVSUKxn2BlntmoTq+4kosi0
	 TeiIHmzXiZbYPU95d/456lAFTYVp/XU/jvg3fGljGC/Uv7DM4pXEsboxH9GYeF64BhoFs
	 SLqc3fKxMZXnsAeWFlfQ/XudqBQ561eIyZtQ7asdtzNxrSuk1a+HDuDNJ9I1g2mZbI/Sc
	 njs5brwz5MSyBskqRNpzfPSlbBJR9g3bqnswEe7mmwRpNHlFIn0bOwAKH9L+IIQZcnfbL
	 wK5rrdcoIUNhdZISWU0Vp725m1DZaEqTdbsY2ik4hSENbn+2VPMuP7LYGTH58TnVF8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJaX4ait;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C5606A333;
	Thu, 12 Nov 2026 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OJaX4ait
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FAD1F00A11;
	Thu, 12 Nov 2026 01:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446830;
	bh=3J8TZs6WUVkHX++6nhj1hS0OOjB3uzJTiefYPSZv9IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OJaX4aitDkS8eakhsgidoYLAyU8KBsh90W4omltrS5CB+/eJsqfHs7rYZVPBpQJw+
	 Oll+GWjTtVPLfc+YzV/u+52X3I37M9nrIZ6BAO9Ktv5BtoZPvchkaAPcOv20hsSxlj
	 Qd0MjhuTHOdNqM2iGJ0iPMI7YkPoRKtUt83dSbo57VGD6rNXQuTHZqIWL3rW4nitPz
	 //FipjjbOBKwlEzOi1xNmrjCjLKhXcSxEGg0D9DBIv5lkRmtfd8r+65xix8guCJ4hP
	 W7ZDQ7Iu0oUEIHGjrTYzMM6riWCIU8pL3V7Lxw18BeE+8Zl04n7M8cbvYnpjyb5Ycv
	 JB6xIcGv9guWQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
Date: Thu, 12 Nov 2026 10:27:06 +0900
Message-ID: <179444682679.345731.13247927117747302891.stgit@devnote2>
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

BTF bitfield parsing in trace_probe.c assumes a 64-bit (8-byte) container
when computing FETCH_OP_MOD_BF shift amounts and basesize, whereas the
preceding store instruction only allocates and writes the field's fetch
type size (which may be 1, 2, or 4 bytes when kflag=1). At runtime,
fetch_apply_bitfield() performs an 8-byte read-modify-write on the
smaller ring buffer slot, corrupting adjacent ring buffer data or writing
past the end of the event record.

In addition, signed bitfields with bit widths other than 8/16/32/64 fail
to resolve a fetch type, bitfields whose width is a multiple of 8 inside
a larger integer or spanning a byte boundary fail to emit FETCH_OP_MOD_BF
or select a container wide enough for bitoffs + bitsize, and kflag=0
bitfield offsets >= 8 bits are not folded into the byte offset.

Compute the bitfield byte and bit offsets consistently during field
lookup, select the smallest unsigned fetch type that covers the bit
offset and bit width, and calculate the FETCH_OP_MOD_BF parameters from
the selected fetch type size.

Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Check (bitoffs % 8) in get_bitoffset_of_field() so unaligned
   byte-sized kflag=0 bitfields also record ctx->last_bitsize.
---
 kernel/trace/trace_probe.c |   58 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index a880a90642d7..3a57fe6b67cc 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -486,6 +486,18 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 {
 	u32 intdata;
 
+	if (ctx->last_bitsize) {
+		u32 bits = ctx->last_bitsize + ctx->last_bitoffs;
+
+		if (bits <= 8)
+			return "u8";
+		if (bits <= 16)
+			return "u16";
+		if (bits <= 32)
+			return "u32";
+		return "u64";
+	}
+
 	/* TODO: const char * could be converted as a string */
 	switch (BTF_INFO_KIND(type->info)) {
 	case BTF_KIND_ENUM:
@@ -520,10 +532,6 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 			case 64:
 				return "u64";
 			}
-			/* bitfield, size is encoded in the type */
-			ctx->last_bitsize = BTF_INT_BITS(intdata);
-			ctx->last_bitoffs += BTF_INT_OFFSET(intdata);
-			return "u64";
 		}
 	}
 	/* TODO: support other types */
@@ -653,6 +661,12 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 		/* Add anonymous structure/union offset */
 		bitoffs += anon_offs;
 
+		type = btf_type_skip_modifiers(btf, field->type, NULL);
+		if (!type) {
+			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+			return -EINVAL;
+		}
+
 		/* Accumulate the bit-offsets of the dot-connected fields */
 		if (btf_type_kflag(container_type)) {
 			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
@@ -660,12 +674,16 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 		} else {
 			bitoffs += field->offset;
 			ctx->last_bitsize = 0;
-		}
-
-		type = btf_type_skip_modifiers(btf, field->type, NULL);
-		if (!type) {
-			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-			return -EINVAL;
+			if (BTF_INFO_KIND(type->info) == BTF_KIND_INT) {
+				u32 intdata = btf_type_int(type);
+
+				if (BTF_INT_OFFSET(intdata) ||
+				    (bitoffs % 8) ||
+				    BTF_INT_BITS(intdata) != BYTES_TO_BITS(type->size)) {
+					bitoffs += BTF_INT_OFFSET(intdata);
+					ctx->last_bitsize = BTF_INT_BITS(intdata);
+				}
+			}
 		}
 
 		if (next)
@@ -858,13 +876,22 @@ static const struct fetch_type *find_fetch_type_from_btf_type(
 }
 
 static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      const struct fetch_type *t,
 			      struct traceprobe_parse_context *ctx)
 {
 	struct fetch_insn *code = *pcode;
 
-	if ((ctx->last_bitsize % 8 == 0) && ctx->last_bitoffs == 0)
+	if ((ctx->last_bitsize == 0 ||
+	     ctx->last_bitsize == BYTES_TO_BITS(t->size)) &&
+	    ctx->last_bitoffs == 0)
 		return 0;
 
+	if (ctx->last_bitsize == 0 ||
+	    BYTES_TO_BITS(t->size) < (ctx->last_bitsize + ctx->last_bitoffs)) {
+		trace_probe_log_err(ctx->offset, BAD_BITFIELD);
+		return -EINVAL;
+	}
+
 	code++;
 	if (code->op != FETCH_OP_NOP) {
 		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
@@ -873,9 +900,9 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
 	*pcode = code;
 
 	code->op = FETCH_OP_MOD_BF;
-	code->lshift = 64 - (ctx->last_bitsize + ctx->last_bitoffs);
-	code->rshift = 64 - ctx->last_bitsize;
-	code->basesize = 64 / 8;
+	code->lshift = BYTES_TO_BITS(t->size) - (ctx->last_bitsize + ctx->last_bitoffs);
+	code->rshift = BYTES_TO_BITS(t->size) - ctx->last_bitsize;
+	code->basesize = t->size;
 	return 0;
 }
 
@@ -1085,6 +1112,7 @@ static int parse_btf_arg(char *varname,
 }
 
 static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      const struct fetch_type *t,
 			      struct traceprobe_parse_context *ctx)
 {
 	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
@@ -1995,7 +2023,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 	} else if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
 		   ctx->last_type) {
 		/* If user not specified the type, try parsing BTF bitfield. */
-		ret = parse_btf_bitfield(&code, ctx);
+		ret = parse_btf_bitfield(&code, parg->type, ctx);
 		if (ret)
 			return ret;
 	}

