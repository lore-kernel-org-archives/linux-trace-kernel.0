Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533834A79D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715754; cv=none; b=bBrt+qLJRQHZvlbdR6nuO/IeA/p1fqilGjOyJeY44PDmtuNNwIVqKrmt0QjZuEEFCS+W1NfJEcK1jqFl1cuxQkP1uNNk3Ln3XWtdoTgwtEIcfyVv41TQ+3QIguNVweTgy4MMMf/+eO1hoFQV0CvxEwALPwyTCWRhgYIogqXpuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715754; c=relaxed/simple;
	bh=fCLTiOBENvUUe9H0p5H9gkzGaABR4ynPRP1JIHswk4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Jb1MAygLeiE0qAUCPYxmhi6v3Fw5KqI/3Du8wMKS2TER+p6lTso6Bj+1WyRjgOyF6CGdhbij+IBxHZij3FwW4Ivt6T/Em9KgvzffXdj0SUeQgX1qt1BC8IoW0k8MJomasmlGwVDZyw8cYZZFQ2lVeJL+PJFGZkEgILnKN0oWt2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B42KS5Ed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B42KS5Ed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786715747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OA6jv8a18DKvdeZ22MpfaNca4IXwtYVOTfHHp+Fdd64=;
	b=B42KS5EdscgcVvSXJw9D1zKKYY7txycZV7RKArfr9veWtA4+Vb5SDv46yjWUZbKdT6loG6
	59ksv/ybl8/alm3gFtWe0SSruHN2N/NlIpdtbZZJYf6edHM7bpP3LRM5tiMelhA6pdcD1F
	VUywzPzh3uIUfWw1OFj887H+jlGQ3/8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-bNAVD2RGNNGn42OWGE3QiA-1; Fri,
 14 Aug 2026 09:55:45 -0400
X-MC-Unique: bNAVD2RGNNGn42OWGE3QiA-1
X-Mimecast-MFC-AGG-ID: bNAVD2RGNNGn42OWGE3QiA_1786715744
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10A3C180034C;
	Fri, 14 Aug 2026 13:55:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F11C91800347;
	Fri, 14 Aug 2026 13:55:40 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 3/5] rtla: Abort on nr_cpus mismatch with tracer
Date: Fri, 14 Aug 2026 15:55:09 +0200
Message-ID: <20260814135511.2207190-4-tglozar@redhat.com>
In-Reply-To: <20260814135511.2207190-1-tglozar@redhat.com>
References: <20260814135511.2207190-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 44QQOyeY7YQtDAHAoOF_KbBi30aMovmdQYc68zDLK1M_1786715744
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In rare situations, sysfs might report a different number of CPUs than
the kernel sees, for example, when /sys is not real sysfs.

In tracefs mode, RTLA will discard any samples that are reported on CPUs
higher than the maximum in sysfs. However, in BPF mode, the incorrectly
sized BPF_MAP_LOOKUP_ELEM syscall on percpu maps will cause a buffer
overflow.

To cover for this corner case, write "all" to osnoise/cpus, and read
back the real kernel-side list of all possible cpus. If it doesn't match
RTLA's nr_cpus (read from sysfs), abort with an error.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/common.c  | 13 +++++++++-
 tools/tracing/rtla/src/common.h  |  1 +
 tools/tracing/rtla/src/osnoise.c | 44 ++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/utils.c   | 16 ++++++++++++
 tools/tracing/rtla/src/utils.h   |  1 +
 5 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 20fae1f19cacf..2a5333270e035 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -62,11 +62,22 @@ static void unset_signals(struct common_params *params)
 int
 common_apply_config(struct osnoise_tool *tool, struct common_params *params)
 {
-	int retval, i;
+	int retval, i, tracer_cpus;
 
 	if (!params->sleep_time)
 		params->sleep_time = 1;
 
+	tracer_cpus = osnoise_get_cpu_count();
+	if (tracer_cpus < 0) {
+		err_msg("Failed to get tracer cpu count from osnoise/cpus\n");
+		goto out_err;
+	}
+	if (tracer_cpus != nr_cpus) {
+		err_msg("Kernel reports %d cpus but rtla sees %d\n",
+			tracer_cpus, nr_cpus);
+		goto out_err;
+	}
+
 	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
 	if (retval) {
 		err_msg("Failed to apply CPUs config\n");
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 051d56182276b..a7a9063c302b5 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -168,6 +168,7 @@ should_continue_tracing(const struct common_params *params)
 int
 common_threshold_handler(const struct osnoise_tool *tool);
 
+int osnoise_get_cpu_count(void);
 int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
 void osnoise_restore_cpus(struct osnoise_context *context);
 
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index b9bcbf9ee430c..5a746bc11f03b 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -124,6 +124,50 @@ void osnoise_put_cpus(struct osnoise_context *context)
 	context->orig_cpus = NULL;
 }
 
+/*
+ * osnoise_get_cpu_count - get the number of CPUs as seen by the osnoise tracer
+ *
+ * Write "all" to osnoise/cpus and read back the real kernel-side list
+ * of all possible cpus. Restore the original value afterwards.
+ *
+ * Returns the number of CPUs, or -1 on error.
+ */
+int osnoise_get_cpu_count(void)
+{
+	char *orig, *readback;
+	int max_cpu;
+
+	orig = tracefs_instance_file_read(NULL, "osnoise/cpus", NULL);
+	if (!orig)
+		return -1;
+
+	if (tracefs_instance_file_write(NULL, "osnoise/cpus", "all\n") < 0) {
+		free(orig);
+		return -1;
+	}
+
+	readback = tracefs_instance_file_read(NULL, "osnoise/cpus", NULL);
+	if (!readback) {
+		tracefs_instance_file_write(NULL, "osnoise/cpus", orig);
+		free(orig);
+		return -1;
+	}
+
+	max_cpu = get_max_cpu_from_list(readback);
+	free(readback);
+
+	if (tracefs_instance_file_write(NULL, "osnoise/cpus", orig) < 0) {
+		free(orig);
+		return -1;
+	}
+	free(orig);
+
+	if (max_cpu < 0)
+		return -1;
+
+	return max_cpu + 1;
+}
+
 /*
  * osnoise_read_ll_config - read a long long value from a config
  *
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d65de511be9e1..5d91c9151aa4a 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -161,6 +161,22 @@ static int max_cpu_callback(int i, void *data)
 	return 0;
 }
 
+/*
+ * get_max_cpu_from_list - get the maximum CPU in a CPU list
+ *
+ * Returns maximum CPU number, or -1 on error
+ */
+int get_max_cpu_from_list(const char *cpu_list)
+{
+	int max_cpu = -1;
+
+	if (cpu_list_iterate(cpu_list, max_cpu_callback, &max_cpu) < 0)
+		return -1;
+
+	return max_cpu;
+}
+
+
 static int tmp_cpu_set_callback(int i, void *data)
 {
 	bool *cpu_set = data;
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 2579e7fa08be6..44b450645ffb5 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -50,6 +50,7 @@ long parse_seconds_duration(char *val);
 void get_duration(time_t start_time, char *output, int output_size);
 
 int cpu_list_iterate(const char *cpu_list, int (*callback)(int, void *), void *data);
+int get_max_cpu_from_list(const char *cpu_list);
 int get_possible_cpus(void);
 
 long long get_llong_from_str(char *start);
-- 
2.55.0

