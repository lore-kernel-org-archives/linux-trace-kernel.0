Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C912E1DF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475654; cv=none; b=E7+rF5jwCUdnXtkYOTyc/WNenCPJTNIBoXHjbcbVynLqbo18Vkp03ZBB8meQ3hh4zPDBV+kH+aHApF96nRLmBDrUiVXBdxviCan0Rk9HAYKstnadCd/ERQvwX+205orm1bnhTAGLHXhaN8T7qU4Oq/CF5Fvv6hCNcyKoXFkjdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475654; c=relaxed/simple;
	bh=O+d59qShzTvBafQqHxGHCWx9WOV1oznH7Tjy6QhzJ58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q4B1kOjRqMUM9WLb4MPol0xxJBgDflamTeuqucyMMXGlNFDHEO0SC2gF55b4mi7zENI7obXquLN9bj3vhNbrEVdLbLShDwTwhw2+YIUP98Tr8AkGDkTHU2oIBXy2SAU6Qpugc6J1MftbZDl4aNiqaCmPdoaunpxGq+frOJR41/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKybTU0c; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKybTU0c"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-349fbb7ab16so4045045f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714475650; x=1715080450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZdtNgS1ADfpekPvRs2FP/KMWugpYNDTTPI4F/Zzcws=;
        b=XKybTU0cxPM/E8VcOhImYdcxXmGcy1fFujR7X+nfuPdnPUrvR2YSt78OnvmYwt/ti5
         vdrf/KqzxzfdnkRYWD55snhEkKIMUcqY2IY67koj1KxpQ29+wmcQEF4WUWHVoq+JWXLl
         7Tz7F/oF/2I6HojWhQ6r07s6M9pBrdEk2A3mEBi3SbvsnLyJ7P0aN2pZTr/s/Ys3NURL
         FCCjZ2PqO5i3PLMiaIP4qHYzrhn88aNwOsxwBlKQ3wgdnjFeJzdfli/yJo1zN+K9yD3M
         3oKkZp2lAD5q6x1qy9+7KZzYJmpBMi00uz7yYHwbkYWOvS3GYph2qT/NQ92zqZTgnJcY
         sdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475650; x=1715080450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZdtNgS1ADfpekPvRs2FP/KMWugpYNDTTPI4F/Zzcws=;
        b=FZjBpaxaIKqo7ssHCU5tdyQPUe1k6YGQDqExcE+9S3m6vJI0sHa6vheXI2jjbcldsy
         x105+QCFSjhL0I3JnXwi2oG1dVbKV9caidnRcT7rwPZFJ8V9spYgz4cjzQ5pN9773mCi
         BU9MyMhmEmcWF+hdqkE5q+g6X5DmzkEpRjQf33+oJt6h8/Pkic7ETyMVPHl7iKdzXucW
         AJSERh+17ttUaWdB17EhwJFXzQB6qXvMP7CQGdByAdjEQovtZMchiKRJlHuAf86YQ8b0
         5fNj4BWNDdM40zOE59diMTAMssSvNw7h8ahYSB0kF/NrmhihnpyYk64lAwqxAufBH5VB
         sIDA==
X-Forwarded-Encrypted: i=1; AJvYcCX3n2KSjEjeV7j9qHFIPDevEAeuQWjtfZlPzXUTq//tPrjBK3tCw6iEp+GvOM4CTJnW6ghKr7AVC8v69Ob5c0x1YAxetsk2enuA+pNVoPKXmvc+
X-Gm-Message-State: AOJu0YwLL460VnlDA/H0lLIcSdTSMSjfgJZGi+7cdufsDG29N62WY88C
	E01XtT19D2EEaPoI9oqKIqARZdE4XhU+580L6qpEG9crgvnxhmHE8L0f6d6pGV6zY+heLLOgKjW
	Lqf5NaOnDqTiQAH/51A==
X-Google-Smtp-Source: AGHT+IEjaQoYqVbTdbjHpcIAJgUuhZa9Cbaa8gDrWXUzsTPJIAcWvjxTMvPyJ34sAGSs0Nys+0tnOp1CyXbv7JGa
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:e0c1:0:b0:34d:713a:647e with SMTP
 id m1-20020adfe0c1000000b0034d713a647emr4531wri.13.1714475650590; Tue, 30 Apr
 2024 04:14:10 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:13:54 +0100
In-Reply-To: <20240430111354.637356-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430111354.637356-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430111354.637356-6-vdonnefort@google.com>
Subject: [PATCH v22 5/5] ring-buffer/selftest: Add ring-buffer mapping test
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

This test maps a ring-buffer and validate the meta-page after reset and
after emitting few events.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/.gitignore b/tools/testing/selftests/ring-buffer/.gitignore
new file mode 100644
index 000000000000..3aed1a2a6c67
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/.gitignore
@@ -0,0 +1 @@
+map_test
diff --git a/tools/testing/selftests/ring-buffer/Makefile b/tools/testing/selftests/ring-buffer/Makefile
new file mode 100644
index 000000000000..627c5fa6d1ab
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wl,-no-as-needed -Wall
+CFLAGS += $(KHDR_INCLUDES)
+CFLAGS += -D_GNU_SOURCE
+
+TEST_GEN_PROGS = map_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/ring-buffer/config b/tools/testing/selftests/ring-buffer/config
new file mode 100644
index 000000000000..d936f8f00e78
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/config
@@ -0,0 +1,2 @@
+CONFIG_FTRACE=y
+CONFIG_TRACER_SNAPSHOT=y
diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
new file mode 100644
index 000000000000..b95eedddbb8c
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ring-buffer memory mapping tests
+ *
+ * Copyright (c) 2024 Vincent Donnefort <vdonnefort@google.com>
+ */
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <linux/trace_mmap.h>
+
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+
+#include "../user_events/user_events_selftests.h" /* share tracefs setup */
+#include "../kselftest_harness.h"
+
+#define TRACEFS_ROOT "/sys/kernel/tracing"
+
+static int __tracefs_write(const char *path, const char *value)
+{
+	int fd, ret;
+
+	fd = open(path, O_WRONLY | O_TRUNC);
+	if (fd < 0)
+		return fd;
+
+	ret = write(fd, value, strlen(value));
+
+	close(fd);
+
+	return ret == -1 ? -errno : 0;
+}
+
+static int __tracefs_write_int(const char *path, int value)
+{
+	char *str;
+	int ret;
+
+	if (asprintf(&str, "%d", value) < 0)
+		return -1;
+
+	ret = __tracefs_write(path, str);
+
+	free(str);
+
+	return ret;
+}
+
+#define tracefs_write_int(path, value) \
+	ASSERT_EQ(__tracefs_write_int((path), (value)), 0)
+
+#define tracefs_write(path, value) \
+	ASSERT_EQ(__tracefs_write((path), (value)), 0)
+
+static int tracefs_reset(void)
+{
+	if (__tracefs_write_int(TRACEFS_ROOT"/tracing_on", 0))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/trace", ""))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/set_event", ""))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/current_tracer", "nop"))
+		return -1;
+
+	return 0;
+}
+
+struct tracefs_cpu_map_desc {
+	struct trace_buffer_meta	*meta;
+	int				cpu_fd;
+};
+
+int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
+{
+	int page_size = getpagesize();
+	char *cpu_path;
+	void *map;
+
+	if (asprintf(&cpu_path,
+		     TRACEFS_ROOT"/per_cpu/cpu%d/trace_pipe_raw",
+		     cpu) < 0)
+		return -ENOMEM;
+
+	desc->cpu_fd = open(cpu_path, O_RDONLY | O_NONBLOCK);
+	free(cpu_path);
+	if (desc->cpu_fd < 0)
+		return -ENODEV;
+
+	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
+	if (map == MAP_FAILED)
+		return -errno;
+
+	desc->meta = (struct trace_buffer_meta *)map;
+
+	return 0;
+}
+
+void tracefs_cpu_unmap(struct tracefs_cpu_map_desc *desc)
+{
+	munmap(desc->meta, desc->meta->meta_page_size);
+	close(desc->cpu_fd);
+}
+
+FIXTURE(map) {
+	struct tracefs_cpu_map_desc	map_desc;
+	bool				umount;
+};
+
+FIXTURE_VARIANT(map) {
+	int	subbuf_size;
+};
+
+FIXTURE_VARIANT_ADD(map, subbuf_size_4k) {
+	.subbuf_size = 4,
+};
+
+FIXTURE_VARIANT_ADD(map, subbuf_size_8k) {
+	.subbuf_size = 8,
+};
+
+FIXTURE_SETUP(map)
+{
+	int cpu = sched_getcpu();
+	cpu_set_t cpu_mask;
+	bool fail, umount;
+	char *message;
+
+	if (!tracefs_enabled(&message, &fail, &umount)) {
+		if (fail) {
+			TH_LOG("Tracefs setup failed: %s", message);
+			ASSERT_FALSE(fail);
+		}
+		SKIP(return, "Skipping: %s", message);
+	}
+
+	self->umount = umount;
+
+	ASSERT_GE(cpu, 0);
+
+	ASSERT_EQ(tracefs_reset(), 0);
+
+	tracefs_write_int(TRACEFS_ROOT"/buffer_subbuf_size_kb", variant->subbuf_size);
+
+	ASSERT_EQ(tracefs_cpu_map(&self->map_desc, cpu), 0);
+
+	/*
+	 * Ensure generated events will be found on this very same ring-buffer.
+	 */
+	CPU_ZERO(&cpu_mask);
+	CPU_SET(cpu, &cpu_mask);
+	ASSERT_EQ(sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask), 0);
+}
+
+FIXTURE_TEARDOWN(map)
+{
+	tracefs_reset();
+
+	if (self->umount)
+		tracefs_unmount();
+
+	tracefs_cpu_unmap(&self->map_desc);
+}
+
+TEST_F(map, meta_page_check)
+{
+	struct tracefs_cpu_map_desc *desc = &self->map_desc;
+	int cnt = 0;
+
+	ASSERT_EQ(desc->meta->entries, 0);
+	ASSERT_EQ(desc->meta->overrun, 0);
+	ASSERT_EQ(desc->meta->read, 0);
+
+	ASSERT_EQ(desc->meta->reader.id, 0);
+	ASSERT_EQ(desc->meta->reader.read, 0);
+
+	ASSERT_EQ(ioctl(desc->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
+	ASSERT_EQ(desc->meta->reader.id, 0);
+
+	tracefs_write_int(TRACEFS_ROOT"/tracing_on", 1);
+	for (int i = 0; i < 16; i++)
+		tracefs_write_int(TRACEFS_ROOT"/trace_marker", i);
+again:
+	ASSERT_EQ(ioctl(desc->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
+
+	ASSERT_EQ(desc->meta->entries, 16);
+	ASSERT_EQ(desc->meta->overrun, 0);
+	ASSERT_EQ(desc->meta->read, 16);
+
+	ASSERT_EQ(desc->meta->reader.id, 1);
+
+	if (!(cnt++))
+		goto again;
+}
+
+TEST_F(map, data_mmap)
+{
+	struct tracefs_cpu_map_desc *desc = &self->map_desc;
+	unsigned long meta_len, data_len;
+	void *data;
+
+	meta_len = desc->meta->meta_page_size;
+	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
+
+	/* Map all the available subbufs */
+	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
+		    desc->cpu_fd, meta_len);
+	ASSERT_NE(data, MAP_FAILED);
+	munmap(data, data_len);
+
+	/* Map all the available subbufs - 1 */
+	data_len -= desc->meta->subbuf_size;
+	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
+		    desc->cpu_fd, meta_len);
+	ASSERT_NE(data, MAP_FAILED);
+	munmap(data, data_len);
+
+	/* Overflow the available subbufs by 1 */
+	meta_len += desc->meta->subbuf_size * 2;
+	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
+		    desc->cpu_fd, meta_len);
+	ASSERT_EQ(data, MAP_FAILED);
+}
+
+FIXTURE(snapshot) {
+	bool	umount;
+};
+
+FIXTURE_SETUP(snapshot)
+{
+	bool fail, umount;
+	struct stat sb;
+	char *message;
+
+	if (stat(TRACEFS_ROOT"/snapshot", &sb))
+		SKIP(return, "Skipping: %s", "snapshot not available");
+
+	if (!tracefs_enabled(&message, &fail, &umount)) {
+		if (fail) {
+			TH_LOG("Tracefs setup failed: %s", message);
+			ASSERT_FALSE(fail);
+		}
+		SKIP(return, "Skipping: %s", message);
+	}
+
+	self->umount = umount;
+}
+
+FIXTURE_TEARDOWN(snapshot)
+{
+	__tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
+			"!snapshot");
+	tracefs_reset();
+
+	if (self->umount)
+		tracefs_unmount();
+}
+
+TEST_F(snapshot, excludes_map)
+{
+	struct tracefs_cpu_map_desc map_desc;
+	int cpu = sched_getcpu();
+
+	ASSERT_GE(cpu, 0);
+	tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
+		      "snapshot");
+	ASSERT_EQ(tracefs_cpu_map(&map_desc, cpu), -EBUSY);
+}
+
+TEST_F(snapshot, excluded_by_map)
+{
+	struct tracefs_cpu_map_desc map_desc;
+	int cpu = sched_getcpu();
+
+	ASSERT_EQ(tracefs_cpu_map(&map_desc, cpu), 0);
+
+	ASSERT_EQ(__tracefs_write(TRACEFS_ROOT"/events/sched/sched_switch/trigger",
+				  "snapshot"), -EBUSY);
+	ASSERT_EQ(__tracefs_write(TRACEFS_ROOT"/snapshot",
+				  "1"), -EBUSY);
+}
+
+TEST_HARNESS_MAIN
-- 
2.44.0.769.g3c40516874-goog

