Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500F286405
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209503; cv=none; b=tV4gnEnEde4R5HhxKuwBULruetEc9NPBpZ9BGKP0l6KZ2NOODyuBbmRegC9QhpP6Po9SfNc7PANoIi7ArviOWfo5cE9OfeBixGPwGS5bi+Et7fVcB7hj20smdqsWX51Em0Z3zM+HZ4qnaXYaE9dpNCIjRpY56qLW9Vxbo8Aufxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209503; c=relaxed/simple;
	bh=CK9ErZBiD4WbSjoP6dPPZiO+HSMuXXD+AAWXKTLTz/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYHa4EIznXHyx/A1FKJerM8Zh+ofSKw+UrsqOdMPTbtFwZek8D8glwMCk9PwwpbfGpXE3kvE74vv/nKWavU+D4NAzZtjX+vAMBkZyms91/R+3g+iTq0NgMMOcF0KQPvueln6KxvbK4jH+BQ0Kv+aMGwnq66OselbrSChXVMh7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Rjq+PDlF; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Rjq+PDlF"
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id 5C89E64C11
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 14:23:28 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1a98:0:640:f7e1:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 4313342B22;
	Fri,  6 Jun 2025 14:23:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id INckSg8Lf8c0-Ip6tNkb7;
	Fri, 06 Jun 2025 14:23:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1749208999; bh=ZHXXDinMriG9HGmHZ2+a97EYaRixwAl1loGpR0gF38E=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Rjq+PDlFf0blwhBXvhkaY2BlwhZMofVmsGVg56eeF526pGRWhc3fJFwYYJykkHPNH
	 D5NPOCYsfaUrbzB2xamf8qOp1tmoZroi12pOtJUVHlf/nCmpvCay/cszQpC6xby+2B
	 x+q3QqhSoZ1L3R5wfpaVWRLL0UklKNDmHFXJ2wYA=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
Subject: [PATCH v2] ring-buffer: fix buffer locking in ring_buffer_subbuf_order_set()
Date: Fri,  6 Jun 2025 14:22:42 +0300
Message-ID: <20250606112242.1510605-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606065124.07857968@gandalf.local.home>
References: <20250606065124.07857968@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ring_buffer_subbuf_order_set()', prefer mutex guard over explicit
mutex operations to ensure that the buffer remains locked everywhere
where its innards may be changed, thus preventing per-CPU sub-buffer
lists corruptions and other concurrency-related issues.

Reported-by: syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=05d673e83ec640f0ced9
Fixes: f9b94daa542a8 ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: use mutex guard as suggested by Steven
---
 kernel/trace/ring_buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e24509bd0af5..00fc38d70e86 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6795,7 +6795,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	old_size = buffer->subbuf_size;
 
 	/* prevent another thread from changing buffer sizes */
-	mutex_lock(&buffer->mutex);
+	guard(mutex)(&buffer->mutex);
 	atomic_inc(&buffer->record_disabled);
 
 	/* Make sure all commits have finished */
@@ -6900,7 +6900,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	atomic_dec(&buffer->record_disabled);
-	mutex_unlock(&buffer->mutex);
 
 	return 0;
 
@@ -6909,7 +6908,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	buffer->subbuf_size = old_size;
 
 	atomic_dec(&buffer->record_disabled);
-	mutex_unlock(&buffer->mutex);
 
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
-- 
2.49.0

