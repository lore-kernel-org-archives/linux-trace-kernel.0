Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C741161B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086173; cv=none; b=LMfRXVuiZNr9ZxlMfRDswuiNK0YtQKuFBsFs9vW+8bi+vTgsz0PLT6xwLGt0tqui7vMzPyy2qu8axj51DiDmhSQ3zAPgYltUjlrsIHJS7VmYrl9DJWxqqOw4iFEvWxSoI7esEWJhjvq2Z+mKa+WwZMUFnzZ5xM45lF6qTtF84QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086173; c=relaxed/simple;
	bh=A6AwkQvxJujn8gLfXjT5hCNqGSMzHSoUg98h4B1tY0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HjHUcZHJ9BLEyZsBJge1h4NR3k9xiEbLDSQrYQF2aJQ7y7GbEFMil4hAiSKOHBA76U5bTlUBvqHRX6vxJ27RCRMOXI1ug6kU9kH+p+IWOw0oJVRDJzvaS3GOrpvImHFRn7VrE+qtBC0VQ4JvjJAmi+E4rjc68MI1MjcBAaD/8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8//i+v6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8//i+v6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XE9tVL0amLnuy/qnOAxXmbfUZQ7BCSZ1Cf0kdtRjbNU=;
	b=N8//i+v6CDdFIueNIgpXyfc12TttlJA0HVuTawMKF8H7ntaCRQ6mKgbocGMbsxI04YLYdO
	dgEWA/gGH2lhkKADZKbujq2e7jGpkoWNp53i93x6VQ7qJtOidRS8XRbbarSw+cNrw9CDma
	EcKiSKkKowlwfAzh/Sow3p3Wt/s1v9A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-LlUycme6NOGwpRd8itdufA-1; Mon,
 09 Mar 2026 15:56:07 -0400
X-MC-Unique: LlUycme6NOGwpRd8itdufA-1
X-Mimecast-MFC-AGG-ID: LlUycme6NOGwpRd8itdufA_1773086165
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E34D1800359;
	Mon,  9 Mar 2026 19:56:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1F3330002D2;
	Mon,  9 Mar 2026 19:55:59 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 03/18] rtla/actions: Simplify argument parsing
Date: Mon,  9 Mar 2026 16:46:16 -0300
Message-ID: <20260309195040.1019085-4-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-1-wander@redhat.com>
References: <20260309195040.1019085-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: YLUwgZMCSG4KvKJILjxNkMme6IXJQXcfxGnbGqIVRW0_1773086165
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The actions_parse() function uses open-coded logic to extract arguments
from a string. This includes manual length checks and strncmp() calls,
which can be verbose and error-prone.

To simplify and improve the robustness of argument parsing, introduce a
new extract_arg() helper macro. This macro extracts the value from a
"key=value" pair, making the code more concise and readable.

Also, introduce STRING_LENGTH() and strncmp_static() macros to
perform compile-time calculations of string lengths and safer string
comparisons.

Refactor actions_parse() to use these new helpers, resulting in
cleaner and more maintainable code.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 57 +++++++++++++++++++++++---------
 tools/tracing/rtla/src/utils.h   | 10 ++++++
 2 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 0ac42ffd734a3..b0d68b5de08db 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -111,6 +111,29 @@ actions_add_continue(struct actions *self)
 	action->type = ACTION_CONTINUE;
 }
 
+static inline const char *__extract_arg(const char *token, const char *opt, size_t opt_len)
+{
+	const size_t tok_len = strlen(token);
+
+	if (tok_len <= opt_len)
+		return NULL;
+
+	if (strncmp(token, opt, opt_len))
+		return NULL;
+
+	return token + opt_len;
+}
+
+/*
+ * extract_arg - extract argument value from option token
+ * @token: option token (e.g., "file=trace.txt")
+ * @opt: option name to match (e.g., "file")
+ *
+ * Returns pointer to argument value after "=" if token matches "opt=",
+ * otherwise returns NULL.
+ */
+#define extract_arg(token, opt) __extract_arg(token, opt "=", STRING_LENGTH(opt "="))
+
 /*
  * actions_parse - add an action based on text specification
  */
@@ -120,6 +143,7 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 	enum action_type type = ACTION_NONE;
 	const char *token;
 	char trigger_c[strlen(trigger) + 1];
+	const char *arg_value;
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;
@@ -152,12 +176,10 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 		if (token == NULL)
 			trace_output = tracefn;
 		else {
-			if (strlen(token) > 5 && strncmp(token, "file=", 5) == 0) {
-				trace_output = token + 5;
-			} else {
+			trace_output = extract_arg(token, "file");
+			if (!trace_output)
 				/* Invalid argument */
 				return -1;
-			}
 
 			token = strtok(NULL, ",");
 			if (token != NULL)
@@ -169,17 +191,21 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 	case ACTION_SIGNAL:
 		/* Takes two arguments, num (signal) and pid */
 		while (token != NULL) {
-			if (strlen(token) > 4 && strncmp(token, "num=", 4) == 0) {
-				if (strtoi(token + 4, &signal))
-					return -1;
-			} else if (strlen(token) > 4 && strncmp(token, "pid=", 4) == 0) {
-				if (strncmp(token + 4, "parent", 7) == 0)
-					pid = -1;
-				else if (strtoi(token + 4, &pid))
+			arg_value = extract_arg(token, "num");
+			if (arg_value) {
+				if (strtoi(arg_value, &signal))
 					return -1;
 			} else {
-				/* Invalid argument */
-				return -1;
+				arg_value = extract_arg(token, "pid");
+				if (arg_value) {
+					if (strncmp_static(arg_value, "parent") == 0)
+						pid = -1;
+					else if (strtoi(arg_value, &pid))
+						return -1;
+				} else {
+					/* Invalid argument */
+					return -1;
+				}
 			}
 
 			token = strtok(NULL, ",");
@@ -194,9 +220,10 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 	case ACTION_SHELL:
 		if (token == NULL)
 			return -1;
-		if (strlen(token) > 8 && strncmp(token, "command=", 8))
+		arg_value = extract_arg(token, "command");
+		if (!arg_value)
 			return -1;
-		actions_add_shell(self, token + 8);
+		actions_add_shell(self, arg_value);
 		break;
 	case ACTION_CONTINUE:
 		/* Takes no argument */
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index e29c2eb5d569d..11458676f607d 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -14,6 +14,16 @@
 #define MAX_NICE		20
 #define MIN_NICE		-19
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+#endif
+
+/* Calculate string length at compile time (excluding null terminator) */
+#define STRING_LENGTH(s) (ARRAY_SIZE(s) - sizeof(*(s)))
+
+/* Compare string with static string, length determined at compile time */
+#define strncmp_static(s1, s2) strncmp(s1, s2, ARRAY_SIZE(s2))
+
 #define container_of(ptr, type, member)({			\
 	const typeof(((type *)0)->member) *__mptr = (ptr);	\
 	(type *)((char *)__mptr - offsetof(type, member)) ; })
-- 
2.53.0

