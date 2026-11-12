Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446839;
	b=Jq7MWbOKZh/UgBgO57oxS0JdzzBIHyRIMzx7SNY3Wglj6Xu/hRjuYNG/bEH5tNAmYEaE
	 wvz9bqbWaKsgN0+QjYt0hy24P9CDWGG777Tv6EAL9kCavRqtRWURikGOT6BYL1oTyJT6o
	 dPyVCUS14JUcfRwddauN76LvZ2Ye8KWlvYm4qonDBgcWkyQgGapHxRIRRKt0rCzHuAZKy
	 T/BHRNrMiNAdgj7ZdSb+bRTJw002Rw4GcVIm5VcxwF2poTYnociuM8r3TydRgetFu76jl
	 O4jJBvmCGcsA/rFU1I3dTs7DXQXWqN0ad+yu78aAEsBrGbJ0FQuCR1EtXT4yknLHydw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446839;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eLPKV+XG/NDVIPVGtVsCkLYRyrN/OgHbO9MTpDsW/Zo=;
	b=p2V2gmQ2/YAwpBHKAu9fWfyXhQMC82SDElAu5GBgzE0+dUCVbaG60XGIEzdK8mdUdril
	 7f1NsaQ1lx1IJKJKk1ZoFWHpsj48Y13kpglENhYasTZBWLVTXOgHn17F6BOJSqiBfXQEm
	 1nfGbrbLb0mHcOTe5+ZY47p/pNqkz0DOjexURzvwaC2Mk+TaS8F9wO5nmr+uHfA3rUTQE
	 J6Ds4fgI5Ra9r96yE0bGYtR+ioMG24jQjL/YCqNDSMM0J9yTzMtb6tngpaGcgAhhXIn1/
	 szxWtsJLlDYV0rJvx16S968yOsvSEImnsPTL8IRFowJ58YszPB1+bWrsfhL1x6SXrAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1ObL4vM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA6606A321;
	Thu, 12 Nov 2026 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1ObL4vM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104CF1F00A05;
	Thu, 12 Nov 2026 01:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446839;
	bh=eLPKV+XG/NDVIPVGtVsCkLYRyrN/OgHbO9MTpDsW/Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X1ObL4vMedeEeMQHtzNiIiZR8ZE417joAJkDIKoV5+9V0WUJE5p4vkBeavzZEABiW
	 8LCs0SFyBrlPFQ+mrBEzHJd2bbkZXi+qQ/SzhrQXlXFtD2/VFX+W9DFq4JRted0vRy
	 KNMEfadnDd0r9cgO/sQoEya3/+O4n1/Yt3Kjy5ArTWoPstQ4PHEI6UATj6qlwE+aAy
	 QV0vacGHmZZbQqICUX98r9HGh/9LjHuhovjRCL7UQnD5y5azZ8XPGWTUHgeqngYmvx
	 Kb1AMKGvf3UAxsly8jzM/Hi3nXrHUzrrlfuyDjPfsMhfVpN9cEGuqrAPhmKDPMhFQt
	 rGjNPM/MJCoFA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] tracing/probes: Fix missing BTF kind checks in char pointer/array helpers
Date: Thu, 12 Nov 2026 10:27:15 +0900
Message-ID: <179444683590.345731.13726797901135918302.stgit@devnote2>
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
index 3a57fe6b67cc..232d1deecb20 100644
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

