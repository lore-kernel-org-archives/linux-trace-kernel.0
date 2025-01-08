Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAF1F9EAC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jan 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336772; cv=none; b=lRXZIfYeunT0xuS90YeEUvj19fwCxoRWzsKjbpSfPlPppNDAHi1TPKzZ/6Xbyo+tvlmYLEyWHMVYsBBTq3sBo63RSIcd7OqJGi5IQ/HcELHyApOuhC9xx6PUUIibupNzAP+HlC71abn5ADAyQLtzfD42ic+SSPLGhX1lwGjJnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336772; c=relaxed/simple;
	bh=99RxVF8AfFvewf/cOdPqL4Drw3x5C4hmfCSpLeCPtKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P8Pi9X2hyrXD8XMNY29Cm0mtCavN3XK2ux7eEuxxwRclYjWF+BS3KJdY2InnYCHS3jLbJC/XwW8LWqwAEBBUrnxn+/dCcIYw4Rv51rscokm65y6q09+AckUddVrq4+TqEYdjl4eyIzoaXIXbRb/BFMVXQwQj9UMXDNPB52PGcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mopScKFP; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mopScKFP"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38a2140a400so10240335f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jan 2025 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736336769; x=1736941569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgqmOH6a98TkR8jot/1TlGkful6kxHKFlf+7ityvX30=;
        b=mopScKFPPsFrLj2e8q3xlTzfSoNCBBosrSFQXlfPL+DHOLZ/tITfWJv2XFv7Zc2qOI
         siELXBjnT/aopTmd6eNCYLzJNZl1u2UAgRnMngw2D1sy4e2hZQqeLa6phvkNxTcedRqO
         9PFP77eA8TY3OX3+pjLQvyAtjZBVNNnXjGQ2tjFIeUKou8mgorGCf1SHZjD0wbZTWWYS
         CqovBtxx/g3qqW6ijvjIlavywtiAEdMOvBeEJdwYdDAbZH+iJU90HMRPCZa7RvjdDPZa
         BLcrFSNK/JAZvhY6jV5zU9PTT+0t7v6QnkEcOhDZeij3DEcmIBfoISi17Ue9Q7hFvy+o
         TeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336769; x=1736941569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgqmOH6a98TkR8jot/1TlGkful6kxHKFlf+7ityvX30=;
        b=wd8MdvOw6CXiO8JvXJDmcfqI1B8qKwDvoULQbdQY9ojfLAVItXccjZu4VQtJO48qqF
         ZPAR/LjU9TlQoAg1W7IfQ7WAxStQ7A6Y6Mh10F2A8OZ2xbP7hYEM0Wz2+CuZce0Z99+G
         3shPXBWEV0Q1+3aYaXEJHpfDUZWXIUK3GP2za3J74uCJJX6vk3WrPzHEDj+Eb30+DS/p
         1cF9k6dN0tEGADQAzFkKe3E/YogSVvUlWqKpjlf3XJ8UEaSwrAHGSRxlQW5IuQqc45Po
         OL69H7r7vBC4Itk1ppLgAO8XxlpH9JgFhihMT9D2S943R89vnrcKlSqmtT8nL3RqehL8
         wnMw==
X-Forwarded-Encrypted: i=1; AJvYcCWVqPu7UcP/EEumKA/rmcfQdkKBqrKKOA8bURPjrbAPSzJSflzy15gDJTAkwQFUZx1+hrvUU7m7sQv5+eRJ4tUB+d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7i2E50v3QsTwbfkqwTpFqmkkjSyfBxEhSPQp4W7YoQEY9HdL
	0kKx+55EKxQvUmvrf4pCK0s1c0yN+bGk7EZJFySg9zZEqllrKbrZopQHLA2T+vA2iEcUTYCVHEF
	CsW945Am9zQ9q/khOWQ==
X-Google-Smtp-Source: AGHT+IHABYhHikttLpH7oYEhUoNKTD1qad9ksTQqIL4Ho8ntiowfjJExOtYJ50MZIueli5bhMxdFJKoQ2+rthSB6
X-Received: from wmbfl19.prod.google.com ([2002:a05:600c:b93:b0:436:16c6:831])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a89:b0:385:fc8c:24b6 with SMTP id ffacd0b85a97d-38a8730b2femr1999023f8f.27.1736336769590;
 Wed, 08 Jan 2025 03:46:09 -0800 (PST)
Date: Wed,  8 Jan 2025 11:45:28 +0000
In-Reply-To: <20250108114536.627715-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108114536.627715-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108114536.627715-5-vdonnefort@google.com>
Subject: [PATCH v2 04/12] KVM: arm64: Support unaligned fixmap in the nVHE hyp
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
index 8850b591d775..c5a9d8874eb2 100644
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
2.47.1.613.gc27f4b7a9f-goog

