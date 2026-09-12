Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E49C420468
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202410; cv=none; b=OkgloGN0AnNMjj5UUjFXvLoBBDzjQZv8bRWB+6vA6ot/VObWWpg0cQN+zVY3vd8EGSEpqqirTTIzPrrmpN9PPKxCQRog0m2W/ycn9iujiq2nH6JmaZBSwn8apR4vycxLPjZbtQctTpuZLYiKqfN7n0MWAb5/dUNhMNMY6Xq5HcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202410; c=relaxed/simple;
	bh=om9F3JjLqilpQxqMizL64AHSEHtKQSAr6f+kLhCAul4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hL9A7dzFwnR50LwgsuVwICKWrlkJy/bB5gqQirSJNjeNBSukGEt9bRxVFOOG+B9cxndt75/p8PMoKAXujqq03amRFGW8PvA73jw2i4xVK7G3k4eShYQAtZWP3z9i6QEWLH74gYF92fKSd+yWYL4bFgf9wZsAhqvCEl6/iO/JG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEzs02EC; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEzs02EC"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so529927a91.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202407; x=1789807207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Db1rd0C7QliIeAgerscV+bUCjXhP0Hqd1SRjTDtf0g=;
        b=qEzs02EC8px2SExOQC8QEWgyJlIS+ZrHIm22t79/7iozFow6/a1VB3VdolTA1UX+PK
         y5teRPyX3FGDrWy/pU4g7HWNpOtSCSwNsxyKdXXbEOs26VTS7BoaAfdvBcnciDzcRq5X
         cQxZ8h0R5cpfUcF51xesKGyBd+Rx70wkUpckwWw43CTjEUQB6OEu7JIYO5gubH4S0nIo
         8bohzzDREJdP0vR1UbISwaSnK6Zm/Ailjpaavg7ol89JZ4hTa3QA3Mr2towcZbw7rUsl
         fi0WbkfKUL9OYVUg8iHkh/UWIoUphGmLY0UP9Jprw79viFRSFuwnct3qH3AXghI5TyPz
         nazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202407; x=1789807207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Db1rd0C7QliIeAgerscV+bUCjXhP0Hqd1SRjTDtf0g=;
        b=DZAprPi37oVzODjAZLTXp9xSVOulDApuiSGmmyssp4YVLkrCntC5N18LIeAMwYY1rG
         X3Er1hHBztI2pTfe00uPQtVcBa9TCAFDsWEpQXRF0BzKhXEnmWc1rtMkmafL4Jttw30o
         BSs+jH1haHLhwPoThgZ7vSIkefpNxel/9MdgyC1+xCJEqgNZ04Bt0Bpr0OMeB0dxvtIA
         bfom5hJ7YQX+0g+SKF0G/es00nStFljFz6TT5xCDs6hdX9vYBnip4MZz1UIjMYNycujE
         hAcErOEN3Ewg1U378/S8xmYMDdm5zY7dHaePG16LhXt9hoO886XFvh+IsNlXSy+kV3SW
         AfTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiabFB7IeY4lpbT9UGOCMFy9PBExgufoyvR3AILXeSEy2EL+QteElOoVdeFjO4N3K+ecuqE4yifnsQYSRWWr3xYKA=@vger.kernel.org
X-Gm-Message-State: AFuF++kEBaplXjJwNRreDNqyVKGBo4iyNHhX6rTCbxN3hKd+JRQjheQW
	eQvGoZxwonZE3jQBjrZdUqmcj4jLCMvZBusl0UDhGFL5LXEDWK5DXmDA
X-Gm-Gg: AYBFou3VURyFzvcJ7VhXJdIavrrZVyUiop2XeB7sEgrhi6Sbehclv0lH5a+dwGnYHhY
	HTqblTOdIJ069i/2jns0v7RsZBa8hEHeprSJKdrasQ7sFhEwAq0nw6ip/hXDytuZMbTwF5S/sM8
	+avWD8nTfQgSXDtB9gDtWEBXyGekfSeWqeksqOANA6FodC1XvvpZBIW+FQbYIeAkq6q1TjKXTNb
	S4CGHzwrIZDwjpwpiqSM+12eJF6Dt6HTBZ+hQe7CqLnh+msVJ1f+3fjFgade4csy2oIj2ThFNJt
	aJF9/9UppD1MVYI8LUf4b25pDtEWQmHQ2/f7wSIayKF4f+Rwe9lmDgCp+xX9L8KIfk8CTVCwTis
	7VyBaoFcv9ljne+59YXT+Qkg58ahn66vZ+fQRkmNQm0rbnHfhjoJ4Atamzt1xbKwy92pfQu5fNw
	DKmStjZwY4rfVj/MNcBjUsOaE6bLpMycuXNCfUxRAfsNB6Y3z4aCGPKeWbIFN27/5+5xOosShWp
	PsiWb7QEDLQjwMxZfAu8eYXQbkLeK1KPExWzShF
X-Received: by 2002:a17:90b:4ad2:b0:398:9be6:f996 with SMTP id 98e67ed59e1d1-39d9c34a241mr12713191a91.21.1789202407372;
        Sat, 12 Sep 2026 01:40:07 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:40:06 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	lkp@intel.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH v7 09/10] selftests/ftrace: add a stackmap reset and binary ABI test
Date: Sat, 12 Sep 2026 16:37:52 +0800
Message-Id: <20260912083753.3426176-10-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Test reset semantics, the version 1 binary ABI, generation changes and
open-time record membership. Keep a directly owned busy-loop worker
alive across the initial capture and the helper's later refill so the
test does not depend on incidental system activity.

Build a complete pre-reset binary snapshot, keep a second descriptor
open across reset, and compare every byte returned by that descriptor
with the old snapshot prefix. Two terminal outcomes are valid:

- the complete old snapshot followed by EOF
- an incomplete exact old prefix followed by ESTALE

This accepts ESTALE immediately after the first byte while rejecting any
byte from the new generation. Reopening after reset must yield an empty
16-byte header. An fd opened on an empty map must also keep its empty
record set when the same generation later gains records.

Run the helper's host-side --selftest from the standard ftracetest entry
to cover complete and short mixed-generation data, zero-additional-byte
ESTALE, invalid terminal states and overlong output. If disabling tracing
fails after the refill, retry the disable once as best effort before
reporting the original error.

The shell test also verifies native-endian magic and version, record
depth and reference count, that reset preserves ring-buffer stack ids,
and that reset clears statistics. Cleanup kills and waits for the owned
worker, and signal exits use the normal EXIT cleanup path.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 tools/testing/selftests/ftrace/.gitignore     |   1 +
 tools/testing/selftests/ftrace/Makefile       |   2 +-
 .../selftests/ftrace/stackmap_bin_test.c      | 383 ++++++++++++++++++
 .../ftrace/test.d/ftrace/stackmap-reset.tc    | 174 ++++++++
 4 files changed, 559 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ftrace/stackmap_bin_test.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc

diff --git a/tools/testing/selftests/ftrace/.gitignore b/tools/testing/selftests/ftrace/.gitignore
index 4d7fcb828850..1661f0bb426f 100644
--- a/tools/testing/selftests/ftrace/.gitignore
+++ b/tools/testing/selftests/ftrace/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 logs
 poll
+stackmap_bin_test
diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
index 7c12263f8260..9e9bfb4c3f27 100644
--- a/tools/testing/selftests/ftrace/Makefile
+++ b/tools/testing/selftests/ftrace/Makefile
@@ -6,6 +6,6 @@ TEST_PROGS := ftracetest-ktap
 TEST_FILES := test.d settings
 EXTRA_CLEAN := $(OUTPUT)/logs/*
 
-TEST_GEN_FILES := poll
+TEST_GEN_FILES := poll stackmap_bin_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ftrace/stackmap_bin_test.c b/tools/testing/selftests/ftrace/stackmap_bin_test.c
new file mode 100644
index 000000000000..a77b7440c143
--- /dev/null
+++ b/tools/testing/selftests/ftrace/stackmap_bin_test.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Test stack_map_bin generation handling across read() calls. */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static ssize_t read_nointr(int fd, void *buf, size_t count)
+{
+	ssize_t n;
+
+	do {
+		n = read(fd, buf, count);
+	} while (n < 0 && errno == EINTR);
+
+	return n;
+}
+
+static ssize_t snapshot_size(const char *path)
+{
+	char buf[4096];
+	ssize_t len = 0;
+	ssize_t n;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	while ((n = read_nointr(fd, buf, sizeof(buf))) > 0)
+		len += n;
+	if (n < 0)
+		len = -1;
+	close(fd);
+	return len;
+}
+
+static int load_snapshot(const char *path, unsigned char **snapshot,
+			 size_t *snapshot_len)
+{
+	unsigned char extra;
+	unsigned char *data;
+	ssize_t measured;
+	ssize_t n;
+	size_t offset = 0;
+	int saved_errno;
+	int fd;
+
+	measured = snapshot_size(path);
+	if (measured < 0)
+		return -1;
+	data = malloc(measured ? (size_t)measured : 1);
+	if (!data)
+		return -1;
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		goto err_free;
+	while (offset < (size_t)measured) {
+		n = read_nointr(fd, data + offset, (size_t)measured - offset);
+		if (n <= 0) {
+			if (!n)
+				errno = EIO;
+			goto err_close;
+		}
+		offset += n;
+	}
+	n = read_nointr(fd, &extra, 1);
+	if (n != 0) {
+		if (n > 0)
+			errno = EIO;
+		goto err_close;
+	}
+	if (close(fd))
+		goto err_free;
+	*snapshot = data;
+	*snapshot_len = offset;
+	return 0;
+
+err_close:
+	saved_errno = errno;
+	close(fd);
+	errno = saved_errno;
+err_free:
+	saved_errno = errno;
+	free(data);
+	errno = saved_errno;
+	return -1;
+}
+
+static int write_control(const char *path, const char *value)
+{
+	ssize_t len = strlen(value);
+	ssize_t n;
+	int saved_errno;
+	int fd;
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -1;
+	do {
+		n = write(fd, value, len);
+	} while (n < 0 && errno == EINTR);
+	if (n != len) {
+		if (n >= 0)
+			errno = EIO;
+		saved_errno = errno;
+		close(fd);
+		errno = saved_errno;
+		return -1;
+	}
+	return close(fd);
+}
+
+static int reset_map(const char *path)
+{
+	return write_control(path, "0\n");
+}
+
+enum old_export_result {
+	OLD_EXPORT_INVALID,
+	OLD_EXPORT_COMPLETE,
+	OLD_EXPORT_STALE,
+};
+
+static enum old_export_result
+validate_old_export(const unsigned char *snapshot, size_t snapshot_len,
+		    const unsigned char *old_export, size_t old_export_len,
+		    ssize_t n, int read_errno)
+{
+	if (snapshot_len <= 1 || old_export_len < 1 ||
+	    old_export_len > snapshot_len ||
+	    memcmp(snapshot, old_export, old_export_len))
+		return OLD_EXPORT_INVALID;
+	if (n == 0 && old_export_len == snapshot_len)
+		return OLD_EXPORT_COMPLETE;
+	if (n == -1 && read_errno == ESTALE &&
+	    old_export_len < snapshot_len)
+		return OLD_EXPORT_STALE;
+	return OLD_EXPORT_INVALID;
+}
+
+static int run_selftests(void)
+{
+	static const unsigned char snapshot[] = { 0x46, 0x53, 0x4d, 0x42 };
+	static const unsigned char mixed_complete[] = { 0x46, 0x00, 0x00, 0x00 };
+	static const unsigned char mixed_short[] = { 0x46, 0x00 };
+	static const unsigned char too_long[] = {
+		0x46, 0x53, 0x4d, 0x42, 0x00
+	};
+	int failures = 0;
+
+	if (validate_old_export(snapshot, sizeof(snapshot), mixed_complete,
+				sizeof(mixed_complete), 0, 0) !=
+	    OLD_EXPORT_INVALID) {
+		fprintf(stderr, "mixed complete export was not INVALID\n");
+		failures++;
+	}
+	if (validate_old_export(snapshot, sizeof(snapshot), mixed_short,
+				sizeof(mixed_short), -1, ESTALE) !=
+	    OLD_EXPORT_INVALID) {
+		fprintf(stderr, "mixed short export was not INVALID\n");
+		failures++;
+	}
+	if (validate_old_export(snapshot, sizeof(snapshot), snapshot, 1,
+				-1, ESTALE) != OLD_EXPORT_STALE) {
+		fprintf(stderr, "zero additional bytes plus ESTALE was not STALE\n");
+		failures++;
+	}
+	if (validate_old_export(snapshot, sizeof(snapshot), snapshot,
+				sizeof(snapshot), 0, 0) != OLD_EXPORT_COMPLETE ||
+	    validate_old_export(snapshot, sizeof(snapshot), snapshot, 2,
+				-1, ESTALE) != OLD_EXPORT_STALE ||
+	    validate_old_export(snapshot, sizeof(snapshot), snapshot, 2,
+				0, 0) != OLD_EXPORT_INVALID ||
+	    validate_old_export(snapshot, sizeof(snapshot), snapshot,
+				sizeof(snapshot), -1, ESTALE) !=
+	    OLD_EXPORT_INVALID ||
+	    validate_old_export(snapshot, sizeof(snapshot), too_long,
+				sizeof(too_long), 0, 0) != OLD_EXPORT_INVALID) {
+		fprintf(stderr, "old export terminal validation selftest failed\n");
+		failures++;
+	}
+	if (failures)
+		return 1;
+	printf("old export validation selftests passed\n");
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	char buf[64];
+	unsigned char empty[17];
+	unsigned char *old_export;
+	unsigned char *snapshot;
+	enum old_export_result result;
+	size_t old_export_len;
+	size_t snapshot_len;
+	size_t read_len;
+	ssize_t total, n;
+	uint32_t nr_stacks;
+	int read_errno;
+	int disable_errno;
+	int fd;
+	int i;
+
+	if (argc == 2 && !strcmp(argv[1], "--selftest"))
+		return run_selftests();
+	if (argc != 4) {
+		fprintf(stderr, "Usage: %s STACK_MAP_BIN STACK_MAP TRACING_ON\n",
+			argv[0]);
+		return 1;
+	}
+
+	if (load_snapshot(argv[1], &snapshot, &snapshot_len)) {
+		perror("snapshot stack_map_bin");
+		return 1;
+	}
+	if (snapshot_len <= 16) {
+		fprintf(stderr, "stack_map_bin has no records: %zu bytes\n",
+			snapshot_len);
+		free(snapshot);
+		return 1;
+	}
+	if (snapshot_len == SIZE_MAX) {
+		fprintf(stderr, "stack_map_bin snapshot is too large\n");
+		free(snapshot);
+		return 1;
+	}
+	old_export = malloc(snapshot_len + 1);
+	if (!old_export) {
+		perror("allocate old stack_map_bin export");
+		free(snapshot);
+		return 1;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror("open stack_map_bin");
+		free(old_export);
+		free(snapshot);
+		return 1;
+	}
+	n = read_nointr(fd, old_export, 1);
+	if (n != 1) {
+		if (n < 0)
+			perror("initial stack_map_bin read");
+		else
+			fprintf(stderr, "short initial stack_map_bin read: %zd\n", n);
+		close(fd);
+		free(old_export);
+		free(snapshot);
+		return 1;
+	}
+	if (old_export[0] != snapshot[0]) {
+		fprintf(stderr, "initial stack_map_bin byte differs from snapshot\n");
+		close(fd);
+		free(old_export);
+		free(snapshot);
+		return 1;
+	}
+	if (reset_map(argv[2])) {
+		perror("reset stack_map");
+		close(fd);
+		free(old_export);
+		free(snapshot);
+		return 1;
+	}
+
+	old_export_len = 1;
+	for (;;) {
+		read_len = snapshot_len + 1 - old_export_len;
+		if (read_len > sizeof(buf))
+			read_len = sizeof(buf);
+		errno = 0;
+		n = read_nointr(fd, old_export + old_export_len, read_len);
+		if (n <= 0)
+			break;
+		old_export_len += n;
+		if (old_export_len > snapshot_len)
+			break;
+	}
+	read_errno = errno;
+	result = validate_old_export(snapshot, snapshot_len, old_export,
+				     old_export_len, n, read_errno);
+	if (result == OLD_EXPORT_COMPLETE) {
+		printf("old fd completed snapshot: consumed=%zu EOF\n",
+		       old_export_len);
+	} else if (result == OLD_EXPORT_STALE) {
+		printf("old fd stopped at snapshot prefix: consumed=%zu ESTALE\n",
+		       old_export_len);
+	} else {
+		fprintf(stderr,
+			"invalid old fd result: snapshot=%zu consumed=%zu n=%zd errno=%d\n",
+			snapshot_len, old_export_len, n, read_errno);
+		close(fd);
+		free(old_export);
+		free(snapshot);
+		return 1;
+	}
+	close(fd);
+	free(old_export);
+	free(snapshot);
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror("reopen stack_map_bin");
+		return 1;
+	}
+	n = read_nointr(fd, empty, sizeof(empty));
+	if (n != 16) {
+		fprintf(stderr, "bad empty export size: %zd\n", n);
+		close(fd);
+		return 1;
+	}
+	memcpy(&nr_stacks, empty + 8, sizeof(nr_stacks));
+	n = read_nointr(fd, buf, 1);
+	if (nr_stacks != 0 || n != 0) {
+		fprintf(stderr, "bad empty export: nr_stacks=%u next_read=%zd\n",
+			nr_stacks, n);
+		close(fd);
+		return 1;
+	}
+	close(fd);
+
+	/*
+	 * Open an empty export, then populate the map without resetting it.
+	 * The old fd must retain its open-time empty record set even though a
+	 * fresh open sees entries from the same generation.
+	 */
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror("open empty membership snapshot");
+		return 1;
+	}
+	if (write_control(argv[3], "1\n")) {
+		perror("enable tracing");
+		close(fd);
+		return 1;
+	}
+	for (i = 0; i < 500; i++) {
+		total = snapshot_size(argv[1]);
+		if (total > 16)
+			break;
+		usleep(10000);
+	}
+	if (write_control(argv[3], "0\n")) {
+		disable_errno = errno;
+		/* Best effort: a transient write failure must not leak tracing on. */
+		if (write_control(argv[3], "0\n"))
+			perror("retry disable tracing");
+		errno = disable_errno;
+		perror("disable tracing");
+		close(fd);
+		return 1;
+	}
+	if (total <= 16) {
+		fprintf(stderr, "map did not refill for membership test: %zd bytes\n",
+			total);
+		close(fd);
+		return 1;
+	}
+	n = read_nointr(fd, empty, sizeof(empty));
+	if (n != 16) {
+		fprintf(stderr, "old fd exported post-open records: %zd bytes\n", n);
+		close(fd);
+		return 1;
+	}
+	memcpy(&nr_stacks, empty + 8, sizeof(nr_stacks));
+	n = read_nointr(fd, buf, 1);
+	if (nr_stacks != 0 || n != 0) {
+		fprintf(stderr,
+			"old fd record set changed: nr_stacks=%u next_read=%zd\n",
+			nr_stacks, n);
+		close(fd);
+		return 1;
+	}
+	close(fd);
+
+	printf("stack_map_bin generation and membership tests passed\n");
+	return 0;
+}
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
new file mode 100644
index 000000000000..35fc1b1ecf54
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-reset.tc
@@ -0,0 +1,174 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - stackmap reset ABI and binary generation handling
+# requires: stack_map stack_map_stat stack_map_bin options/stackmap options/stacktrace events/sched/sched_switch/enable od:program
+
+# Check reset, binary format, and old-fd generation behavior:
+# 1. Reset clears the map and leaves existing trace records intact.
+# 2. The binary header contains magic 'FSMB' and version 1.
+# 3. After reset, an old fd returns only its buffered generation: either
+#    the exact remaining export and EOF, or buffered bytes then ESTALE.
+#    Reopening after reset yields an empty 16-byte export.
+
+fail() {
+    echo "FAIL: $1"
+    exit_fail
+}
+
+BIN_TEST=${FTRACETEST_ROOT}/stackmap_bin_test
+if [ ! -x "$BIN_TEST" ]; then
+    echo "stackmap_bin_test program is not compiled!"
+    exit_unresolved
+fi
+"$BIN_TEST" --selftest || fail "stack_map_bin helper selftest failed"
+
+worker=
+
+cleanup() {
+    disable_tracing 2>/dev/null || :
+    if [ -n "$worker" ]; then
+        kill "$worker" 2>/dev/null || :
+        wait "$worker" 2>/dev/null || :
+    fi
+    echo 0 > events/sched/sched_switch/enable 2>/dev/null || :
+    echo 0 > options/stackmap 2>/dev/null || :
+    echo 0 > options/stacktrace 2>/dev/null || :
+    echo 0 > stack_map 2>/dev/null || :
+}
+trap cleanup EXIT
+trap 'exit 1' HUP INT TERM
+
+disable_tracing
+clear_trace
+echo 0 > stack_map || fail "initial stackmap reset failed"
+
+# Use sched_switch as a bounded, inexpensive writer through
+# __ftrace_trace_stack(). Full function tracing with per-function stacks is
+# prohibitively slow in small QEMU guests and is not required here.
+echo 1 > options/stackmap
+echo 1 > options/stacktrace
+echo 1 > events/sched/sched_switch/enable
+
+# Keep an owned task runnable for both this capture and the helper's later
+# open-time membership refill; do not depend on incidental host activity.
+(while :; do :; done) &
+worker=$!
+
+enable_tracing
+sleep 1
+disable_tracing
+
+# Sanity: the buffer must contain stack_id events before reset, otherwise
+# the buffer-untouched check below would be meaningless.
+before=$(grep -c "<stack_id" trace || true)
+: "${before:=0}"
+if [ "$before" -eq 0 ]; then
+    fail "no <stack_id> events captured before reset"
+fi
+
+# Validate a non-empty binary export before reset. od -tu4 uses the
+# target's native byte order, matching the kernel ABI on any endianness.
+magic=$(od -An -tx4 -N4 stack_map_bin | tr -d ' \n')
+[ "$magic" = "46534d42" ] ||
+    fail "stack_map_bin bad magic: 0x$magic (expected 46534d42)"
+ver=$(od -An -tu4 -j4 -N4 stack_map_bin | tr -d ' \n')
+[ "$ver" = "1" ] || fail "stack_map_bin version is $ver (expected 1)"
+nr_stacks=$(od -An -tu4 -j8 -N4 stack_map_bin | tr -d ' \n')
+: "${nr_stacks:=0}"
+[ "$nr_stacks" -gt 0 ] || fail "stack_map_bin has zero stacks before reset"
+first_nr=$(od -An -tu4 -j20 -N4 stack_map_bin | tr -d ' \n')
+: "${first_nr:=0}"
+if [ "$first_nr" -lt 1 ] || [ "$first_nr" -gt 64 ]; then
+    fail "first binary entry has invalid depth $first_nr"
+fi
+first_refs=$(od -An -tu4 -j24 -N4 stack_map_bin | tr -d ' \n')
+: "${first_refs:=0}"
+[ "$first_refs" -gt 0 ] || fail "first binary entry has zero ref_count"
+binary_bytes=$(wc -c < stack_map_bin)
+minimum_bytes=$((32 + first_nr * 8))
+if [ "$binary_bytes" -lt "$minimum_bytes" ]; then
+    fail "first binary entry is truncated: $binary_bytes < $minimum_bytes bytes"
+fi
+
+# Keep one binary fd open across reset, and require the stale-iterator path.
+#
+# The helper reads one byte, resets the map through a second fd, then drains
+# the first fd. A one-byte read cannot buffer the whole export: seq_read_iter()
+# stops filling once the buffered amount satisfies the request, and the binary
+# show() emits the 16-byte header as a record of its own. The old fd therefore
+# still has to start a new seq pass to continue, which is where the generation
+# is rechecked, so the drain must end in ESTALE at a strict prefix rather than
+# at EOF. Requiring that line keeps a regression from silently downgrading to
+# the fully buffered case and never exercising the check at all.
+bin_out=$("$BIN_TEST" stack_map_bin stack_map tracing_on)
+ret=$?
+printf '%s\n' "$bin_out"
+[ "$ret" -eq 0 ] || fail "stack_map_bin generation test failed (ret=$ret)"
+case "$bin_out" in
+*"old fd stopped at snapshot prefix"*) ;;
+*) fail "old binary fd did not reach the cross-pass ESTALE check" ;;
+esac
+
+# The helper refills the map for its membership check. Save the actual
+# stack-id records before the stopped reset below; comparing only their count
+# would miss replacement, reordering, or content corruption.
+before_records=$(grep "<stack_id" trace || true)
+if [ -z "$before_records" ]; then
+    fail "no <stack_id> records remain before stopped reset"
+fi
+
+# Reset clears the map only. It must succeed and must not disturb the
+# trace buffer.
+echo 0 > stack_map || fail "reset failed"
+
+after_records=$(grep "<stack_id" trace || true)
+if [ "$after_records" != "$before_records" ]; then
+    fail "reset changed the trace buffer records"
+fi
+before=$(printf '%s\n' "$before_records" | wc -l)
+
+entries=$(cat stack_map_stat | grep "^entries:" | awk '{print $2}')
+: "${entries:=-1}"
+if [ "$entries" -ne 0 ]; then
+    fail "stackmap still has $entries entries after reset"
+fi
+
+successes=$(grep "^successes:" stack_map_stat | awk '{print $2}')
+: "${successes:=-1}"
+if [ "$successes" -ne 0 ]; then
+    fail "reset left successes=$successes (expected 0)"
+fi
+
+drops=$(grep "^drops:" stack_map_stat | awk '{print $2}')
+: "${drops:=-1}"
+if [ "$drops" -ne 0 ]; then
+    fail "reset left drops=$drops (expected 0)"
+fi
+
+rate=$(cat stack_map_stat | grep "^success_rate:" | awk '{print $2}')
+if [ "$rate" != "0%" ]; then
+    fail "stackmap reset success_rate is '$rate' (expected 0%)"
+fi
+
+# Binary export header: magic 'FSMB' (0x46534D42) + version 1.
+# od -tx4 uses the target's native byte order, matching the kernel ABI.
+magic=$(od -An -tx4 -N4 stack_map_bin | tr -d ' \n')
+if [ "$magic" != "46534d42" ]; then
+    fail "stack_map_bin bad magic: 0x$magic (expected 46534d42)"
+fi
+ver=$(od -An -tx4 -j4 -N4 stack_map_bin | tr -d ' \n')
+if [ "$ver" != "00000001" ]; then
+    fail "stack_map_bin bad version: 0x$ver (expected 00000001)"
+fi
+nr_stacks=$(od -An -tu4 -j8 -N4 stack_map_bin | tr -d ' \n')
+: "${nr_stacks:=-1}"
+if [ "$nr_stacks" -ne 0 ]; then
+    fail "stack_map_bin has $nr_stacks stacks after reset"
+fi
+binary_bytes=$(wc -c < stack_map_bin)
+if [ "$binary_bytes" -ne 16 ]; then
+    fail "empty stack_map_bin is $binary_bytes bytes (expected 16)"
+fi
+
+echo "stackmap reset test passed: map cleared, $before stack_id events kept, ABI header ok"
+exit 0
-- 
2.34.1

