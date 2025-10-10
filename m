Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76554277CB2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085299; cv=none; b=DuSEpLBUC8s5yGTuDRUY7S/ZgpbqTok1CaEjQJ1tBtd+HOlHX8dbgeLSKdY6Kthz5pu1Lt5IPa6VFxEvwbVrQmMmf+SmEnImWajiYvNcypYpUod44+tgg70/nSrTe0ogx1cZKqoZ2IvbIjbciYOh3s+EZJ2zI8WcWUm2NzOFQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085299; c=relaxed/simple;
	bh=ETcUFRp7Y640qwjOoQZKCzn4RuBAqnHbLA1tNYHmtGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pa33fH9t4hPgUMTG7SI0hqkjm5kPTb4vF1jfdjojV82cRhec1JLXu8iZvj5k4wiX/Kbon+qBDFHvJ6emuBcciOeNhNzDFE9NUQbwx+CHVCbou1EqPyRgiS6hC01ZgZlr4UTlj3w6SPjc2QUfCajeLVEUavOng9mN1N5QTitM06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkQ/7G7r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkQ/7G7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41+4ai0rqazcMx3eP0C0LY+GmTK8OcTNHQBt4S97B2Q=;
	b=MkQ/7G7rbFWGYyNYavV8KEeNvqrLE38uDYlPqh2vl+piddAf0omdz1m4tTeuTp6yORTMMa
	SBOD6MnBACPaCzN7rkGyoN3C2TQbHr/4lc8C6mjs+1PHF5ol4ejeTvIDPcCNwjSZVSWdu3
	AKePDmEVGACo+eOL6E2OaQ3quRZo324=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-kjH4I658MX6CxCuls_x2PQ-1; Fri,
 10 Oct 2025 04:34:53 -0400
X-MC-Unique: kjH4I658MX6CxCuls_x2PQ-1
X-Mimecast-MFC-AGG-ID: kjH4I658MX6CxCuls_x2PQ_1760085292
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF413195608C;
	Fri, 10 Oct 2025 08:34:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CAFA1955F42;
	Fri, 10 Oct 2025 08:34:47 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 8/9] Documentation/trace: Specify exact priority for timerlat
Date: Fri, 10 Oct 2025 10:33:37 +0200
Message-ID: <20251010083338.478961-9-tglozar@redhat.com>
In-Reply-To: <20251010083338.478961-1-tglozar@redhat.com>
References: <20251010083338.478961-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The timerlat tracer documentation mentions that threads are created with
real-time priority, but does not mention which priority and scheduling
class is used.

Add the information so that users do not have to look it up in
trace_osnoise.c.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/trace/timerlat-tracer.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/timerlat-tracer.rst b/Documentation/trace/timerlat-tracer.rst
index 53a56823e903..68d429d454a5 100644
--- a/Documentation/trace/timerlat-tracer.rst
+++ b/Documentation/trace/timerlat-tracer.rst
@@ -43,12 +43,12 @@ It is possible to follow the trace by reading the trace file::
            <...>-868     [001] ....    54.030347: #2     context thread timer_latency      4351 ns
 
 
-The tracer creates a per-cpu kernel thread with real-time priority that
-prints two lines at every activation. The first is the *timer latency*
-observed at the *hardirq* context before the activation of the thread.
-The second is the *timer latency* observed by the thread. The ACTIVATION
-ID field serves to relate the *irq* execution to its respective *thread*
-execution.
+The tracer creates a per-cpu kernel thread with real-time priority
+SCHED_FIFO:95 that prints two lines at every activation. The first is
+the *timer latency* observed at the *hardirq* context before the activation
+of the thread. The second is the *timer latency* observed by the thread.
+The ACTIVATION ID field serves to relate the *irq* execution to its
+respective *thread* execution.
 
 The *irq*/*thread* splitting is important to clarify in which context
 the unexpected high value is coming from. The *irq* context can be
-- 
2.51.0

