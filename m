Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6B478851
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551240; cv=none; b=YiuNXSljYAfnDef7swuJxRygCY0jmcfmRS3ZG1MXEOAWBiizl/GuYAwAtilYaAeR6Iacx0N86+oXOv3mDaOmMWDBcKQCHgPdf39KsiQON1ZHjP7ExLc+GHy3C1akIMX/2HPZf4yE7R5/ZoJIHnGxblOjpYSBpTBoVIN7RCYlZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551240; c=relaxed/simple;
	bh=+aLf8sJ2jSSh6RfXGhvqvy30hVqnV99JUTrdKIVPIoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdA2Pa90jiDCV0wK5kG0nxRTifu7TcfNb1QxT55yStEz561UezvhqqbuMSiHCudYVTbQR5X23pj3FBJGgcd7VSQkVGHtK8SUreO9kqA83dkyIi4PxVPs3GxIK6VM097cinWM3xiw22ch7PRGtWTh7zeWKZH2umkhsprVpu59N0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Py+gop+I; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Py+gop+I"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so7733715e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551238; x=1787156038; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QBxDFwerGNp3kLgXxOLNRiwJfs3Kv7+f/0VlNLh+Dd8=;
        b=Py+gop+IqHITx1nP7zeaHfWl1Q0Mvx89/H1KnufPwrHb0uCWEZx4IzSgWEcynH5JnN
         7j1amBtF2ViNCi6e/RImqmSLINgETsPi1Pir1JCxhFfYc+vZPsAfAsR9ic0qbWMcXrNB
         Sb1W5sbG3gmuhCYn4I1kyRIxAtPsyPbtSVD9tjC1UMPcIsQa95ZXxHMVg64StxZOgGs7
         Et8dQi1njNJ2HYHd6xOi57d7hJb/3RvwNg2rR9DkwhTHZsKA7o7g81eCRDVD/Cq0HSb9
         CMM206DnzEmL57AgmcV7JRBwozJfFOs9m238NIkhwziHt1Ybt61WqYEVkEZXkYKtmrOU
         t2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551238; x=1787156038;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBxDFwerGNp3kLgXxOLNRiwJfs3Kv7+f/0VlNLh+Dd8=;
        b=Pm0uX+Ojg+OqKyBGBlRrq8cnxG/dV8M8+SRtETyo3Wow6U+Icymz/1M9JszIetP4/b
         3qxdRY+l5zoUfMJgFIlz7kWOadNsXCi2/zrmmsb0Ez+Ot19pUwVKXbRq5M/DOvhTXMFv
         DX/RdIHnPf59PhyIZ2o89WgZK6jRn6IkaxR0Fie672cyD/hT1QUHCTE+xoncRBPjHlFh
         tBTcHppZ5n+y3crK5+yo93B6CbjH6lLcQNykE4FsASzn9QrrjSjVXHjVhWNzHtuABi2z
         Q/J/ZKdbLoxQSlkZz6ZOqXuAvfsnASGWLcmeqM6ZkpYN6P9CX+GbTMoLUiHcSuemJVG2
         SFhg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4W4ArznYrnMq/jE/tBQimO1gy1yD5zm6DcSJrlkrYRNM101pg4MtstSig7fynFGKOpw0gCWqhPhXgDu/2oD7szyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/B0ukSaa+nYnzB3WCxUQct5OjkadZGzolwl9nbYUBb1calPM
	agGkIOS3k4kcWMj6XNuTfVM0RscaluVVAcLbuFTVcWXnJGsCmQ5ZhOMSem5mW/P+cBlhRsxE4PT
	DjrqAPeqD6LOFt5KZEFtBmw==
X-Received: from wmxa7-n1.prod.google.com ([2002:a05:600d:6447:10b0:492:4a70:b7a6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524c:b0:499:7219:122f with SMTP id 5b1f17b1804b1-4997c39ca1emr75089885e9.4.1786551237541;
 Wed, 12 Aug 2026 09:13:57 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:34 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-13-vdonnefort@google.com>
Subject: [PATCH v5 12/18] ring-buffer: Add kerneldoc for ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Document ring_buffer_poll_remote().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 77561f90d0e4..290c5958c053 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6851,6 +6851,17 @@ int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu)
 	return 0;
 }
 
+/**
+ * ring_buffer_poll_remote - poll a remote ring buffer for new data
+ * @buffer: The ring buffer
+ * @cpu: The CPU buffer to poll (or RING_BUFFER_ALL_CPUS)
+ *
+ * This function polls the specified remote CPU buffer (or all of them)
+ * by reading its meta page to update the local reader's view. If new
+ * entries are detected, it triggers wakeups for any waiting readers.
+ * Returns:
+ *  0 on success, or -EINVAL if the CPU is not in the buffer's cpumask.
+ */
 int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-- 
2.55.0.691.gc56d675ccc-goog

