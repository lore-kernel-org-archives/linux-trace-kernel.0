Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FB41754;
	Sat, 14 Mar 2026 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479203; cv=none; b=pwQGIy+cfszPVjEbTwkst3597Rw1UJlvf9rdYw4e9Hp/++O+TZAcDo+De71ErVSSvRtBUzX+86LMcmly+q2ncSjj5W2G+6IItw6e/1mMCU1orz5WCibVV+Jqljb3kuUCPOvk10MXIF29fPKRYIkP91uDEKm81VNNaHGJd8kAwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479203; c=relaxed/simple;
	bh=TmE4g8j4MFz5iz7lMaGBzoqAgEv9f1/6DVo5t4ub6b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3zXr6r4xPRz+c4bm6HknoNbzTaXMX32xvPgfu57AOZN1kAoXfshK1rOI5+xsUGLELO5oWK/9XOazhv1eLvwXl06hInlL26QOOaz5U3mf0ktOpHclJcK/Hgvby+Z5WINo/qSFAKh8EvglC3MTMSYfKwNQ2e6Ys74Rf5Z7a9ggAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR1ahwtm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR1ahwtm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC936C116C6;
	Sat, 14 Mar 2026 09:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773479203;
	bh=TmE4g8j4MFz5iz7lMaGBzoqAgEv9f1/6DVo5t4ub6b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CR1ahwtmkejtg6TL6+U3lLiFv0yJ5uvSWzjFwW4mIfq6fxZ6KmiJZ1AUZ4g/TOJ+Q
	 rv9BdXw9e14Ji/wLfkcTTDxAQZnZJr4Nm/mEouK3II/FhUidWaPQgnBEUtcyJhAdtf
	 ExlRzT3QrKyGUkUBw8RcM6nJfohM9onbB5tQrVTT4xauvJAbKW/Sf73OmUz1wdxp8U
	 SKTubXlKOkIhMjeQ6ZQQpkvtyPRaK5qaCGumMicFohYwxhajwZb258MLDKMPv/Gu1E
	 7SYE4eeCZ00kO85DEzW2TbPr0RiS/hDbDEfiR0XaeshEDscDkA6RJNZ4ykHOv6C9IP
	 Mpbqa/gBWbUlw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation: bootconfig: Add EBNF definiton of bootconfig
Date: Sat, 14 Mar 2026 18:06:40 +0900
Message-ID: <177347919991.458550.13051415412509206815.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177347919093.458550.1919253264724868769.stgit@devnote2>
References: <177347919093.458550.1919253264724868769.stgit@devnote2>
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
to formally define the bootconfig syntax.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index f712758472d5..5c5f736ca982 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -22,6 +22,21 @@ The boot config syntax is a simple structured key-value. Each key consists
 of dot-connected-words, and key and value are connected by ``=``. The value
 string has to be terminated by the following delimiters described below.
 
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
+
 Each key word must contain only alphabets, numbers, dash (``-``) or underscore
 (``_``). And each value only contains printable characters or spaces except
 for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),

