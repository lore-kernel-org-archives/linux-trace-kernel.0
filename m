Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0583019C3
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508361; cv=none; b=pNVBqyrUSTFS5JmM+uDoANNSsfUAvVBveqMF5bWgTXg8JMlEAeWzMuIXQMId97PBA6VVMcM75JDYtR1Mdmgs6x/9I2UWWF/XERSKhcmkP1OlC+IX96mUpHVMHYli5NHLPXjYHaCxwpUn5GCIBDMKigxG8pC1mVDeXMxwvDQKZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508361; c=relaxed/simple;
	bh=FSHBZshxGqpNtFR2tBK6AAI7ONDbMwOQc+bxV8nB2pM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TU/eg3ca0n3+8x3gyU5BF+xNsimpv38n6J4uVTh7rPnRMhRSN/zowqNfkw1oy4H7JCe4YXbEykJ2hvvgpWdDKx+l+Ix2h+/WVAM2kxpMSVPmfEugPCQXYDXpRe32MyCqp0qgNp5fonBfNxamuhuGkx0DPxOPqdMVR6ZF+c0fXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iv3qvMjJ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iv3qvMjJ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso3712875e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508354; x=1763113154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XbzgYWavEDkucaAQHkJWm/yuhE4r5kJ12caCWyV8SCQ=;
        b=Iv3qvMjJ9EfvG2vFy5B+8zkjZuEE+FxgTpRk5Ff4xi4O+5iVz+ZBotppgl6LASb7Rt
         VlI78szQ5oWzjBbywQ+eSl7OrbnSkR5z8BYD9Q762uMN8M8M10foaWeH65uVm/PBSxxY
         B0QLtHfmvXgK/YeY8AAu8VtiIhKremeBwzfrBSgusPxlSH4g5Nxgf7EZX++kv8jO1/4p
         7O69DiYUl3RFtyl0XDDsne2zeYUyt1M5ihhvSyUXUUBzJu+NebLW5K+zEHgk+l9OOwmg
         8UhKQGkL4jY3cC0uNzRNikn/XvYDET2w6pLtuJbpfNGkNyrsiy48Wpc+gWex0pG8A7cm
         mH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508354; x=1763113154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XbzgYWavEDkucaAQHkJWm/yuhE4r5kJ12caCWyV8SCQ=;
        b=IMcdozYDosUWk+vJl6UgRjXzingxIub0nYLMEWEPosaUHfKfZ5rubR14++0m83Zirz
         +aa+5P/Q/UefeC8C53zuHGz9yf4C5c1xzXr6sfJu4eDql+B3pvwlk4zr069Eqwj/q4Bk
         4EssLbHbio1LeMyN3EpiQx9yPrSnXGmVFVfvFkLV+XIXBm2CnmL+KnunCLAmrtWLpYMf
         xRmqdpE0lYGgKnd81GrqvZyPAinnl0DVi11cdZj1xjHBGcqUAwqwKC43s50yPDhlu5xk
         HbZi0xjlqsfcHAyn1NTkrSuC+6l70uFWFGoL0SLnlJWXMBV2vldiTv5YlkUmz2DiUIW9
         MALw==
X-Forwarded-Encrypted: i=1; AJvYcCW9UliHW80A//Gj9w2IJAWowwIm8yOBj7dW4b7EML+5t3WXNvkp6MCA7jExXSVgVrE0BOJ0f9Lad0NmBGJ0qU/CH64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqPdSx/1f0yacIW2o/5b11xFiVkGpg2vM0svE3nPkSMjWcIqB
	fDpqTm2Esg9SzHKXmvuZIr3IWlm9i25Ow/7X5ygEzR6rLUIvtVDhLRvsR+Xzk3m9+ERG3KoxDCd
	jH1UgjYi/BEJA/72b5CtcMA==
X-Google-Smtp-Source: AGHT+IF60dCQJ41NPrptxy3Gj7Wrk7uExuUAy3Aow0y9dEr8CGkC0R5jKhv9OaLVv5BJbKI98weG92o8nKAmsyEF
X-Received: from wmdb6-n1.prod.google.com ([2002:a05:600d:486:10b0:46e:37d6:c1a6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468f:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-4776bc89facmr19293645e9.3.1762508354525;
 Fri, 07 Nov 2025 01:39:14 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:40 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-29-vdonnefort@google.com>
Subject: [PATCH v8 28/28] tracing: selftests: Add pKVM trace remote tests
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
2.51.2.1041.gc1ab5b90ca-goog

