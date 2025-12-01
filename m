Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFB3164BC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599930; cv=none; b=mo0GPGo3nto0458EefHXJ59XgNZq1mULg3inLZpMQ+spmJJxIjE4m9ks9QTv2DY4ilvF9k6oY6Yi4pZhj278E31PsyPGed0SIhpcpBjASqirX9TPaCN87JIJLYaiqCaRP3WOmRpVtdl7t37Hx0vyEsMLiarqHJ5mNp8tVO/FjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599930; c=relaxed/simple;
	bh=qM7RV0MVgKkPuugCJA5gyjnZ7ZMfHWsak5/IcOuknMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YitYiYZItYQYrQbopo59+9maR0enuMfxA5objZdxCtBgifpDI0jKjMfVxrJIZGauvxlBRSYXyvPypqUP3gIFz3Aj1owEtt+XJlFdm9gmJj2ArsPpDXW3TMxxFNOiAj0iE9S3EZJbzjh/SGotiA3Z3xa4l8i7qcOLxWWn31HQbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+On5pTo; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+On5pTo"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640c9c85255so5307516d50.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764599926; x=1765204726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo9YRGLlIAYiT7xnWNZFnCqDAVAkIBY4ckpgELisi8o=;
        b=c+On5pToj0s8Zh0VmKNPJd9+P2w9n1RI9c/dWLLGXUGFYh+tkcEbDRI8gk524d+bqo
         /J3j0QtRjeHrAHwue29f+RUrPigjGYHAKdtieim92Gz5uTPOmWta8lxNjpDI0+U4Fq78
         Yd0QjgxJiAtmw6llq4fz8RJLQlwhPVlYLzThLvO2/m9a/agS3Lls4nsTqfKfME5Jsxlv
         cCP+zqOOEKeD+EYMX7ThSyuTyRgF281A/dMSAN79gTiTQiAd10M3gnaY1jR+T+k2b7uD
         AhSDNBm/qZeGxSMkGM7d3L4SD9Sw7q2v4QbR8IPxRGLiyE4XCE+lfZFD0PGyUT4XgBmE
         st9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764599926; x=1765204726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xo9YRGLlIAYiT7xnWNZFnCqDAVAkIBY4ckpgELisi8o=;
        b=OsM1rFfP9RIS9DpiaimitbkqZMqnjSASJKoCVicRq88nyDYy2YL/W3jhQu+Xo+FmLv
         669m6aGejTqB3qGLwL131N7XIpRQ4oEbtAp0re3p2aTszNf/5oiSpCyo/51eB+HftBpE
         OBAI6Jvj1S0XtngiIxn0u5xAxNPdQ9fFgaNvLV0blqGmNyCJbDZWgolfwr6gyGyxSjZN
         KKPQO7OA1J04sWFGG6iEX4SY0K84zAJB1saijnu+uOszzsYppZBOaoe71AO5dAQsG/h7
         hSasJRs89xa2MP1kniEAyrr++lZnrd2ZsIW3ka1vBNs3yWUz2xjrwxOc07wcQ0SBlIFS
         DO/g==
X-Forwarded-Encrypted: i=1; AJvYcCUphJp8/jtN53ClBl8UnU3RGw1bC9yxfTBdacLvTBd7RAxR8rJD3PQTHhjXecZwRguElvlo8sFEV0WbRPGfaXF3ffk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR01OY+dSSpFpDVBPYAMrisYINYqUfU73sRDCW3okJc35xl3o+
	d1Yc+eePAapD8GRIvgaUL+skWOXh2JjVzHFMxjLP8WWQjNF1/mUYOBOt
X-Gm-Gg: ASbGncvUTtil2P3i9zP0uogYIoDOqAyen8nBTJBUUXx458BMmlxW+4Ae2G829iovYRX
	wmobLTpoqUBc+yC+1cBdVw2G1jXAAYftpQD/r5gPfKGsvrJsLxKTx/RsUC1SSi96zKfheATTHWx
	hWWQCY8js1RGnWc+mAKkgQ9MCXHS80wxNYtEzpdfUOB7RHB+G2w6CoV78XMLInkq+kurvtZRB3Z
	IqfNEuSWRfHiGYmfHusbbo5LO7Q870YD3sqUYtF6g4xPyCaic47Mcf9Jx6RJtqeonq9RezgiLvv
	grmKONr4o0Xdfo6Vq9CfraKRkLYJUheMSmCFKegWJr0XRG75mvpuhVYTvBDvBzbTy62yzDs7/K6
	UtQP2Qz2Jugq8ncOMf5QOm3brHeCLIC+Il+ViyQE0C7N9Y9jahgpD0+ROEd+98mAo7Kixycqv6G
	IpvPQB/dL6zQnptUFnSpWTPl79B6Fun2Fy2lEhjqzAnbOA0sD7Z9Y=
X-Google-Smtp-Source: AGHT+IEIrSHba8FocFc5Gk3MFeTWxBnLr3J1VTXOHJr+YqTAbJw73W+9zD/FtWppzYACtNAQhWj4iQ==
X-Received: by 2002:a05:690e:1187:b0:63f:b445:6a0a with SMTP id 956f58d0204a3-643293b7773mr16916167d50.54.1764599926388;
        Mon, 01 Dec 2025 06:38:46 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c078297sm4889911d50.9.2025.12.01.06.38.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 06:38:46 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Mon,  1 Dec 2025 22:38:13 +0800
Message-ID: <20251201143813.5212-3-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251201143813.5212-1-electronlsr@gmail.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple LSM BPF program and a corresponding test_progs test case
to exercise bpf_d_path() and ensure that prefix comparisons on the
returned path keep working.

The LSM program hooks bprm_check_security, calls bpf_d_path() on the
binary being executed, and compares the returned path against the
"/tmp/" prefix. The result is recorded in an array map.

The user space test runs /tmp/bpf_d_path_test (copied from /bin/true)
and checks that the BPF program records a successful prefix match.

Without the preceding fix to bpf_d_path()'s helper prototype, the
test can fail due to the verifier incorrectly assuming that the
buffer contents are unchanged across the helper call and misoptimizing
the program. With the fix applied, the test passes.

Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 .../selftests/bpf/prog_tests/d_path_lsm.c     | 27 ++++++++++++
 .../selftests/bpf/progs/d_path_lsm.bpf.c      | 43 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c b/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
new file mode 100644
index 000000000000..92aad744ed12
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include "d_path_lsm.skel.h"
+
+void test_d_path_lsm(void)
+{
+	struct d_path_lsm *skel = NULL;
+	int err, map_fd, key = 0, val = 0;
+
+	skel = d_path_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	err = d_path_lsm__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto out;
+
+	system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
+	system("/tmp/bpf_d_path_test >/dev/null 2>&1");
+
+	map_fd = bpf_map__fd(skel->maps.result);
+	err = bpf_map_lookup_elem(map_fd, &key, &val);
+	ASSERT_OK(err, "lookup_result");
+	ASSERT_EQ(val, 1, "prefix_match");
+out:
+	d_path_lsm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c b/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
new file mode 100644
index 000000000000..36f9ff37e817
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+#define FILENAME_MAX_SIZE 256
+#define TARGET_DIR "/tmp/"
+#define TARGET_DIR_LEN 5
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} result SEC(".maps");
+
+SEC("lsm/bprm_check_security")
+int BPF_PROG(d_path_lsm_prog, struct linux_binprm *bprm)
+{
+	char path[FILENAME_MAX_SIZE] = {};
+	long len;
+	int key = 0;
+	int val = 0;
+
+	len = bpf_d_path(&bprm->file->f_path, path, sizeof(path));
+	if (len < 0)
+		return 0;
+
+#pragma unroll
+	for (int i = 0; i < TARGET_DIR_LEN; i++) {
+		if ((u8)path[i] != (u8)TARGET_DIR[i]) {
+			val = -1; /* mismatch */
+			bpf_map_update_elem(&result, &key, &val, BPF_ANY);
+			return 0;
+		}
+	}
+
+	val = 1; /* prefix match */
+	bpf_map_update_elem(&result, &key, &val, BPF_ANY);
+	return 0;
+}
-- 
2.52.0

