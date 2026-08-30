Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1782EBB8D;
	Sun, 30 Aug 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088401; cv=none; b=Cc5pxHY5pZT00qfSlU8OH3dkBhUVPj+IUAtVubNemgPilPD1nMhDL5MvVlIBiZG/pMMdYHIpjcUQ34l3V7O7u/ILtcc0z0OQ607QTZJW1G7B3iRskHKXLV2TMBokLlkwEfQPsEPc/q2KSEqFTKA/fv7v0XddOrQASDLKbe1AGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088401; c=relaxed/simple;
	bh=9jtPWnys6WyDppmzeqDb8MHIOUwYRHyGTfX1Jvgk14k=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=nPZF55ha33V14pH/mEwbrtJDWIcCEwrjjQwtf/wW3PEAJCKqQQrEZ24wXIpVithrBEQgZxCvs1Xa06lugRa5tdEWV6xWGHMSBHw6xeDPO30Xu9E8bM/CaiJV0PG3VVHlNgzjVMmx8JmyKCEbondMKS6zDus1S0UCKdMsacohL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hXqH03VYzz4x6DG;
	Sun, 30 Aug 2026 19:13:00 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 67UBCteX004137;
	Sun, 30 Aug 2026 19:12:55 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 30 Aug 2026 19:12:58 +0800 (CST)
X-Zmail-TransId: 2afc6a94103a9c6-d4a4b
X-Mailer: Zmail v1.0
Message-ID: <20260830191258354QN6qx13iCRbQd2Uj3Ve2s@zte.com.cn>
In-Reply-To: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
References: 20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn
Date: Sun, 30 Aug 2026 19:12:58 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <hu.shengming@zte.com.cn>
Cc: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <mark.rutland@arm.com>,
        <corbet@lwn.net>, <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: =?UTF-8?B?W1JGQyBQQVRDSCA0LzRdIERvY3VtZW50YXRpb24vZnRyYWNlOiBEb2N1bWVudCBmdW5jdGlvbiBjb21tIGZpbHRlcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 67UBCteX004137
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 30 Aug 2026 19:13:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A94103C.001/4hXqH03VYzz4x6DG

From: Shengming Hu <hu.shengming@zte.com.cn>

Document set_ftrace_comm and set_ftrace_notrace_comm, including their
write and O_TRUNC behavior, accepted comm names, interaction with PID
filters, and when a task is rechecked after its comm changes.

Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 Documentation/trace/ftrace.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7261f25f8b4b..a96fc436ec16 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -313,6 +313,37 @@ of ftrace. Here is a list of some of the key files:
         If a PID is in both this file and "set_ftrace_pid", then this
         file takes precedence, and the thread will not be traced.

+  set_ftrace_comm:
+
+	Have the function and function_graph tracers trace only threads whose
+	task comm is listed in this file. Names are matched exactly and must
+	contain between 1 and TASK_COMM_LEN - 1 bytes.
+
+	Each write adds one name. A single trailing newline is ignored, while
+	embedded newlines are rejected. A zero-length write or a write containing
+	only a newline adds no entry. Duplicate entries have no effect.
+
+	Opening the file with O_TRUNC clears the filter. Otherwise, writes add
+	names to the existing filter. From a shell, use >> to add a name without
+	clearing the filter. Reading an empty filter prints `no comm`.
+
+	If both set_ftrace_pid and set_ftrace_comm contain entries, a thread must
+	match both filters to be traced.
+
+  set_ftrace_notrace_comm:
+
+	Have the function and function_graph tracers ignore threads whose task
+	comm is listed in this file. Matching and file operations have the same
+	semantics as set_ftrace_comm.
+
+	A match in either set_ftrace_notrace_pid or set_ftrace_notrace_comm
+	excludes the thread and takes precedence over all include filters.
+
+	Function-tracer task filters are evaluated when a task is scheduled in,
+	and the result is cached per CPU. Changing a filter refreshes the result
+	for currently running tasks. If a running task changes its comm, it is
+	rechecked the next time it is scheduled in.
+
   set_event_pid:

 	Have the events only trace a task with a PID listed in this file.
-- 
2.25.1
