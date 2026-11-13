Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558520;
	b=HqWt1kgvVAkrBE1BHcAdvixX2oeOnYvhD5wQTEOspI5bZ1Fz0P139uTLn93fvlirNqzW
	 KkUpLyhKJ5VomDs7IxuTetDid7J4zS0Mp4Xdjpq2Ufq0PwxyTHM29uxqzPIryBqQst5zx
	 EaqFp4qF5JABU5CeL3M/+m5DN3YGO/emgda/usSgk0jg9VdVxHwGvC06MwacYHz+k4/yT
	 9ozN5yyzmUpX7GDImi9JwKjxZUGq+9KMR7x4qz93vwYSB3rmtPZy7tB0t3pWDOxkdz4f0
	 y6FQT7t3edy/KNi4iXRgcQpv8HYoJwJIsgq5IsDUMYmYVhLAQeEbGmx4D0ERKqeBlLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558520;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G6P8ksKwHMGkfAuloy0LApJAp04ZPu6qUfNJ844hiTQ=;
	b=1MxWp4/S/otMy2if+hN7eQVefNF1PALpPGMDLwQXKuo5AIcTnPgL9XjFfwIALCmrAPb7
	 eos8Q2KNU06k8oENtVEFNW5KFRDMZ4T0RTFT7HtFiro7kMYT+a8f5vMs49tB7LIXHjsHM
	 jV2tq4AzrsyFV1sjpbjlZtJvcI91XZDQmq0JJP3fY+3wxXH6Fg8sZBU6j59FcoaX5l3VW
	 JU7o07HBW8gpWJ1FaRdBdE1aKnNJAf6j6iT0A61BGM+dJChj0Nxx3KoVOPOUnMclpVAPX
	 sPhIE6+15m7KpprRh1tx4+S5VUBHxGxk0GHqg42otK+XMrXaEFq5W+6bbZJZiX5RpGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoKh8G8E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B67606A323;
	Fri, 13 Nov 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OoKh8G8E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71931F000C6;
	Fri, 13 Nov 2026 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558520;
	bh=G6P8ksKwHMGkfAuloy0LApJAp04ZPu6qUfNJ844hiTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OoKh8G8E/Ee7WOzNOjcszSYoBnMCxNX7LCzri9JCJauoNTDZdPK2t7ChB74P5+TO2
	 /FY6eBVZCBPlVD3xrrkp7F9N88ickUt6QTubQEC8gUI0hV6WVN2gjW/eRclOOMvhu/
	 G/mN3c490DkAbvDX48LuCAZxmj0TbhGhS6OruyZilpfLA6Scesjz8+NeZY7JZ6gsHH
	 nlIdzUFty6AskLxGLLNTUfYrM0K9TGWXi2aUQGIXFxhMv66UJPMTtDvoFNTdWt4pnU
	 7UszfFe1oaeBTaZUeUkq4hjFrtVD1wrhmjAaugvCUu6xT+sAs+dXLeQRvzb/O/oUdi
	 ICXqZMONNbm3w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 04/13] tracing/probes: Fix missing BTF kind checks in char pointer/array helpers
Date: Fri, 13 Nov 2026 17:28:36 +0900
Message-ID: <179455851632.403392.258264246782960594.stgit@devnote2>
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

In struct btf_type, the type ID and byte size share a union, and only
BTF_KIND_INT types are followed by a 32-bit integer encoding word.
Because btf_type_is_char_ptr() and btf_type_is_char_array() do not
verify that the outer type is BTF_KIND_PTR or that the resolved element
type is a non-NULL BTF_KIND_INT before inspecting it, non-pointer BTF
types can have their byte size misinterpreted as a BTF type ID, and
arrays of non-integer types read out-of-bounds or misinterpret trailing
BTF metadata as BTF_INT_* encoding bits.

Validate the BTF type kinds and NULL pointers before reading inner type
metadata in both helpers.

Fixes: 27973e5c64b9 ("tracing/probes: Add string type check with BTF")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 54cd3c2584a8..b8f6a36ee0d4 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -411,6 +411,9 @@ static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
 	const struct btf_type *real_type;
 	u32 intdata;
 
+	if (BTF_INFO_KIND(type->info) != BTF_KIND_PTR)
+		return false;
+
 	real_type = btf_type_skip_modifiers(btf, type->type, NULL);
 	if (!real_type)
 		return false;
@@ -435,6 +438,11 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 	array = (const struct btf_array *)(type + 1);
 
 	real_type = btf_type_skip_modifiers(btf, array->type, NULL);
+	if (!real_type)
+		return false;
+
+	if (BTF_INFO_KIND(real_type->info) != BTF_KIND_INT)
+		return false;
 
 	intdata = btf_type_int(real_type);
 	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)

