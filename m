Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462A17B43F;
	Sat, 14 Mar 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773483053; cv=none; b=HhwkSWrGmI9ULX2XylcFEKFExYJXY+4xAAkGUcws1z8L/LZXrXfKE8HMVRGN4Y6+9z9zbj48MsXTpLsvGZ1jb/H1bvN1hz9ZBvmvdp/Sl7Z1dM/tXhIQoMuNLV7Dj8gcQN3/2YkjhT2EBoIjUE2APH6heVDgwogJZIDVIgW7P70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773483053; c=relaxed/simple;
	bh=XlS8bB5aiFrJgpMoA+5FmJrVMPtY9Id3Xq/yMyZD2zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYCNcpJcOydsUHG5v9nVee2nCHL1SuNTEJwvgOThJ+23F0cDb/Y1QCqAf1rMi/2qSwSN+jCcFNcL/0UEzgOTHd9kTMiXKNbC2d95YQUS415EXf8VTDVF+YXHmbcbxklhHRR5pymXSQKuf2TMjnADQnTW9gRgAL7v/cV38JoaKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4sG7zQM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4sG7zQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE17C116C6;
	Sat, 14 Mar 2026 10:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483053;
	bh=XlS8bB5aiFrJgpMoA+5FmJrVMPtY9Id3Xq/yMyZD2zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4sG7zQM4jtLKRV8b/7RGirFUqfhCVcoPU7qG4jc80IzpHXUtUrku7XewYICxU7wQ
	 J0UcaRxKv147vhEu/RkC36QsjcadC3nW9YyEfMrp2/ugBz3pV91gqAIYDCdKR3pwGN
	 BlhXtCAvkR4IIB2RRaLqOIWwo6AjR6MM9c+zjH0oPTYdPNeQeYLj+Y0v3NyWO8w8Qj
	 im6BfMnJsLRIBgqJRpDAZJ63IuaabAygCS9F8+PkqOorV7t/u8t0OsKdEa5HY2sXTM
	 c0H/CJ68gIehuTfxDoAwF86UG9MotO3Ko+wu6mFiUoV7MkMI05erqH1i6GP4C+dn3j
	 B9zzJMgNBntMA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Documentation: bootconfig: Add EBNF definiton of bootconfig
Date: Sat, 14 Mar 2026 19:10:49 +0900
Message-ID: <177348304960.463670.10025294494717117792.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177348304012.463670.8543295382997674229.stgit@devnote2>
References: <177348304012.463670.8543295382997674229.stgit@devnote2>
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

Add the EBNF definition to Documentation/admin-guide/bootconfig.rst
as an additional section to formally define the bootconfig syntax.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Move EBNF as a separated section.
---
 Documentation/admin-guide/bootconfig.rst |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index f712758472d5..41bd1ee92395 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -152,6 +152,23 @@ Note that you can NOT put a comment or a newline between value and delimiter
  key = 1 # comment
        ,2
 
+EBNF definition
+===============
+
+The syntax is defined in EBNF as follows::
+
+  Config = { Statement }
+  Statement = [ Key [ Assignment | Block ] | Comment ] ( "\n" | ";" )
+  Assignment = ( "=" | "+=" | ":=" ) ValueList
+  ValueList = [ Value { "," [ { ( Comment | "\n" ) } ] Value } ]
+  Block = "{" { Statement } "}"
+  Key = Word { "." Word }
+  Word = [a-zA-Z0-9_-]+
+  Value = QuotedValue | UnquotedValue
+  QuotedValue = "\"" { any_character_except_double_quote } "\""
+              | "'" { any_character_except_single_quote } "'"
+  UnquotedValue = { any_printable_character_except_delimiters }
+  Comment = "#" { any_character_except_newline }
 
 /proc/bootconfig
 ================

