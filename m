Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218CF299A95;
	Thu, 22 May 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929295; cv=none; b=ezYVa6zpmBllIeRSQ+M5tGTXzrvCPyKqmQV2XJU5cp41u6SNBcX1S/hhrtF9jVsLQOFRJoHQTauJqilA6wr8tpI8VVpstzLC9tt6Vz7m3PAcg/pCsb8FCtUhqKiN2F50c9tU5owSRPuzCg6KyYFvQSIViJ0UKYoksvDaxgLKN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929295; c=relaxed/simple;
	bh=9qG4JhAoBQLx6c7DB59VR7Z7mrm/lsKWEYWuNW+y8ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kArh2wpx3OwaSCKM9dPucl+slMTrzo4fkAEYdLJRVlaUTH7CB/ftkiD/VCWDD/QQWCThE0rVKinx+ihjQDU0Vs8kXduHWy4CIS1n6TCSVkpCE2nmmraYQIArdKFeec8AXkqJzdtvl95PelbDPIkXwV4P2Su+xxJVbvwkJvo2/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6VjfWlE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6VjfWlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB178C4CEE4;
	Thu, 22 May 2025 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747929294;
	bh=9qG4JhAoBQLx6c7DB59VR7Z7mrm/lsKWEYWuNW+y8ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6VjfWlEtEdMSqCuiJUuOZj7Oyw/GTASTFCqc1g16+USAJN8QHYuybsNuRlDzOspZ
	 zv5L7/fCpD3q9SsbRZ89SEPLDFBpqFrxbZbWxruZ2d0zUpq+zJhb15OajgaA6jvfu3
	 EnEVEvbyG86Tg3Q5em5vB/aVataCs7HIsn39A2RIVzhjj7iSmqRcXfuZeM9x5WGozI
	 eHTA4xHukLgKsiZbDF5JOG6/NSdO4HWRQNfsaVBOiwFSVSOnfostyJivVIzNfqRYI3
	 r5EGBlg77WFgbg6T0yLeGt8R4FEgl2wXePBQrMuylnfHC8WwvI4mzUH4323Y1Fws5i
	 BSWFeb0oD/JMQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] tracing: Reset last-boot buffers when reading out all cpu buffers
Date: Fri, 23 May 2025 00:54:52 +0900
Message-ID:  <174792929202.496143.8184644221859580999.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
In-Reply-To:  <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
References:  <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
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

Reset the last-boot ring buffers when read() reads out all cpu
buffers through trace_pipe/trace_pipe_raw. This prevents ftrace to
unwind ring buffer read pointer next boot.

Note that this resets only when all per-cpu buffers are empty, and
read via read(2) syscall. For example, if you read only one of the
per-cpu trace_pipe, it does not reset it. Also, reading buffer by
splice(2) syscall does not reset because some data in the reader
(the last) page.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c1764ed87b0..433671d3aa43 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6677,6 +6677,22 @@ static int tracing_wait_pipe(struct file *filp)
 	return 1;
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr)
+{
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return false;
+
+	if (!ring_buffer_empty(tr->array_buffer.buffer))
+		return false;
+
+	/*
+	 * If the buffer contains the last boot data and all per-cpu
+	 * buffers are empty, reset it from the kernel side.
+	 */
+	update_last_data(tr);
+	return true;
+}
+
 /*
  * Consumer reader.
  */
@@ -6708,6 +6724,9 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 	}
 
 waitagain:
+	if (update_last_data_if_empty(iter->tr))
+		return 0;
+
 	sret = tracing_wait_pipe(filp);
 	if (sret <= 0)
 		return sret;
@@ -8286,6 +8305,9 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 
 	if (ret < 0) {
 		if (trace_empty(iter) && !iter->closed) {
+			if (update_last_data_if_empty(iter->tr))
+				return 0;
+
 			if ((filp->f_flags & O_NONBLOCK))
 				return -EAGAIN;
 

