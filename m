Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC21A5BA9
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201504; cv=none; b=rBl31S3igehIi8AaW67P+RdUmGriM58IcNb/WgRSu687o6DIdM46DQ1nnLQenmpmucYY4MfEG/lkPsjn0yF/sRsyr+S2GiH7jAVApZfWn/CEyxnHGGwSIi0vgU6+718dd3dEufWixfxg7lB9HmEF22aDs3izhT/eTReENkdwst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201504; c=relaxed/simple;
	bh=BoQZtvX3bZoXXg2uV+ad+XML7n+oP6VMU/XCxcimOec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsIbObTZOBhSm0vNJlpcXZF2PJz5FBH3D4Q2Us1i4PSsChO0xbZahvYl+BXCQLbwMsRAIpWx5kGBQk07GZtzR+jgykj6o09UZ22Kjgw4Y5JK6xgOrytR+xzIHvH6/s4/Oi3bO4eE98IqMB9a5g/gKHF8M1V5BMPqQmm43qEyf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=tFWiEOxc; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tFWiEOxc"
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id ADB4D6440C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Jun 2025 12:12:27 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:644d:0:640:2ef6:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 52A1060AC0;
	Fri,  6 Jun 2025 12:12:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ICaDjTkLZ0U0-fQXNwwfx;
	Fri, 06 Jun 2025 12:12:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1749201139; bh=yRuRawRgo2kd+HlIxkTQTcSrwLVPuDOG6TwJMxfLjAw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=tFWiEOxcxxtdzCUBiFDphM94jZkU+jVnsNTZBjaiBQpR61rGTN5TdHBlbvr3SS9jw
	 zAfKyigATRBQUeBXpfM4OM0j356UbQTnaBsH/AYgJazkTCY5VHZsOOeLSKjLlTqhR6
	 yvKNuP+sVJKOkUCQm1OLc/YA11wszuiHdzBHPbk8=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
Subject: [PATCH] ring-buffer: fix error handling in ring_buffer_subbuf_order_set()
Date: Fri,  6 Jun 2025 12:12:17 +0300
Message-ID: <20250606091217.1506673-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ring_buffer_subbuf_order_set()', enlarge critical section to
ensure that error handling takes place with per-buffer mutex hold,
thus preventing list corruption and other concurrency-related issues.

Reported-by: syzbot+05d673e83ec640f0ced9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=05d673e83ec640f0ced9
Fixes: f9b94daa542a8 ("ring-buffer: Set new size of the ring buffer sub page")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 kernel/trace/ring_buffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e24509bd0af5..2028a24d6418 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6908,9 +6908,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	buffer->subbuf_order = old_order;
 	buffer->subbuf_size = old_size;
 
-	atomic_dec(&buffer->record_disabled);
-	mutex_unlock(&buffer->mutex);
-
 	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
@@ -6923,6 +6920,9 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		}
 	}
 
+	atomic_dec(&buffer->record_disabled);
+	mutex_unlock(&buffer->mutex);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
-- 
2.49.0

