Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583654;
	b=lZYvNMJcT1EOF69Xbig0ig7CknfUYVdxxtKqJohrQx8ZosLnR8FZ4AOIibeJrRO/2tlf
	 khsGzUPWY9i1Fm5iGQXXTO3GQy9t7lqEsNI+PQ/r/6rLUEvUGIMLg18K+Bm9SCsLmofW3
	 MXSJnuRy2XqomD4zx4AvJ+HsqjyOpq1Hwni/sVOz1gWOaedtgbWcCOMTRtbH7pa0Gpm4m
	 e5Hhn0RY/vMOkIN0958tL2YpdQtliP952fgpldxgAjQBO57WOffWOIYbA5Y+cgkMaQpu9
	 7AsDwdnPTO+p+HxSTC6qQ8A5WBOC+KZHZ51bFPou1ya566ZT+Va12elCbe86jT4qOdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Kb6BNBHWUZprPI1vwsmUapLJRh7sJ5t4OJsDs7YS7EQ=;
	b=U+TywjDXOIlqwBGdHBlTiBJV/Zsst0+itFJW/cFHPwhcJZFC5cyZOGKqu/H29/VrtPc7
	 JGKSTDVfOS0M4kfSfzqX2jEzB9Jg6GMAyKYEn5Wz5trM1vx9y3TYzNUJ4jD2tpOoeV/fu
	 SCIz2GhfInSzsABlW4NR47OkvOLxQcR8yxRcqm/s77+Ldp675uqaZdWMJAzLMHdytZLv9
	 pZYNyZ94xkE8H8Hb3IPgJHyo5T0dbeJPVwVWQvvjTHlfSo53WmlgZYmVFXr5XSxhTcAgU
	 DVSwDwY0reuo9TTFymXqk6RX6K3Ta41Ta7ePav3JVxU1CBUHF0Tj6C9Dmpt7F7yUX0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QOzMZnPV;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF94606A333
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 15:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF94606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QOzMZnPV
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b56a350f2aso1376942a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583652; x=1795188452; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kb6BNBHWUZprPI1vwsmUapLJRh7sJ5t4OJsDs7YS7EQ=;
        b=QOzMZnPVto8tgdXcMbvPKEhrJUGqQbsXRc7uAdZ+tx0cvxcmT1cuJCd7iVsAodAN7I
         wUP69KTYU+WcrQycjo4OiMGFAuNNTJA2ACmhz5FVbOCdhl2ItdvYbZENmxS5Mknz6QN7
         odB0LC/3drK4ReNgAwDGidlLv2C6q+cwi37HFigDF9fjRtSXoDNERz+bsyr/9xIJcxRj
         rnZ8QstDHWA5+HsG4otQIoWpOqrlEU3VAcnWut8co2Nck7L2+2FcqvEkRdr75vcHJu8l
         3hLKnVYqkoVzTx1cZsFlbprplA+5GfW+1Y/6vkiq6QEtS7vwptF3PvAGEfgSSjckntMI
         IGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583652; x=1795188452;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kb6BNBHWUZprPI1vwsmUapLJRh7sJ5t4OJsDs7YS7EQ=;
        b=gDBUntWX4m4GbUrF/2dFysnput+PQJwfdFwo+n7DzillV8vU8ISS62b9OtH9AbUo99
         DykT4zg+FjfeOAyOIWuOcY8+cY8uUlzB35ccPRqUv0yTZzNhjDDspWJSFPyJMnobt48b
         uQdpX3wXwmBFLShYlAk9tTQJ4VmcpofVj4ZYk+ZMfgxSKgO6F9qDS+1xkN8d3uV/4Hfu
         kxqtMeTucTwYeS6e9b9B0KJQImTOH3vLndV8qYWselBvSxG8+8PMf5Vx3WIiPtDi5pcL
         4WPlR9TWlLQFEgp4WniI8+IUF9A1x9tQn3L+F5ZPH3zcx6H4DMWnw6JW1AZaL38UEd2f
         9E3g==
X-Forwarded-Encrypted: i=1; AL+hErHDk7M1cRyI1uYex7sDJkT/2RabX7h8aUxM/R8ZKASIg1Fronr4DM5jTsZ2fiLFosvz/5GFcEHl/80vY4DyHJeAUro=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UHi0bew0baBy0WQNaUle+hdw0OTVs9+uQ+zwCvXlCLtMUnzF/
	1+f4ypR1/5OLF5WQWnMX8hyAK3UxSHPyx3ZW+RUj36J4+WSLRU0JCA8syaCGmysT1uTferdCbD8
	/WUa+VdCrjSsy3wQSfk3JvA==
X-Received: from edgd14.prod.google.com ([2002:a05:6402:a50e:b0:6b5:7fe9:bce9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1511:b0:6b4:be3f:51b3 with SMTP id 4fb4d7f45d1cf-6b7c0958100mr1868438a12.12.1794583652187;
 Fri, 13 Nov 2026 07:27:32 -0800 (PST)
Date: Fri, 13 Nov 2026 15:27:10 +0000
In-Reply-To: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113152729.837429-2-vdonnefort@google.com>
Subject: [PATCH v1 1/4] ring-buffer: Skip remote reader page swap when on tail
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bgrzesik@google.com, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the reader page is also the tail, swap should not be permitted or
it would insert the tail behind the head, breaking the integrity of the
ring buffer. While __rb_get_reader_page() does correctly prevent this
situation, the simple_ring_buffer implementation misses it.

Once the reader catches up with the tail, make
simple_ring_buffer_swap_reader_page() return 0. The remote reader now
can expect an unchanged reader. When it is the case, there's nothing
more to read.

Also, when the simple_ring_buffer writer moves the tail to a new page,
it resets the new tail counters and more specifically page::commit. As
moving the tail unblocks page swap, order the page reset before the
tail_page update. This ensures the reader can't swap the reader page
with the new tail and observe a stale commit value.

Cc: stable@vger.kernel.org
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c        |  3 ++-
 kernel/trace/simple_ring_buffer.c | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..3c7aa982d43e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5848,7 +5848,8 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
 	new_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
 
-	WARN_ON_ONCE(prev_reader == new_reader);
+	if (prev_reader == new_reader)
+		return NULL;
 
 	prev_head = new_reader;  /* New reader was also the previous head */
 	new_head = prev_head;
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index abfaf9bee12e..d5c84af01925 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -139,6 +139,13 @@ int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer)
 
 	reader = cpu_buffer->reader_page;
 
+	/*
+	 * The reader is already the tail page. See simple_rb_move_tail() for
+	 * memory ordering.
+	 */
+	if (reader == smp_load_acquire(&cpu_buffer->tail_page))
+		return 0;
+
 	do {
 		/* Run after the writer to find the head */
 		ret = simple_rb_find_head(cpu_buffer);
@@ -196,7 +203,13 @@ static struct simple_buffer_page *simple_rb_move_tail(struct simple_rb_per_cpu *
 	}
 
 	simple_bpage_reset(new_tail);
-	cpu_buffer->tail_page = new_tail;
+
+	/*
+	 * Setting a new tail may unblock the swap in
+	 * simple_ring_buffer_swap_reader_page(). Ensure the reader observes the
+	 * page::commit reset.
+	 */
+	smp_store_release(&cpu_buffer->tail_page, new_tail);
 
 	simple_rb_meta_inc(cpu_buffer->meta->pages_touched, 1);
 
-- 
2.56.0.611.g1030f0b940-goog

