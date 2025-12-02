Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0232548D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668225; cv=none; b=XrU6hep8fk9WZW7K5wGPNfS56A/KWZlCo0xl4Ix2hC/5ruhd8kXQXbfZ2x/olqIJdktdEVSFngEvm3TOMutfxbce/a9hu8rumIpryTxumtNcFyfdZIHOQKaLnJYvsmjLsuVPH/FL8w7pK90QSi3CRC95m4GlZ0DvNrbsQr+nB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668225; c=relaxed/simple;
	bh=eqUL/kWkYdof9hQMILS88EY8tqaEdynZnep63XC21Sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JywgOqdUz28IE36/JawhIQ8q5jcSTwPY67pcp8XWRvb88sZuHgxDZ6vP/5Hn4TIhiyCz1q2LUVh/5xGVA76+LX0ImZ9XQbeBOmjTpw4yUBI1ibuuSwLXOhZ+DfmnuV11Y+rNzi27t1zEQB1yBYNYk+p1NlDo9MsTOTO2UWfuwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3YTG4Ht; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3YTG4Ht"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b7178ad1a7dso675846266b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668221; x=1765273021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+SzM9KLgL2lNiqGPyjU/uTvcU4SeOJpnexCrssRjDMk=;
        b=K3YTG4Ht8XxILMxJNNwDryzO4NeOAMKBptFhAJ2O7A3E8+oG5pBeIe9m6c0B4Kvk0F
         yGuwc8/jCpGUlU2MtyT/67WeRJerOAhXfbqVA8fEEWt0qnym4upkYiQi7DG0S7nDgLtB
         84Q5cdaAL/junQ2sr7JZ4jrwCWOoQN8nOU/rVqF/ipfd8MNEMrUzXRd34S8Uds/fA1F2
         VmWHobg5JYmRmfsClwslv2KQKRKVYszNF5/J2zuXwkBFOEmIeUp3Qv5Bw5X7EoqDykcH
         L4E3EvtnPlqNQLdDYCTA8Quz9InnS6G9ilog5PZUQDikvBB/5wpP3ro0Q6aJDKDMrT6W
         rPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668221; x=1765273021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SzM9KLgL2lNiqGPyjU/uTvcU4SeOJpnexCrssRjDMk=;
        b=ML+CbhPWPSIJAd6fa4t0SpjlOIuSfFJOvuU3ESWO+HtUPKyul9+Rhz1ReBIgX3o+jo
         /4MfSoRVLGGOT74bpap+WM4wBV6+5s54swBbLCDGzgNeKmTvUqo8I3gHCG9/J5fOmSGo
         bPHIxo6mUGuemBVoOJPIoXMl3tst3+WtwvDE4K8jkGrx6qb0O2wkfgsn3sgM3sQSUbwh
         M+GsrOuNvSBITM94qN1lLgKg5ee5n2zc6AeCG08HqImOveBVgZgdvX6UV3yQypzlPqU3
         Z7RrXaSw9mRW/WbQ6ymt72VCsBq009Aa9S2uYeJ2xnREfkRfkLX4WowO4Zzvc1Y4veQf
         U5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVn22xpIOA/vmNAa42PyVl+MfHWS0QHfW8FWOgOAVFbcv9g5Kwm5wprdoDWzntSep5z3pPGuxmPSw+URl4tvtGgNIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3+9xYcwNIbRmwAQ3wZJyGGI84xVNVvWxhnXqc4gWuh/iiePW
	Ob80u8fTknjmcSD4SCWtxstkHIYcPdJqDeePi/I7IsWOgrR4OGPaNwnTX1uKkHUupDsFC9H1QyV
	69a3ZtNwezZuhfntCY20VKQ==
X-Google-Smtp-Source: AGHT+IHvb3xnp0JFd6fDTPTjFHfgzvMoOO5D/uqUHZuJommh44ByPSgz4fUGk8BxStO8hqDOnZDIAusho37QJVIV
X-Received: from ejcst12.prod.google.com ([2002:a17:907:c08c:b0:b73:3b4b:d5ce])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6eaa:b0:b71:854:4e49 with SMTP id a640c23a62f3a-b767189cf54mr4813189466b.56.1764668220623;
 Tue, 02 Dec 2025 01:37:00 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:23 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-31-vdonnefort@google.com>
Subject: [PATCH v9 30/30] tracing: selftests: Add hypervisor trace remote tests
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
2.52.0.107.ga0afd4fd5b-goog

