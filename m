Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35733DBD62
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677593; cv=none; b=MKCO7tfxWUPEDbvbSXN9M751oHyFmCuSuonA7F/e4axoAQUk/xxO1d6nlm2NoOn11klILGSZh1iJk4Wk9jm9BFXXZqRtAhVadBlgz+UWnrBVJfm9BYye+JJHlGUzAoxch0GXCAgzNcYU4crGys5XPWQV7Dw1bRx+8RXN3KrttBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677593; c=relaxed/simple;
	bh=2D3pUv2l8rGNI6WlCo73pimcp3TrabhpvPl3mzbF3n0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e79dtfH7GjA2j4SmxmJKYkVOkgVFb1mJ9ySvv3oR7U1v13ZW1L/TQphyAhUlMEm/P31zd3e8lkXdp3u3JZTiHIn/aGINHvsrIQ0+l3cb7cBChBI6YzhZXI2Vkurs8cgmmIoycV4DevTYFbajlBFPdK6UQsHMWDayI9uftAWp71s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCpSazb9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCpSazb9"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a786f987so26089515e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677588; x=1781282388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rkv5u4AuTLR0uMy1FcbSJ0ntbAOQzhFhsaCwkVPYqrU=;
        b=GCpSazb9QHjU8jocpwGzPENnimlCR0SLejkZZfc3jikf/SqtXxS9IXJFqjpjuQs0+p
         AwCNedlvofQfkVLhRGCR7jIoS9P8D0f8lhSSZieAWh5oREl/Fd+OTXolx9q6SSZAxdOt
         m9mtS9EQSSJyzgLCkkXZX5VebSymeOehCn7gflsjusEksBxeTN0sdFmDGHOnrhyWZKVR
         +o/ZnO/S7YunTdY3NR9jw4eKqJiPtvZFBeBlTmYUENJUlTvCsuRzbZ3HUrghJEKDvD9D
         WceePoBhj8cOeEb/oE62gLAuaq0qPB+2HEOiLloWGBAUN+U3fSKz/szkY/3Uuc08pm2n
         wP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677588; x=1781282388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rkv5u4AuTLR0uMy1FcbSJ0ntbAOQzhFhsaCwkVPYqrU=;
        b=sE/18pDewSSjXwbbi9jGuoHB/T90e2a9uikrz5oVQsUfHfqD8EiJRkR1/ewDoLUzBg
         N+J4XSApKiqSDQDQu8rQNDCQElRI/ebDdCPBaIxje0kyr4FDc2xZX0vRFJl9UWIxTMfk
         RBP0t9mv/oB8R8y11Rn1b4TJDiw8Trr4AXKU51cc8YflmdVMwKu94Ch94ksD1JeE7gCy
         3Kfaqz9OrWJmc5nvHfE1qJpaVOWL/j+H6XEfiR7Lf0ySuXazSbDBgf91Qvx5FmJB0Qss
         cvG7RRB4UGFHW8Ean6MvmU5ouYwr5YCFifnCxVVK9ic9/IRljOy2RnYS34ShUKxvkTEj
         SLJg==
X-Forwarded-Encrypted: i=1; AFNElJ+jZFfxorCKC/cikwipgPbNlzeF+RvpTDuuH244hhV2XEeN7MIySLotFdNiOQpRWXGve2ANDQVnD0BVPC0he/mwPzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+qE2/MHLwn4jj0l0CM3DQYgOOnxM3aRj+Ij0W5GBZbM2DkAg
	qO86P12p6z6llV4GlJqSEnYjN1OTdLkcQkhVt11z7RWUav2rfcHHp8xF257epO0kVuCudXx/f4o
	w6BISYVra5D/aY7WCZ1bXOQ==
X-Received: from wmjq15.prod.google.com ([2002:a7b:ce8f:0:b0:490:7e29:9cea])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5020:b0:48f:e230:d5ab with SMTP id 5b1f17b1804b1-490c260f495mr73062745e9.31.1780677588228;
 Fri, 05 Jun 2026 09:39:48 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:19 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-13-vdonnefort@google.com>
Subject: [PATCH v2 12/18] ring-buffer: Add kerneldoc for ring_buffer_poll_remote
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Document ring_buffer_poll_remote().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index efae14e3ba80..2f99f77a039b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6676,6 +6676,17 @@ int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu)
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
2.54.0.1032.g2f8565e1d1-goog

