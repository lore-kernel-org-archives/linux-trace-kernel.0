Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15835B631;
	Thu,  9 Apr 2026 02:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702039; cv=none; b=KA5CC8ttwRQtCRc2N52RSQ5U3NfEl9WxlPuORhXNZJ0YJPLcKHiTzQS4DJBNN2Myg1E1uHikEWhDvG3oMfLhGsBqxP3JUj0mFIOkx5Vfn9epmyTMrp4BD87KuUAH3fASuOzxQFhAk3lscSe1NWVKzxGuiFoSAxFUmH8+UA2bOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702039; c=relaxed/simple;
	bh=epsiyXiccB7VM7RTtd97wRFP0aA36T0y5ASy8AxTFp0=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=kiRBDewSLcFHEDH0Kx8V9Z/aGi+H+PSP/n2gNtRzxcDJ802V9dH+IjRUTYSQDPTvVfSTwOo6dBqXvcvAZWRdTcR1bz4B421zTvnCPdmjRxU441+Y4E1QG89taScGUDYVtsA+5rS1u28JL6PVc7ZzbBAotu466s6JzRja+YbFFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-tracing-hist-synth-v3.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowABXdt0LENdpmn5wDQ--.52706S2;
	Thu, 09 Apr 2026 10:33:47 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Thu, 9 Apr 2026 10:19:43 +0800
Message-ID: <20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260401112224.85582-2-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-2-pengpeng@iscas.ac.cn> <20260401112224.85582-2-pengpeng@iscas.ac.cn>
Subject: [PATCH v3] tracing/hist: bound synthetic-field strings with seq_buf
X-CM-TRANSID:rQCowABXdt0LENdpmn5wDQ--.52706S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UJryxArWUXFW8tr4DXFb_yoWrZr1DpF
	W5Awn8K3y5Jr12gr4fCF4qkr95Aw4kuw1DKF1akws5try5tr4v9FWq9ry5WasYqrWI9w13
	WF4DWrZ8Cws8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

The synthetic field helpers build a prefixed synthetic variable name and
a generated hist command in fixed MAX_FILTER_STR_VAL buffers. The
current code appends those strings with raw strcat(), so long key lists,
field names, or saved filters can run past the end of the staging
buffers.

Build both strings with seq_buf and propagate -E2BIG if either the
synthetic variable name or the generated command exceeds
MAX_FILTER_STR_VAL. This keeps the existing tracing-side limit while
using the helper intended for bounded command construction.

Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2: https://lore.kernel.org/all/20260401112224.85582-2-pengpeng@iscas.ac.cn/

- switch the synthetic name and generated command construction to seq_buf
  as suggested by Steven Rostedt
- keep MAX_FILTER_STR_VAL as the tracing-side limit and return -E2BIG on
  overflow

 kernel/trace/trace_events_hist.c | 44 ++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad55..7c3873719beb 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/security.h>
+#include <linux/seq_buf.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
@@ -2962,14 +2963,21 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
 			 char *system, char *event_name, char *field_name)
 {
 	struct hist_field *event_var;
+	struct seq_buf s;
 	char *synthetic_name;
 
 	synthetic_name = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!synthetic_name)
 		return ERR_PTR(-ENOMEM);
 
-	strcpy(synthetic_name, "synthetic_");
-	strcat(synthetic_name, field_name);
+	seq_buf_init(&s, synthetic_name, MAX_FILTER_STR_VAL);
+	seq_buf_puts(&s, "synthetic_");
+	seq_buf_puts(&s, field_name);
+	seq_buf_str(&s);
+	if (seq_buf_has_overflowed(&s)) {
+		kfree(synthetic_name);
+		return ERR_PTR(-E2BIG);
+	}
 
 	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
 
@@ -3014,6 +3022,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	struct trace_event_file *file;
 	struct hist_field *key_field;
 	struct hist_field *event_var;
+	struct seq_buf s;
 	char *saved_filter;
 	char *cmd;
 	int ret;
@@ -3046,41 +3055,48 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
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
 	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!cmd) {
 		kfree(var_hist);
 		return ERR_PTR(-ENOMEM);
 	}
 
+	seq_buf_init(&s, cmd, MAX_FILTER_STR_VAL);
+
 	/* Use the same keys as the compatible histogram */
-	strcat(cmd, "keys=");
+	seq_buf_puts(&s, "keys=");
 
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
 		if (!first)
-			strcat(cmd, ",");
-		strcat(cmd, key_field->field->name);
+			seq_buf_putc(&s, ',');
+		seq_buf_puts(&s, key_field->field->name);
 		first = false;
 	}
 
 	/* Create the synthetic field variable specification */
-	strcat(cmd, ":synthetic_");
-	strcat(cmd, field_name);
-	strcat(cmd, "=");
-	strcat(cmd, field_name);
+	seq_buf_printf(&s, ":synthetic_%s=%s", field_name, field_name);
 
 	/* Use the same filter as the compatible histogram */
-	saved_filter = find_trigger_filter(hist_data, file);
-	if (saved_filter) {
-		strcat(cmd, " if ");
-		strcat(cmd, saved_filter);
+	if (saved_filter)
+		seq_buf_printf(&s, " if %s", saved_filter);
+
+	seq_buf_str(&s);
+	if (seq_buf_has_overflowed(&s)) {
+		kfree(cmd);
+		kfree(var_hist);
+		return ERR_PTR(-E2BIG);
 	}
 
 	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
-- 
2.50.1 (Apple Git-155)

