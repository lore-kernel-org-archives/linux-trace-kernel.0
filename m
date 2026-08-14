Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4638345CCE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715746; cv=none; b=UWahv1zQ0RygOhDo9c+DTW1zlLbnNUBLjeRnyoCgE0sWWWz1HmfBQDzyrSyNweuOKPeH7376zxZP9r+yjwgjWElVnIEa+cRLrHv1pQ50xE5gJ1FpGw+/YleA5sGa8IG2IeNggk96R035vCj89ioxXeZFa2Wldg8XzybiD4f8tvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715746; c=relaxed/simple;
	bh=sc78Hk1btPXC49wnLAe1xrOecZn47e32z9aYl0gmmKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YXENIBz8H64+1UoapyW4IxzBqMLFH+x7jmvHnpsoFXarj8FqdFGB2+FBtnJYe5rrakFUfwF1+l62R5O3q3nKEEnJ5jUx88TFMZl9NEWDj1Sf6WNpmsnCcIOAfz83EbDPDoi32y3t8L5+yJQWUqwGuZqqoW8sE1ieGGu8NjMfz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CeOwvxYd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeOwvxYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786715739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpoJZM0WjsRFDkJiqJMu2NKVg5poGpYPGFQ5YIwFtG4=;
	b=CeOwvxYdXUN5qDpdVDpUwKbN/wWvLpZXpiSQ4Nl9h6/LMUuSXzWdeXjUnJz1GpjcWgF+pv
	wjOY/HUWe0qnfP9YmIN9WL9pR4t5YMKodzmSg25k/j8QtenfP996x1aA6AGlm+Y4aMD4mz
	Y3hQVmGCe/f6cuuxvFKhrbCA9S21Eoo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-TxiFbgekOvCAkqrsDCZdgQ-1; Fri,
 14 Aug 2026 09:55:38 -0400
X-MC-Unique: TxiFbgekOvCAkqrsDCZdgQ-1
X-Mimecast-MFC-AGG-ID: TxiFbgekOvCAkqrsDCZdgQ_1786715737
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22FF21800747;
	Fri, 14 Aug 2026 13:55:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84D131800347;
	Fri, 14 Aug 2026 13:55:33 +0000 (UTC)
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
Subject: [PATCH 1/5] rtla: Replace get_nprocs_conf() with sysfs possible cpus
Date: Fri, 14 Aug 2026 15:55:07 +0200
Message-ID: <20260814135511.2207190-2-tglozar@redhat.com>
In-Reply-To: <20260814135511.2207190-1-tglozar@redhat.com>
References: <20260814135511.2207190-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: SfATvyi2IUmT0lxsMy8BmQjFjbyN9jF4kO644ojtTbM_1786715737
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

rtla uses get_nprocs_conf(), a standard libc routine, to retrieve the
total number of CPUs for the purpose of processing per-CPU data.

In some configurations, libc might return a different value than what is
seen by the kernel. To cover for this situation, replace the call to
get_nprocs_conf() with a newly added helper, get_possible_cpus().

get_possible_cpus() reads /sys/devices/system/cpu/possible and parses
the CPU list, identically to what libbpf_num_possible_cpus() does.
Additionally, it checks that the possible cpu list is zero-based and has
no holes by computing both the cpu count and the maximum cpu number.
Systems where /sys/.../cpu/possible is unreadable, is not zero-based,
or has holes, now report an error instead of crashing later due to unmet
assumptions.

Note that parse_cpu_set() cannot be used to parse
/sys/devices/system/cpu/possible, because it only supports CPU count of
1024 and lower. Higher CPU counts are not fully supported by rtla;
nr_cpus > 1024 is, though, so it has to be covered by the new
implementation in order to avoid a regression.

A new function, cpu_list_iterate(), is added to utils.c to contain the
cpu list parsing logic, which is now shared between the new function
get_possible_cpus() and the pre-existing parse_cpu_set().

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/common.c |  16 +++-
 tools/tracing/rtla/src/utils.c  | 165 +++++++++++++++++++++++++++-----
 tools/tracing/rtla/src/utils.h  |   3 +
 3 files changed, 156 insertions(+), 28 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 8c7f5e75b2ec8..20fae1f19cacf 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -6,7 +6,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/sysinfo.h>
 
 #include "common.h"
 
@@ -155,7 +154,20 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 	bool stopped;
 	int retval;
 
-	nr_cpus = get_nprocs_conf();
+	nr_cpus = get_possible_cpus();
+	if (nr_cpus == -1) {
+		err_msg("Could not read number of possible cpus\n");
+		goto out_exit;
+	}
+	if (nr_cpus == -2) {
+		err_msg("Could not parse number of possible cpus\n");
+		goto out_exit;
+	}
+	if (nr_cpus == -3) {
+		err_msg("Unsupported non-contiguous or non-zero-based CPU topology\n");
+		goto out_exit;
+	}
+
 	params = ops->parse_args(argc, argv);
 	if (!params)
 		exit(1);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index cb187e7d48d1c..d65de511be9e1 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -108,57 +108,170 @@ void get_duration(time_t start_time, char *output, int output_size)
 }
 
 /*
- * parse_cpu_set - parse a cpu_list filling cpu_set_t argument
+ * cpu_list_iterate - parse a cpu list and call a function on each element
  *
- * Receives a cpu list, like 1-3,5 (cpus 1, 2, 3, 5), and then set
- * filling cpu_set_t argument.
+ * If callback returns a non-zero value, the iteration is stopped.
  *
- * Returns 0 on success, 1 otherwise.
+ * Returns the number of cpus in the list (including duplicates) on success,
+ * callback return value on break, and -1 on error.
  */
-int parse_cpu_set(char *cpu_list, cpu_set_t *set)
+int cpu_list_iterate(const char *cpu_list, int (*callback)(int, void *), void *data)
 {
 	const char *p;
-	int end_cpu;
-	int cpu;
-	int i;
-
-	CPU_ZERO(set);
+	int i, cpu, end_cpu, count = 0, retval;
 
-	for (p = cpu_list; *p; ) {
+	for (p = cpu_list; *p && *p != '\n'; ) {
 		cpu = atoi(p);
-		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
-			goto err;
+		if (cpu < 0 || (!cpu && *p != '0'))
+			return -1;
 
 		while (isdigit(*p))
 			p++;
 		if (*p == '-') {
 			p++;
 			end_cpu = atoi(p);
-			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
-				goto err;
+			if (end_cpu < cpu || (!end_cpu && *p != '0'))
+				return -1;
 			while (isdigit(*p))
 				p++;
 		} else
 			end_cpu = cpu;
 
-		if (cpu == end_cpu) {
-			debug_msg("cpu_set: adding cpu %d\n", cpu);
-			CPU_SET(cpu, set);
-		} else {
-			for (i = cpu; i <= end_cpu; i++) {
-				debug_msg("cpu_set: adding cpu %d\n", i);
-				CPU_SET(i, set);
-			}
+		for (i = cpu; i <= end_cpu; i++) {
+			retval = callback(i, data);
+			if (retval)
+				return retval;
+			++count;
 		}
 
 		if (*p == ',')
 			p++;
 	}
 
+	return count;
+}
+
+static int max_cpu_callback(int i, void *data)
+{
+	int *max_cpu = data;
+
+	if (i > *max_cpu)
+		*max_cpu = i;
+
+	return 0;
+}
+
+static int tmp_cpu_set_callback(int i, void *data)
+{
+	bool *cpu_set = data;
+
+	cpu_set[i] = true;
+
+	return 0;
+}
+
+/*
+ * get_possible_cpus - get the number of possible CPUs from sysfs
+ *
+ * Parse /sys/devices/system/cpu/possible to determine the number of
+ * possible CPUs. Only contiguous zero-based CPUs lists are accepted.
+ *
+ * Returns the number of possible CPUs, or a negative value on error:
+ * - -1 if the file is unreadable,
+ * - -2 if parsing failed,
+ * - -3 if the cpu list is non-zero-based or non-contiguous.
+ */
+int get_possible_cpus(void)
+{
+	char *str = NULL;
+	size_t len = 0;
+	int nr_cpus = 0, max_cpu = -1, i;
+	FILE *fp;
+	bool *cpu_set;
+
+	fp = fopen("/sys/devices/system/cpu/possible", "r");
+	if (!fp)
+		return -1;
+
+	if (getline(&str, &len, fp) < 1) {
+		/* cpu string should be at least 1 character */
+		if (str)
+			free(str);
+		fclose(fp);
+		return -1;
+	}
+
+	fclose(fp);
+
+	/* get maximum cpu number */
+	if (cpu_list_iterate(str, max_cpu_callback, &max_cpu) < 0) {
+		free(str);
+		return -2;
+	}
+
+	if (max_cpu < 0 || max_cpu == INT_MAX) {
+		/* empty or bogus cpu list */
+		free(str);
+		return -2;
+	}
+
+	/* get max cpu using dynamic array, as nr_cpus might be > 1024 */
+	cpu_set = calloc(max_cpu + 1, sizeof(bool));
+	if (!cpu_set) {
+		free(str);
+		return -2;
+	}
+	if (cpu_list_iterate(str, tmp_cpu_set_callback, cpu_set) < 0) {
+		free(str);
+		free(cpu_set);
+		return -2;
+	}
+	for (i = 0; i <= max_cpu; i++) {
+		if (cpu_set[i])
+			++nr_cpus;
+	}
+	free(cpu_set);
+
+	free(str);
+
+	if (max_cpu >= nr_cpus)
+		/* rtla assumes cpu < nr_cpus for all cpus */
+		return -3;
+
+	return nr_cpus;
+}
+
+static int cpu_set_callback(int i, void *data)
+{
+	cpu_set_t *set = data;
+
+	if (i >= nr_cpus || i >= CPU_SETSIZE)
+		return -1;
+
+	debug_msg("cpu_set: adding cpu %d\n", i);
+	CPU_SET(i, set);
+
+	return 0;
+}
+
+/*
+ * parse_cpu_set - parse a cpu_list filling cpu_set_t argument
+ *
+ * Receives a cpu list, like 1-3,5 (cpus 1, 2, 3, 5), and then set
+ * filling cpu_set_t argument.
+ *
+ * Returns 0 on success, 1 otherwise.
+ */
+int parse_cpu_set(char *cpu_list, cpu_set_t *set)
+{
+	CPU_ZERO(set);
+
+	if (cpu_list_iterate(cpu_list, cpu_set_callback, set) < 0) {
+		debug_msg("Error parsing the cpu set %s\n", cpu_list);
+		return 1;
+	}
+
 	return 0;
-err:
-	debug_msg("Error parsing the cpu set %s\n", cpu_list);
-	return 1;
 }
 
 /*
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 2ba3333669bb4..c26ba8827947a 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -47,6 +47,9 @@ void fatal(const char *fmt, ...);
 long parse_seconds_duration(char *val);
 void get_duration(time_t start_time, char *output, int output_size);
 
+int cpu_list_iterate(const char *cpu_list, int (*callback)(int, void *), void *data);
+int get_possible_cpus(void);
+
 long long get_llong_from_str(char *start);
 
 static inline void
-- 
2.55.0

