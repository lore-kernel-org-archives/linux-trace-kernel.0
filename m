Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA1256C84;
	Sun, 29 Mar 2026 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774753801; cv=none; b=j3T5vJR1k2JOROhQz8Ry1jcyDWeOXJ+tQXLvNiBic5ToeMEZPjKOST4KANz6AA8MK6KT+TAsjEiTlQ5kQv0Ynk3XpneiY75bzfdoz8Ruw+sWK1pqGwDlaT+iSC71rWsz7cl90wpwjLCMNcM7wbA3Cj1Blmx34Je/o3a+j/8S94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774753801; c=relaxed/simple;
	bh=kpBdTQ05NqadcVx9Xslb0AF8NWXyG19mgWmBT3EW/Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bmvKAUiCcjC2W3pEbH9Kl7yWU5oCRtCeLOZH4GZJU4N3C/q6Ipmr1CuL36Q5wD44xHl7aar2sxIDMfpb/M4e8ENxzpCXo28jzFw3dTTmH3SjwPyojVU60fqyzg2in7Buu+C7liPtTjPbw6M38DY5VUwvOOGO/C2yqU1ydQcCqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowADnjGj+l8hpxOd8Cw--.807S3;
	Sun, 29 Mar 2026 11:09:51 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH 2/2] tracing/hist: allocate synthetic-field command buffers to fit
Date: Sun, 29 Mar 2026 11:09:50 +0800
Message-ID: <20260329030950.32503-2-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnjGj+l8hpxOd8Cw--.807S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWDZF18Wr1xJr1xJFyDtrb_yoW5KF17pr
	WFywn8Ga1DJr4Igr43CF4UCryrCw4kuw1qg3Wa9wn5tr1Yyrs2krWqkry0gas5trWjvwsI
	gF1qgr98Cws7WFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r
	1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWx
	JVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8v38UUUU
	U
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The synthetic field helpers currently build temporary names and trigger
commands in fixed MAX_FILTER_STR_VAL buffers with strcpy() and strcat().
Long field names, key lists, or saved filters can therefore overrun
those staging buffers while constructing the synthetic histogram
command.

Allocate the synthetic name and command buffers to the exact size
required by the current histogram instead of relying on fixed-size
scratch storage.

Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 kernel/trace/trace_events_hist.c | 46 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 4a27da628a71..1883bd6d9b95 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2964,13 +2964,10 @@ find_synthetic_field_var(struct hist_trigger_data *target_hist_data,
 	struct hist_field *event_var;
 	char *synthetic_name;
 
-	synthetic_name = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	synthetic_name = kasprintf(GFP_KERNEL, "synthetic_%s", field_name);
 	if (!synthetic_name)
 		return ERR_PTR(-ENOMEM);
 
-	strcpy(synthetic_name, "synthetic_");
-	strcat(synthetic_name, field_name);
-
 	event_var = find_event_var(target_hist_data, system, event_name, synthetic_name);
 
 	kfree(synthetic_name);
@@ -3016,6 +3013,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	struct hist_field *event_var;
 	char *saved_filter;
 	char *cmd;
+	size_t cmdlen;
+	size_t off;
 	int ret;
 
 	if (target_hist_data->n_field_var_hists >= SYNTH_FIELDS_MAX) {
@@ -3053,35 +3052,46 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 	if (!var_hist)
 		return ERR_PTR(-ENOMEM);
 
-	cmd = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
+	saved_filter = find_trigger_filter(hist_data, file);
+
+	cmdlen = strlen("keys=") + strlen(":synthetic_") +
+		 strlen(field_name) + strlen("=") + strlen(field_name) + 1;
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
+	cmd = kzalloc(cmdlen, GFP_KERNEL);
 	if (!cmd) {
 		kfree(var_hist);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	/* Use the same keys as the compatible histogram */
-	strcat(cmd, "keys=");
+	off = scnprintf(cmd, cmdlen, "keys=");
+	first = true;
 
 	for_each_hist_key_field(i, hist_data) {
 		key_field = hist_data->fields[i];
-		if (!first)
-			strcat(cmd, ",");
-		strcat(cmd, key_field->field->name);
+		off += scnprintf(cmd + off, cmdlen - off, "%s%s",
+				 first ? "" : ",", key_field->field->name);
 		first = false;
 	}
 
 	/* Create the synthetic field variable specification */
-	strcat(cmd, ":synthetic_");
-	strcat(cmd, field_name);
-	strcat(cmd, "=");
-	strcat(cmd, field_name);
+	off += scnprintf(cmd + off, cmdlen - off, ":synthetic_%s=%s",
+			 field_name, field_name);
 
 	/* Use the same filter as the compatible histogram */
-	saved_filter = find_trigger_filter(hist_data, file);
-	if (saved_filter) {
-		strcat(cmd, " if ");
-		strcat(cmd, saved_filter);
-	}
+	if (saved_filter)
+		scnprintf(cmd + off, cmdlen - off, " if %s", saved_filter);
 
 	var_hist->cmd = kstrdup(cmd, GFP_KERNEL);
 	if (!var_hist->cmd) {
-- 
2.50.1 (Apple Git-155)

