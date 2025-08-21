Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4C2F5319
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764099; cv=none; b=p/4/YP6qYXbk2PwVmu3Jc9atT1eQP2n9XHMFD0aO9edx52/QIl2/xH9qq2K7XTmp36g92OwMu2YMO7SnB9YloKhy3UL8K0YM02RXZPrVWbVZNQvQO6THJZMk92r7bOiOP3gbOJ8SzREIvB5UpllsoQnPYYG2yOLWRGXVhlts5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764099; c=relaxed/simple;
	bh=3KMoWYrKCS9iXFyZU23vQdmkGsH1bjakmfocPm6yigk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nkX5NiE8ETv2f9xh/o2wcPB0ymeB+oLfXk7XZbm7oRE0ZE7L1dzhUbxA5moWiXBI/VNnY5zFxwGXHbWDENpu/RltBi7hs3hw+PN2HPWf6xI64SoqLaFgXMYHFOvo95ktlwvZeTHZ9MRxl4V+xC//KqH3a5jpjyp2Huf+ZG8qDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hM0UtY8/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hM0UtY8/"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so3703455e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764096; x=1756368896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXmeaJhI9e99CmL9wkkDfiednrjI4qTS7gtaFJx7Vrs=;
        b=hM0UtY8/PDxLvU684ct/gumgTLbeTeQm8/iI37L77iHdMsdCmx9css7YopzJmmniVO
         1R4pd6QNIM1fu1o1z9kyaLS5DRjS9Q/FN4oI2TPopv+2erXcwNtRpfVTOc0USIfFbGYv
         3yWqg2+c0mmPKsbEbF6wO56HneUz/I3aX8b727tmFomieVEKKGglITHu3HfRoaZV9zfR
         nXYnMNy2JPggizwZfD6yLr+skdPBeRYHSaJsZkH51cDuCCWbfPNrouze1Qb++Q23jcWT
         yXvrtWq/HV+NDArRW1sAYevoN/Qk46HEzFFCU3oNO1x5ukH5HzvjU3+TX5VNwCApSKNf
         QwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764096; x=1756368896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXmeaJhI9e99CmL9wkkDfiednrjI4qTS7gtaFJx7Vrs=;
        b=qDEdsbDb7FGqyr4WPUrj52dBJpm3MqLIZwzAWL8HrgrpDqZFpLE32AjfnKVZgkHEf0
         HRqq4RBwaV9WxM/F8Nvomtyh7B48+JS4Xmale0eaOS1YhPepq/XZ/cuUdJSTYOuACz4G
         BNRoy0rZxQbBzEwWoVA41qL2cmYvyrC3U4UfoT+7ikJmN7pIs/LQ4Wr0GrtiBV4qOkv9
         l3ZZ5vXuwl1rA/Ht6eclPFmlCwa+W/9rvRuzJbZEzIVlFbeUTfWsweTUyU7mhIE8Oheb
         i2y3OJjc9FpACz4h2cQyNbU0XdsnjLd5T8geGwbVoBl+QEHM4Ny7fvwGMdNRexeFf0Wa
         Y76A==
X-Forwarded-Encrypted: i=1; AJvYcCX0fSY7IaWCbi4JJmrIRSSxS56+W3tA5euvXvXkFucUf0QCXd65cDFM2+OeNCrIBA8hAR4oW97A+i3N6pSnCDrts80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0nDWiXPjt/n7f1KdzYQcULuZb/IjwR5bZqf4riIIKedcXyzZ
	TkFa1wKkzmoBGmr4xQUR81j6gyON3Ttz1vxiKClBWPxZ2rX5nH+XOwbH1bmSN2BJowXt+id0f3G
	ONynEnpuLbncuye4K8OWdpQ==
X-Google-Smtp-Source: AGHT+IHVkLSbuPXaBGbeYxLB8Apzj2J/LjIQ1ACzqcVV+IhVmKpANZi8n0fKVREaY1XDOmHvrY0P+LX9S3g8rjan
X-Received: from wmcn3-n2.prod.google.com ([2002:a05:600c:c0c3:20b0:45b:4777:8063])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a46:b0:45b:47e1:ef79 with SMTP id 5b1f17b1804b1-45b4d869ceemr12017085e9.36.1755764096134;
 Thu, 21 Aug 2025 01:14:56 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:12 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-25-vdonnefort@google.com>
Subject: [PATCH v6 24/24] tracing: selftests: Add pKVM trace remote tests
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
index 000000000000..383ef7a84274
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/buffer_size.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing buffer size
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/buffer_size.tc
+
+set -e
+setup_remote "hypervisor"
+test_buffer_size
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
new file mode 100644
index 000000000000..679e31257d0b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/reset.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing reset
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/reset.tc
+
+set -e
+setup_remote "hypervisor"
+test_reset
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
new file mode 100644
index 000000000000..4c77431e884f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace_pipe.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing pipe
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace_pipe.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace_pipe
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
new file mode 100644
index 000000000000..059c7ad1c008
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/unloading.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing buffer unloading
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/unloading.tc
+
+set -e
+setup_remote "hypervisor"
+test_unloading
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

