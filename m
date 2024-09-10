Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD51991BA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979416; cv=none; b=eX4AaLS/lZGFwSVsMYc8Ut0T26o9FjUv5OsrkLWMnF1lF4O7C3tGl2aN1uesayOj1WWC7QnrV0nvd/sGDzouRJFoOho8/YZOL14yKjEAainJWdFlk60yPCSKnAtfG3Rj8/rZioboQaxYCk5Eq6EjFf7TdanmokXBmVAUPvWX5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979416; c=relaxed/simple;
	bh=RCYNMX+Z82k7jT8P9aVLzBPdg0xNoEXKxXILyWfK5NU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ki8tRYlsAMkNnGbL5dAQFAqfDu/jZTdtmcuSfU9WMau82Q3PkKpDHWy+jsz6xklFNkA7UCPNcOEMWpja3J7JYXAkKOzafNqNa3RkCe6GTLVGgVB+OjXspI0rgNy9pPblSmCw4BlfcWD7j1gKfx4cVOxqMRkZLrriAO4NI5OOGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JD+Zoa1k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JD+Zoa1k"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a7fd2eb36so11787516276.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725979413; x=1726584213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibGrxbI73RSG7FymEJkxpWaZzraxcmdDkoe0B6DLosk=;
        b=JD+Zoa1kZGBtTJ5I34i53+O38jEpj9H4Cho009tKwZ0RVXdcJZw9oRpwmit8N61xOD
         iV9rAO7YcyfBgkkH1ElQguXICnuSHgs9bF0tMPnmAlk6+Ht8LDHWFupw0exW3psxisbh
         8+TAj8O7EJHqq9Yg7cXanseT/h2P256D8RdKNoyfp6betYr653+Htu6Uls+7TiXRzfnM
         TTPbuLiTcfNgbJmwawVjmVlLKfAq7Cz4ArWVj1rQFwnZu3Ccnz8o+KBfDw38To81SE/M
         lh0g6mofPeeyopfg7lW6K5E6o2QDpKwfecndOMnxW2sU3hAlYHjqfgJ/ap5V55PM1eCX
         p4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979413; x=1726584213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibGrxbI73RSG7FymEJkxpWaZzraxcmdDkoe0B6DLosk=;
        b=XxlKtqejU7oxfGv83WZWDAqicI0o/c1qyfcJB2IsNgVWNHw7bWAT/7qmCmVBUJbw33
         x59L6FZqxgbOBEUU70C6rgE2gnuNv1+o4gbfDwNDXDLb8V4glezNMYoTdZS0VXye9g91
         fEACNqGtvVb+t+ABvqQJ/kOduOaJlTCAoabYHRd2VXCvGWHtdvZ+zNUasLIF6JlDxsfC
         rHwA+GcWOyjMvnOiDIGlJHO5KzRLeaaCiXVDUwLdNVeaIQ+c+cGQoFCZ/E2tTvoYRKQg
         9egtTQktVUXKWBIncy8CUWPsYOC+KnaQh5YQVOOovI//7gwmbeWX6ENw0YNS5G/Y94sm
         Wr2w==
X-Forwarded-Encrypted: i=1; AJvYcCUmgJBDc3NGYMFvqRqv0OkJZoes53lPafET11q53u4wE1EkbswzeE5Ivlpr3C1tFGG9naZdKD/YrfP+wWracydsRao=@vger.kernel.org
X-Gm-Message-State: AOJu0YylmTk3nhE1Ei6wXym2VX9VijJzRoQaWlDqWsZqrocyXHdIHKgB
	8W2nyERHq9Dw6gkkB70qp/uk36brZRqq4e2MjyAb7y00WK5yz4+61mAUu7nmf+JXNd8HmZ6ATaS
	G7RFk7tM6wm5PBbTQ2Q==
X-Google-Smtp-Source: AGHT+IGdkBcgxj1v76lEXm1qHQFt8PCW2R7aktqiJJOVwd8mY500hT8WuV7t+zl/Z2FKmxK4Z05XV8G5B5zlvqpI
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a25:5f08:0:b0:e0b:f1fd:1375 with SMTP
 id 3f1490d57ef6-e1d34a1fb19mr22434276.10.1725979413374; Tue, 10 Sep 2024
 07:43:33 -0700 (PDT)
Date: Tue, 10 Sep 2024 15:43:23 +0100
In-Reply-To: <20240910144323.2888480-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240910144323.2888480-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910144323.2888480-3-vdonnefort@google.com>
Subject: [PATCH 2/2] ring-buffer/selftest: Handle meta-page bigger than the system
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Handle the case where the meta-page content is bigger than the system
page-size. This prepares the ground for extending features covered by
the meta-page.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
index ba12fd31de87..d10a847130fb 100644
--- a/tools/testing/selftests/ring-buffer/map_test.c
+++ b/tools/testing/selftests/ring-buffer/map_test.c
@@ -92,12 +92,22 @@ int tracefs_cpu_map(struct tracefs_cpu_map_desc *desc, int cpu)
 	if (desc->cpu_fd < 0)
 		return -ENODEV;
 
+again:
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, desc->cpu_fd, 0);
 	if (map == MAP_FAILED)
 		return -errno;
 
 	desc->meta = (struct trace_buffer_meta *)map;
 
+	/* the meta-page is bigger than the original mapping */
+	if (page_size < desc->meta->meta_struct_len) {
+		int meta_page_size = desc->meta->meta_page_size;
+
+		munmap(desc->meta, page_size);
+		page_size = meta_page_size;
+		goto again;
+	}
+
 	return 0;
 }
 
-- 
2.46.0.598.g6f2099f65c-goog

