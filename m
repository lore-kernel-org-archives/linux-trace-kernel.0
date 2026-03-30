Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37E234964;
	Mon, 30 Mar 2026 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774838790; cv=none; b=O8R1aklINb5aSPscPWq357IrYYwrZEBha9ShWjRdkr8w8J3iU/Zehs+OV54X226MBHAW0cjyp7WUT/7ZqExJvOzScg9HVFvfKyPsLqzE+TKAdfnxf99XZ9nSlFWmWm4t2HkjITmXgqp3pRspb4Fe7FWPamcHZvVA2E2BnOCm2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774838790; c=relaxed/simple;
	bh=PloNdn8K/lVcwzrd37Eq+IYlJYHBhG67XQhbIEIdyso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLd8PNvCmYr5F4duk+uFALdAzuju78vwEHG/vDbPZBqHl0gSJgDWexiiSRV4t1gd8rIfbuX1uPLGheHezbczvujl3uqKJciMNi0DWml2zzUM933bmh69e8mz7jVSdL4EUoe7s2d5Q6lkjDMjtdSV28g5pQOP115pU5j75y1NMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowABnC2f748lp9d+XCw--.12530S2;
	Mon, 30 Mar 2026 10:46:20 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH v2 2/2] tracing/hist: reject synthetic-field strings that exceed MAX_FILTER_STR_VAL
Date: Mon, 30 Mar 2026 10:46:19 +0800
Message-ID: <20260330024619.38460-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329030950.32503-2-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-2-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnC2f748lp9d+XCw--.12530S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWDJFW7AF1DAr4UAry3twb_yoWrZF48pr
	WYv3s8GayUJr4Igr43C3WUCFyrCw4kuw1DG3Wa9ws5tr1Yyrs7KrWjkry8Xas5tryjvwsI
	gF4DXr98CwsruFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUG0PhUUU
	UU=
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
v2:
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

