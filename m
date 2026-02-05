Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AA77404E;
	Thu,  5 Feb 2026 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770252399; cv=none; b=AuTDQhcx7dk/4o7d4R/7+pdoMjGdLlY3AxYvs5jLCWKk53mwbsjDgHgZsrfCAJU5f/AHCBmd1XtKZdrjZBUJWI8DEsKCnbjWBBJ450AO7m3SE2oXzQBo70gHqPXbw8Nc6NmirbI/en8EeKxXGv3x1qZEnBG46TGRu+6K1D2sy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770252399; c=relaxed/simple;
	bh=KD/PrNKxu0z69syPL6ucmtIuDepM7ZtLxk7vRvNSJng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXfW3LdaIWWZZIobr6sMMfogfBAz915Ez/kjcW8sclAkCgRtrxewHHtFN5VMmt8Lh+WRRQzIFddx5wDBItry4voXT8pE8alPZ4ds5oxijvz0oLC46COxIvy+jUuf6sJejwHJbkLXkMyKlTfmfmgDBPUG0B+5YGnUdxDnXmR/jds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUflrtpU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUflrtpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CE2C4CEF7;
	Thu,  5 Feb 2026 00:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770252399;
	bh=KD/PrNKxu0z69syPL6ucmtIuDepM7ZtLxk7vRvNSJng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUflrtpU4DkcCvCIoYYBRC5JFAW56oewCMzlYUXevv3LFvXzapSrHNz/j1JX4pCDi
	 IfLNKD7qV68eSqgc5VgSlS7E0zH0ue2ZkwHjdQnVhE8qg9tT+umcZPpsqsW7SAQ0x2
	 urBkMC5Bx0A633UVsgXrzYkCLnlZDCkQaizbwWa229dnzHtcvdk/mTs3k/c4IkE+O1
	 5djiAwOpx8Xw8XdFF+bmtC7Y/erAip+nTKN48h1/3ijnwtQJD8SER/DpwYDa6E6Jpf
	 lji4KizKEfbf+CMhmLUeUjfgmna3yA0H4mQMzdVJK/ig+zmJnZwLsPf2mNbM3B9mZ5
	 CyxWiT58+mElA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Julius Werner <jwerner@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] bootconfig: Check the parsed output of the good examples
Date: Thu,  5 Feb 2026 09:46:35 +0900
Message-ID: <177025239529.14982.12913754615993262263.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177025237564.14982.14899224362754775890.stgit@devnote2>
References: <177025237564.14982.14899224362754775890.stgit@devnote2>
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

Check whether the parsed output of the good example configs are
the same as expected.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../samples/exp-good-array-space-comment.bconf     |    1 +
 .../samples/exp-good-comment-after-value.bconf     |    1 +
 .../bootconfig/samples/exp-good-mixed-append.bconf |    2 ++
 tools/bootconfig/samples/exp-good-mixed-kv1.bconf  |    2 ++
 tools/bootconfig/samples/exp-good-mixed-kv2.bconf  |    2 ++
 tools/bootconfig/samples/exp-good-mixed-kv3.bconf  |    5 +++++
 .../samples/exp-good-mixed-override.bconf          |    2 ++
 tools/bootconfig/samples/exp-good-override.bconf   |    4 ++++
 tools/bootconfig/samples/exp-good-printables.bconf |    2 ++
 tools/bootconfig/samples/exp-good-simple.bconf     |    8 ++++++++
 tools/bootconfig/samples/exp-good-single.bconf     |    3 +++
 .../samples/exp-good-space-after-value.bconf       |    1 +
 tools/bootconfig/samples/exp-good-tree.bconf       |    8 ++++++++
 tools/bootconfig/test-bootconfig.sh                |    3 +++
 14 files changed, 44 insertions(+)
 create mode 100644 tools/bootconfig/samples/exp-good-array-space-comment.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-comment-after-value.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-append.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-kv2.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-kv3.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-override.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-override.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-printables.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-simple.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-single.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-space-after-value.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-tree.bconf

diff --git a/tools/bootconfig/samples/exp-good-array-space-comment.bconf b/tools/bootconfig/samples/exp-good-array-space-comment.bconf
new file mode 100644
index 000000000000..8d3278fa6af5
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-array-space-comment.bconf
@@ -0,0 +1 @@
+key = "value1", "value2", "value3";
diff --git a/tools/bootconfig/samples/exp-good-comment-after-value.bconf b/tools/bootconfig/samples/exp-good-comment-after-value.bconf
new file mode 100644
index 000000000000..a8e8450db3c0
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-comment-after-value.bconf
@@ -0,0 +1 @@
+key = "value";
diff --git a/tools/bootconfig/samples/exp-good-mixed-append.bconf b/tools/bootconfig/samples/exp-good-mixed-append.bconf
new file mode 100644
index 000000000000..c2b407901ddd
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-mixed-append.bconf
@@ -0,0 +1,2 @@
+key = "foo", "bar";
+keyx.subkey = "value";
diff --git a/tools/bootconfig/samples/exp-good-mixed-kv1.bconf b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
new file mode 100644
index 000000000000..8346287d9251
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
@@ -0,0 +1,2 @@
+key = "value";
+key.subkey = "another-value";
diff --git a/tools/bootconfig/samples/exp-good-mixed-kv2.bconf b/tools/bootconfig/samples/exp-good-mixed-kv2.bconf
new file mode 100644
index 000000000000..40c6232c7cdd
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-mixed-kv2.bconf
@@ -0,0 +1,2 @@
+key = "another-value";
+key.subkey = "value";
diff --git a/tools/bootconfig/samples/exp-good-mixed-kv3.bconf b/tools/bootconfig/samples/exp-good-mixed-kv3.bconf
new file mode 100644
index 000000000000..8368a7bef60a
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-mixed-kv3.bconf
@@ -0,0 +1,5 @@
+key = "value";
+key {
+	subkey1;
+	subkey2 = "foo";
+}
diff --git a/tools/bootconfig/samples/exp-good-mixed-override.bconf b/tools/bootconfig/samples/exp-good-mixed-override.bconf
new file mode 100644
index 000000000000..58757712ca45
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-mixed-override.bconf
@@ -0,0 +1,2 @@
+key = "value2";
+key.foo = "bar";
diff --git a/tools/bootconfig/samples/exp-good-override.bconf b/tools/bootconfig/samples/exp-good-override.bconf
new file mode 100644
index 000000000000..00bbd30e99ae
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-override.bconf
@@ -0,0 +1,4 @@
+key {
+	word = "2", "3";
+	new.word = "new";
+}
diff --git a/tools/bootconfig/samples/exp-good-printables.bconf b/tools/bootconfig/samples/exp-good-printables.bconf
new file mode 100644
index 000000000000..5981d304eacb
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-printables.bconf
@@ -0,0 +1,2 @@
+key = "	
+ !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
diff --git a/tools/bootconfig/samples/exp-good-simple.bconf b/tools/bootconfig/samples/exp-good-simple.bconf
new file mode 100644
index 000000000000..d17f39421c86
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-simple.bconf
@@ -0,0 +1,8 @@
+key {
+	word1 = "1";
+	word2 = "2";
+	word3 = "3";
+	word4 = "4";
+	word5 = "5";
+	word6 = "6";
+}
diff --git a/tools/bootconfig/samples/exp-good-single.bconf b/tools/bootconfig/samples/exp-good-single.bconf
new file mode 100644
index 000000000000..01196910d7f4
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-single.bconf
@@ -0,0 +1,3 @@
+key = "1";
+key2 = "2";
+key3 = "alpha", "beta";
diff --git a/tools/bootconfig/samples/exp-good-space-after-value.bconf b/tools/bootconfig/samples/exp-good-space-after-value.bconf
new file mode 100644
index 000000000000..a8e8450db3c0
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-space-after-value.bconf
@@ -0,0 +1 @@
+key = "value";
diff --git a/tools/bootconfig/samples/exp-good-tree.bconf b/tools/bootconfig/samples/exp-good-tree.bconf
new file mode 100644
index 000000000000..b711d38d86fd
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-tree.bconf
@@ -0,0 +1,8 @@
+key {
+	word.tree.value = "0";
+	word2.tree.value = "1", "2";
+}
+other.tree {
+	value = "2";
+	value2 = "3";
+}
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 7594659af1e1..be9bd18b1d56 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -179,6 +179,9 @@ done
 echo "=== expected success cases ==="
 for i in samples/good-* ; do
   xpass $BOOTCONF -a $i $INITRD
+  x="samples/exp-"`basename $i`
+  $BOOTCONF $i > $TEMPCONF
+  xpass diff $x $TEMPCONF
 done
 
 

