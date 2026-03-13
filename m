Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F71A683D;
	Fri, 13 Mar 2026 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375539; cv=none; b=ODGH9Nvba4XGiUQygMJN5kBMo/tzOdYg8QQT2H+cWFAADSmdfmW7WZADvSWuBv6lTXhPPE9kcyv0WN4vQnCp0IPnLIBu2aWhqSZjeZspuQ+dYDyVQQ6rhNcKZM7yIidInEfbYO6NSEPJ2T/8gMQRZj3gevGC4CPXNrlC6eM/8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375539; c=relaxed/simple;
	bh=Tt3AfELBEtOk0qMhCqYoOGFksbxLNP2gfazCyyXA3zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxqSeJJUWMqGETTipxUxjEShthWCUZW4t2SKePFHjBhDZUyY02eNtZd8vorSTZhj9H73pqrP8lcBAdzdBQHENT5tOgLhfcXU6bxXKWAdeXivQ0nxlt1d2nYn/sd3MO0qb+z5lzpg+szkZgf7aM9Oa9Qqnxs9AXLD1gnD6uc2Mgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6UOstIi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6UOstIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B618C19421;
	Fri, 13 Mar 2026 04:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375539;
	bh=Tt3AfELBEtOk0qMhCqYoOGFksbxLNP2gfazCyyXA3zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a6UOstIivyxodtN4Yn3n1/3OrFn5+d/tauxRsgMqeRycoq9gNcw0BlhiGva6OPxqB
	 5XTv5NAJrR9RtJRpJADxjMrp747XpM2NlvFGcX+pRnuncWeujNaEanB9YiKcGyWrIM
	 +8BpctJGPV6XtvHb1mNoIA3GnneOzd2cNOQotNkCceqN4oXiFihUIdkFwNJCMb+tVn
	 LCqguYEgE904J/M+Zdl5q/SlY81BTLtJjulhc7MkxPefdeeNhvXDT3cRlyA/Ua5AjE
	 PedrOhXQ3lwxBoeV13QL8MOGq8897or2HwTDyrW6wB+0b2RMPMhUYlmZ4M+q4Y4o0T
	 W37mYJfFW9MaQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Josh Law <objecting@objecting.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: Add bootconfig tests about braces
Date: Fri, 13 Mar 2026 13:18:55 +0900
Message-ID: <177337553551.416919.11217619471547711262.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312191143.28719-1-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
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

Add more bootconfig tests for checking the error message of
non closing brace and max number of nested braces.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../bootconfig/samples/bad-non-closed-brace.bconf  |    4 ++++
 tools/bootconfig/samples/bad-over-max-brace.bconf  |   19 +++++++++++++++++++
 .../bootconfig/samples/exp-good-nested-brace.bconf |    1 +
 tools/bootconfig/samples/good-nested-brace.bconf   |   18 ++++++++++++++++++
 tools/bootconfig/test-bootconfig.sh                |    9 +++++++++
 5 files changed, 51 insertions(+)
 create mode 100644 tools/bootconfig/samples/bad-non-closed-brace.bconf
 create mode 100644 tools/bootconfig/samples/bad-over-max-brace.bconf
 create mode 100644 tools/bootconfig/samples/exp-good-nested-brace.bconf
 create mode 100644 tools/bootconfig/samples/good-nested-brace.bconf

diff --git a/tools/bootconfig/samples/bad-non-closed-brace.bconf b/tools/bootconfig/samples/bad-non-closed-brace.bconf
new file mode 100644
index 000000000000..6ed9f3363dde
--- /dev/null
+++ b/tools/bootconfig/samples/bad-non-closed-brace.bconf
@@ -0,0 +1,4 @@
+foo {
+ bar {
+   buz
+ }
diff --git a/tools/bootconfig/samples/bad-over-max-brace.bconf b/tools/bootconfig/samples/bad-over-max-brace.bconf
new file mode 100644
index 000000000000..74b5dc9e21dc
--- /dev/null
+++ b/tools/bootconfig/samples/bad-over-max-brace.bconf
@@ -0,0 +1,19 @@
+key1 {
+key2 {
+key3 {
+key4 {
+key5 {
+key6 {
+key7 {
+key8 {
+key9 {
+key10 {
+key11 {
+key12 {
+key13 {
+key14 {
+key15 {
+key16 {
+key17 {
+}}}}}}}}}}}}}}}}}
+
diff --git a/tools/bootconfig/samples/exp-good-nested-brace.bconf b/tools/bootconfig/samples/exp-good-nested-brace.bconf
new file mode 100644
index 000000000000..19e0f51b4553
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-nested-brace.bconf
@@ -0,0 +1 @@
+key1.key2.key3.key4.key5.key6.key7.key8.key9.key10.key11.key12.key13.key14.key15.key16;
diff --git a/tools/bootconfig/samples/good-nested-brace.bconf b/tools/bootconfig/samples/good-nested-brace.bconf
new file mode 100644
index 000000000000..980d094f296e
--- /dev/null
+++ b/tools/bootconfig/samples/good-nested-brace.bconf
@@ -0,0 +1,18 @@
+key1 {
+key2 {
+key3 {
+key4 {
+key5 {
+key6 {
+key7 {
+key8 {
+key9 {
+key10 {
+key11 {
+key12 {
+key13 {
+key14 {
+key15 {
+key16 {
+}}}}}}}}}}}}}}}}
+
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index be9bd18b1d56..fc69f815ce4a 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -171,6 +171,15 @@ $BOOTCONF $INITRD > $OUTFILE
 xfail grep -q 'val[[:space:]]' $OUTFILE
 xpass grep -q 'val2[[:space:]]' $OUTFILE
 
+echo "Showing correct line:column of no closing brace"
+cat > $TEMPCONF << EOF
+foo {
+bar {
+}
+EOF
+$BOOTCONF -a $TEMPCONF $INITRD 2> $OUTFILE
+xpass grep -q "1:1" $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD

