Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080553E19
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGvD8Rzf"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9dacc912so6643441276.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704989851; x=1705594651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=chPSMnrDRu741hV8mN6BhcsZOY4+3XYSLVWxRQVgXxY=;
        b=UGvD8RzfpYUIhBQ91b4rrlCN8cdhWQTaenUUoyYPbR2cXdS51zCxvrzeeolJjxgndl
         jM86vQfrZgnp2duq8HAl58jWzrDs5xPmRuo8txvbB/f2TUHtlcnee22+y6Fw5u3F7Q9X
         aw7xkOyJt09WNC6VhStqGhoK8uGzw/bID3m3aOR0sLaZqa97gLU1mjGsJbJ5Gh0XYLqI
         rV2vSkDkZeJY60Ea7mBANwH1WTDOL4nlG5kVd/GtCyWfkkJcGJxBeHe3F8mGwNeu+tHe
         bQW6kOaQMEBAsREc+OTEiUzGUJ90APx8jWMRW2iAHcK3M0hvXbfjRBc12+o9C1fxhPBU
         SKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989851; x=1705594651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chPSMnrDRu741hV8mN6BhcsZOY4+3XYSLVWxRQVgXxY=;
        b=ayHlzv9NrQOBMts0J/jP2kcRe6Mjh6thPu8NPVPVik6AWu1lex8QH6EKF22Oua/DTC
         tNkji72ba7RQYqggenccNeSNpzem/V8oRfKHBb/bDD9r97wSM0FAkZBrBi4r9azk0O30
         EQXGftWDm2Q1O7nSwKxByJ8ipg/pH5e+X4FMmheIlT5mCNgtfRUl4hbMPN8K6v21EmGD
         bp2KlhBUi68SLOhHoOAG9TBsWlApLO12cVLXd8fCP3JizlaCeMq8uuo4B1X/V4SAKIq3
         ZYZCqRAI4ZNAzYGgy0V/vBWvlfpibuyD89cIOYnbMLB/LXwOVkMs1Czg2hSb9l2id4WS
         5D6g==
X-Gm-Message-State: AOJu0Yw8H9z3WvcXpwWsOW4J8r2/SsRXWmlOXUab7I7uYg7ItBnTXcmq
	c3BFexQEUrN9mffhn96ro93rfg4Uw+NYmnaT/TmuMT8=
X-Google-Smtp-Source: AGHT+IHHfm2bkJmkStR1wq4BV1bTZwd9grT/yuiYYzm76Uayh3kw3vXeMdTe0+5TfEpL0gIMuqmrKrfMetDNGNv7
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:b03:b0:dbf:142d:9dc4 with SMTP
 id ch3-20020a0569020b0300b00dbf142d9dc4mr59718ybb.3.1704989851099; Thu, 11
 Jan 2024 08:17:31 -0800 (PST)
Date: Thu, 11 Jan 2024 16:17:12 +0000
In-Reply-To: <20240111161712.1480333-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111161712.1480333-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111161712.1480333-6-vdonnefort@google.com>
Subject: [PATCH v11 5/5] ring-buffer/selftest: Add ring-buffer mapping test
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This test maps a ring-buffer and validate the meta-page after reset and
after emitting few events.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

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
index 000000000000..ef8214661612
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/config
@@ -0,0 +1 @@
+CONFIG_FTRACE=y
diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
new file mode 100644
index 000000000000..49107e8da5e9
--- /dev/null
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -0,0 +1,188 @@
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
+	FILE *file;
+
+	file = fopen(path, "w");
+	if (!file)
+		return -1;
+
+	fputs(value, file);
+	fclose(file);
+
+	return 0;
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
+static int tracefs_reset(void)
+{
+	if (__tracefs_write_int(TRACEFS_ROOT"/tracing_on", 0))
+		return -1;
+	if (__tracefs_write_int(TRACEFS_ROOT"/trace", 0))
+		return -1;
+	if (__tracefs_write(TRACEFS_ROOT"/set_event", ""))
+		return -1;
+
+	return 0;
+}
+
+FIXTURE(map) {
+	struct trace_buffer_meta	*meta;
+	void				*data;
+	int				cpu_fd;
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
+	int cpu = sched_getcpu(), page_size = getpagesize();
+	unsigned long meta_len, data_len;
+	char *cpu_path, *message;
+	bool fail, umount;
+	cpu_set_t cpu_mask;
+	void *map;
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
+	ASSERT_GE(asprintf(&cpu_path,
+			   TRACEFS_ROOT"/per_cpu/cpu%d/trace_pipe_raw",
+			   cpu), 0);
+
+	self->cpu_fd = open(cpu_path, O_RDONLY | O_NONBLOCK);
+	ASSERT_GE(self->cpu_fd, 0);
+	free(cpu_path);
+
+	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, self->cpu_fd, 0);
+	ASSERT_NE(map, MAP_FAILED);
+	self->meta = (struct trace_buffer_meta *)map;
+
+	meta_len = self->meta->meta_page_size;
+	data_len = self->meta->subbuf_size * self->meta->nr_subbufs;
+
+	map = mmap(NULL, data_len, PROT_READ, MAP_SHARED, self->cpu_fd, meta_len);
+	ASSERT_NE(map, MAP_FAILED);
+	self->data = map;
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
+	munmap(self->data, self->meta->subbuf_size * self->meta->nr_subbufs);
+	munmap(self->meta, self->meta->meta_page_size);
+	close(self->cpu_fd);
+}
+
+TEST_F(map, meta_page_check)
+{
+	int cnt = 0;
+
+	ASSERT_EQ(self->meta->entries, 0);
+	ASSERT_EQ(self->meta->overrun, 0);
+	ASSERT_EQ(self->meta->read, 0);
+	ASSERT_EQ(self->meta->subbufs_touched, 0);
+	ASSERT_EQ(self->meta->subbufs_lost, 0);
+	ASSERT_EQ(self->meta->subbufs_read, 0);
+
+	ASSERT_EQ(self->meta->reader.id, 0);
+	ASSERT_EQ(self->meta->reader.read, 0);
+
+	ASSERT_EQ(ioctl(self->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
+	ASSERT_EQ(self->meta->reader.id, 0);
+
+	tracefs_write_int(TRACEFS_ROOT"/tracing_on", 1);
+	for (int i = 0; i < 16; i++)
+		tracefs_write_int(TRACEFS_ROOT"/trace_marker", i);
+again:
+	ASSERT_EQ(ioctl(self->cpu_fd, TRACE_MMAP_IOCTL_GET_READER), 0);
+
+	ASSERT_EQ(self->meta->entries, 16);
+	ASSERT_EQ(self->meta->overrun, 0);
+	ASSERT_EQ(self->meta->read, 16);
+	/* subbufs_touched doesn't take into account the commit page */
+	ASSERT_EQ(self->meta->subbufs_touched, 0);
+	ASSERT_EQ(self->meta->subbufs_lost, 0);
+	ASSERT_EQ(self->meta->subbufs_read, 1);
+
+	ASSERT_EQ(self->meta->reader.id, 1);
+
+	if (!(cnt++))
+		goto again;
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0.275.g3460e3d667-goog

