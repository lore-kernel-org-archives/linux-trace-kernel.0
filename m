Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1017B43F;
	Sat, 14 Mar 2026 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773483062; cv=none; b=gIxgnQzqsCblQW8ohzKRcPe677XMKQINnTSq6Ava5J5/udKbLpfbOALKXE7EoFXGXXJzaf7D+xYzLjiMWkQXaQX7bb1Dv5z653uvtGwa85uNm+E1p5/A7EzhgarTDZ4zS40EujDFvbdwFkoBdTrh+3o+s6Py/Qr0q1NrCpX2KwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773483062; c=relaxed/simple;
	bh=7VkJjXzeXYwJ7pfvTiOGUj5L+IBz/aF0RFlZKjCffZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMMYarbhkb/t2F9GyI67z2Akn7VsSUS0hhLzJIAvMQ80NbEz9VvoDfmT2hxn7gGI+TvrCl/WdobruUM1TW9u3cWPcwJidgnW6HfXSjdzi9YcE7tiJMyWVLJLw4TJme89AwEJHs0/Uuc6pCjqmDNzeWA6H2CWAf73bNRU3JgpbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keip+0P8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keip+0P8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80A0C116C6;
	Sat, 14 Mar 2026 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483062;
	bh=7VkJjXzeXYwJ7pfvTiOGUj5L+IBz/aF0RFlZKjCffZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=keip+0P8oM3D2KkOE3HVi84p084uf8xOHXwKzfP68AwGq6VPacZRcXHx9DBtGQOOe
	 tJXT4yDv4iuR1JfbyB3Mhzs7QBmEnZX3dv6nyJJcPlnRfva66YQ75wU9ftJxMGN/Dr
	 61Rl56Hb4KZ9TyHoSweszEu2qlr54XwH2OWaSb7t8sWjf+drdJX3yBQ1BLYO0hEzsR
	 usI6fX8xbnAbbxNaCxJjkkzDQH2oHqsFTogXCI2mgftKI0YWrWhr61Zih5UHcjhemb
	 EYEQOujv8RucaPLa3Q1M7gC5ixSSYHmIvzNykrSTrnsGms8z/OwRooNd5Bp34bPqi/
	 ULsDSWzBaTp3A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] bootconfig: Add more test samples
Date: Sat, 14 Mar 2026 19:10:58 +0900
Message-ID: <177348305841.463670.259256758582249863.stgit@devnote2>
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

Add more test samples for edge cases (empty block, quoted newline,
various error cases) to tools/bootconfig/samples/.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Make EBNF as a separated section.
---
 .../samples/bad-array-comment-delimiter.bconf      |    2 ++
 tools/bootconfig/samples/bad-dot-middle.bconf      |    1 +
 .../bootconfig/samples/bad-invalid-operator.bconf  |    1 +
 tools/bootconfig/samples/bad-key-dot-end.bconf     |    1 +
 tools/bootconfig/samples/bad-unclosed-quote.bconf  |    1 +
 .../samples/bad-unexpected-close-brace.bconf       |    4 ++++
 .../samples/exp-good-dot-with-block.bconf          |    1 +
 .../bootconfig/samples/exp-good-empty-block.bconf  |    1 +
 .../samples/exp-good-empty-value-sep.bconf         |    3 +++
 .../samples/exp-good-quoted-newline.bconf          |    2 ++
 tools/bootconfig/samples/good-dot-with-block.bconf |    3 +++
 tools/bootconfig/samples/good-empty-block.bconf    |    1 +
 .../bootconfig/samples/good-empty-value-sep.bconf  |    3 +++
 tools/bootconfig/samples/good-quoted-newline.bconf |    2 ++
 14 files changed, 26 insertions(+)
 create mode 100644 tools/bootconfig/samples/bad-array-comment-delimiter.bconf
 create mode 100644 tools/bootconfig/samples/bad-dot-middle.bconf
 create mode 100644 tools/bootconfig/samples/bad-invalid-operator.bconf
 create mode 100644 tools/bootconfig/samples/bad-key-dot-end.bconf
 create mode 100644 tools/bootconfig/samples/bad-unclosed-quote.bconf
 create mode 100644 tools/bootconfig/samples/bad-unexpected-close-brace.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-dot-with-block.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-empty-block.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-empty-value-sep.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-quoted-newline.bconf
 create mode 100644 tools/bootconfig/samples/good-dot-with-block.bconf
 create mode 100644 tools/bootconfig/samples/good-empty-block.bconf
 create mode 100644 tools/bootconfig/samples/good-empty-value-sep.bconf
 create mode 100644 tools/bootconfig/samples/good-quoted-newline.bconf

diff --git a/tools/bootconfig/samples/bad-array-comment-delimiter.bconf b/tools/bootconfig/samples/bad-array-comment-delimiter.bconf
new file mode 100644
index 000000000000..5300cef82aa3
--- /dev/null
+++ b/tools/bootconfig/samples/bad-array-comment-delimiter.bconf
@@ -0,0 +1,2 @@
+key = 1 # comment
+      , 2 # Error: comment between value and its comma delimiter
diff --git a/tools/bootconfig/samples/bad-dot-middle.bconf b/tools/bootconfig/samples/bad-dot-middle.bconf
new file mode 100644
index 000000000000..b3bd19e3c991
--- /dev/null
+++ b/tools/bootconfig/samples/bad-dot-middle.bconf
@@ -0,0 +1 @@
+key..word = value # Double dots are not allowed
diff --git a/tools/bootconfig/samples/bad-invalid-operator.bconf b/tools/bootconfig/samples/bad-invalid-operator.bconf
new file mode 100644
index 000000000000..ca19895bee8a
--- /dev/null
+++ b/tools/bootconfig/samples/bad-invalid-operator.bconf
@@ -0,0 +1 @@
+key ?= value # Unsupported operator
diff --git a/tools/bootconfig/samples/bad-key-dot-end.bconf b/tools/bootconfig/samples/bad-key-dot-end.bconf
new file mode 100644
index 000000000000..57ae39d36e95
--- /dev/null
+++ b/tools/bootconfig/samples/bad-key-dot-end.bconf
@@ -0,0 +1 @@
+key. = value # Key cannot end with a dot
diff --git a/tools/bootconfig/samples/bad-unclosed-quote.bconf b/tools/bootconfig/samples/bad-unclosed-quote.bconf
new file mode 100644
index 000000000000..9384e68d17f6
--- /dev/null
+++ b/tools/bootconfig/samples/bad-unclosed-quote.bconf
@@ -0,0 +1 @@
+key = "unclosed quote
diff --git a/tools/bootconfig/samples/bad-unexpected-close-brace.bconf b/tools/bootconfig/samples/bad-unexpected-close-brace.bconf
new file mode 100644
index 000000000000..a372be395200
--- /dev/null
+++ b/tools/bootconfig/samples/bad-unexpected-close-brace.bconf
@@ -0,0 +1,4 @@
+key {
+    subkey = value
+}
+} # Extra closing brace
diff --git a/tools/bootconfig/samples/exp-good-dot-with-block.bconf b/tools/bootconfig/samples/exp-good-dot-with-block.bconf
new file mode 100644
index 000000000000..ff563ceec024
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-dot-with-block.bconf
@@ -0,0 +1 @@
+key.subkey.subsubkey = "value";
diff --git a/tools/bootconfig/samples/exp-good-empty-block.bconf b/tools/bootconfig/samples/exp-good-empty-block.bconf
new file mode 100644
index 000000000000..fe460e8e675c
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-empty-block.bconf
@@ -0,0 +1 @@
+key;
diff --git a/tools/bootconfig/samples/exp-good-empty-value-sep.bconf b/tools/bootconfig/samples/exp-good-empty-value-sep.bconf
new file mode 100644
index 000000000000..266851aae8f2
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-empty-value-sep.bconf
@@ -0,0 +1,3 @@
+key1 = "";
+key2 = "";
+key3 = "";
diff --git a/tools/bootconfig/samples/exp-good-quoted-newline.bconf b/tools/bootconfig/samples/exp-good-quoted-newline.bconf
new file mode 100644
index 000000000000..2b5166541df6
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-quoted-newline.bconf
@@ -0,0 +1,2 @@
+key = "value
+that spans multiple lines";
diff --git a/tools/bootconfig/samples/good-dot-with-block.bconf b/tools/bootconfig/samples/good-dot-with-block.bconf
new file mode 100644
index 000000000000..3d9bef7daa2f
--- /dev/null
+++ b/tools/bootconfig/samples/good-dot-with-block.bconf
@@ -0,0 +1,3 @@
+key.subkey {
+    subsubkey = value
+} # Combination of dot-notation and block syntax
diff --git a/tools/bootconfig/samples/good-empty-block.bconf b/tools/bootconfig/samples/good-empty-block.bconf
new file mode 100644
index 000000000000..8c390f37b177
--- /dev/null
+++ b/tools/bootconfig/samples/good-empty-block.bconf
@@ -0,0 +1 @@
+key { } # Empty block should be allowed and ignored
diff --git a/tools/bootconfig/samples/good-empty-value-sep.bconf b/tools/bootconfig/samples/good-empty-value-sep.bconf
new file mode 100644
index 000000000000..fbfb9a17ff99
--- /dev/null
+++ b/tools/bootconfig/samples/good-empty-value-sep.bconf
@@ -0,0 +1,3 @@
+key1 = ;
+key2 = 
+key3 = # comment
diff --git a/tools/bootconfig/samples/good-quoted-newline.bconf b/tools/bootconfig/samples/good-quoted-newline.bconf
new file mode 100644
index 000000000000..8c9cd088579a
--- /dev/null
+++ b/tools/bootconfig/samples/good-quoted-newline.bconf
@@ -0,0 +1,2 @@
+key = "value
+that spans multiple lines" # Quoted values can contain newlines

