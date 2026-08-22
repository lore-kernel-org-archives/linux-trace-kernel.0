Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DC3C819B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406848; cv=none; b=Jz2TZHUwWfnVEXwLapCD3GLWUtj+MbHncj23o2Zapm6V1wTBqSu5gd8Ik8LuDmfghwLgRPvtpshJxOSlWEc4NSWH09SzX4MayFhy2vd7n+CkTvoOu1sNFIpWOc/APRIx9l1U5WXt5LUrA3TGkYWSdye3HSMGd7ZY1AQQ2ZmLKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406848; c=relaxed/simple;
	bh=eyMdQms5h38vSRYfAWR0WcETsyXaqJ5IJyvglyGQo3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hAww4FnxjswBl7T+kp6B5U7CrP0voRNiverXq7jwwEybswgYPH3FWjzCJPF7QmQTk5AZP6wVEuxY531dawZCbfzXMj/TTX74+JY+ZAl3yRwVRDaR2ALSDkxW3uUpqX2F26IIyOeyv1Z6Qy69bLSfhqWpiVWiRqCXJQBKqm4VB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5lsYzjc; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5lsYzjc"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767b782so11841505e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406845; x=1788011645; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkCM63s99i91p1PpHDumOCyyQdfuhx7OwD6Jd3t1Lq4=;
        b=Y5lsYzjcfdqLMLXLcZZQUwStHswCMeFGu02DpVcS1iXPH1gVnDy2xzSgULZF8sxmk3
         n8XGkg4CPwyB51MEmBvZ2H+clgoEF/X9hnSa/SX8iyZRQ/UR4mtQb5qW7T0F8YUJZvZZ
         BBOFL365Ua/UQkip4KtvXdAYSgA8G6LF1uPOrz9RmVVO6IoURnc8DTuFMOqnkd+onjhx
         ZC03DV1kEbefpEgKoGujQD1KOFClhkJJTbdhIltayq8QWfw+bIAxcjROXmf5fiNeVJYj
         CaXjPGjVKOvOvTSYNmcmPwbeTDdhdZUjVoCb76tgyULYwBePR7wRws0v7Sb6wIEHGKQy
         dvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406845; x=1788011645;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hkCM63s99i91p1PpHDumOCyyQdfuhx7OwD6Jd3t1Lq4=;
        b=Vk/6QdzkKzisjmmQjpbsHCR8FmLvctAqysgsVc64iOPR8JIl93gDXVcwYh2bdwwyO4
         zyRRSYZBBVXBuUiauzbQivq8ylZTOWs3ZXIWuDkj/tdrjjhQ9ZDM8yTuTnzqIQWUNQed
         CqcByngBa1qoSc5FoK4FeatqibBs7Jk6SyeMC7omgFxXuPytB1t1uyIysBfMo9VxQjr6
         gLmWMmCrflhQCnJI7Qfe016y2395CRRG/MennKkl6HcEk5GyvmpN7iwnz579P/97R6el
         Q0U1w+2vGQUk+koHfUfumvZ9YgrXyDK1a7myZ0+tS0rTbH/FALInjPdDRAFjug+b+tTj
         Owtw==
X-Forwarded-Encrypted: i=1; AHgh+RoKrPvde6GR+wc2JkTImYs4q1EA03n5f6lKExrTsuUbCHe7rWxxsAkObPNcxyTIlzQaw2Qpa/WhjBNqjEkv8HZs+90=@vger.kernel.org
X-Gm-Message-State: AFuF++mYzZ3Jea5qMRO9VDRa66tZoUh24OgrEw65HsjBsbVXtZv2ikZz
	ns0Zn1h1OaKRVpN1JTCt8bZbqxoDyayy1BBSn4Lgdy502txKniP6jdcwcTLvy9U1rdTFNYKH4Q=
	=
X-Received: from wmsk20-n1.prod.google.com ([2002:a05:600d:8494:10b0:495:5b3d:ed8e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f87:b0:499:5a50:b022
 with SMTP id 5b1f17b1804b1-499b830d220mr157713495e9.3.1787406845321; Sat, 22
 Aug 2026 06:54:05 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:24 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=ardb@kernel.org;
 h=from:subject; bh=P7ZGJgEcYK0LKyyPgb8fkUAxKeezm6n7kbgZPbKu2yU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5TWxr2KyTbZTbOpLO1+U67/Xi9h1eWvb4iPcl4w+S
 bRJZ7V0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIms3cbwv5ahahdT+LH2cO82
 t1yDecoKnrvaJgjtU5h+/th0FT1bD4Z/Wub5/n96de+wmHSaPL+t1b4gf0nC0eXNz1JN5Yqla1c yAgA=
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-13-ardb+git@google.com>
Subject: [RFC PATCH 2/9] mm: execmem: Allow huge vmappings to be avoided for
 execmem caches
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Only recent arm64 systems are guaranteed to be able to manipulate the
permissions on live kernel mappings that may use huge mappings. Older
ones can only do so on live mappings that are mapped down to pages.

In order to make execmem caches work on arm64 despite this distinction,
allow huge vmappings to be omitted when allocating the caches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/execmem.h | 2 ++
 mm/execmem.c            | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 59bd862cb061..b04926f3fff2 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -48,10 +48,12 @@ enum execmem_type {
  * enum execmem_range_flags - options for executable memory allocations
  * @EXECMEM_KASAN_SHADOW:	allocate kasan shadow
  * @EXECMEM_ROX_CACHE:		allocations should use ROX cache of huge pages
+ * @EXECMEM_NO_HUGE_VMAP:	cache allocations must avoid huge vmappings
  */
 enum execmem_range_flags {
 	EXECMEM_KASAN_SHADOW	= (1 << 0),
 	EXECMEM_ROX_CACHE	= (1 << 1),
+	EXECMEM_NO_HUGE_VMAP	= (1 << 2),
 };
 
 #ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
diff --git a/mm/execmem.c b/mm/execmem.c
index 6db0c1d82a9d..5790d4a8532a 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -276,7 +276,8 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 
 static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t size)
 {
-	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
+	unsigned long vm_flags = (range->flags & EXECMEM_NO_HUGE_VMAP)
+						? 0 : VM_ALLOW_HUGE_VMAP;
 	struct mutex *mutex = &execmem_cache.mutex;
 	struct vm_struct *vm;
 	size_t alloc_size;
-- 
2.55.0.860.g4b6b3295ed-goog

