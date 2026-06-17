Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB6F9D9;
	Wed, 17 Jun 2026 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658178; cv=none; b=r5ubRfHJ3T6ZcPa6wySAH1hCxZQHdwatxy6mzZ8zVCejMFkzr0F659lABh27qNViZnm/8Y02Zf59HjwK7khiAHKGQRnII2QwqfdVXLNMVuIOr/jSVCOpvA+XJOlj2r4qT6SqV0k/C3qrLoSz7Vqrd9H7I9+EzacRxVO7MWLoKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658178; c=relaxed/simple;
	bh=MzBTi/tHniuupSgZNNgJV6HTE/0IMN1vtSnLhJYNgEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHW/KzizMygs/e87Y8I4xVJZfqZD0haqAnhR1YgtuaiuVfMUZLR2Yapc9GW3PniDbmIj17h+ZDXV77FhwfRm526wdXIgPEIPRIdi37pnbUJ3jzZSMeSrJC0oqS8st5nHDsgx1bIWVKrRyVP/HCT7NzpYcDRG3G0EteMbQwHW1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9jb2Vd4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9jb2Vd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B541F000E9;
	Wed, 17 Jun 2026 01:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658177;
	bh=cTmALM5v9MF+mL5ZFkPM1vyGeEUBS3mg7wggTL6NLQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L9jb2Vd4nLlnTssQCVroiiD8RH+3D6TnR+4n3LzataTyQguT4g+GZ1fM2KhSADHK3
	 Yc1uJan+se76uzSCrm2liNACRV2v8vPc573/pzKpoXszF4qSrkecMHa7Itj8mZtpM0
	 zzbHL0pPmmmlSq/WLxzA8a9SI+PaWGivq31YSgThyUh3FcpQcNO6aYmq87RDZ3b3kr
	 idUUBN/WbGWJPiruOGqRZELQ+pdrVyHDVsXyl613Z7ruPi2tuUznHp4AC9mD3k3ZLu
	 eMGT/CvJzSbtdVm4PjME9w1NpmmFKPmO+wdfY+bRxqX5YZV/iGvSoljHEmXW7+Jkdv
	 IvKwkq7nFvxiA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 1/7] tracing/events: Fix to check the simple_tsk_fn creation
Date: Wed, 17 Jun 2026 10:02:53 +0900
Message-ID: <178165817322.269421.3992299509400184196.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178165816303.269421.7302603996990753309.stgit@devnote2>
References: <178165816303.269421.7302603996990753309.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko pointed that this sample code does not correctly handle the
failure of thread creation because kthread_run() can return -errno.

Check the simple_tsk_fn is correctly initialized (created) or not.

Link: https://sashiko.dev/#/patchset/178092865666.163648.10457567771536160909.stgit%40devnote2

Fixes: 9cfe06f8cd5c ("tracing/events: add trace-events-sample")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
   - Fix to remove decrementing counter in error path, since foo_bar_reg() always returns 0.
   - Add a newline to error message.
 Changes in v3:
   - Recover the usage counter.
---
 samples/trace_events/trace-events-sample.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index ecc7db237f2e..0b7a6efdb247 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -107,6 +107,10 @@ int foo_bar_reg(void)
 	 * for consistency sake, we still take the thread_mutex.
 	 */
 	simple_tsk_fn = kthread_run(simple_thread_fn, NULL, "event-sample-fn");
+	if (IS_ERR_OR_NULL(simple_tsk_fn)) {
+		pr_err("Failed to create simple_thread_fn\n");
+		simple_tsk_fn = NULL;
+	}
  out:
 	mutex_unlock(&thread_mutex);
 	return 0;

