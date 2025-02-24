Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96879221F21
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399333; cv=none; b=YhUOUl6mVzobf0ltyGPM5t0D0EyIGXeK1b6xM7plyb4/O9fxgiGcjxEdPcCCTuW0fWlrrpMq0f4J/a81saS0dGvn7m0pOZCfAKHvoNXXJy1O4CaZkaLbhrglJ5L89AGrPZ1VgrIST0OpjGU7QY5CGsRekZVeFhye7l3yJ8rQqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399333; c=relaxed/simple;
	bh=F56QYlJoDZJ+5vN4/HPXUDdjBW0FdSUoL0+uYMqsb5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZYBAErKmD9d805i9O0TPn4FJXIP3ao81xcQYcGOFAgSlacAQe6GCyvSX/SxPFPu5KOlUwnotWuc9YOLIJ5EsbNqnH+scZBFVXuwlhRg5Wo3sZ283GDOAoh1v9rDdqjU9LxTxZqJYzH2Zwi97B7nme4JffMucHGOHfjZ9Flv2GZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPIBvpjD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPIBvpjD"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso33566215e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740399330; x=1741004130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=boWUnC75AglyvSxymfq6WOxHhiCHfMqe3a7p6Cadurk=;
        b=ZPIBvpjDq3QtbAkreD4aitJXkXfB8D9uAJP4PtnAd3Uwsxn22rg37KW2lcKFx0nMJV
         fOy23ntqrfOQ1wO9ccYouFfVSjlUw0nRoZ0IuOqS8aAI1JgLpU2ZpCQlqu+i38Jfxjc6
         ECrGNq0Awx9zLjy6ESP0S7Z+lI28S0X19/DUSsPjm7oaqwgPg+OPYsDin0Tz+sE+rcZl
         KYGRiKtmDNKxREd2RApItS89IULkzMZuBzDyRZ8ZEkdLZuwh/NUT4OSRxmDsquRJ3qsj
         1usNdKWnU1zxzzqrqrbd/H8CivceWlX2NdF0keazKApy8LGk2iGDfU+SgA7BQdj/WIqC
         /LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399330; x=1741004130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boWUnC75AglyvSxymfq6WOxHhiCHfMqe3a7p6Cadurk=;
        b=WPNgB/wGdk3+sTpZRfxRn9d8k42yqk1x/b8zj6aWI9elFp3tJTVtbhgoS0Krk41Qok
         dTqoyTggvlPUVByAgWPhqZbU0U4IAFPyc/M8WzV2WejXwTdzUGatMgoPQJR1yS4kVxd3
         QCsuvQf2g6TzUHdp2t1UVxo756SSgRJK3elJS3lM5GC846Tb/UAcnpvGwNrGGye85Qi2
         OrFa9Oc0Umoc0BcrpmCAe3KbFIHRlrUH7kqNgU/1XNwq9M4alGxj5VvSTHlxo73Epjh9
         F+YRVIC6dLd+BnZU1yjEqU0eIr9oc7A6loxqe6UGIeI2xCRDKBiutgE0uLVwYgn7YWuP
         G6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMhZK/Tar1MzTYq+Ms5BwRwkDCmRkjf5WlglZhD7LoMy1HZJ6aHMHuaoRFAEW9T7+KTNj2ZIqpohJmFQ31FD8IJzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjXwDMWQwyIN5RHFEzjTv+76lHgOXIEpc2xtW/WGn1gLZq3SD
	IMByqQgkOzGAcZFALSEVudu4apLuPEoJjTxwNswo4X54Q3qcUGeKqRfuj171WE1xOCKl5cZDVr+
	QEXTJ2YkRZY9BTRaI2Q==
X-Google-Smtp-Source: AGHT+IEZCk3oy+HQSHrsEDAqwXlupd0xHmeS8IuL0N9dhMMAdmGlo9OyR+iiK51V+OKl7+wJfLEr+VwrJuInfXQr
X-Received: from wmbjg14.prod.google.com ([2002:a05:600c:a00e:b0:439:4366:35c2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f88:b0:439:96aa:e502 with SMTP id 5b1f17b1804b1-439ae1e6a2fmr119293615e9.12.1740399330189;
 Mon, 24 Feb 2025 04:15:30 -0800 (PST)
Date: Mon, 24 Feb 2025 12:13:45 +0000
In-Reply-To: <20250224121353.98697-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224121353.98697-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224121353.98697-4-vdonnefort@google.com>
Subject: [PATCH 03/11] KVM: arm64: Support unaligned fixmap in the nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Return the fixmap VA with the page offset, instead of the page base
address.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index f41c7440b34b..720cc3b36596 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -240,7 +240,7 @@ void *hyp_fixmap_map(phys_addr_t phys)
 	WRITE_ONCE(*ptep, pte);
 	dsb(ishst);
 
-	return (void *)slot->addr;
+	return (void *)slot->addr + offset_in_page(phys);
 }
 
 static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
-- 
2.48.1.601.g30ceb7b040-goog

