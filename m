Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E54334B0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786548821; cv=none; b=e1HvZXQ6YqqjTdnn/EsK3FtnSOApkn8g2kGGzXfYaTrR8nsyHWRKkSSNXDTx2drLJKxtrV0WTfMxQbgJmKHg5GE2Jk9GXN5avdSZhxqZ6LYsv+hHfqqfcHuE5LaUB9dRx2x8ZYvPRv8A+JN7jmb4rDSrH3eN64O/pMfggI31pTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786548821; c=relaxed/simple;
	bh=MshSAdzlkn4ap22AVygvjx0jv1ySj3uhv1qD48JSN/A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FdR/FIoXRXBIRKJ5FNFveNZqNN1v1/PXlGnZMcHOP39XMXWhhnNOJoX0fxCMcB1g+asFTnNuRP5q4le2nu0TGB9q3tb1JT8rc+2h2LDzWorjabicKDhX95mS8RdbHtEDuK8kUwM5hguGWMdFR5b9qaJqDcpdw9+ord26wHYXG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBrJLiS+; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBrJLiS+"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so8709785e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786548811; x=1787153611; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ+oGpfrYdP0u5dy7mXQ7HlJ9v4mKCq4nCtAk0vOwG8=;
        b=YBrJLiS+kfOvqfHFrg3TsduISAs+eLb0foc2K/bZrZbX/00k/aFcNppx6C8djtLVen
         chJTP09C4omu4/+xYCTXGQGtwlmdL2ixL7ESlfo5dtzpUFUJEBWNyDF3+eeiDA0YVfIu
         kIIZKlE3lFTDA0RcXX9Cy3lbNFhgQkse9tu1PfhpA2FZ+nv5Lv3nXE/cxxjew3XdGqH9
         8Hb0SIjHvGEHZ2h1+iziXVLf9EjZUrLYLotiZ+HIzTFtzijK/GWjt3ue+lL+llhTAsfc
         xQhRSAJZoLkziy1C2M4PHr9+wUQS0j5bkFJSZLI73cUBivpXoUpLOrsTPOan2xPY2Kd4
         NP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786548811; x=1787153611;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZ+oGpfrYdP0u5dy7mXQ7HlJ9v4mKCq4nCtAk0vOwG8=;
        b=SAqdIUimFCpL8tgJ+AAUp9HksLHvFqBBdMlbN3KxxVEVFVjkWoro9GRpAAOH07EeKD
         UQ/D6WQVU6U4/XP5rU28o1+y4tUg4/AF80LLxEPjXA8Mw2+znIE3p+PyhEMSzuwzMLtd
         PgaW9/Pk6y1v4sCsNawp+twmdE2yrSEBe7JuIwF1hMKKduQu7uZ6Z+14Zlql/Yc1On7q
         5LRV4IFFtbW4xG36kBgPmAOc6pFFK89StOL3nWkCik5JFQkaDIf3uWUsRB7n/fMBXl+B
         qn0v+AAwXflSM11w/K+9/5ToL5WtGq/LlcODKgppiZoD3ffAvnl7y+JdG8G0MfmqknWp
         zpSw==
X-Forwarded-Encrypted: i=1; AHgh+RoWHYYT2AxN/tibBxKQqyr8Y0dL3fqiKKF9kR6CB5+j9IAhvPvC3Cq8DweT74oqDRsQC6FZ+vUdmHFO15O2d9AT/fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oMzmCCo6JFoUrFXhsWio05si6Lg21WfwosOon8Oh/oY+DV7T
	63FJmFz3vJzQ4+sHRfoDUzJ+i5k4uuo2JIDdhgX15nNFafEuJFIuUZhWmIHvq/fyuqxgKzVpMJ3
	p00fVjC8g5KR3whC5HpRnsg==
X-Received: from wmi18.prod.google.com ([2002:a05:600c:212:b0:495:6708:efe5])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b17:b0:497:ff73:68d5 with SMTP id 5b1f17b1804b1-4997bf7d7ffmr73532505e9.0.1786548811300;
 Wed, 12 Aug 2026 08:33:31 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:33:05 +0100
In-Reply-To: <20260812153311.2328812-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812153311.2328812-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812153311.2328812-5-vdonnefort@google.com>
Subject: [PATCH v4 4/9] ring-buffer: Fix subbuf resize race in ring_buffer_alloc_read_page()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

ring_buffer_alloc_read_page() is racy with ring_buffer_subbuf_order_set,
it can allocate a reader page with an outdated order. This isn't a big
issue, the user can still re-allocate a new reader page and try again.

However, what is more problematic is if the value of subbuf_order
changes in the middle of ring_buffer_alloc_read_page(). In that case,
bpage->order might not match the actual allocated memory.

Use bpage->order for the allocation to prevent this race.

Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 97449423d3a6..94552a433228 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7018,7 +7018,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data) {
 		rb_init_data_page(bpage->data);
 	} else {
-		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
+		bpage->data = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->data) {
 			kfree(bpage);
 			return ERR_PTR(-ENOMEM);
-- 
2.55.0.691.gc56d675ccc-goog

