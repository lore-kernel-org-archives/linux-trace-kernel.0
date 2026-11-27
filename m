Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793596;
	b=1AoPJ8Llar9ljgva2sResANq3ZWZSOvh+H052SgPFPC4OpknbKzjztx2kJe+Iw9YjRHs
	 iiBY2nogkIDJyxRdytB4ZnoU2eU5q191LbkTdE8LxG9evc7W25XXuzgAvxCdO+a15ha+1
	 EFMAhR+OorncUaoc7wWZApLrjXwp/VhHJfmqZCPz97x7ggLddW2zOFyoyMVZiTkQ9YQz6
	 3ouS++lxtiKsdlJ7UuaDE1LfZ3GAO9BMOOWn2daU6RIie7N4XkzGuqGES2VlmvKftkIdG
	 TxIg0cimihHS72nTgEAF0Gu0U+5N7mUtbVyLN2K29hZglI6lo2lw0pFshb+YNcuUFUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793596;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=b0vSNq/5tHB+9tMuM07Dq7/JDaLhsCwUzxqt3fEJRaY=;
	b=Spc4NvUKZb8QdXLHV5Np0U2wNE0LAisw9ADPS+iuV2zwPzPArEMzoqVxgvwvdNZkC+ct
	 xGIpeL575StMdLqUAeBcT3Cy4PNxUQsCcbMpDoOenQqwjLjdHX9v5TgDMYpAjR0rcstHb
	 RZxQMpPlY3AO6akij3VG7YgYjsequAd6YtQUEWChP5OECnjLumpsHEvBSKuTPWFwtmP+I
	 XENV8YscZ1YWNJy/10tp9cx0+MXxGgonUMq1WtBAbZr3JrkgVeDrcm6XckGpErgLTKixk
	 +J4EA6ALkl2Y0DmmKstjNK9TwBePcbYGy16swCWc+6Ed891VeANd+iTkW4M0Ee2IQWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2j0P8wB;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CCD606A324
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1CCD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2j0P8wB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795793594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0vSNq/5tHB+9tMuM07Dq7/JDaLhsCwUzxqt3fEJRaY=;
	b=I2j0P8wBqn81wAfOpWiKQGKtYiXBitgeNeOcs3WtiCihG8+q7NXyWWcdh/i6ej1dKdZPnB
	7N+3uQboHbnE23YhgNQVnlwAYuWOuiRd/IqxsNG2N7ghLnrEyob0aZT+GUJeO1S9srrfW1
	FSQ5iz4p8np9Ypwb1lsc/pyBwKsbgbQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-lRG-jB5iOROewON9dHggdg-1; Fri,
 27 Nov 2026 15:33:10 +0000
X-MC-Unique: lRG-jB5iOROewON9dHggdg-1
X-Mimecast-MFC-AGG-ID: lRG-jB5iOROewON9dHggdg_1795793589
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2D9D1800364;
	Fri, 27 Nov 2026 15:33:09 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DBBE1955F76;
	Fri, 27 Nov 2026 15:33:07 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH 05/10] rtla/trace: Add helper to read "now ts" stats field
Date: Fri, 27 Nov 2026 16:32:01 +0100
Message-ID: <20261127153206.134322-6-tglozar@redhat.com>
In-Reply-To: <20261127153206.134322-1-tglozar@redhat.com>
References: <20261127153206.134322-1-tglozar@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OR-I2Wcb-d8d42IzTosgDvGn10SypfYjwZbw3mko9Dc_1795793589
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add trace_get_cpu_now_ts() to read the current timestamp of a given CPU
from the per-CPU stats file.

The returned value is in nanoseconds in the instance clock, matching the
trace event timestamps, so it can be used as a per-CPU reference to
compute how long before a sample the measurement started.

The "now ts" field reports the clock of the CPU executing the read, not
the clock of the CPU owning the stats file, so callers must be running
on the CPU they are reading.

The stats file reports the timestamp as seconds.microseconds, so the
value is reported with microsecond granularity. Clocks that use a
non-nanosecond unit (in_ns == 0) are unsupported.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 42 ++++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/trace.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index c608393533494..e068f25759c00 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -275,6 +275,48 @@ int trace_instance_clear(struct trace_instance *trace)
 	return tracefs_instance_file_write(trace->inst, "trace", "");
 }
 
+/*
+ * trace_get_cpu_now_ts - get the current timestamp of a CPU
+ * @inst: the trace instance, NULL for the top instance
+ * @cpu: the CPU to read
+ * @ts: output, timestamp in nanoseconds in the instance clock
+ *
+ * The "now ts" field reports the clock of the CPU executing the read, not
+ * the clock of the CPU owning the stats file, so the caller must be running
+ * on @cpu.
+ *
+ * The output has microsecond granularity, matching the format of per-cpu stats
+ * reported by tracefs. Clocks that operate in non-nanosecond time units
+ * (in_ns == 0) are not supported.
+ *
+ * Returns 0 on success, -1 otherwise.
+ */
+int trace_get_cpu_now_ts(struct tracefs_instance *inst, int cpu,
+			 unsigned long long *ts)
+{
+	unsigned long long sec, usec;
+	char path[MAX_PATH];
+	char *buf, *line;
+	int ret = -1;
+
+	snprintf(path, sizeof(path), "per_cpu/cpu%d/stats", cpu);
+
+	buf = tracefs_instance_file_read(inst, path, NULL);
+	if (!buf)
+		return -1;
+
+	line = strstr(buf, "now ts:");
+	if (!line || sscanf(line, "now ts: %llu.%llu", &sec, &usec) != 2)
+		goto out;
+
+	*ts = sec * 1000000000ULL + usec * 1000ULL;
+	ret = 0;
+
+out:
+	free(buf);
+	return ret;
+}
+
 /*
  * trace_events_free - free a list of trace events
  */
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
index b3a626b676b3d..4ec8259ccdd71 100644
--- a/tools/tracing/rtla/src/trace.h
+++ b/tools/tracing/rtla/src/trace.h
@@ -37,6 +37,8 @@ struct tracefs_instance *create_instance(char *instance_name);
 void destroy_instance(struct tracefs_instance *inst);
 
 int save_trace_to_file(struct tracefs_instance *inst, const char *filename);
+int trace_get_cpu_now_ts(struct tracefs_instance *inst, int cpu,
+			 unsigned long long *ts);
 int collect_registered_events(struct tep_event *tep, struct tep_record *record,
 			      int cpu, void *context);
 
-- 
2.56.1

