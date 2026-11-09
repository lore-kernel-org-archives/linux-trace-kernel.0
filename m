Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184125;
	b=VEfzlmiLOr4R94NxSUbAlRMsBhTA0ZcSKUCVbjhjFxx1GoPVARllrbQzysfTLy2/Ef1m
	 XBGZVlRgVuwVTXLuAr6xwu+Ii5TnrLS22bYbCQtFPxCjj3ZDGdUxCygFxK+5fa/cXmYOn
	 IhlCr4yEJ5Xs4eUVZYh0FajKciIBOZIOfoYBXPHWdqJNb1W3LqqCaTgytbo/49u7jVhKM
	 ccYEiHMyADe6YljhiUB2oPOJxULG+7DZAz4IKihQ7xIHRFIdimq/v5QDY1dUZQGcG3KCa
	 UElSKahf76k/Y3FuLi2XImQbopuZLmnp+AayVN2CEnHzSeRlVZMjgyAsCLdCaAhDYtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184125;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=G3Ti5HGbHvQ7VXBzjY8deEsQcMLCkSCpBiVO5wB9ipY=;
	b=IeuwTK6aqUpSo00eq2MBIuN5sBWlQ0gXtZWO1JUjG+bOyrMdbWxaTlmPWi3/y9XnjnmC
	 WZWPz25qkY3ic8cZqMYJ8nOTxcj+5FwJmguVk7OtoJExXS8qvXNg8TqKEp09zZOOv7PCg
	 +ZS2HPDgVDXAA2lCJZOlM1fWUJXi/q/RUZYeP/gIevSXa8AX76YVDGf/Q2s+a95DQ4URd
	 mqNdd3y4LCRexQPKYpl6yY44j7d5+JcnDRNlTYiQBYdjXKIEhfdCE6XIUZL3n8WMrzWlk
	 RENgnrwQpxs8VbCx8dkKRwNcksmxfpkfoea6WPMLS3hiwuRXutcqQsiNCXEjITndW9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzjhImCP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D9606A320;
	Mon,  9 Nov 2026 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzjhImCP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449111F008A1;
	Mon,  9 Nov 2026 00:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184124;
	bh=G3Ti5HGbHvQ7VXBzjY8deEsQcMLCkSCpBiVO5wB9ipY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FzjhImCPUVVoJ0eVwc6A7YLJ5aaSze2Yva9BCnrANLvVgeOaO3h3znmGzO3okOl1j
	 rz2F/fUkzhq+Pdmw/tHdIhXDd12DgAnrGGz9f/WCpdY3WTqHSW4W2TfFOQVsQZRSVz
	 LYoh57Ea1ttPQ926bOlFi945iRscGfS5seoB6xzZRd+Gx9C6giVcFmzHuzl8aeVo8P
	 qrx/QMfkHjNusKkipJKkTmZsPXgcOalWsTO2dGYXlJ3wdzBsKDeeO35yrV/5Ga/fUd
	 neLL5OvcYmH/MtXb92i0alh2jfy1vtBjeV7JPWmgBFjYAFnbMVnGClxlru1rhCqSdK
	 x/sZAODEgQhsg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 04/12] tracing/probes: Fix missing BTF kind checks in char pointer/array helpers
Date: Mon,  9 Nov 2026 09:28:40 +0900
Message-ID: <179418412088.227715.6938451582565786291.stgit@devnote2>
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
index 26e02929f1ff..829fa6559b59 100644
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

