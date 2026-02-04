Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A53939C6;
	Wed,  4 Feb 2026 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194033; cv=none; b=S81TG7Sa+ErgMuH7enRDcr0JSujWy70PCyWNipYw3m+JpSaoj3awpqUH+tWQ+2CtAlAoi9JbQbeRgbLyQKyxNfR+43Q+DNteCO55WX7uJ3CqmxAtutJtmIi2Y6jdgvD0gBcsPRpBHiA7rSAWIxO9d76v2nHSVKd92Dv8jOOdn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194033; c=relaxed/simple;
	bh=1cOkDbKMpYsYNHXVAbpVY0vQllsEmE1khMNUWtLPUtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGUaTisZ2R/7FsB+Ex5brB789OqSroXthHMoVg1Lt/CzleRDRMZOnguZ7qbINVVi5xefr9cmUkXPBXViSabZ18cHUzGBBCoGWwTSyukpGLB4G/Pip4CSi0p//9NyM0lQoAsM4GHjWi6+nHOiRHZSb8vRF5Xs8fhRDWU0k94DyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/ZldSk3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/ZldSk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD3CC4CEF7;
	Wed,  4 Feb 2026 08:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770194032;
	bh=1cOkDbKMpYsYNHXVAbpVY0vQllsEmE1khMNUWtLPUtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/ZldSk3Wme+1rcbjVWQ9g7Eu5VAefM/fD/TryuiCnaTWmIEbNhdeW46RTl7Dzdrz
	 UolqtMN6dR2/JY75Qj7ci9U2lwFGUvSTGBExGBcpGm7sYOWa4o9dfBLiiZQYxTHiiE
	 3im3nTvH/YDY8/hkEBw/uQ1Q2IJth8r/sqtBMlsL2EPt/Kpq4gvGXHpSxYXj3KkjGI
	 EZAYdlRFOxP161OjFHnbLJ78OfKE2NdTA+xkLqjtqrJTHzydiP0vl0r7yCCOXh/Y6X
	 qHMaJWMtQImphJLEGab/0xMQPYJbPcEloKCz/dJzcnS6CF4I8Oxo+sV2+yU5YDfCop
	 Fa23aeeuPBaaQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Julius Werner <jwerner@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] bootconfig: Terminate value search if it hits a newline
Date: Wed,  4 Feb 2026 17:33:48 +0900
Message-ID: <177019402883.80694.10977484286951965499.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177019401833.80694.554894321526842218.stgit@devnote2>
References: <177019401833.80694.554894321526842218.stgit@devnote2>
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

Terminate the value search for a key if it hits a newline and make
the value empty.

When we pass a bootconfig with an empty value terminated by the
newline, like below::

  foo =
  bar = value

Current bootconfig interprets it as a single entry::

  foo = "bar = value";

The Documentation/admin-guide/bootconfig.rst defines the value
itself is terminated by newline:

  The value has to be terminated by semi-colon (``;``) or newline (``\n``).

but it does not define when the value search is terminated.
This changes the behavior to more line-oriented, so that it can
clear how it is working.

- The value search of key-value pair will be terminated by a comment
  or newline.
- The value search of an array will continue beyond comments and
  newlines.

Thus, with this update, the above example is interpreted as::

  foo = "";
  bar = "value";

And the below example will cause a syntax error because "bar" is expected
as a key but it has ','.

  foo =
    bar, buz

According to this change, one wrong example config is updated.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Fix to handle multi-line array case correctly.
  - Make this as a spec update, not fix.
---
 .../samples/good-array-space-comment.bconf         |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 7a86042c9b6d..843b24b8de88 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -20,18 +20,26 @@ Config File Syntax
 
 The boot config syntax is a simple structured key-value. Each key consists
 of dot-connected-words, and key and value are connected by ``=``. The value
-has to be terminated by semi-colon (``;``) or newline (``\n``).
-For array value, array entries are separated by comma (``,``). ::
-
-  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
-
-Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
+string has to be terminated by the following delimiters described below.
 
 Each key word must contain only alphabets, numbers, dash (``-``) or underscore
 (``_``). And each value only contains printable characters or spaces except
 for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
 hash (``#``) and closing brace (``}``).
 
+If the ``=`` is followed by whitespace up to one of these delimiters, the
+key is assigned an empty value.
+
+For arrays, the array values are comma (``,``) separated, and comments and
+line breaks with newline (``\n``) are allowed between array values for
+readability. Thus the first entry of the array must be the same line of the
+key.::
+
+  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
+
+Unlike the kernel command line syntax, white spaces (including tabs) are
+ignored around the comma and ``=``.
+
 If you want to use those delimiters in a value, you can use either double-
 quotes (``"VALUE"``) or single-quotes (``'VALUE'``) to quote it. Note that
 you can not escape these quotes.
@@ -138,8 +146,8 @@ This is parsed as below::
  foo = value
  bar = 1, 2, 3
 
-Note that you can not put a comment between value and delimiter(``,`` or
-``;``). This means following config has a syntax error ::
+Note that you can NOT put a comment or a newline between value and delimiter
+(``,`` or ``;``). This means following config has a syntax error ::
 
  key = 1 # comment
        ,2
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 81f29c29f47b..c210fb8b1e85 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -557,17 +557,13 @@ static int __init __xbc_close_brace(char *p)
 /*
  * Return delimiter or error, no node added. As same as lib/cmdline.c,
  * you can use " around spaces, but can't escape " for value.
+ * *@__v must point real value string. (not including spaces before value.)
  */
 static int __init __xbc_parse_value(char **__v, char **__n)
 {
 	char *p, *v = *__v;
 	int c, quotes = 0;
 
-	v = skip_spaces(v);
-	while (*v == '#') {
-		v = skip_comment(v);
-		v = skip_spaces(v);
-	}
 	if (*v == '"' || *v == '\'') {
 		quotes = *v;
 		v++;
@@ -617,6 +613,13 @@ static int __init xbc_parse_array(char **__v)
 		last_parent = xbc_node_get_child(last_parent);
 
 	do {
+		/* Search the next array value beyond comments and empty lines */
+		next = skip_spaces(*__v);
+		while (*next == '#') {
+			next = skip_comment(next);
+			next = skip_spaces(next);
+		}
+		*__v = next;
 		c = __xbc_parse_value(__v, &next);
 		if (c < 0)
 			return c;
@@ -701,9 +704,17 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 	if (ret)
 		return ret;
 
-	c = __xbc_parse_value(&v, &next);
-	if (c < 0)
-		return c;
+	v = skip_spaces_until_newline(v);
+	/* If there is a comment, this has an mpty value. */
+	if (*v == '#') {
+		next = skip_comment(v);
+		*v = '\0';
+		c = '\n';
+	} else {
+		c = __xbc_parse_value(&v, &next);
+		if (c < 0)
+			return c;
+	}
 
 	child = xbc_node_get_child(last_parent);
 	if (child && xbc_node_is_value(child)) {
diff --git a/tools/bootconfig/samples/good-array-space-comment.bconf b/tools/bootconfig/samples/good-array-space-comment.bconf
index 45b938dc0695..416fa2ed4109 100644
--- a/tools/bootconfig/samples/good-array-space-comment.bconf
+++ b/tools/bootconfig/samples/good-array-space-comment.bconf
@@ -1,4 +1,3 @@
-key =	# comment
-	"value1",	  # comment1
+key = "value1",	  # comment1
 	"value2"	 , # comment2
 	"value3"

