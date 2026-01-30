Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD381FD4;
	Fri, 30 Jan 2026 04:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748110; cv=none; b=bKYS4+Bg9iO88jW7mDVcayDyBkoCR3uTZ1IOSQ1PJEhMzx1j6Mywhi43Sd851Ttlp/fSEEDJTBBiU4BQmH96H5r+cSVmwNcQcHemuF9R/9zIW5WPrKtJoFn2nNu2nV8LQYgXHDJ7SP5KGa6l+9+7vE41O+D9wYL7ciDtgCWF0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748110; c=relaxed/simple;
	bh=AP1L/GpqQOUMoiBRHtaHAxcoeCKObBcbQsHi/ZPQzxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mASpSmd/kPS6abZyXAhsOVudEzIU33kBdJRcnW8HYKnmzu22XIfSj/byWdtHVy6tXJ477UQvSI1ZaUy7OF28xJ3+KU4/4r/KwH6gD3E2f8oaXIyeMNv69TITwyrEfJ3aPAnzUNcwqCZYFREXkoE5mHLIgG19TIyZGTldKU8159Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1lGh0+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1lGh0+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E70CC116C6;
	Fri, 30 Jan 2026 04:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769748110;
	bh=AP1L/GpqQOUMoiBRHtaHAxcoeCKObBcbQsHi/ZPQzxU=;
	h=From:To:Cc:Subject:Date:From;
	b=u1lGh0+Dpm9xM0Qwg/qsh7k89I1wp0YRBB/4fATbvyYSObzyuq62fK5iznTSz4ECl
	 OCMq6/b9MCAO/6eFIkUjn/k1Db+Ni9E1/FC2VG7CVv5JTxZI8nVGWXv4ai6ZIWvo6f
	 +D80rye9W3KNVFiuwYj5rn7ReARXfthpbYyIjIpTBaBnQDnu3MDt1pFnjJKrfhu6wA
	 DdaA2LFHCfnInJROuw00N45HaK+C9ChCuNmEdGQamzyUj7ft2ILi2BDpPS4tpIqK7N
	 hut8PkhWqndwmgBZF3wy+Nw1zGr1DVbArZZpI4zigPSWIBZk99M4wKv8CHclADreEk
	 b9QL/LweHcV8g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Julius Werner <jwerner@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] bootconfig: Fix to terminate value search if it hits a newline
Date: Fri, 30 Jan 2026 13:41:45 +0900
Message-ID: <176974810577.124104.16012554973099890517.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Fix bootconfig to terminate the value search if it hits a newline
even if it is empty.

When we pass a bootconfig with an empty value terminated by the
newline, like below::

  foo =
  bar = value

Current bootconfig interprets it as a single entry::

  foo = "bar = value";

However, the Documentation/admin-guide/bootconfig.rst said that

  The value has to be terminated by semi-colon (``;``) or newline (``\n``).

Thus, it should be interpreted as::

  foo = "";
  bar = "value";

Note that if the line has a comment, it still keep searching the
value to the next line::

  foo = # comment
  value

This is interpreted as `foo = "value"`.
This also updates the test script so that it can check the above cases.

Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/bootconfig/test-bootconfig.sh |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 81f29c29f47b..94b55ec32444 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -563,7 +563,7 @@ static int __init __xbc_parse_value(char **__v, char **__n)
 	char *p, *v = *__v;
 	int c, quotes = 0;
 
-	v = skip_spaces(v);
+	v = skip_spaces_until_newline(v);
 	while (*v == '#') {
 		v = skip_comment(v);
 		v = skip_spaces(v);
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 7594659af1e1..0873883182b0 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -171,6 +171,24 @@ $BOOTCONF $INITRD > $OUTFILE
 xfail grep -q 'val[[:space:]]' $OUTFILE
 xpass grep -q 'val2[[:space:]]' $OUTFILE
 
+echo "Empty value with ="
+cat > $TEMPCONF << EOF
+foo =
+bar
+EOF
+$BOOTCONF $TEMPCONF > $OUTFILE
+xfail grep 'foo[[:space:]]=[[:space:]]"bar"' $OUTFILE
+xpass grep 'foo[[:space:]]=[[:space:]]"";' $OUTFILE
+
+echo "Continue value after comment"
+cat > $TEMPCONF << EOF
+foo = # comment
+bar
+EOF
+$BOOTCONF $TEMPCONF > $OUTFILE
+xpass grep 'foo[[:space:]]=[[:space:]]"bar"' $OUTFILE
+xfail grep 'foo[[:space:]]=[[:space:]]"";' $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD

