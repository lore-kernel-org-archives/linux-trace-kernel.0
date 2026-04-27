Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D1329C48
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302719; cv=none; b=BtuQvFqUukHSoXWySGqVbM7i2q7PmLTGdHbD0KCkVFyzsDulazvaNj9iBC2juRhrq0sRAULEEE25tQbjpXKfaMRvI9h1NM/gSpgMfSs8vvhgcwArRkc7W/oH7HLoho8YZ/eh+0CD/g0Ehi2hOo8TPeAzfp1UKk8HMqyvuL+ek1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302719; c=relaxed/simple;
	bh=6vx7EVUEeXu+w4Q4EMKcVbjcZH3hUDGdi+p13lmJFzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rxMrVFDuwHvctk+wvhB5TeS67fUOkXPJYBAi3dLkGIE47f1sopQdIRHVD1G4QCinBkzkjCk1Utojmo6jgvucX9UgKL9s3bm5yNswxXe8jbwsGvRJ3+jsZWpMy86OmQQuvYrBrz/TxH3VfD0LTIT2hsfeZgU62YUUIogOVKTvZis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAm5qBAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAm5qBAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777302716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d8rayQv9Te5MjRAGc+HYTqoPOPUAIqg0Cp2spaG8Zw=;
	b=XAm5qBAxrCWycoT6b608MZ7gvxxscbGZObPATdMsVxFk2yVpQcN5p47apCaYn7NlrsjdI8
	qDxEEgibLLBO3bSjOmNJiu0cmGxQq4ylzZJvdq8lfLWXn2l+R+dsoED4AjOW/YdMxXTKUK
	9ot+VtrIY98ijK0O6jMhaqf0Eyfpwv0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-2YCjGELPOl6Nysi9yQ852g-1; Mon,
 27 Apr 2026 11:11:55 -0400
X-MC-Unique: 2YCjGELPOl6Nysi9yQ852g-1
X-Mimecast-MFC-AGG-ID: 2YCjGELPOl6Nysi9yQ852g_1777302714
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 393DE19560B8;
	Mon, 27 Apr 2026 15:11:54 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CD56195608E;
	Mon, 27 Apr 2026 15:11:50 +0000 (UTC)
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
Subject: [RFC PATCH 01/12] tools/rv: Fix substring match bug in monitor name search
Date: Mon, 27 Apr 2026 17:11:23 +0200
Message-ID: <20260427151134.192971-2-gmonaco@redhat.com>
In-Reply-To: <20260427151134.192971-1-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: nV47acFdifShISRgkoQ5-lRZbhjygojOnNzF662KhsM_1777302714
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
2.53.0

