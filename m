Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184116;
	b=LN8MkeFR0IHAxfQZRUJDTrPviM7PODsDONYBafmeBkUxMs3XKZlKOyvPZ1t/OV8j7Nt6
	 kpKUnh3QNJd3u6YQ2028wDqPSX7/BsXgMvCnqNqBtC8e/uvhF+/yRVIeeuhLy9Dh6eIWO
	 aD5op1+o7CByDaVbAzPn+3TTwSk2na2xE8OkH4Lwbx75WY0LiU1GcNWiGh7T7axuBGSLP
	 HX3AAceYcI+hvsyGiOh2mSm4/ldVhvX4VzNyrEvQBkYs/06AUzZYdrDmeNWzqeoZ2fOlQ
	 JBPf0Nwjl7jD4f4NqMXK312yiAGGS4ULaNs10/r0jycBGNQWyPlq39ogseTb8g6iQ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6jSTTjDXADiP7ewhDU2qkyczwPXuPv/M6hQDx7Ie8iY=;
	b=XZz8IIUZ/g/G8nich4cx4Vv0wukAFJknUdUPaXgLyTuawBVKpGss07NAJWFGFkDTG788
	 V/Bj6PAFP1ChrXwZf6DPHYWcP1ZMEgcn5OgprZl9J96Iqj76MUrI22RwROeUFac05hnXz
	 1SdGJmcx0Kxzqbx+N9BAIER01d34fsUopy7kOdfIBZJdKt7iWMrSQrP7YtzacC2kIHwP/
	 Z9ugxoXDFLIxvI2NeJfHlqR3JB5MHWK7+jbr5PmJ8t6lPZhGAn+b8pINd1qJIAP5nfu9B
	 sNkQwYgUc3tt5ONZeX4NSW9EeCt1TDmJjDgTeXVZY7rmpoKUhlLgP6Y6IgPuuzwKuTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSdct5N0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BD606A31C;
	Mon,  9 Nov 2026 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSdct5N0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD0D1F0089F;
	Mon,  9 Nov 2026 00:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184115;
	bh=6jSTTjDXADiP7ewhDU2qkyczwPXuPv/M6hQDx7Ie8iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSdct5N06qQdnEr14EuH2WFimpU/6HeHdkrlnOZ3PW5+NA86OcJKRybrUIrz5r+a4
	 YbPC8jc92Orbv1Eo9LCbfPCFoaE5NVcZHkvW77EDrlWr43HlQ7oN5847ti446liz2q
	 kEM8zKsaJysT9C91uDjFyRw8FP1eQcELL37/1gKLMdw9vcBve0XfFqpnv2xidyagT1
	 ws8nZGJwyV6x3B9xzaTe9FgIyZMsDUfZwZy8VaIlgLaECjfKTJ+1t2ePflfZ7mtjwp
	 16QErxchmJwUx1bKxtg4n+Jvya3wqzHs0lfhyIijFoYgUsdDDd9fs47/lAvHKfujZH
	 WQ37cVxMt75Xg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 03/12] tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
Date: Mon,  9 Nov 2026 09:28:32 +0900
Message-ID: <179418411197.227715.5577722703946865281.stgit@devnote2>
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
 kernel/trace/trace_probe.c |   55 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index a880a90642d7..26e02929f1ff 100644
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
@@ -660,12 +674,15 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 		} else {
 			bitoffs += field->offset;
 			ctx->last_bitsize = 0;
-		}
+			if (BTF_INFO_KIND(type->info) == BTF_KIND_INT) {
+				u32 intdata = btf_type_int(type);
 
-		type = btf_type_skip_modifiers(btf, field->type, NULL);
-		if (!type) {
-			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-			return -EINVAL;
+				if (BTF_INT_OFFSET(intdata) ||
+				    BTF_INT_BITS(intdata) != BYTES_TO_BITS(type->size)) {
+					bitoffs += BTF_INT_OFFSET(intdata);
+					ctx->last_bitsize = BTF_INT_BITS(intdata);
+				}
+			}
 		}
 
 		if (next)
@@ -858,13 +875,22 @@ static const struct fetch_type *find_fetch_type_from_btf_type(
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
@@ -873,9 +899,9 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
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
 
@@ -1085,6 +1111,7 @@ static int parse_btf_arg(char *varname,
 }
 
 static int parse_btf_bitfield(struct fetch_insn **pcode,
+			      const struct fetch_type *t,
 			      struct traceprobe_parse_context *ctx)
 {
 	trace_probe_log_err(ctx->offset, NOSUP_BTFARG);
@@ -1995,7 +2022,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 	} else if (IS_ENABLED(CONFIG_PROBE_EVENTS_BTF_ARGS) &&
 		   ctx->last_type) {
 		/* If user not specified the type, try parsing BTF bitfield. */
-		ret = parse_btf_bitfield(&code, ctx);
+		ret = parse_btf_bitfield(&code, parg->type, ctx);
 		if (ret)
 			return ret;
 	}

