Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3433AD98
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424298; cv=none; b=Pf1p+LWKa8nL/BbDKVuYiFSYR3JieFnemyqoEtdyGYKxY9FKrwg5q3qfIZxcL8lenQh4/MypfDLH9NpX15gsZj+Q5ESai4VSrX3dmFgUgQW+MrubZmohEeCVeiLubvdr7QKdb8Pp0XAhEoEPa/FQOHWv8/wGbfzMyuSf7Cxh+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424298; c=relaxed/simple;
	bh=rQU0pqdKqe8avW/ctXbf7hWIvHSRj7RwdreDLZd/I2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S8Z/I/MbEV3s5n9LwPbLUQikyNajCpLhhCvnDbLvb5QUrGhVXVqOB79V+jYUr4GjHRi+UCrT3nZbMutg8UAfkLXbGGR1cCqYy/RmKYYYrUFW8C2ndYG/H8OSh6E97/LM1cY8StZzYlRfQY7lBdCMfDL2MJoKAorQfJx/NSQzbK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmF2qS8v; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmF2qS8v"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-480600391e2so7887505e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424293; x=1770029093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcuxT0tCf/T7ct2VsPnptK2x4TV5cU08DiX9A8D84RY=;
        b=KmF2qS8vEks4oLQEti44HDIhwkqWCFxpLdXAuTPNT8HX+fiwj9aG/22DjEnAcnojfU
         rSUwQpxEZp+ar4XLXFYMchEcykxcNdI1mYvwI4WcLj7OLfHHeLM1B0l168qGuQ68OTMG
         ilE/zA8d59buDyNmxf48ahtqN/P6Lj+/wJJYatcxnhCZre97FB8hZA0QZfLKsEBGPSiZ
         2xEyOV7XSyV1pdOtELFkt4ofQj+5WhFhMLXVgLUJqtuxWYPjL83WSQv1wdqUKDvY88ic
         sMobctHtXfubhPIaEO30qMnqDEO4uiA45IFUKc+3REX2ODwgn5sJwJOywfgIOhwcJe/h
         sN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424293; x=1770029093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcuxT0tCf/T7ct2VsPnptK2x4TV5cU08DiX9A8D84RY=;
        b=MdSlp5adiNIQFd5Q5zzp/HcCwmbxID4GltgAfCUp6u1YWSQe9Vsh0L71fUIUzI3JOE
         Jd5xYyYdJXxVui+DgLI/GesIDHmRFLLADkVKrSCsoWDKBQZ2ZsW1bkLl16Q1t0StPitD
         TxugaYvhsTHMvcQ9cDRdJVF7+bjupc3Otuzbawon/6yfgsX1hdSe+VR6Up/C4OJwBp1H
         T4I8SioBjOKkGdeLTERt6FosSYHpAyuMLLq0DrHNDRK0nfM8XJ86rDyLUhHZZFSnCohj
         y3ZP9mBi39/HTrciGa88fquuaFHrF3gykfGsrvX5ZNr3VUGaVFgyzvfdA4lpYh++avqQ
         jzrg==
X-Forwarded-Encrypted: i=1; AJvYcCXb/9nOU5y/OjAp6xAiXdNjIrg77Syyj+TO9rSbAuAKIT7RNRHeqg2LV3l47VFp4ZuGJIbAYPw0JnmVWz9oCru+Rcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGNXsBjGS5jZDPCSStMhPapYI9oLoqRfK8Uj7jRfqcxyJmaGw
	8d4Lm1RSLi2HIkYxhNJrZpz+ZaRZVGvpy0KCuOUgiWfoOsLIT3JzZBQsx37XnpNyOdV6xxc60bM
	7DsVl3CmiUJm7ZCqMcPH2OA==
X-Received: from wmbdn2.prod.google.com ([2002:a05:600c:6542:b0:477:9b3e:67e3])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba0:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-4805d064554mr67628505e9.26.1769424293569;
 Mon, 26 Jan 2026 02:44:53 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:19 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-31-vdonnefort@google.com>
Subject: [PATCH v10 30/30] tracing: selftests: Add hypervisor trace remote tests
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Run the trace remote selftests with the trace remote 'hypervisor', This
trace remote is most likely created when the arm64 KVM nVHE/pKVM
hypervisor is in use.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
new file mode 100644
index 000000000000..64bf859d6406
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace buffer size
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/buffer_size.tc
+
+set -e
+setup_remote "hypervisor"
+test_buffer_size
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
new file mode 100644
index 000000000000..7fe3b09b34e3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace buffer reset
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/reset.tc
+
+set -e
+setup_remote "hypervisor"
+test_reset
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
new file mode 100644
index 000000000000..b937c19ca7f9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor non-consuming trace read
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
new file mode 100644
index 000000000000..66aa1b76c147
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor consuming trace read
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace_pipe.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace_pipe
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
new file mode 100644
index 000000000000..1dafde3414ab
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace buffer unloading
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/unloading.tc
+
+set -e
+setup_remote "hypervisor"
+test_unloading
-- 
2.52.0.457.g6b5491de43-goog

