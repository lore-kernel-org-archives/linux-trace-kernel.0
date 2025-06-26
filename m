Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A962E2EE8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Jun 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941403; cv=none; b=DUy/wtdv0hWBuwJFuKlNhT6gu7WYM5bPi1t50ahXVu46HB96/mc9IVmM03x27WFzSMLKl42BQbfuIRH48XLk49CU89EZ6vvOTqB7jUuh/1LByXYH0d6wHRdFjpjCqHSQrZ+0Irg1rNYKoilzozreGKE3ysQ7xaywWr4XzYh4TQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941403; c=relaxed/simple;
	bh=M3hdx2skcWoqfn5nBTo8ujRdHVpFUS3GEfGFgitw2iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEv+fhsP4htfkv+GQ7A1CcWJfAOHwRh+gzQ4d+haHhA6c8sI7c8dawP58hnsiDOwE7+WR6EabWo4TlW7vreB5cJga+HWvq57GCmd8LHYZRQzgZCdpwGp4xc1TPPp1QeArhWP9G1SJ/rLbpK5TxbSpVsB9rndfm8Dzjz8cj6Suos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C218B4o+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C218B4o+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M92KV+ly5nxnIVd6n/jgRKgpirFRCSP8wIHHelv0nmQ=;
	b=C218B4o+/RNtZVvc2c+JIcHv8S72DYqRqsY2N+gvC+uDQH8Z+CVFce2pV+nbkdFPQe6xmJ
	pyNjKDTe7G4BMtF5fj5RG4UD2wGn1s6GtK4ljTWgkBlWqfZ9AAEMy+MJVhRoXEKzUdFHDH
	560jh8EM3ecg36r+XdmFo6oIMr90gSw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-ZcDS_bLPN1iw_IT1Y43BWg-1; Thu,
 26 Jun 2025 08:36:37 -0400
X-MC-Unique: ZcDS_bLPN1iw_IT1Y43BWg-1
X-Mimecast-MFC-AGG-ID: ZcDS_bLPN1iw_IT1Y43BWg_1750941396
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B2241978C9A;
	Thu, 26 Jun 2025 12:36:36 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.241])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B6E7180045C;
	Thu, 26 Jun 2025 12:36:33 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 9/9] Documentation/rtla: Add actions feature
Date: Thu, 26 Jun 2025 14:34:05 +0200
Message-ID: <20250626123405.1496931-10-tglozar@redhat.com>
In-Reply-To: <20250626123405.1496931-1-tglozar@redhat.com>
References: <20250626123405.1496931-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Document both --on-threshold and --on-end, with examples.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 .../tools/rtla/common_timerlat_options.rst    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 10dc802f8d65..7854368f1827 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -55,3 +55,67 @@
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
         See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
+
+**--on-threshold** *action*
+
+        Defines an action to be executed when tracing is stopped on a latency threshold
+        specified by **-i/--irq** or **-T/--thread**.
+
+        Multiple --on-threshold actions may be specified, and they will be executed in
+        the order they are provided. If any action fails, subsequent actions in the list
+        will not be executed.
+
+        Supported actions are:
+
+        - *trace[,file=<filename>]*
+
+          Saves trace output, optionally taking a filename. Alternative to -t/--trace.
+          Note that nlike -t/--trace, specifying this multiple times will result in
+          the trace being saved multiple times.
+
+        - *signal,num=<sig>,pid=<pid>*
+
+          Sends signal to process. "parent" might be specified in place of pid to target
+          the parent process of rtla.
+
+        - *shell,command=<command>*
+
+          Execute shell command.
+
+        - *continue*
+
+          Continue tracing after actions are executed instead of stopping.
+
+        Example:
+
+        $ rtla timerlat -T 20 --on-threshold trace
+        --on-threshold shell,command="grep ipi_send timerlat_trace.txt"
+        --on-threshold signal,num=2,pid=parent
+
+        This will save a trace with the default filename "timerlat_trace.txt", print its
+        lines that contain the text "ipi_send" on standard output, and send signal 2
+        (SIGINT) to the parent process.
+
+        Performance Considerations:
+
+        For time-sensitive actions, it is recommended to run **rtla timerlat** with BPF
+        support and RT priority. Note that due to implementational limitations, actions
+        might be delayed up to one second after tracing is stopped if BPF mode is not
+        available or disabled.
+
+**--on-end** *action*
+
+        Defines an action to be executed at the end of **rtla timerlat** tracing.
+
+        Multiple --on-end actions can be specified, and they will be executed in the order
+        they are provided. If any action fails, subsequent actions in the list will not be
+        executed.
+
+        See the documentation for **--on-threshold** for the list of supported actions, with
+        the exception that *continue* has no effect.
+
+        Example:
+
+        $ rtla timerlat -d 5s --on-end trace
+
+        This runs rtla timerlat with default options and save trace output at the end.
-- 
2.49.0

