Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DA3655FA;
	Sun, 14 Jun 2026 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448818; cv=none; b=V4P5bxhuKvc0BaHqjrva2Hz+j6Kvv86Tx/5oQf57icqnZM/pYY3CqHBnlDh1PSHprgDyGUz1IIbijmPCrAN3c8FB7G6WrsGlSFMhdl7F83/f2u7MD0y4mO2uIPnoP3yVwrsgXneHqKPCDL4AUbD0JcVMNkZg7/a3leHfdtk9MqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448818; c=relaxed/simple;
	bh=QcFr5+mwK3CZ0m9G/jp1dWbBi7JUR2KORdUkSvH3qYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGbKRwJS5sa1zYgUCXSyIfq8HRRT4A6XCe36wfXFXFzGra+opz09SOrfjyOhkXup05VADEyd2hjJ+2pSH0iPaif9nr+V9fFkAlhs0wdhG/DJiFXjMxuAwwgR/o7Vz+oY/IesMgR3aG5XdAKhuJMyqkuGUWZM3D4rI90fl8rk4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPIhdZMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPIhdZMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8D91F000E9;
	Sun, 14 Jun 2026 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781448817;
	bh=GoXdwca9fhS0RCaOYZ41c2u2InQfm701aGxH9f8iT+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aPIhdZMOCznrbhIhaQPQrY+Afvvn3maerr0Odd0C9/kd7P4KQAIZiGPnhAtmfDxU4
	 Up9aAT3SHUxWbSHtXcRvt0nhiPrfmA6ojzTwNkz/xqT2lWpWjW6EPTeVi5yD2Fy9TP
	 SMeTaMU7CLSsA0gSG0cPw0jTzGLP4xrgh/X3Q1vqtUACipYqfoIlvVUlpCoZRNdMCD
	 EUNIuHDq4psYhTTPgWiQ9FjEu93flRAzZNYrYFsO+GoSELQLr8nhsYpLzLGkLZz7nZ
	 n389zuUM0Q52bhxbUSOXDD1TLFTUSJM4IPWU1OmmtYi+SG22fetfW/t5/UHqcDsDH/
	 V4r5gD9jYKmSQ==
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
Subject: [PATCH v3 1/7] tracing/events: Fix to check the simple_tsk_fn creation
Date: Sun, 14 Jun 2026 23:53:33 +0900
Message-ID: <178144881296.159464.324691652224909545.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178144880282.159464.16882854283219530040.stgit@devnote2>
References: <178144880282.159464.16882854283219530040.stgit@devnote2>
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
 Changes in v3:
   - Recover the usage counter.
---
 samples/trace_events/trace-events-sample.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index ecc7db237f2e..82344a78e471 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -107,6 +107,11 @@ int foo_bar_reg(void)
 	 * for consistency sake, we still take the thread_mutex.
 	 */
 	simple_tsk_fn = kthread_run(simple_thread_fn, NULL, "event-sample-fn");
+	if (IS_ERR_OR_NULL(simple_tsk_fn)) {
+		pr_err("Failed to create simple_thread_fn");
+		simple_thread_cnt--;
+		simple_tsk_fn = NULL;
+	}
  out:
 	mutex_unlock(&thread_mutex);
 	return 0;

