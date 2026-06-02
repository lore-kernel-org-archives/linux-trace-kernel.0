Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DD01DF261
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404928; cv=none; b=DwtJVpCz0QG4yiDIJrBiW/sQlNNcbZKd8rL0cgLSCgq9F+zad6vo3y9u6GmlkLyeoEx5T2k4KRhLNh20SUeh9sP5McRjCp7T98tCUxU6Zz352YWLIo4nYkTHco0l5bBeA60UWL5Ni00+dx8Xafv76ZULENsvfI2KJpGl0skcwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404928; c=relaxed/simple;
	bh=40a8CZ4Xcre+mLS5Sfq8BpXBloAO2QqvYjH+FDVui7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=tYz/CSz5WkSlLw32KSfbFe34YHoM+ZR9TkPGbjVg26cy02kieGuEPsUgpprKxkK57o8x2AEyXr/tI/buv/pRqzNC8xEXIo8DXUbPeQp3lsRDj16aW7aQcQe8e10E4jMJ01A8qOqludVKHVroc9QBaMxxzDl8Gg0yMUKRihtoCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNW6qFoN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNW6qFoN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780404924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oOwelyxxlXBlv9AIJnzIccidy6w0wdZvodsmuAcSGIw=;
	b=BNW6qFoNSRbzc9fYl+Odz+t8JWpPzoXnTszO4iVRkvDObayCzkfhd+2iRgZrEuFVOx2MXq
	5oleuqfmOrqtAmTSU28RQJYz4mW3GNNYEw4vTwEJNyis0nGg/V2B7xWj+XB9bN5LCzTxz1
	G3A2d6S7u4Rx10SyLHZyI+miOrh7D1U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-xfj5Bs9dN8W4GZ-dvjVPmQ-1; Tue,
 02 Jun 2026 08:55:21 -0400
X-MC-Unique: xfj5Bs9dN8W4GZ-dvjVPmQ-1
X-Mimecast-MFC-AGG-ID: xfj5Bs9dN8W4GZ-dvjVPmQ_1780404920
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76DB419560A2;
	Tue,  2 Jun 2026 12:55:20 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18DA51684;
	Tue,  2 Jun 2026 12:55:17 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] rtla: Fix parsing of multi-character short options
Date: Tue,  2 Jun 2026 14:55:06 +0200
Message-ID: <20260602125506.3325345-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: xTGoAC-jFhBXFDu2HBBQsb_6u3radAFgMfYBmTTQhdw_1780404920
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

A bug was reported where the parsing of multi-character short options,
be it a short option with an argument specified without space (e.g.
"-p100") or multiple short options in one argument (e.g. -un), ignores
options specific to individual tools.

Furthermore, if the rest of the option is supposed to be an argument, it
gets reinterpreted as a string of options. For example, -p100 gets
interpreted as -100, which is due to hackish implementation read as
--no-thread --no-irq --no-irq with timerlat hist, causing rtla to error
out:

$ rtla timerlat hist -p100
no-irq and no-thread set, there is nothing to do here

This behavior is caused by getopt_long() being called twice on each
argument, once in common_parse_options(), once in [tool]_parse_args():

- common_parse_options() calls getopt_long() with an array of options
  common for all rtla tools, while suppressing errors (opterr = 0).
- If the option fails to parse, common_parse_options() returns 0.
- If 0 is returned from common_parse_options(), [tool]_parse_args()
  calls getopt_long() again, with its own set of options.

* [tool] means one of {osnoise,timerlat}_{top,hist}

At least in glibc, getopt_long() increments its internal nextchar
variable even if the option is not recognized. That means that in the
case of "-p100", common_parse_options() sets nextchar pointing to '1',
and timerlat_hist_parse_args() sees '1', not 'p'; the same then repeats
for the first and second '0'.

As there is no way to restore the correct internal state of
getopt_long() reliably, fix the issue by merging the common options back
to the longopt array and option string of the [tool]_parse_args()
functions using a macro; only the switch part is left in the original
function, which is renamed to set_common_option().

Fixes: 850cd24cb6d6 ("tools/rtla: Add common_parse_options()")
Reported-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/common.c        | 28 +++++---------------------
 tools/tracing/rtla/src/common.h        | 12 ++++++++++-
 tools/tracing/rtla/src/osnoise_hist.c  |  7 ++++---
 tools/tracing/rtla/src/osnoise_top.c   |  7 ++++---
 tools/tracing/rtla/src/timerlat_hist.c |  7 ++++---
 tools/tracing/rtla/src/timerlat_top.c  |  7 ++++---
 6 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 35e3d3aa922e..bc9d01ddd102 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -84,37 +84,20 @@ int getopt_auto(int argc, char **argv, const struct option *long_opts)
 }
 
 /*
- * common_parse_options - parse common command line options
+ * set_common_option - set common options
  *
+ * @c: option character
  * @argc: argument count
  * @argv: argument vector
  * @common: common parameters structure
  *
  * Parse command line options that are common to all rtla tools.
  *
- * Returns: non zero if a common option was parsed, or 0
- * if the option should be handled by tool-specific parsing.
+ * Returns: 1 if the option was set, 0 otherwise.
  */
-int common_parse_options(int argc, char **argv, struct common_params *common)
+int set_common_option(int c, int argc, char **argv, struct common_params *common)
 {
 	struct trace_events *tevent;
-	int saved_state = optind;
-	int c;
-
-	static struct option long_options[] = {
-		{"cpus",                required_argument,      0, 'c'},
-		{"cgroup",              optional_argument,      0, 'C'},
-		{"debug",               no_argument,            0, 'D'},
-		{"duration",            required_argument,      0, 'd'},
-		{"event",               required_argument,      0, 'e'},
-		{"house-keeping",       required_argument,      0, 'H'},
-		{"priority",            required_argument,      0, 'P'},
-		{0, 0, 0, 0}
-	};
-
-	opterr = 0;
-	c = getopt_auto(argc, argv, long_options);
-	opterr = 1;
 
 	switch (c) {
 	case 'c':
@@ -154,11 +137,10 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 		common->set_sched = 1;
 		break;
 	default:
-		optind = saved_state;
 		return 0;
 	}
 
-	return c;
+	return 1;
 }
 
 /*
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 51665db4ffce..8921807bda98 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -178,7 +178,17 @@ int osnoise_set_stop_total_us(struct osnoise_context *context,
 			      long long stop_total_us);
 
 int getopt_auto(int argc, char **argv, const struct option *long_opts);
-int common_parse_options(int argc, char **argv, struct common_params *common);
+
+#define COMMON_OPTIONS \
+	{"cpus",                required_argument,      0, 'c'},\
+	{"cgroup",              optional_argument,      0, 'C'},\
+	{"debug",               no_argument,            0, 'D'},\
+	{"duration",            required_argument,      0, 'd'},\
+	{"event",               required_argument,      0, 'e'},\
+	{"house-keeping",       required_argument,      0, 'H'},\
+	{"priority",            required_argument,      0, 'P'}
+int set_common_option(int c, int argc, char **argv, struct common_params *common);
+
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
 int top_main_loop(struct osnoise_tool *tool);
 int hist_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8ad816b80265..cb4ce58c5987 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -475,6 +475,7 @@ static struct common_params
 
 	while (1) {
 		static struct option long_options[] = {
+			COMMON_OPTIONS,
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
@@ -498,15 +499,15 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		if (common_parse_options(argc, argv, &params->common))
-			continue;
-
 		c = getopt_auto(argc, argv, long_options);
 
 		/* detect the end of the options. */
 		if (c == -1)
 			break;
 
+		if (set_common_option(c, argc, argv, &params->common))
+			continue;
+
 		switch (c) {
 		case 'a':
 			/* set sample stop to auto_thresh */
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 244bdce022ad..e65312ec26c4 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -328,6 +328,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 
 	while (1) {
 		static struct option long_options[] = {
+			COMMON_OPTIONS,
 			{"auto",		required_argument,	0, 'a'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
@@ -346,15 +347,15 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			{0, 0, 0, 0}
 		};
 
-		if (common_parse_options(argc, argv, &params->common))
-			continue;
-
 		c = getopt_auto(argc, argv, long_options);
 
 		/* Detect the end of the options. */
 		if (c == -1)
 			break;
 
+		if (set_common_option(c, argc, argv, &params->common))
+			continue;
+
 		switch (c) {
 		case 'a':
 			/* set sample stop to auto_thresh */
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 79142af4f566..4b6708e333b8 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -785,6 +785,7 @@ static struct common_params
 
 	while (1) {
 		static struct option long_options[] = {
+			COMMON_OPTIONS,
 			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
@@ -819,11 +820,11 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		if (common_parse_options(argc, argv, &params->common))
-			continue;
-
 		c = getopt_auto(argc, argv, long_options);
 
+		if (set_common_option(c, argc, argv, &params->common))
+			continue;
+
 		/* detect the end of the options. */
 		if (c == -1)
 			break;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 64cbdcc878b0..91f88bbebad9 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -549,6 +549,7 @@ static struct common_params
 
 	while (1) {
 		static struct option long_options[] = {
+			COMMON_OPTIONS,
 			{"auto",		required_argument,	0, 'a'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
@@ -577,11 +578,11 @@ static struct common_params
 			{0, 0, 0, 0}
 		};
 
-		if (common_parse_options(argc, argv, &params->common))
-			continue;
-
 		c = getopt_auto(argc, argv, long_options);
 
+		if (set_common_option(c, argc, argv, &params->common))
+			continue;
+
 		/* detect the end of the options. */
 		if (c == -1)
 			break;
-- 
2.54.0

