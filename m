Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F041C0A2
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086405; cv=none; b=IhNEYXEPn82UFPTCSfQoEmVwXMChS+Kfb2Pw5DGeg2yhOl7AWcQiB+2bLROYjgvHNnRE1dX++is3vVWDRJb20B+FmTcRyVeYtlGNhCpF1ND1PqZG7DUFN3dkAO+jc8FK0hNPwjP29y9FJGfVCzVpCwCNDSOh+cvceN+SofTZSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086405; c=relaxed/simple;
	bh=1ybQh4sBgEINHMKA7rClXzZjVr9/TGJrOUR0U4WS+H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ko1g8e0wQ+y8MDu5HfyitiS4Ietrc7XYlH+jZq2yH8xMXVMIQJpYxHdAGFQviOV8tPbZzFHgmlOZ2LH/vHDkY5wX1t7NdZio1O4XbLWujHrhudnn0NlyYeoT7GKD5kW3N8GYPhagyNUEF8hqeziOaKWHw86Jggh/xEf7HreJEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzIgeIex; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzIgeIex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773086403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiaRr03N8wA70yCAXhPMGSRFMitoImbMz/sP2pIqagQ=;
	b=SzIgeIex/HMEKtDsKBMrYvQAK1kBbLYwzeWWoQ8jWd5XnIs+YrSFcrxeGLQDtbTAWfT7OE
	Ws42igUxtAHsRQXx6GaYSUnDLpKaOVk+h/IqtN5cW0ATA1eOeseZR3AKUVvV5zz3Cl6zLZ
	XCiJW4DzxzwmxDWk+mwYpig3G305xSY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-16FM4JjXOgmy0VitcfCGuA-1; Mon,
 09 Mar 2026 15:59:59 -0400
X-MC-Unique: 16FM4JjXOgmy0VitcfCGuA-1
X-Mimecast-MFC-AGG-ID: 16FM4JjXOgmy0VitcfCGuA_1773086394
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83B261954B0A;
	Mon,  9 Mar 2026 19:59:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.81.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B7ED130001A2;
	Mon,  9 Mar 2026 19:59:49 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	linux-trace-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	linux-kernel@vger.kernel.org (open list:Real-time Linux Analysis (RTLA) tools),
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: [PATCH v4 16/18] rtla/trace: Fix I/O handling in save_trace_to_file()
Date: Mon,  9 Mar 2026 16:46:29 -0300
Message-ID: <20260309195040.1019085-17-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-1-wander@redhat.com>
References: <20260309195040.1019085-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: -2seY8CRgXPi6OJMDVKJm6e0M9gkUmX5tEI-Smm1TEk_1773086394
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The read/write loop in save_trace_to_file() does not correctly handle
errors from the read() and write() system calls. If either call is
interrupted by a signal, it returns -1 with errno set to EINTR, but
the code treats this as a fatal error and aborts the save operation.
Additionally, write() may perform a partial write, returning fewer
bytes than requested, which the code does not handle.

Fix the I/O loop by introducing proper error handling. The return
value of read() is now stored in a ssize_t variable and checked for
errors, with EINTR causing a retry. For write(), an inner loop ensures
all bytes are written, handling both EINTR and partial writes. Error
messages now include strerror() output for better debugging.

This follows the same pattern established in the previous commit that
fixed trace_event_save_hist(), ensuring consistent and robust I/O
handling throughout the trace saving code.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/tracing/rtla/src/trace.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index fed3362527b08..e407447773d04 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -73,6 +73,8 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
 	char buffer[4096];
 	int out_fd, in_fd;
 	int retval = -1;
+	ssize_t n_read;
+	ssize_t n_written;
 
 	if (!inst || !filename)
 		return 0;
@@ -90,15 +92,30 @@ int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
 		goto out_close_in;
 	}
 
-	do {
-		retval = read(in_fd, buffer, sizeof(buffer));
-		if (retval <= 0)
+	for (;;) {
+		n_read = read(in_fd, buffer, sizeof(buffer));
+		if (n_read < 0) {
+			if (errno == EINTR)
+				continue;
+			err_msg("Error reading trace file: %s\n", strerror(errno));
 			goto out_close;
+		}
+		if (n_read == 0)
+			break;
 
-		retval = write(out_fd, buffer, retval);
-		if (retval < 0)
-			goto out_close;
-	} while (retval > 0);
+		n_written = 0;
+		while (n_written < n_read) {
+			const ssize_t w = write(out_fd, buffer + n_written, n_read - n_written);
+
+			if (w < 0) {
+				if (errno == EINTR)
+					continue;
+				err_msg("Error writing trace file: %s\n", strerror(errno));
+				goto out_close;
+			}
+			n_written += w;
+		}
+	}
 
 	retval = 0;
 out_close:
-- 
2.53.0

