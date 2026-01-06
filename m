Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25163346E53
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707117; cv=none; b=P0sIIdQ0JR68vW8JENzuO3HDxszqHVVe4ZR88fjDVd6QbIWEdNH3+K63U+8j0f0j8diBEe2WzxJ/48IXm/0vQef+jfVZX6njhrJdpnSyMF0fPrHZgbgOQcFJdv+uM5/+hd/jsN5X+dcri6ckEzFEGjgoW6QIkd6UtBhM30s0CjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707117; c=relaxed/simple;
	bh=s2TZMSh4wNlugwQUb/grB4j80JCmYqggHPpNTuBQUks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tn6Kqr9moONJBCPY4c70vyOtrNRE0LJbjqe4kiWaDyQhn1I0mtOjP0/D8c1BcrDvBlQX8+LLS4V+/IDwZz1bpvdi4OmscoDEfSCW1toP3qkvwU/uP8Q5y2N3P3fuh5emw6nxQDZNa7cEmx+bhXheCOGFsSSUpVVFfG+eM/65Hqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNWjIvkL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNWjIvkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767707115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BanPd8d6y/CBsOyxFKDYt9T0QkVzk6reOpvMykHk2A=;
	b=TNWjIvkL8CPM2odosegIDhePWS/xgHVBXzM/Js3BiIR25sG1j3xoszU3onNOSy8EZprlpk
	tUBJC+Nn9sifSiQ/gEma3/Sv5UZPrEhkmtSBUEQ3QSQqSqqco4o+Tv5OJUUHiNIgB2/W+F
	wqTaf9G0AEaAdEhZGjZZDXNYR4scp8I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-2v_Wx45JO3eXZdm8xw726A-1; Tue,
 06 Jan 2026 08:45:14 -0500
X-MC-Unique: 2v_Wx45JO3eXZdm8xw726A-1
X-Mimecast-MFC-AGG-ID: 2v_Wx45JO3eXZdm8xw726A_1767707112
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94D9195DE56;
	Tue,  6 Jan 2026 13:45:12 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.89.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E27D1800367;
	Tue,  6 Jan 2026 13:45:08 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v2 12/18] rtla: Fix NULL pointer dereference in actions_parse
Date: Tue,  6 Jan 2026 08:49:48 -0300
Message-ID: <20260106133655.249887-13-wander@redhat.com>
In-Reply-To: <20260106133655.249887-1-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The actions_parse() function uses strtok() to tokenize the trigger
string, but does not check if the returned token is NULL before
passing it to strcmp(). If the trigger parameter is an empty string
or contains only delimiter characters, strtok() returns NULL, causing
strcmp() to dereference a NULL pointer and crash the program.

This issue can be triggered by malformed user input or edge cases in
trigger string parsing. Add a NULL check immediately after the strtok()
call to validate that a token was successfully extracted before using
it. If no token is found, the function now returns -1 to indicate a
parsing error.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/actions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 00bbc94dec1bd..b0d68b5de08db 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -153,6 +153,8 @@ actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 
 	strcpy(trigger_c, trigger);
 	token = strtok(trigger_c, ",");
+	if (!token)
+		return -1;
 
 	if (strcmp(token, "trace") == 0)
 		type = ACTION_TRACE_OUTPUT;
-- 
2.52.0

