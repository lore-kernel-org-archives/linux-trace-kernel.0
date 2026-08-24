Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6F3AFB0E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567357; cv=none; b=M4UX9p0wyiRt+CL6tzGfcoum5sOnmOSnEPq8WKMvn5s3CKhvYytyLH/uW/23xYz2e093KN2UM7ppb9x0pqZbREyiYnVAYFf5eZH2s+2aSU7NTT88xxSlUM0hvEZ8pVCDoY67oIXmmKB1oxYNJG+SHtBFPs4qJueuohhWW2/kCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567357; c=relaxed/simple;
	bh=SMp0BYiGxQrk8xhB9F+B5Fv4uJjjSg1RFFD3BO6xRHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiVT2QzEumcZhx1sxLt1Bctrxfsl2vWyThT58j5YXviFwf5PIkt3zyHbv5YuloeofZwd/UHrWsc+QiEUo2Fw+mmNOtDEiHg9EaUrMqhouC7iTUhXlVTMqod0gmTxhTt0K3Qu9o27tCSK5yiiMaobgvVllxyyjq+qh+Mq9hw1U6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRLuBOzj; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRLuBOzj"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451e1066971so1382634fac.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787567355; x=1788172155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZgNVvVnK6qtTAurSHfCAYIGP8l/75f7zp4ee8TcekQQ=;
        b=cRLuBOzjC+tpBkY6XdL/V5eR0DotXeuU5/9P52SEFcLN9+jeIjQeYHWNrAQ5CzR1GO
         DVYP3hcscdSo1O75hu5jkaUagqX+23OSVo+6AtQezPjuXlV4LP8xsAJ6y/Y80ugUTcBD
         U/84raiwiw2S5DV/wHndSh4gVWKxpvUJKNJ3S0u8lUyTwlEKOpIgy9ii/2KsbyPbAAn2
         FtANUsgRGiXRpAlahAS7P9XZm7gov1XPpyxDm5H9HPVT/dDY61pbgoB/RpLDSzpNDXBu
         graL2tf1jiKLPRJ60m+EvuJBQ2dR9eN72mfFF0ENi1b6n2RDeRE0iXrjN2Zn/CRXOQAI
         BavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787567355; x=1788172155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZgNVvVnK6qtTAurSHfCAYIGP8l/75f7zp4ee8TcekQQ=;
        b=B+cGkaoG0Mal57jPqiT+NAOCgjRxbic1XhhngRyfm15467jmq/ii0Q4I+RArSTNO1k
         32V1eGcNQyObAVKrZWi6seGbVjGNgVCHbYHE0OjXlVua5xodt3bEujN9mu8L1D4Rwv5c
         PqEIANR7OAdZ3Ysp7JiP28GtTc1MHNLTh1gSCuFP1r0+AXqKqqGmSSyNP1hSmUFs6EHF
         pwwLBC1Va9VGJSzzJLKmjPjkMEyTw73cnVOvsYrwcwrz3uBr1Qoo0r5bmbkf3cS2I8nh
         MnOxj1Fm3ig7RSbS8dZ8D5R2BMiG5rS32ODUk1zZEOcsN8BzlnS4yyRv9Evt3m09nMBA
         nwCg==
X-Forwarded-Encrypted: i=1; AHgh+Rrl568/lzvDbQFwuaw3xFFI9HayhhMBxhvQYgzOEI7Mw719oP2alIrDLWRIfIREy5qjkJBrgK9u5mH41iNgpNrxv+U=@vger.kernel.org
X-Gm-Message-State: AFuF++lsvbLFjrzI5bXm+MfmTg5YFlZ+JsuUq16wH+zMoOIvo9asCn71
	2YroZEnE5GNj9zNAFCj0s14bNJDCXJdZk8tFFGi2XQq/FL+b/9pO6DFP
X-Gm-Gg: AR+sD10mEHXc3+bj/RlIRmMYm/FjXLZmVWz8P4UrbdzJrKgueidMxFrjelRz30EDC8T
	Ti8DMv3GR3X+Act0Zkh8C0bnUxdQ8FMz5gdtttKNiGYNkW/DpvyR1KyqZSXXmA3PjxRSroBAUVE
	+nBgGoMBGmTQCQA1Ll6D/YuhxUhhOgsReHZP597AJxvaDjm3LwVWDC/iCusmOAWXa6bbjH7S82L
	d9pS7brFfhZ1lJj16DHASsc0LxWWrExI2wH4b822a9++AB1quMCJDi6Q7zowt8oQonvz1N5tv8V
	DJpuP5mfLdzL2CnHK2dreVYNptzU2bqq5fYB4yYDogDuMi+6XSDP6dEBAR0IUoru+pKJO66yY1d
	75EiqlRItEgfMhUwKYU7F71t0fBmRBEydB3RUA3YlYaJZrt3+fY+DavtESQUAgrM5c2mfwcoLQz
	aOmyqzuqK6GY4tqzTsmZSpvXRIz+gLMOM9/mVddzikoyQD9WJEdFSz0feurobJo/FkSHtIl43mQ
	kC06SzHFQU7fabQmxY91yGttA==
X-Received: by 2002:a05:6820:615:b0:6a1:80a7:2c8d with SMTP id 006d021491bc7-6b15944db93mr23802831eaf.32.1787567354991;
        Mon, 24 Aug 2026 03:29:14 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b17cc2c0dbsm3363378eaf.12.2026.08.24.03.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:29:13 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] tracing/user_events: Don't destroy fields when event removal fails
Date: Mon, 24 Aug 2026 18:29:07 +0800
Message-ID: <20260824102907.4173063-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

destroy_user_event() destroys the event's fields before attempting to
remove the trace event call. If user_event_set_call_visible() fails,
e.g. because the event is still enabled and trace_remove_event_call()
returns -EBUSY, the event is left registered with an irreversibly
destroyed field list. Any subsequent interaction with the event then
operates on an empty field list while it is still fully visible in
tracefs.

Move the field destruction after the call removal, and splice the
field list back onto the event when the removal fails so the event
remains in a consistent state.

Fixes: 7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 kernel/trace/trace_events_user.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 8c82ecb735f41..0b021c212995a 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1119,10 +1119,9 @@ static void user_event_destroy_validators(struct user_event *user)
 	}
 }
 
-static void user_event_destroy_fields(struct user_event *user)
+static void user_event_destroy_fields(struct list_head *head)
 {
 	struct ftrace_event_field *field, *next;
-	struct list_head *head = &user->fields;
 
 	list_for_each_entry_safe(field, next, head, link) {
 		list_del(&field->link);
@@ -1499,17 +1498,21 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 
 static int destroy_user_event(struct user_event *user)
 {
+	LIST_HEAD(fields);
 	int ret = 0;
 
 	lockdep_assert_held(&event_mutex);
 
-	/* Must destroy fields before call removal */
-	user_event_destroy_fields(user);
+	list_splice_init(&user->fields, &fields);
 
 	ret = user_event_set_call_visible(user, false);
 
-	if (ret)
+	if (ret) {
+		list_splice(&fields, &user->fields);
 		return ret;
+	}
+
+	user_event_destroy_fields(&fields);
 
 	dyn_event_remove(&user->devent);
 	hash_del(&user->node);
@@ -2209,7 +2212,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 put_user_lock:
 	mutex_unlock(&event_mutex);
 put_user:
-	user_event_destroy_fields(user);
+	user_event_destroy_fields(&user->fields);
 	user_event_destroy_validators(user);
 	kfree(user->call.print_fmt);
 
-- 
2.43.0
