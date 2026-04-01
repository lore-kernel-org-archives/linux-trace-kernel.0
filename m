Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881573F7867;
	Wed,  1 Apr 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042559; cv=none; b=evD6OsjpBsq1Zbd6kyFAeERHwjFP9bi5zaTVO3i0cw3QGICIn33+WtSL1UPV14cWgEeezuGIwTf9ZuGN+sVr2obKY7DZTHXxV50HhqiwnZ2gfQP6EJOK0/7+3cNA1VMKeEpaYJfmNnlyDbG86KBXofbHRavQsBJQN5AkfPP/z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042559; c=relaxed/simple;
	bh=Bx+tCa9Cg0O972ijwfPaasWig6LowsOhqwwdri2zYUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mT8rBsZe2QKyluXh0cAOJDx0ObF2UskLpR0JtasYoJnkg1TabiD2iWiRKWWKCdmjMrVNS9Efq7HWVcfri8uMLmocDuFwofFglTe1QNHnn64wnfc/0UOsnQF+nyrHrqNwTybpNBryib8AO7m2MXewqZNuw90uv+xi4y90E3WDdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAA34m3y_8xpatzbCw--.6665S3;
	Wed, 01 Apr 2026 19:22:28 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH v2 2/2] tracing/hist: reject synthetic-field strings that exceed MAX_FILTER_STR_VAL
Date: Wed,  1 Apr 2026 19:22:24 +0800
Message-ID: <20260401112224.85582-2-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA34m3y_8xpatzbCw--.6665S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWDJFW7AF1DAr4UAry3twb_yoWrurWxpr
	WYv3s8G3yUJr1Igr43C3WUCFyrCw4kuw1DG3Wa9ws5tr1Yyrs7KrWjkry8Xas5tryjvwsI
	gF4DXr98CwsruFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUemhwUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The synthetic field helpers build a prefixed synthetic field name and a
hist trigger command in fixed MAX_FILTER_STR_VAL staging buffers. Even
when each individual field or filter string stays within that limit, the
combined "keys=...:synthetic_...=... if ..." command can exceed 256
bytes and overrun the scratch buffer.

Keep MAX_FILTER_STR_VAL as the tracing-side limit and reject synthetic
field names or generated commands that do not fit in that bound before
formatting them into the fixed buffers.

Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260329030950.32503-1-pengpeng@iscas.ac.cn/

- keep MAX_FILTER_STR_VAL as the fixed tracing-side limit
- reject overlong synthetic names and generated commands with -E2BIG
- drop the previous dynamic-allocation approach

 kernel/trace/trace_events_hist.c | 57 +++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f9c8a4f078ea..4172c91605af 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2966,12 +2966,16 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
 	struct hist_field *event_var;
 	char *synthetic_name;
 
+	if ((sizeof("synthetic_") - 1) + strlen(field_name) >=
+	    MAX_FILTER_STR_VAL)
+		return ERR_PTR(-E2BIG);
+
 	synthetic_name = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!synthetic_name)
 		return ERR_PTR(-ENOMEM);
 
-	strcpy(synthetic_name, "synthetic_");
-	strcat(synthetic_name, field_name);
+	scnprintf(synthetic_name, MAX_FILTER_STR_VAL, "synthetic_%s",
+		  field_name);
 
 	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
 
@@ -3018,6 +3022,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	struct hist_field *event_var;
 	char *saved_filter;
 	char *cmd;
+	size_t cmdlen;
+	size_t off;
 	int ret;
 
 	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
@@ -3048,13 +3054,36 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	/* See if a synthetic field variable has already been created */
 	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
 					     event_name, field_name);
-	if (!IS_ERR_OR_NULL(event_var))
+	if (IS_ERR(event_var))
+		return event_var;
+	if (event_var)
 		return event_var;
 
 	var_hist = kzalloc_obj(*var_hist);
 	if (!var_hist)
 		return ERR_PTR(-ENOMEM);
 
+	saved_filter = find_trigger_filter(hist_data, file);
+
+	cmdlen = strlen("keys=") + strlen(":synthetic_") +
+		 strlen(field_name) + strlen("=") + strlen(field_name);
+	first = true;
+	for_each_hist_key_field(i, hist_data) {
+		key_field = hist_data->fields[i];
+		if (!first)
+			cmdlen++;
+		cmdlen += strlen(key_field->field->name);
+		first = false;
+	}
+
+	if (saved_filter)
+		cmdlen += strlen(" if ") + strlen(saved_filter);
+
+	if (cmdlen >= MAX_FILTER_STR_VAL) {
+		kfree(var_hist);
+		return ERR_PTR(-E2BIG);
+	}
+
 	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!cmd) {
 		kfree(var_hist);
@@ -3062,28 +3091,24 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	}
 
 	/* Use the same keys as the compatible histogram */
-	strcat(cmd, "keys=");
+	off = scnprintf(cmd, MAX_FILTER_STR_VAL, "keys=");
+	first = true;
 
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
-		if (!first)
-			strcat(cmd, ",");
-		strcat(cmd, key_field->field->name);
+		off += scnprintf(cmd + off, MAX_FILTER_STR_VAL - off, "%s%s",
+				 first ? "" : ",", key_field->field->name);
 		first = false;
 	}
 
 	/* Create the synthetic field variable specification */
-	strcat(cmd, ":synthetic_");
-	strcat(cmd, field_name);
-	strcat(cmd, "=");
-	strcat(cmd, field_name);
+	off += scnprintf(cmd + off, MAX_FILTER_STR_VAL - off,
+			 ":synthetic_%s=%s", field_name, field_name);
 
 	/* Use the same filter as the compatible histogram */
-	saved_filter = find_trigger_filter(hist_data, file);
-	if (saved_filter) {
-		strcat(cmd, " if ");
-		strcat(cmd, saved_filter);
-	}
+	if (saved_filter)
+		scnprintf(cmd + off, MAX_FILTER_STR_VAL - off, " if %s",
+			  saved_filter);
 
 	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
 	if (!var_hist->cmd) {
-- 
2.50.1 (Apple Git-155)

