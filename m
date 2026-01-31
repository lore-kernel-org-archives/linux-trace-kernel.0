Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECEF35EDAF
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866196; cv=none; b=s3WN/E8akgn+RxlSrrG+iiGnqPcQLeF910s5XHc6JC7J7GogkoA+dPgnw+J6TUXFMcuTmXVFXxt7m4FRkejJBaNbaz28oWCS1I3p53Fm1+SYm3ZnHS0JXSbnkXTZoF3qkT31kbZFE0ZRrBGvehG56YZjfx/op9fRba6ARMgKRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866196; c=relaxed/simple;
	bh=D32IWT1yvJNiCztIHYR2AGCCVHmxZFcptNwe3+a563g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OeUY4OXyaIUwqRZJIQbIf2nDTsBf/M0Jl7I76fiDC9MU2wxBGVAEzM1eaodaVeE09uzUoEp70MEiKS9KnQ+wKtth9zjMFGrv0YjTVTWsYO6qcvOut+gWL9LhQ1uaAUIAGjTXYTX3q0OyGTBoN4uAURfWv5tQhwovAa/CWDkmJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mt3x14up; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mt3x14up"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4806fce5ab1so17894305e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866190; x=1770470990; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x0jKC8f/iEFEqNg/0cUe99XmInCeV76uXOT4uvAYEUM=;
        b=mt3x14upAydMErSxtmOcNJocB6FpFXXLeHupv/zFRpx+WwQxBJsduvRFjax9kTKTo2
         GEsFFbIA9wfxEce+NaYjCzKzJTrrPKKqNLW4o4SfBaLObdPugagRehYOUI2vjXHOLfZ1
         EzwiOoUKnXCLvJ7RCeiXKhD5nEfnFZDYin11nwpDFazYmqU1PfzY5IWg6wc2VgY6/OH1
         UaOF9F8/pwg3tz8brzbr0EvXBtsClwi7a/QEezjpH+53EoRBausOUL6AZhbxhLvPqyuH
         ltZerpxmkupMrxMg09BqCQgfwr+4TlysRO+9mn6wHn6C/af7wfmS0dkG8lo+cD7bFO9w
         0uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866190; x=1770470990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0jKC8f/iEFEqNg/0cUe99XmInCeV76uXOT4uvAYEUM=;
        b=Cqi6t9wvmZd9qy5Wq6oDykvaxVSseSPink/wCxknbAmF/8ikC5coJuip9aJRjfQIKc
         RmSKmbfp/Cf0qF5hM+D2jsg/JWDYoI/O6xtd//J0hLqaHKqa8poeCXL0zwvKV/heQVj6
         +dpqm8bLhCZZiqOo/lE1lpILaAi5uiLJf0M/GbhchGOYl4uQ/f+LnUEgCCfYu9nohTe4
         POOzf3mIZpRQ/9grjAizCeOoAX51gimrQWJ8FHXc52f4CioPNCiK/BKl9drFMQo6+0QW
         exKcSp0j4mozMD07aqe0FN4z4tleHwMfGv5RqtfYX1gpxoylnmYiv7YwpTJEDimENFFg
         W56A==
X-Forwarded-Encrypted: i=1; AJvYcCUTTSGxvH2IaCUOBzaDLk2PDlwKToU60FEuTaC12KesPVLhDnAcpR/tq0tEoFa7JjPP+239AbMznq1FpSJaQJ7st9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmKqe2c26TwGkphT2RIce+/ihFGuKZ8DakjkMRGZIkbjk6AD1
	2AZFokpzt8SYBHvWEl7iS2YdPmjJt3FwfCtQ9ndpezz99BoC7OSSL2EDuDAdGRbFqiin0pq94ZX
	ikhRp26FAiwjb+EOeUwo2Jg==
X-Received: from wmk26.prod.google.com ([2002:a05:600c:29a:b0:480:4a03:7b5e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4443:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-482db4a317bmr74357055e9.32.1769866190616;
 Sat, 31 Jan 2026 05:29:50 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:48 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-31-vdonnefort@google.com>
Subject: [PATCH v11 30/30] tracing: selftests: Add hypervisor trace remote tests
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
2.53.0.rc1.225.gd81095ad13-goog

