Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E53DEACC;
	Mon, 20 Jul 2026 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544279; cv=none; b=fQIJZH/PkFLZTg21SGMHHXsZxw676n4OiU4XoLrkocaoALzn9JuscdopcXw0iLa8LXC1gvjSJeJEXySTlFRxFA4lXkjbBxMgSOFw5yJJpLHJgI4X9hEouxI+OJM1YiYFFBZXYpy0waCQ4XDDznaORFs/CrIZGrrOp5/9hHyb1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544279; c=relaxed/simple;
	bh=g+H17M+iXGwuA0QGd0Qlc2BtwRVhN2ItpW9d0MLu8fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjadmI4UrFL7TIRgRYFmaTgAJHHbGVlNpO0TowK/Edr8BFsK19FF8g7PSnrKInkrPfJqgpTfy4JNM45egG3fcv1Ygl4hYOEqilSulz1lWEeSaeqRK+eAfOWQDkyMFxmnGjYxpQAIDVUyZCqM8ayNFXS49c4l9K54huHffjFN830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlAql9h/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlAql9h/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D391F000E9;
	Mon, 20 Jul 2026 10:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544269;
	bh=6d3WXTHTastn4to/Cmx8QUQto+Rl7lHpOtUy0Yr0XcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VlAql9h/o9tF3CKUqqZToW+48SBTQy1s6LStmmV1VaulL8Em0MzYUTULR4GtQsXB+
	 CYY2znKnbPEcp6+GX32sxSK43q0FgtjiRUB1Tlwu9lWMh0hhQjxoH4TCft23kcBOsX
	 vkTL85yLdTWB1swxn98X7L2pYhsRhkDo/00n+aHp0TFVeRXILxUYr7K+C5AXfHDHuP
	 wwvkWT5GScxSeFnfopqBjhbOxy28DV6bL5ebP11LZ65f6aGiLqxlgCwEXbZuBtGuNK
	 XhiR/e3JYsm3/mWCML0Lmb6IfPBun+GiX+Jkv2lAB6Y801f2PdhGgOnL8sLOsNpzGf
	 3yS4m5GJJyx2A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 06/10] tracing/probes: Simplify BTF_KIND_PTR case in fetch_type_from_btf_type()
Date: Mon, 20 Jul 2026 19:44:25 +0900
Message-ID: <178454426554.296567.17700307233923830044.stgit@devnote2>
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

Use a ternary operator for checking IS_ENABLED(CONFIG_64BIT) in the
BTF_KIND_PTR case of fetch_type_from_btf_type() to simplify the code.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4899aa5f9230..fc62d09ea535 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -495,10 +495,7 @@ static const char *fetch_type_from_btf_type(struct btf *btf,
 		return "s64";
 	case BTF_KIND_PTR:
 		/* pointer will be converted to "x??" */
-		if (IS_ENABLED(CONFIG_64BIT))
-			return "x64";
-		else
-			return "x32";
+		return IS_ENABLED(CONFIG_64BIT) ? "x64" : "x32";
 	case BTF_KIND_INT:
 		intdata = btf_type_int(type);
 		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {

