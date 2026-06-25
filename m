Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5A3E025E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389700; cv=none; b=fW+eVr+rpODazRouHzXfeNE/d36sSPo1Lr1iY6WY6stbSxkBQwDQsT9PMyseCymTeoE5Cig/fuwJswhgF1uCNvFy43D4mvv/aZaLfri1xDnDKZNPFRD4oBOvpGi3UGrTsIG7U9nvyCZ0xRqAkJteveQB5UYfYeiAC1qnOjirvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389700; c=relaxed/simple;
	bh=7s+OKRCK0QBe4L0qHTeNKZrGnGLtIrICnQ+wpLeebPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SpKMs1fQ54wIlgAlBEUHVAgWcoyrP6V+uagRm4zTj2zOoFev3clFXxPP4J7U5l+FPRTdzY8QJrdv9DdiKQ38CX/0VS+I9MrvE8u+gwfqPyW4VEWA6j2/h74vk9wz6+lE7JCug0TSlp6oJQcJ7GO3tFGyQymw55FipB5STVeVIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctalD+d+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctalD+d+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UW0NuecwDPJhAJyeyG4htblBd+CPduoP/0I5PEKSGOY=;
	b=ctalD+d+xeLkFymolCETJb3DOwTfl7rR8O74GfqaqwrBW5MCi2hUCdEnh2orxVr8HtBxaT
	haEySWse57Z2nONY2GADy4N9RdVKWRClqmG80omgtdkmXPo25V92G85HuSHRfFaZZH6Rat
	uXQXnNTHa6GAN3OFDi4fNpqmGYMIMx0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-Ry6_na6FPvWj5K0UrV_Rug-1; Thu,
 25 Jun 2026 08:14:54 -0400
X-MC-Unique: Ry6_na6FPvWj5K0UrV_Rug-1
X-Mimecast-MFC-AGG-ID: Ry6_na6FPvWj5K0UrV_Rug_1782389693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 661B2187BE07;
	Thu, 25 Jun 2026 12:14:53 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE34B30003B6;
	Thu, 25 Jun 2026 12:14:50 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 02/17] tools/rv: Fix exit status when monitor execution fails
Date: Thu, 25 Jun 2026 14:14:24 +0200
Message-ID: <20260625121440.116317-3-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: FLnehavCzU-cpjKlAwpMj9D9gXGtXbfp0g8JEFRX2Xw_1782389693
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
 tools/verification/rv/src/rv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
index b8fe24a87d..cd9100f91c 100644
--- a/tools/verification/rv/src/rv.c
+++ b/tools/verification/rv/src/rv.c
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
2.54.0

