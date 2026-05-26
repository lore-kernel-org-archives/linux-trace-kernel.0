Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7413E3C64
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795466; cv=none; b=jiJJfF3aMw6RwXsMmFNptddgTVS7ePEBXFTTCbfk7VvztC9Tda0/p+Rjt6RpYJV6wrsLhXgYvbMUF6sWNWNN3pFPtvy/xUZpX6wRQONTdBo3x0rXSyAm77f9fLkg1UuffvENBtqSfjXTQoE7rRgb9C4P7jYLL4Y3vzwU15GifJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795466; c=relaxed/simple;
	bh=5MIHgChRNy12kVUm5iWs8ChIekHBsvSP0fhUEXrwf9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZHmE6K/E8takIyenZZQxUaaUFtoyYFaeRDj73YjafuRAx2ue0F+rGNnYCtjeu35sBBSqpDEt1RvbJ5zou+Ftj0vU1aRTWJhwbK4n0J+d0oMAAsBXpYbRMi329B6pp70Y62679jLIAV+84fr/JTAOQeCmawcSHcJMDEdqP+KPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJQhF0c/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJQhF0c/"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so9527526e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795457; x=1780400257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RepOlA7uegAkHRX0rdEAbivBLVoGLgApQvWSVyuj8bk=;
        b=rJQhF0c/wNUvYl4FdibYFxZABQ4a1PwizuxWRg+q9h8Cbkt+dYbsnTNMO3bjlKf5cH
         diSP9ZV0qO3t9eIcVsfjURWbiA30lCDwbWkCHj37E/fCGyJhXBzETl/Ss8WJjc2TvSYS
         I8YF5WHHp8qZR3Py5hgp5i014cMmeBUFZkP4/r0AKWPLlHn/PKidrqEQ3Cf3NhmdinZ6
         ZTaWKDNvTgYMBu4SOQop2oHobW/1+F7uGsMAC/ggxv86svSy0FDgDQDqNNECObEBowaa
         n7ptagAbTPkvPfZWPd6MgD2SwbpwuhZRKEhKTnG59DQI0CqpUFCtGJAjO1vGD+/5zoRt
         va7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795457; x=1780400257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RepOlA7uegAkHRX0rdEAbivBLVoGLgApQvWSVyuj8bk=;
        b=tBbT+FM4EK2jFR2/kCqxyBsO+0AmT00GrQxIWnl7Y8F9lPUKTH/BpDYQkhgl+3PRSS
         bc0mRhkbzTe6x7FLc592+mPpkbA+Aas8Vi6tKW7U6O1Z7dX8HC9m9ca/+TgVFD36R1Qp
         MTKQrAFufD6b6ggtoM7fld4qKvG32IrSBfl1o0CcEbrTup554mxt8UeUM5Nz3ce0YMXo
         bSe75CaVObYcH7OtltqHR9r+tt72tE9tIcEgbukVqYdAD3iP1sqNiuxNGiFsyLi2gGsm
         Ja16npqwdwVJwcYelrCdU8hcUhd03bi3akZiRP65pAZk4VGAtuZEaFrh/Vm82FfYCHiH
         ITPg==
X-Forwarded-Encrypted: i=1; AFNElJ/268XdrxkIIu4GGlJCHnMmzdROUKoHru2seqRSLPJF+q0BtXxhR8gOnMqGbhBHgnr4nWMUJeIYKG/uKYTX5gI0kKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRxPF9CzigNO+nQaf630q1Am6UZ9fa7q901cXs7zgdUnZvPD3w
	4b7sfE04Ap8X4Y7PFcVW7aBZD/p58xW/OJiA0KH40Ct8IpzXfE2RzEmf
X-Gm-Gg: Acq92OE1bAQIFb4XPQ0pPb9COGZypJyFcIUYn3E29FOZqpJV2T6gAvQtQPwz9S0K0ai
	/Q107wEaq42Yz2nk/Ull5rjJjXu5gAMMrN7MvTBgHERCGJc+1EgWwdXwfduhEG+siOqmKdQQZMb
	45uuQzEo8yQCK4Cill/W2St5UVijHcs8pAQaBQiJm8Rcw4avs5w81iZRl3UX93pvEGicJY7+L2N
	LJSMM69kU1o3QQ38bUTMPjTJPmjJTVHDKZdlm2N4QGG5uPZi7Op/2q4tk/Xb5ES8cUafUW7VaKF
	9deD7kI8jY6qqagVoaQy1MT0ZjKGY047uEXaLWTyubtODOqR2v0xRGf1IOoMzk6fDhJOHi8olWC
	j53UjbaTYCBIoU6jHO8zdAyYgQS0A/9H2kWnWOiz36H+jn9Iuduwf7xniM7zdIneyw/ljFYHK/v
	uRvj479/enKUSBhG//ElHblrpOohgKRgTfmNQAGJzBW3FfFTq+2jE1Fop6bii5xRkqq0Z+
X-Received: by 2002:a05:6512:48cc:b0:5a8:87fc:2b34 with SMTP id 2adb3069b0e04-5aa323c3ee8mr3865629e87.32.1779795457167;
        Tue, 26 May 2026 04:37:37 -0700 (PDT)
Received: from [127.0.1.1] (h-62-63-197-109.NA.cust.bahnhof.se. [62.63.197.109])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa46330d9asm376332e87.59.2026.05.26.04.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:37:36 -0700 (PDT)
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Tue, 26 May 2026 13:37:02 +0200
Subject: [PATCH RFC 1/3] mm, x86: support copying a folio using
 non-temporal stores
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-rfc-nt-demote-v1-1-eb9c9422daef@zptcorp.com>
References: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
In-Reply-To: <20260526-rfc-nt-demote-v1-0-eb9c9422daef@zptcorp.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <nifan.cxl@gmail.com>, 
 Frank van der Linden <fvdl@google.com>, Jonathan Cameron <jic23@kernel.org>, 
 Raghavendra K T <rkodsara@amd.com>, 
 "Rao, Bharata Bhasker" <bharata@amd.com>, SeongJae Park <sj@kernel.org>, 
 Wei Xu <weixugc@google.com>, Xuezheng Chu <xuezhengchu@huawei.com>, 
 Yiannis Nikolakopoulos <yiannis@zptcorp.com>, dimitrios@palyvos.net, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, 
 Alirad Malek <alirad.malek@zptcorp.com>
X-Mailer: b4 0.15.2

From: Alirad Malek <alirad.malek@zptcorp.com>

In x86, use memcpy_flushcache (that uses non-temporal store
instructions) to copy a folio. To achieve that, starting from folio_mc_copy
down to copy_mc_to_kernel, create a series of helpers (named with an _nt
suffix) that have similar behavior to the original counterparts.

Signed-off-by: Alirad Malek <alirad.malek@zptcorp.com>
Co-developed-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Signed-off-by: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
---
 arch/x86/include/asm/uaccess.h |  4 ++++
 arch/x86/lib/copy_mc.c         | 26 ++++++++++++++++++++++++++
 include/linux/highmem.h        | 32 ++++++++++++++++++++++++++++++++
 include/linux/mm.h             |  1 +
 mm/util.c                      | 17 +++++++++++++++++
 5 files changed, 80 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 367297b188c3..2d0938d3e372 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -494,6 +494,10 @@ unsigned long __must_check
 copy_mc_to_kernel(void *to, const void *from, unsigned len);
 #define copy_mc_to_kernel copy_mc_to_kernel
 
+unsigned long __must_check
+copy_mc_to_kernel_nt(void *to, const void *from, unsigned len);
+#define copy_mc_to_kernel_nt copy_mc_to_kernel_nt
+
 unsigned long __must_check
 copy_mc_to_user(void __user *to, const void *from, unsigned len);
 #endif
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 97e88e58567b..5a2ee5c2211e 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -81,6 +81,32 @@ unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigne
 }
 EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
 
+/**
+ * copy_mc_to_kernel_nt - memory copy that handles source exceptions
+ * if enabled, otherwise uses non-temporal stores
+ * @dst: destination address
+ * @src: source address
+ * @len: number of bytes to copy
+ *
+ * Return 0 for success, or number of bytes not copied if there was an
+ * exception.
+ */
+unsigned long __must_check copy_mc_to_kernel_nt(void *dst, const void *src, unsigned len)
+{
+	unsigned long ret;
+
+	if (copy_mc_fragile_enabled) {
+		instrument_memcpy_before(dst, src, len);
+		ret = copy_mc_fragile(dst, src, len);
+		instrument_memcpy_after(dst, src, len, ret);
+		return ret;
+	}
+
+	memcpy_flushcache(dst, src, len);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(copy_mc_to_kernel_nt);
+
 unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, unsigned len)
 {
 	unsigned long ret;
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..a5cb435b9ffe 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -468,6 +468,32 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 
 	return ret;
 }
+
+#ifdef copy_mc_to_kernel_nt
+static inline int copy_mc_highpage_nt(struct page *to, struct page *from)
+{
+	unsigned long ret;
+	char *vfrom, *vto;
+
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
+	ret = copy_mc_to_kernel_nt(vto, vfrom, PAGE_SIZE);
+	if (!ret)
+		kmsan_copy_page_meta(to, from);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
+
+	if (ret)
+		memory_failure_queue(page_to_pfn(from), 0);
+
+	return ret;
+}
+#else
+static inline int copy_mc_highpage_nt(struct page *to, struct page *from)
+{
+	return copy_mc_highpage(to, from);
+}
+#endif
 #else
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 					unsigned long vaddr, struct vm_area_struct *vma)
@@ -481,6 +507,12 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 	copy_highpage(to, from);
 	return 0;
 }
+
+static inline int copy_mc_highpage_nt(struct page *to, struct page *from)
+{
+	copy_highpage(to, from);
+	return 0;
+}
 #endif
 
 static inline void memcpy_page(struct page *dst_page, size_t dst_off,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5be3d8a8f806..d07ce478582d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1644,6 +1644,7 @@ void __folio_put(struct folio *folio);
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
 int folio_mc_copy(struct folio *dst, struct folio *src);
+int folio_mc_copy_nt(struct folio *dst, struct folio *src);
 
 unsigned long nr_free_buffer_pages(void);
 
diff --git a/mm/util.c b/mm/util.c
index b05ab6f97e11..e09e9b5f8eee 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -749,6 +749,23 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_mc_copy);
 
+int folio_mc_copy_nt(struct folio *dst, struct folio *src)
+{
+	long nr = folio_nr_pages(src);
+	long i = 0;
+
+	for (;;) {
+		if (copy_mc_highpage_nt(folio_page(dst, i), folio_page(src, i)))
+			return -EHWPOISON;
+		if (++i == nr)
+			break;
+		cond_resched();
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(folio_mc_copy_nt);
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 static int sysctl_overcommit_ratio __read_mostly = 50;
 static unsigned long sysctl_overcommit_kbytes __read_mostly;

-- 
2.43.0

