Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D483364059;
	Fri, 17 Apr 2026 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403589; cv=none; b=gmYgI+j1GdE9ZvKaz21KD4gNUTuTG8zdVPFVLkBlqnp4ifUdZOyMbi+6yNX9eUX24Hkj4L9vXtN8lZS8XF00ugcVJkPovKD4gOUJxbf9O8ZoRnLp6CzvgTF6taH2nOG6lU+Gd/kTwrX1KrAue48v+mAJkqXxK9iT16YNXmxu15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403589; c=relaxed/simple;
	bh=Pm6fCsx2Bl8OvsxUOjNM7+W58rzW4wfQK0UHa9Wkx1w=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=jODmpROTnoe2uemVjhjr2beV8kFBS1UPqMwAuw2nj/VmglcWQHAlxQlD00T+QTZBWFfAaLkV2Ip4GKxObH+/VNgnuGcc58KJzGveuS4Miljic28A0C+C7wKQRsAqYPL/RaRExvajzm9iKQGR8pM0aoyA+k/mtPio+cBxXxbCf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-tracing-synth-v4.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowABHaeB6xOFp6DdZDg--.34069S2;
	Fri, 17 Apr 2026 13:26:18 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 17 Apr 2026 20:20:00 +0800
Message-ID: <20260417223001.1-tracing-synth-v4-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
References: <20260329030950.32503-2-pengpeng@iscas.ac.cn> <20260401112224.85582-2-pengpeng@iscas.ac.cn> <20260409103001.1-tracing-hist-synth-v3-pengpeng@iscas.ac.cn>
Subject: [PATCH v4] tracing: Bound synthetic-field strings with seq_buf
X-CM-TRANSID:rQCowABHaeB6xOFp6DdZDg--.34069S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UJryxArWUXFW8tr4DXFb_yoWrGw1kpF
	W5Aws8K3y5Jr42gr4fCF4qkr95Jw4kuw1DKFsIkws5tr13tr4v93yq9ryUWasYqrWI9wsx
	WF4DWrZ8Cw4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pR6yxiUUUUU=
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
Changes since v3:
- add the requested comment before seq_buf_str()
- keep the saved_filter lookup next to its use
- drop the unrelated event_var simplification from the previous respin

 kernel/trace/trace_events_hist.c | 44 ++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad55..99da91461abc 100644
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
@@ -2962,14 +2963,22 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
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
+	/* Terminate synthetic_name with a NUL. */
+	seq_buf_str(&s);
+	if (seq_buf_has_overflowed(&s)) {
+		kfree(synthetic_name);
+		return ERR_PTR(-E2BIG);
+	}
 
 	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
 
@@ -3014,7 +3023,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	struct trace_event_file *file;
 	struct hist_field *key_field;
 	struct hist_field *event_var;
-	char *saved_filter;
+	struct seq_buf s;
 	char *cmd;
 	int ret;
 
@@ -3059,28 +3068,35 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
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
+	{
+		char *saved_filter = find_trigger_filter(hist_data, file);
+
+		if (saved_filter)
+			seq_buf_printf(&s, " if %s", saved_filter);
+	}
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

