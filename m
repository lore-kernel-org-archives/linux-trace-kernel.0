Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4B1C32;
	Sat, 26 Oct 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954460; cv=none; b=FZWPe4IqKsk8oXtzdMLQqu0ke2EKroyNi0T+VBzwpNIEx6PPP4KUHk0aH+vmSPKZztraxCuMML1D1uhT68y4pByw2qdxGwhp/yOlLE17Uk8E3pRPK1S6O8/zWdaU9kfzzvcGtEjiRtOiN7w89DDmgGCZV7ylFVoDceYnbEVK6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954460; c=relaxed/simple;
	bh=Xk81TdcWRQDfnCEIxCLdBc+GxIdRbjVtmK13yxQqWvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B57tPUVvwUQUY/M9fuezR2dh9nKbYIr6YZ/8Ut8Qp/PR9ig1T6Y5idzZueC2Krv1WIzFYh/RmSGQb7VWM/LP/fsK2Nm67rFpqWj/Wp7vJJMXyR7DqF6iTrLoRcajKtUjSTQuGNo8H/5Lk3TuDpsGj5NnbKo12+BrPgDs4y941Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=S1NcvznR; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="S1NcvznR"
Received: by lichtman.org (Postfix, from userid 1000)
	id 09918177103; Sat, 26 Oct 2024 14:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729954457; bh=Xk81TdcWRQDfnCEIxCLdBc+GxIdRbjVtmK13yxQqWvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1NcvznRHNFl9e7NrJuivc+m1pyoWxu4+8ew/sIeH0eooA48WTXl5U5uQk2s1Xi+O
	 39UpYBy0iITxZcwJZIX6wfd7B7PmptLCYCDUvUBiKkxO3ZgU6/mXLYGm9dZ3fJNqpK
	 Yz3AAy85qSlAoQ1g1+emYASZ6Mc31Mtk4cwa5GgwV6pS1X95xYR74NjQwcrccqk887
	 s1bKs9GyIYlOdkzB8nXbiGBzHpbxsS55aVrml22+zeqYVprumOwmIWH3UHQWbDmuo7
	 iqI3MrKPRvllvi8HfBYlMrjHIvIDPdWVqvfOeOU9QPsuOZ9Hd2pJG6AaSATt+B5f/g
	 +U2ol/GMmju5A==
Date: Sat, 26 Oct 2024 14:54:17 +0000
From: Nir Lichtman <nir@lichtman.org>
To: kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org
Cc: yuran.pereira@hotmail.com, jason.wessel@windriver.com,
	daniel.thompson@linaro.org, dianders@chromium.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 1/3] kdb: Replace the use of simple_strto with safer
 kstrto in kdb_main
Message-ID: <20241026145417.GA892629@lichtman.org>
References: <20241026144724.GA892311@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026144724.GA892311@lichtman.org>

From: Yuran Pereira <yuran.pereira@hotmail.com>

The simple_str* family of functions perform no error checking in
scenarios where the input value overflows the intended output variable.
This results in these functions successfully returning even when the
output does not match the input string.

Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
simple_strtoul(), and simple_strtoull() functions explicitly ignore
overflows, which may lead to unexpected results in callers."
Hence, the use of those functions is discouraged.

This patch replaces all uses of the simple_strto* series of functions
with their safer kstrto* alternatives.

Side effects of this patch:
- Every string to long or long long conversion using kstrto* is now
  checked for failure.
- kstrto* errors are handled with appropriate `KDB_BADINT` wherever
  applicable.
- A good side effect is that we end up saving a few lines of code
  since unlike in simple_strto* functions, kstrto functions do not
  need an additional "end pointer" variable, and the return values
  of the latter can be directly checked in an "if" statement without
  the need to define additional `ret` or `err` variables.
  This, of course, results in cleaner, yet still easy to understand
  code.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
[nir: addressed review comments by fixing styling, invalid conversion and a missing error return]
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 kernel/debug/kdb/kdb_main.c | 69 +++++++++++--------------------------
 1 file changed, 21 insertions(+), 48 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f5f7d7fb5936..930de4fdc708 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -306,8 +306,8 @@ static int kdbgetulenv(const char *match, unsigned long *value)
 		return KDB_NOTENV;
 	if (strlen(ep) == 0)
 		return KDB_NOENVVALUE;
-
-	*value = simple_strtoul(ep, NULL, 0);
+	if (kstrtoul(ep, 0, value))
+		return KDB_BADINT;
 
 	return 0;
 }
@@ -402,42 +402,23 @@ static void kdb_printenv(void)
  */
 int kdbgetularg(const char *arg, unsigned long *value)
 {
-	char *endp;
-	unsigned long val;
-
-	val = simple_strtoul(arg, &endp, 0);
-
-	if (endp == arg) {
-		/*
-		 * Also try base 16, for us folks too lazy to type the
-		 * leading 0x...
-		 */
-		val = simple_strtoul(arg, &endp, 16);
-		if (endp == arg)
+	/*
+	 * If the first fails, also try base 16, for us
+	 * folks too lazy to type the leading 0x...
+	 */
+	if (kstrtoul(arg, 0, value)) {
+		if (kstrtoul(arg, 16, value))
 			return KDB_BADINT;
 	}
-
-	*value = val;
-
 	return 0;
 }
 
 int kdbgetu64arg(const char *arg, u64 *value)
 {
-	char *endp;
-	u64 val;
-
-	val = simple_strtoull(arg, &endp, 0);
-
-	if (endp == arg) {
-
-		val = simple_strtoull(arg, &endp, 16);
-		if (endp == arg)
+	if (kstrtou64(arg, 0, value)) {
+		if (kstrtou64(arg, 16, value))
 			return KDB_BADINT;
 	}
-
-	*value = val;
-
 	return 0;
 }
 
@@ -473,10 +454,10 @@ int kdb_set(int argc, const char **argv)
 	 */
 	if (strcmp(argv[1], "KDBDEBUG") == 0) {
 		unsigned int debugflags;
-		char *cp;
+		int ret;
 
-		debugflags = simple_strtoul(argv[2], &cp, 0);
-		if (cp == argv[2] || debugflags & ~KDB_DEBUG_FLAG_MASK) {
+		ret = kstrtouint(argv[2], 0, &debugflags);
+		if (ret || debugflags & ~KDB_DEBUG_FLAG_MASK) {
 			kdb_printf("kdb: illegal debug flags '%s'\n",
 				    argv[2]);
 			return 0;
@@ -1619,10 +1600,10 @@ static int kdb_md(int argc, const char **argv)
 		if (!argv[0][3])
 			valid = 1;
 		else if (argv[0][3] == 'c' && argv[0][4]) {
-			char *p;
-			repeat = simple_strtoul(argv[0] + 4, &p, 10);
+			if (kstrtouint(argv[0] + 4, 10, &repeat))
+				return KDB_BADINT;
 			mdcount = ((repeat * bytesperword) + 15) / 16;
-			valid = !*p;
+			valid = 1;
 		}
 		last_repeat = repeat;
 	} else if (strcmp(argv[0], "md") == 0)
@@ -2083,15 +2064,10 @@ static int kdb_dmesg(int argc, const char **argv)
 	if (argc > 2)
 		return KDB_ARGCOUNT;
 	if (argc) {
-		char *cp;
-		lines = simple_strtol(argv[1], &cp, 0);
-		if (*cp)
+		if (kstrtoint(argv[1], 0, &lines))
 			lines = 0;
-		if (argc > 1) {
-			adjust = simple_strtoul(argv[2], &cp, 0);
-			if (*cp || adjust < 0)
-				adjust = 0;
-		}
+		if (argc > 1 && (kstrtouint(argv[2], 0, &adjust) || adjust < 0))
+			adjust = 0;
 	}
 
 	/* disable LOGGING if set */
@@ -2428,14 +2404,12 @@ static int kdb_help(int argc, const char **argv)
 static int kdb_kill(int argc, const char **argv)
 {
 	long sig, pid;
-	char *endp;
 	struct task_struct *p;
 
 	if (argc != 2)
 		return KDB_ARGCOUNT;
 
-	sig = simple_strtol(argv[1], &endp, 0);
-	if (*endp)
+	if (kstrtol(argv[1], 0, &sig))
 		return KDB_BADINT;
 	if ((sig >= 0) || !valid_signal(-sig)) {
 		kdb_printf("Invalid signal parameter.<-signal>\n");
@@ -2443,8 +2417,7 @@ static int kdb_kill(int argc, const char **argv)
 	}
 	sig = -sig;
 
-	pid = simple_strtol(argv[2], &endp, 0);
-	if (*endp)
+	if (kstrtol(argv[2], 0, &pid))
 		return KDB_BADINT;
 	if (pid <= 0) {
 		kdb_printf("Process ID must be large than 0.\n");
-- 
2.39.2

