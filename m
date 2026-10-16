Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B903B27F4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131408; cv=none; b=keOGj8cCV8PrLELPFrktXyUK7EwevO4DsFAhKyb3Y9GNBS3GvQVlja3HVTMl4utpIbj6n6ptHpbnFlo2rlvTFtBODoJp2hxHaIXyOK/usq9Om0O6iAPjMOQt8FyZCGZ5rz5pVdPBRF+WauVXhV/8757FpW4Ud2xzyDsM1bGTLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131408; c=relaxed/simple;
	bh=vyDeX8k8/sPjBY1Pb3s9Gz8zKDNgwOVVETru05itzdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHHPp/UwAnE7q8JBTJ+07QH9sZC670QmTeWcmOpF7oBAVvEGP5OQMs+2L28qmecFu3qOO0L9GY2cYl1oXMwoyxp5ki1gGdpLTYF6wp7MGcKvqEPg/1XP9WeqfVI03qUisWsjbFAPJrRiXgzvhPOTCQfmlZsUCdBuAnabGsPR7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rR+IHqfF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR+IHqfF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso43435865e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131403; x=1792736203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8EDIcpHqc3pxDbfYRG6SRGOamgW/C6wGExJNy1Xs+Q=;
        b=rR+IHqfF5oKozGZoT8adWuepaIQQqOP3n25pt/d5z1elIFbL9W15aedCElGG6bW7Ij
         An312Zi2cl1R9AxihcBHaSFkVmqBvUoJfOv/E5H95avW+/4+3HVvuu/Tde3sevxJGYhJ
         i3QammZV/5N1KkgbbUUdNevwdL7urK0SBiHPLHYpUkoZwOGYTWc92tlQY0mmth618enh
         LlR9kOtqr5DHjGGVh8cxGLumxk3SfDhVbZqLKLRx7xHAuHhxdnIXxMM6+dbL+4NmfvRZ
         eIsGHQslqcRpo5f2Kq6wcETXkDHDzjkDBfVyczBTAouGDVVatc5byuG/XyF6akUQOweZ
         eXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131403; x=1792736203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E8EDIcpHqc3pxDbfYRG6SRGOamgW/C6wGExJNy1Xs+Q=;
        b=Xc3WqmrYaSq7iqnVn82/WecBCFhZIevcut4cm7YI0ht33lI/+26q6qoj0TO++8FHOL
         YgGUv6oVwRBqzprtnPgSpiZ1V88ryCnUsKcdbnidlfu3tMi4fc4u0ZSo4AnHSKIUmwBR
         nP+Y0RO6swoAE6nfxbGMNOw4rCrZeT6/K5PUIqS+esJvqbMFL/VsC+mmZWR+xV0dPtlv
         er6u9Y1RsAyeL3ZnRXqyykKoZV9xhlj3Et7elw1o/WBmFUpB30OxgGbe0y/AtNifMF9x
         BB5heFZGgwCU2Tc/xUX0eWsOvQwRJiEq6SXgaiJtJFBiYsaRC05OGYStOdxSfLRVTk+e
         GgNA==
X-Forwarded-Encrypted: i=1; AKwUvBx+9b8Cb18LSrs4zValT+OYMv6QzR3D89MOk1phppl7wEJVNYYWBs646xUcbQs4mimeUoBQN+uFl2XWYj8QnxZVVEo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyLcLoCjNRa7Gb6XewQs9p0hdf6v2cDeBB3AUmi0jW4UOdJVv0
	93j+KEHy6rze23/Dn1UsKK9o5iZIqflxL+cGHL9OzMJyN96+Xw8qtZjL
X-Gm-Gg: AYBFou1k/Z1543kPdluxIM3lF/xN7Y++YarHMkvtJfStKQ++sKz+Ekb5+RUQltNzfEM
	NWERSJiMigE1dJYYeWZXqB2csXHMOWkyjpHTbXRK9aQHbKW1h7lejbNS+mSAzJuLQhtEII40vz+
	eiJfUaBdWjwqBooOrXyWC2+grENi+wkuf4ypIE9KhNrYJ7R1Sql3mLweefbq638DvtusNvXmXuS
	MQUmjlcAx97Gl4n9wEMwyHF6O/MjzxHCIFxNud2Ac16gRYh48ORr7vvSlXMzqhm3BS47QXx7MPF
	RaZrh+niPlOg1H/JNLgsrLWetJd22oQ3uiPfQ79PCdLQCI4C8yqfVpad5LmpHC5/ogCjWRVk6/K
	LRsX9ONN9rpfXrZMLOyoXUS4Vcdt4IgyxPQQTO3hLKE2RIL9glRiWKlok2b9KZkLjayH+3VCM+j
	T0bdG3RjPmuphKEcl9HInTDR2Lq23XYlqbFPYqBtvR8Hrh6Vi3KNv3fzpaGvf9CE7tn2qSZ8iO2
	t/GkwLoLGqolzDAn44kCESt8JlTezh2gEysLoCIMBd97BxWWEQgPr8sJEA=
X-Received: by 2002:a05:600c:608d:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-4a18e48d45cmr464623495e9.16.1792131402801;
        Thu, 15 Oct 2026 23:16:42 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8abfae7sm14985945e9.0.2026.10.15.23.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:42 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] tracing: Hold trace_types_lock when resetting last boot data from readers
Date: Fri, 16 Oct 2026 07:16:35 +0100
Message-ID: <20261016061638.214847-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016061638.214847-1-devnexen@gmail.com>
References: <20261016061638.214847-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_last_data_if_empty() is called from tracing_open() with O_TRUNC,
tracing_read_pipe() and tracing_buffers_read() without trace_types_lock.
Two readers can both pass the LAST_BOOT test and free module_delta
twice, and a module notifier can update module_delta while it is being
freed.

Take trace_types_lock in those paths and keep the callers that already
hold it on an unlocked variant.

Fixes: 32dc0042528d ("tracing: Reset last-boot buffers when reading out all cpu buffers")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d3ffbed9c44b..cf8663c27ae6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3603,6 +3603,7 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static bool __update_last_data_if_empty(struct trace_array *tr);
 static bool update_last_data_if_empty(struct trace_array *tr);
 
 static int tracing_open(struct inode *inode, struct file *file)
@@ -4697,7 +4698,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
-	update_last_data_if_empty(tr);
+	__update_last_data_if_empty(tr);
 	return t->init(tr);
 }
 
@@ -5371,8 +5372,10 @@ static int tracing_wait_pipe(struct file *filp)
 	return 1;
 }
 
-static bool update_last_data_if_empty(struct trace_array *tr)
+static bool __update_last_data_if_empty(struct trace_array *tr)
 {
+	lockdep_assert_held(&trace_types_lock);
+
 	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
 		return false;
 
@@ -5387,6 +5390,16 @@ static bool update_last_data_if_empty(struct trace_array *tr)
 	return true;
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr)
+{
+	/* Avoid the lock on the read path unless this is a last boot buffer */
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return false;
+
+	guard(mutex)(&trace_types_lock);
+	return __update_last_data_if_empty(tr);
+}
+
 /*
  * Consumer reader.
  */
@@ -6479,7 +6492,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		ring_buffer_set_clock(tr->snapshot_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->snapshot_buffer);
 #endif
-	update_last_data_if_empty(tr);
+	__update_last_data_if_empty(tr);
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
 		struct trace_scratch *tscratch = tr->scratch;
-- 
2.55.0

