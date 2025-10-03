Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15AF2F0C7E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498769; cv=none; b=V5vB9emYUSZKQox2PgoWq5KpXnOqxR11RUFqfQboZ/HQ6ekiecwYpI6HYmSncgofsBu6Q6MhPb1ZetQ7XTJDTyuLw2CXTQUUYpxXyx+NvX4DN2BXfJZOJfrRFs6PoUcr8/KKcfOlfqioE9UWqh25K7atQntAxuXWUYKNMcNHY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498769; c=relaxed/simple;
	bh=EhJlCtUGcSeWQktaiM83P9YNtXVSdRR4pDoNVCpu5bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mgv69hAQRUq8eIr9zLRWR37dqI8x/Eh4kITWh7W+AAJyxxIElF6kbPOLvyNMf1gOGwuYN8wOInJumL67v4eoxsZLYexeoK/aMbNX9fGHyhj091QxZTGch4fpP2MsX+vALBrpuzhbHth3UsChBBvCzz4swRgb91I1+bCIgwCSHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgeU7H9s; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgeU7H9s"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e4cc8ed76so8148605e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498763; x=1760103563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UM3bjOGfRXsiIqNoVQZ3XTLMtvfmMCHhcAES2xrn08=;
        b=wgeU7H9sSbsrjdJ3kHLO/aKVcmAegzUy/xfLFaWHfe+rLIfmkIkDxnh3nar4ajBVA9
         AjjZgt+gIq+P18hFGbDKF4YchbyAShj5kMOBTQESUQRrjI410WQp9Osdm7tnUniCFruL
         /CtpA97GZHe5EBtY89CaJKEH0s9dm3gdunWjQQmRg2lvtqCwClkT6LSSOAsR9upS5+yW
         EecikaBye/FAYxcB8CcYPpVwBv7NNOKfXQqlqBDzxsXSo+Nwta4gfSy1JHV1O8D3EL5e
         KEb6NtBsTDKpc+4A5egb8wWIofq126Qn54RHpWa3FhngkZt4vlxJeG+vocDTX9VFb3da
         miAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498763; x=1760103563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UM3bjOGfRXsiIqNoVQZ3XTLMtvfmMCHhcAES2xrn08=;
        b=Uom+860vkVcGnlWZjHNelSZiM6AJXhOrBY6bXWcNy8XbNpMkmM2tE6WKu1oY3rQTxa
         HZr3Uw3nIjcJIDVWK/uKea2sO1BxsIoEpARy69VBBaZaQ281nQ6aslRGZx0Q2P35mfSc
         9KvN5FTpF8Kzizwk9jzJqQ7pJCxzPUjf3Gg4gscs6t8psv1yS4LIIOoGgNb0/ict3WU7
         QdqfMpTAlGcUNAdMDQdMiEYrWoGd5YnIClJDsmDpWBUsRbbng/xbJfGfCKrj8JrpM5cf
         Ahtjlt6VSbkaBlgdEPm5a9fa+zrRijedfNanbOsOkNBTYOfJMWe9zGbV1j0QYz9BRmiz
         F2AA==
X-Forwarded-Encrypted: i=1; AJvYcCUChKJzTCDl1cLJ+ee9Yza4FsIY+pIjk+OpSdVGh1p/YqegHqNrBqZmMztV+WkNQWnCy0dZ9dzonGik7UzJtGTpHpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Uj97e+ECtU2giw4YxkYXSSqgBKGLTB5Mg77VauKP2Y9Ztffj
	v7VwYidpNZjbMj1nFaQ1TbQO/xQMdWeqNdkYkwB+oJBHr2b6bGVV96M+W6WpQ4p1p6P1CGKIyrk
	qmbcdE15O93RUNQnVLMelXQ==
X-Google-Smtp-Source: AGHT+IH69tFTi6ZXKv+400BRPyLOvUgxD9vIa5eZfePSc6PtEn5y2PQMqER0DyOBvI5qOTvfVEhXP1sn9nPiGRc7
X-Received: from wmco6.prod.google.com ([2002:a05:600c:a306:b0:45d:cfa4:ce0d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4447:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46e7113ceddmr26045525e9.17.1759498763415;
 Fri, 03 Oct 2025 06:39:23 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:25 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-29-vdonnefort@google.com>
Subject: [PATCH v7 28/28] tracing: selftests: Add pKVM trace remote tests
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

Run the trace remote selftests with the pKVM trace remote "hypervisor".

Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
new file mode 100644
index 000000000000..2de07e4d72fe
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer size
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/buffer_size.tc
+
+set -e
+setup_remote "hypervisor"
+test_buffer_size
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
new file mode 100644
index 000000000000..48afc51627e8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer reset
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/reset.tc
+
+set -e
+setup_remote "hypervisor"
+test_reset
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
index 49dca7c3861a..00aed1c2e650 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
@@ -1,9 +1,10 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: Test pkvm hypervisor tracing pipe
+# description: Test pkvm hypervisor non-consuming trace read
+# requires: remotes/hypervisor/write_event
 
 SOURCE_REMOTE_TEST=1
-. $TEST_DIR/remotes/trace_pipe.tc
+. $TEST_DIR/remotes/trace.tc
 
 set -e
 setup_remote "hypervisor"
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
new file mode 100644
index 000000000000..b63339aca380
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor consuming trace read
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace_pipe.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace_pipe
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
new file mode 100644
index 000000000000..eb1640a927cc
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor trace buffer unloading
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/unloading.tc
+
+set -e
+setup_remote "hypervisor"
+test_unloading
-- 
2.51.0.618.g983fd99d29-goog

