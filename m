Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7AC3DD52E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 14 May 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772084; cv=none; b=IGrsMbp/+CwFM/HRcSnPwnD0zqNFHFdnw+hN/Q6XdN289E37mYZcUYqExmlbqXC0DkHdGZXHnGZFypwN3bvsfHhdJR4IBn3behIA8njyObFAZaatpvCkMag38xIRiWVl8+rQhIGiq8X1kSp6Y4LsPiuZEXdqMWoeLEcwURQ6jn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772084; c=relaxed/simple;
	bh=s8nFJ+2JWsR835hCjxv/sjajTJVR5mTrLIXZa6+KMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PM+MXtr1J0+nGsV2rHZQ9sy7uo3eqA83rhBUSKuErxDCWx5aHj7R03PYBm6/hdisIx4WCVycTzOhLhc9dhI2q9oSkUxRLKdaALVDMP7Tf74IgupYNoMJYFVid2+kAvyzhBXOpqjXcGBStZ3jBqOXEM4SFhP1bhiYhD5FGd1vi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrWWtV6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrWWtV6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778772081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoIyt76b7jqnRvNU6b8a3WX34nlOmKB7uW+1jd9CVSs=;
	b=OrWWtV6j0qRDs8KSxMf7rLW73rDzHD6/diQpyAKyJQwdbWULETM/fWNZt+xjtulb2QlDzH
	7Lm102XBCelH3fAhdTgTY3aMCU/NaV61DEDNnAMCzGTWGiQ/DWReUYXicsYqC8Run5gUGS
	71HJ5U7A/G/IHAWOySfyrO/GsIpLwmc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-AyK_rq60PeS6y1Cb_swzog-1; Thu,
 14 May 2026 11:21:18 -0400
X-MC-Unique: AyK_rq60PeS6y1Cb_swzog-1
X-Mimecast-MFC-AGG-ID: AyK_rq60PeS6y1Cb_swzog_1778772077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62C431800372;
	Thu, 14 May 2026 15:21:17 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.48.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53FF230001A2;
	Thu, 14 May 2026 15:21:14 +0000 (UTC)
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
Subject: [PATCH v2 01/14] tools/rv: Fix substring match bug in monitor name search
Date: Thu, 14 May 2026 17:20:42 +0200
Message-ID: <20260514152055.229162-2-gmonaco@redhat.com>
In-Reply-To: <20260514152055.229162-1-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: l2zCts7SIVZKnrkUl9gdcdNrK1nRLruKciERSv6VV7c_1778772077
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

__ikm_find_monitor_name() relies on strstr() to find a monitor by name,
which fails if the target monitor is a substring of a previously listed
monitor.

Fix it by tokenizing the available_monitors file and matching full
tokens instead.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 48 ++++++++++++++-------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 4bb746ea6e17..a200b63f4509 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -58,38 +58,40 @@ static int __ikm_read_enable(char *monitor_name)
  */
 static int __ikm_find_monitor_name(char *monitor_name, char *out_name)
 {
-	char *available_monitors, container[MAX_DA_NAME_LEN+1], *cursor, *end;
-	int retval = 1;
+	char *available_monitors, *cursor, *line;
+	int len = strlen(monitor_name);
+	int found = 0;
 
 	available_monitors = tracefs_instance_file_read(NULL, "rv/available_monitors", NULL);
 	if (!available_monitors)
 		return -1;
 
-	cursor = strstr(available_monitors, monitor_name);
-	if (!cursor) {
-		retval = 0;
-		goto out_free;
-	}
+	config_is_container = 0;
+	cursor = available_monitors;
+	while ((line = strsep(&cursor, "\n"))) {
+		char *colon = strchr(line, ':');
 
-	for (; cursor > available_monitors; cursor--)
-		if (*(cursor-1) == '\n')
-			break;
-	end = strstr(cursor, "\n");
-	memcpy(out_name, cursor, end-cursor);
-	out_name[end-cursor] = '\0';
-
-	cursor = strstr(out_name, ":");
-	if (cursor)
-		*cursor = '/';
-	else {
-		sprintf(container, "%s:", monitor_name);
-		if (strstr(available_monitors, container))
-			config_is_container = 1;
+		if (strcmp(line, monitor_name) && (!colon || strcmp(colon + 1, monitor_name)))
+			continue;
+
+		strncpy(out_name, line, 2 * MAX_DA_NAME_LEN);
+		out_name[2 * MAX_DA_NAME_LEN - 1] = '\0';
+
+		if (colon) {
+			out_name[colon - line] = '/';
+		} else {
+			/* If there are children, they are on the next line. */
+			line = strsep(&cursor, "\n");
+			if (line && !strncmp(line, monitor_name, len) && line[len] == ':')
+				config_is_container = 1;
+		}
+
+		found = 1;
+		break;
 	}
 
-out_free:
 	free(available_monitors);
-	return retval;
+	return found;
 }
 
 /*
-- 
2.54.0

