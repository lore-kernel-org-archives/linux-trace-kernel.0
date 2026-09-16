Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101251D512
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572519; cv=none; b=Y9arjyyTa1WbdFTL9JlsVBxVnAPbJPdnvn7BYif/AWbSh5MUIl4UCmkArud30bEg8FI9Es7dgFTne8qDWvWlv6N8O0sbiEApSf5hL3j6xL1nahl6PhQVPK5BLG5P1g/PsSnyou/zDCLaaa2K0L02cPWyzPO6EEUvcqcPkZH5DEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572519; c=relaxed/simple;
	bh=seTCgIroPxqNkO9TjoG0CMQWVPklh/K3GHcYMoDJZ2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dJxWTDfZenbXWQFJG8LIo+ZadlonxHUlBx5cmKHWF4h0SQ9UKR6XfinrVsfiQWFn1b7QJ2zCXuM9KL3QdUjjW+2otspucFkHtnItDcdewIpDn+/rFKGqla2oP7aW8mMo8FYefRa8e96RDN/Q8FI3sQ5lDt51ruPF28u9EygIs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EfcRoDPB; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EfcRoDPB"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso48095945e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789572509; x=1790177309; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8XwdVS42p1CP6QnGtJO4ImFTQHL4GGRP2dYFUy8/Ek=;
        b=EfcRoDPBgkU1DqOwtjrWRuGk9TeIyus351PdZPJuQKmhOq6RyTA6FO7vvo4M5KrFjc
         hGPFQau/Mpv9bY5flzuWyWYNshG7CejZrlsSx/0KIQKxWL53wkCouOB8FaJsS1SHGNXC
         JmHzgZ+T7Y+VrRzEtki903LmNadrQHdagKiBd1rCzacqNFRGvjuWu6r+6hBxiWmyd7ME
         b+vSURzkoPR7R6Wr/wmaWYhcIBU8BK93g4XKGTsIk96qZPSLKO3UBJz8qZvTY04ivYN8
         iVZHYKDPr9IJsPIFxNlHkuj7AXLHynchQwvypkraIpdwQNmqrbERBTIkkZS4Y39hloQz
         5bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572509; x=1790177309;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8XwdVS42p1CP6QnGtJO4ImFTQHL4GGRP2dYFUy8/Ek=;
        b=0cDNa2ksgmzCab/w7jYpfrF6QKs6neZC0/FdjZhGOBkxCOHwGuCn4oq7o9OZ71HXMA
         XJ6C0+//7Q/yvkyWdEOYzWXAKyHjPs/FKITptg1RTwN5riLRTZqlYpO2jltTBdiNqmrL
         fprUdhLNYsHh8vp+Ic1zcoUN0visdmeL7EPvE5ev3DUK5KPkpLkGDd0Gu7TaD/70zHDf
         yZQa/joEKXXaJjP4I7vRKsi8dLcrq/dVfuAb786vtHpwFmturcTSSn2eoNOujAp99ImI
         KuGMshwlMAdi+CuOCXYlzhIBTePDTNsbJFn+psdOD//XXPJYotaMgf/buA0Yz4ytjsRX
         9/2A==
X-Forwarded-Encrypted: i=1; AKwUvBxjDvPeRdvwMjy9wFirB/enVzsm7DfFkC0PEaPAC6SAjPX+QJeQ07bqg++Rm5ml0ARo2tJNDIPd+iiT8KH1oXeLurs=@vger.kernel.org
X-Gm-Message-State: AFuF++lPcYjyxiiQ3A0Ctfw0FVeg5cbA6hzMOKZNpTFk1P523LFZqHSj
	AEhICokRbf+L+MaUEyMs6en8Qpygg33dIMxtM5KXvL2ChR7fqWYbVzH8bWnpObSHHUWBaZuqmb9
	BWqE+lkMir/3ISRlSFbY7/A==
X-Received: from wrdf7.prod.google.com ([2002:a5d:58e7:0:b0:486:f98c:60be])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34d6:b0:49c:fc6c:bdfa with SMTP id 5b1f17b1804b1-49eb7322c98mr36772795e9.17.1789572508661;
 Wed, 16 Sep 2026 08:28:28 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:28:13 +0100
In-Reply-To: <20260916152813.105082-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260916152813.105082-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916152813.105082-3-vdonnefort@google.com>
Subject: [PATCH v2 2/2] ring-buffer: Remove unnecessary cpumask_test_cpu
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, devnexen@gmail.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

for_each_buffer_cpu() already iterates over buffer->cpumask. Remove the
unnecessary cpumask_test_cpu() found in ring_buffer_subbuf_order_set().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 73311c4fc556..2087bbfd8f20 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7488,10 +7488,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 	/* Make sure all new buffers are allocated, before deleting the old ones */
 	for_each_buffer_cpu(buffer, cpu) {
-
-		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			continue;
-
 		cpu_buffer = buffer->buffers[cpu];
 
 		/* Update the number of pages to match the new size */
@@ -7522,9 +7518,6 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		struct list_head old_pages;
 		unsigned long flags;
 
-		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			continue;
-
 		cpu_buffer = buffer->buffers[cpu];
 
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-- 
2.55.0.1082.g2b9226bbc0-goog

