Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89DE49F110
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261923; cv=none; b=l4GNoIBWqoTaqf0DPXgnX4ikgGqq5FAF9CE8R1idN/WxOQLp6cRlU8dYkulf44l6bEIbr7sS6VSBGh/vbLaeoEofk2dXEUgpwF/M7ZxYUvxqQdYth6zwSA4x8DV+vsPuNk24RwkFNfdl8dZdDVp+rHlTD77GZGBQrz4LNHqVrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261923; c=relaxed/simple;
	bh=29OEV1XRj92C0jmL9xqVACrPk1/1JdAX4Z/bbOoFKsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gQFSoEtMQRWT2AQ+GukJkkusJm2uzAyPeCCT7D6zPJD8B5IbkETlKe4Anp5sj7vFb43aexoNyT8PQQvqRzWpebv+1Hg3WXO7tdD7gmRqcGzpP+5Xo/vH3m7a4aiJo+y2VELsabIFaCmqkcGvXaNKo1kMb7DCIVbBIf8+SSPyJNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxPo8PUQ; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxPo8PUQ"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-487041c4c82so786386f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261919; x=1790866719; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rK/bC4txKuETskqWy3KUoq+SaTW39LjoZD3qIqTAvo=;
        b=vxPo8PUQo7VLn7zrm+rmJKXVfNvtQd4cpMA99DNWxu75AYSG6US3knq958/x4BYSc9
         6deD50Ro1auFA/VbhrZlonvm9lX3cjXKuiNVSQfV/tCPsf+J0gdx3U74LByoqetk6qDA
         ffdZ1Gag7coX48vYb2ivP6CFPIaijDZj25TY48O1nQHnbGFVnhkhutlNz2XYlyne5Ny9
         OFIkfcdLdDKyEib8xsz/eltA8XXkfVVRvwEcQLLOzP+bDL6FIKrwR/3gYeF2+BWHyq75
         Qoe+rKmy5J7/OPyzfefBso2n1SR2ynbc6jUjqLUm5soP6r/MbN1nHJrFEEEV32+5BBw1
         ne3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261919; x=1790866719;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rK/bC4txKuETskqWy3KUoq+SaTW39LjoZD3qIqTAvo=;
        b=WKcymCTdMcyHHbdOieaeGXb5ehSIuVXWzZQSKzbcz5HIoIRqy5FlIN6/5cWZXapyGF
         bDxtmuMQi5z+htJzSY/huUrMRYFHcnQph/j8LiF2+R7UkH6u192TKtfYY+mA05Pt9KFR
         VZnFNLWJdF85po8WijKAUJ+DSRGduOg5KIwx715eVpJWurg/fvuax2zqLmpdgsHXDGFz
         evMksc59A25KkjRCKF6qdtpV4TpOkieAiYVJim1pCuPnlFnklPDFvbF6SKT2rqeUTuEk
         X5y/blXVTlf6Qg+vtLUiV1K9gjYLEO7XfPBKahhrc5bKjEE13kmJkXqR36pEjFEBXvtq
         nuqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxtEqMbXbecz3/MH73NBLp3rLYFeS52WqIGNFZ0inrPb2I/8PC6KftPV6F2Yxq0XVSDkGg2iWTBP/Ur+zp4ulkYB7w=@vger.kernel.org
X-Gm-Message-State: AFuF++mCQZq9wR0O0KNLDKUy8xLvX9WK4QNc+UDG/s8eRPsrEkx3Up+M
	h+cGaDV++RHgTVYeXyDIDGW2yXFsYvxaD1ERkb4gMC3qMlqUYVixNAJOZ33hhi2yzKpG15udhFc
	f96JscftlLd7cbn4oBEk52Q==
X-Received: from wrbev3.prod.google.com ([2002:a05:6000:23c3:b0:488:614b:b574])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4108:b0:488:78e4:5e34 with SMTP id ffacd0b85a97d-48878e460c1mr853815f8f.9.1790261919207;
 Thu, 24 Sep 2026 07:58:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:48 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-15-vdonnefort@google.com>
Subject: [PATCH v7 14/20] ring-buffer: Add kerneldoc for ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Document ring_buffer_poll_remote().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index df16e05d7049..5dec079e28f1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6943,6 +6943,17 @@ int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu)
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
2.56.0.rc1.310.g51773c2048-goog

