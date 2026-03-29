Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E267B248893;
	Sun, 29 Mar 2026 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774753800; cv=none; b=sVRviW86B4P0I27AhhjXR6QtMpfyaXYk1SUy5OJVHnNG22+Evw3VuPrKgKoacIZgHSqL4BIy0mqnJW0GTrK4Yo4PQpkEJJ7LNQYlaRXbB1XIw/rqHyUXiYcZ7zVZ/1ejvznxWfAUhQ/oUdl2xg10MWfJU+QQQTya2Eoyj5SfsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774753800; c=relaxed/simple;
	bh=4VZHQ+x1hmPacZi1eRNs9UkHJYuYhEzXlBOLBeqWWNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtDtHRwKClTr7x20rZl1KLxw93F/NIIac31FBb5PC5QMXDHq6roRVzqeBw+l+GhD7HjJpasA+e/DXMCKYn92KkGlWRE6zOqhuf/WdXe80psThbnZXzCVU/6pVTiw9sLYO2JwyvGXu5I9FbMXQ8jmGgzFbetEGCx+F0b3w/XfND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowADnjGj+l8hpxOd8Cw--.807S2;
	Sun, 29 Mar 2026 11:09:50 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH 1/2] tracing/hist: bound full field-name construction
Date: Sun, 29 Mar 2026 11:09:49 +0800
Message-ID: <20260329030950.32503-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnjGj+l8hpxOd8Cw--.807S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDur47Aw1DZr4xCw15urg_yoW8XrW8pF
	ySkrnF9F1xJFWIga13Zw4DC348G3srC34DC3Wvkw1FyryFvr1DXFWDGr18Ww1aqryFq390
	qFs8Xry3GF12qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	d-PUUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

hist_field_name() builds a fully qualified synthetic field name in a
fixed MAX_FILTER_STR_VAL buffer using repeated strcat() calls. Long
system, event, and field names can therefore overflow the static staging
buffer.

Build the qualified name with snprintf() and fall back to the plain
field name if it does not fit.

Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist triggers")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 kernel/trace/trace_events_hist.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad55..4a27da628a71 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1362,12 +1362,12 @@ static const char *hist_field_name(struct hist_field *field,
 		if (field->system) {
 			static char full_name[MAX_FILTER_STR_VAL];
 
-			strcat(full_name, field->system);
-			strcat(full_name, ".");
-			strcat(full_name, field->event_name);
-			strcat(full_name, ".");
-			strcat(full_name, field->name);
-			field_name = full_name;
+			if (snprintf(full_name, sizeof(full_name), "%s.%s.%s",
+				     field->system, field->event_name,
+				     field->name) < sizeof(full_name))
+				field_name = full_name;
+			else
+				field_name = field->name;
 		} else
 			field_name = field->name;
 	} else if (field->flags & HIST_FIELD_FL_TIMESTAMP)
-- 
2.50.1 (Apple Git-155)

