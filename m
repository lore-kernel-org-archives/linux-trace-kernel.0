Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D2612D7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460599; cv=none; b=NWX/eCPnZmvno6Ey0nXNhbZewVVzf9GYfDLWvLLcuXhHrrj3R+GVUwdJfKpsFgobRMeLuWe194ksVahQaifxtEdxXfm5WK2aKLi7r6FMe5Nd+BQCjDk+txJktPvOQzHL63m7nOPzPAcSkjepC0zIgPc0UQQGkAqTDgyeiKGJdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460599; c=relaxed/simple;
	bh=okSYdCoqtYalJqTVBXSYlec5NVTxMVA7/+jsV6YNCNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJT7qL80t40dLerqPeP1IsFUpqeKQ0LuMSlW6NM0lFxMTsQ+iK7T7w7zQ+uyJsYGTEBu2U8TBpN+POgNQG8zrBDO8DOLrBBwbrZLXFIYwI3R310QWTxeOC9jVdPlJ6WFjrese2r4qw7iCaxxA3nmdvBHA1pF00/56TEwafW+auY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XCe6XRjN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XCe6XRjN"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso12311594276.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708460597; x=1709065397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2evzm3HI5GwNbxXWo5kB/PowbSsdEjz5X/q5vGufRc=;
        b=XCe6XRjNKl6p6D+QtnVQ1fd7smNuNNF4gBbip7rGWdP1a9Zwnxyxrd1pYVihv84RY9
         WabywR95mB+MegEgdXAnDXr68KTYX1cqytlQb7wrnLOLVGuu2kqszQpbhTqqn1cIP/gC
         d9Z72cSndzBGxmybUSkSBj0iZXd3pLfFhZ+Xqiyp2J9KCelQXOJymKmMr0PVBZdQsXHX
         b+WskpkM1w1+CPsfhPajAZux0PI+FhOhO1WHZDlJ4Z9XT6lMcHxmK6YShuJe9FiMvtA9
         EzuHCIyvpCTAMSnwjSIA1xUEz5rxDYnp+tx2OeAoW0w8YrhqLeAjLOKa7TU+znrT/IcW
         pfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708460597; x=1709065397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2evzm3HI5GwNbxXWo5kB/PowbSsdEjz5X/q5vGufRc=;
        b=hcQKHMl9hGT8cQOh9ERR6hEpKmOHYb/ZCWTMQeuJtLLYVdVpYfICFJh46ttj7ilNxd
         HORbWkZBG+5seACzeTySBQb4UdXHUp7/WpuycB2dmzG8nZ52lpUkWmHNM6fem+7VeQkB
         bmitpZ+nmKsZFcd3kYz9uwSLRwG+BIA48Kh7WTEap3uHEkMdCnpHVyXFeXjm7NF6/iOC
         JTKOFbwB0uhUQoHX0WhmuODXBMvOP4uddUzFSODKqRg/n445HTvdpNAGtAtoozI3DgwB
         9ia1iUVPaMfz/ibe7E053WdmFFHBb59q2RoaSBVJ1FYgG9A/Me5OvquQzUVfE5NhS6Aj
         usag==
X-Forwarded-Encrypted: i=1; AJvYcCUSrLYI1VdE5g1lho2ZOPlucum0HlKrhSBkn50XwqM7a1Tb9Yaoytuylz/CikdGyUUkuJyGB5a3joo/wGh8PwgeY6bNDfX5FQqKI+hjSE1fvXDh
X-Gm-Message-State: AOJu0YwgMRqKqh/ReOy6MamQ0pwzUW0lq5WgNhaMn1ngD3rq/qufPHtB
	YgcHtNzBwMy0xbLIW7IZ5NZ4qAkirAqh+TmvMDgVxW/5hXSHur4XQk/qoNw2mIKVohHIBQPKlXL
	CyvoM1qjsH6tin1rpbA==
X-Google-Smtp-Source: AGHT+IF9l0VKWnBaSreNF7S4sqi6G/8kgHmMrShHsp5wOZWAOcrtrpo0Vk2Q23Wkc3CzfLSQ6ShF4bsT3GENMm1y
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6902:2188:b0:dc7:6efe:1aab with
 SMTP id dl8-20020a056902218800b00dc76efe1aabmr4730294ybb.6.1708460597013;
 Tue, 20 Feb 2024 12:23:17 -0800 (PST)
Date: Tue, 20 Feb 2024 20:23:05 +0000
In-Reply-To: <20240220202310.2489614-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240220202310.2489614-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220202310.2489614-2-vdonnefort@google.com>
Subject: [PATCH v18 1/6] ring-buffer: Zero ring-buffer sub-buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping where each subbuf will
be accessible to user-space, zero all the page allocations.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4bfe3ecf01..ca796675c0a1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1472,7 +1472,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 		list_add(&bpage->list, pages);
 
-		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
+		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
+					mflags | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1557,7 +1558,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
 	bpage->page = page_address(page);
@@ -5525,7 +5527,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data)
 		goto out;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
+	page = alloc_pages_node(cpu_to_node(cpu),
+				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.44.0.rc0.258.g7320e95886-goog

