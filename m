Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA9367B8C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303236; cv=none; b=mzLGrQUkKaRH/g39rUd2wMEsCA5VugzH8kmGpWbRSEXv4Lqb8rG55lARVVLKJq9pRCoM+u/o1i7BdV9WPF75deqFOBW8yNbpIkfANb9oK0ArHq4ou+zDuzdeMjrjz+0yjE8sZcPbRsBkbqU8ud963mjf/L3kNcY+mXIb/fLVtvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303236; c=relaxed/simple;
	bh=ycYvBP9hzjR8aDm3BJY/4osWJ8vsvl8LdYfIxaFDnyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FCD5VFpnoxsxaV1JUV1XPVN+jsev5HSILVjfBv33HIgaghcvC5aBdszECs7cii5hIemRpvWLA8NumpJCXZgW3gtnaAvSLbWMiYUzk5QZ9DihplU72kK7IMwtUMkqgyyKHSz+FmT7Um4iJCh7QMoF7Ka1cjVydX6BSwKnIN24qk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fku6VN6e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fku6VN6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784303234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEnIH1pC1zinOd93k1MlbOMnciBp15Ri/sQHFqDz0Fw=;
	b=Fku6VN6e+qBaWqUlsa+ZAeTE6Ir4rIIdNSSvvGYqGTk5u0ViQasV5ze+iTl7AiUYotTv2u
	6z17mb/baJ/UaWSZN5J1idYdmbVkklaTdFZkH5b17A0v2NjO2Iob3RxjoNU96mtqqhI93q
	mBxH27GdYODtlpnoBqBzY9xKwIOwrPw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-BmF_NjkvPlSArehR5ht7EQ-1; Fri,
 17 Jul 2026 11:47:10 -0400
X-MC-Unique: BmF_NjkvPlSArehR5ht7EQ-1
X-Mimecast-MFC-AGG-ID: BmF_NjkvPlSArehR5ht7EQ_1784303229
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33CE718009CE;
	Fri, 17 Jul 2026 15:47:09 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7547A30040BF;
	Fri, 17 Jul 2026 15:47:06 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 02/17] tools/rv: Fix exit status when monitor execution fails
Date: Fri, 17 Jul 2026 17:46:23 +0200
Message-ID: <20260717154638.220789-3-gmonaco@redhat.com>
In-Reply-To: <20260717154638.220789-1-gmonaco@redhat.com>
References: <20260717154638.220789-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: mbXHCFprOilvE1bZN4gUGrcOjFUS54WSgGaD6jmuL9w_1784303229
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When running "rv mon" on a monitor that is already enabled, the tool
fails to start but incorrectly exits with a success status (0).

Fix the exit condition to ensure it returns a failure code on any
execution error. Also use the standard EXIT_SUCCESS/EXIT_FAILURE macros
throughout the file.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/rv.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index b8fe24a87d97..09e0d8598619 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
@@ -50,23 +50,23 @@ static void rv_list(int argc, char **argv)
 		"	[container]: list only monitors in this container",
 		NULL,
 	};
-	int i, print_help = 0, retval = 0;
+	int i, print_help = 0, retval = EXIT_SUCCESS;
 	char *container = NULL;
 
 	if (argc == 2) {
 		if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")) {
 			print_help = 1;
-			retval = 0;
+			retval = EXIT_SUCCESS;
 		} else if (argv[1][0] == '-') {
 			/* assume invalid option */
 			print_help = 1;
-			retval = 1;
+			retval = EXIT_FAILURE;
 		} else
 			container = argv[1];
 	} else if (argc > 2) {
 		/* more than 2 is always usage */
 		print_help = 1;
-		retval = 1;
+		retval = EXIT_FAILURE;
 	}
 	if (print_help) {
 		fprintf(stderr, "rv version %s\n", VERSION);
@@ -77,7 +77,7 @@ static void rv_list(int argc, char **argv)
 
 	ikm_list_monitors(container);
 
-	exit(0);
+	exit(EXIT_SUCCESS);
 }
 
 /*
@@ -108,14 +108,14 @@ static void rv_mon(int argc, char **argv)
 
 		for (i = 0; usage[i]; i++)
 			fprintf(stderr, "%s\n", usage[i]);
-		exit(1);
+		exit(EXIT_FAILURE);
 	} else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")) {
 
 		fprintf(stderr, "rv version %s\n", VERSION);
 
 		for (i = 0; usage[i]; i++)
 			fprintf(stderr, "%s\n", usage[i]);
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	monitor_name = argv[1];
@@ -127,7 +127,7 @@ static void rv_mon(int argc, char **argv)
 
 	if (!run)
 		err_msg("rv: monitor %s does not exist\n", monitor_name);
-	exit(!run);
+	exit(run > 0 ? EXIT_SUCCESS : EXIT_FAILURE);
 }
 
 static void usage(int exit_val, const char *fmt, ...)
@@ -174,13 +174,13 @@ static void usage(int exit_val, const char *fmt, ...)
 int main(int argc, char **argv)
 {
 	if (geteuid())
-		usage(1, "%s needs root permission", argv[0]);
+		usage(EXIT_FAILURE, "%s needs root permission", argv[0]);
 
 	if (argc <= 1)
-		usage(1, "%s requires a command", argv[0]);
+		usage(EXIT_FAILURE, "%s requires a command", argv[0]);
 
 	if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
-		usage(0, "help");
+		usage(EXIT_SUCCESS, "help");
 
 	if (!strcmp(argv[1], "list"))
 		rv_list(--argc, &argv[1]);
@@ -197,5 +197,5 @@ int main(int argc, char **argv)
 	}
 
 	/* invalid sub-command */
-	usage(1, "%s does not know the %s command, old version?", argv[0], argv[1]);
+	usage(EXIT_FAILURE, "%s does not know the %s command, old version?", argv[0], argv[1]);
 }
-- 
2.55.0

