Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C987D412;
	Wed, 12 Jun 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177025; cv=none; b=ejJcFbRuli+5LW79Z+6d9dh1/Mkyk2rZyq7WbjY42i1dtJSFIXPEFgKHO6L5x4XFknogsal/qYEO6i8g+SHaT++BEe5HCr9G350jYDqFqI3x0n2sSmGinI75CWOmALImgxKsyO9Bd8i3jEOj/gbjDBCpBzonE5niJqkiTM6CrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177025; c=relaxed/simple;
	bh=y9mF+JpF82gFZ7/11rrW03SsbP5vOzAjWt7DDYM8LqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1WuhWhjOzhBWleL7l33oYMU7zlva7mINseY5C07G8tqG3gsgYQaawt1KZ00M6Lrpb4XAX/Bhbf/oRgnkZKWIEVFIbC0PKpJZbwvkNP5s0/SRMETHGSXSod38xGknoR5ackA67jNTZvtIPfVD3FwfVpojgYhKWmML8bvSgSjoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0REuxv0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0REuxv0"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57ca8e45a1bso489484a12.0;
        Wed, 12 Jun 2024 00:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718177022; x=1718781822; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzoZ2C0guQAGIJY+WDpPhVUMExli5mSXJ8fvKFTkBhw=;
        b=D0REuxv0DCfBochDjS7RcgE3H7p3V4hdflD+WUVe785xX0teBtApfC92TUSr7lWbfO
         +0fSwRswvYu6tYVQPRyzX5p6yF27atUTEyX2Nmia7u+aJ5SpdqTcloVlTZ3heq2e8jQj
         PFUVGmLpjCaEDvMehvArQR3GdYBHA1ddKx6U6Ujrknlf2LUi5BsOlXezc+Fbl5ake/9G
         4zNF0N9Q38e/vwM34VrvvqXWVCgEWemuUZsx5FFoEnKBzjKjJ2f9L4ZQRQgwyjWF3PwC
         KUOmLq0W8X0Gd69LSLmANPI3nlMQCM0q45aVc5PYN7D2xFDFrVb55Z+F46nrLyFdCt5B
         OdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718177022; x=1718781822;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzoZ2C0guQAGIJY+WDpPhVUMExli5mSXJ8fvKFTkBhw=;
        b=YMLojAPS+zBfhR0N1ZmlduDiqUuKBvVh7g1ArJCv9LYmCldGx9kqfMfou5KdgNgxIr
         HDrqKhzEfFxMgN1d1h7T9UU17ctFmgt0WX7jRGv7Cu0HMnBAGoT4LOvkTDaIt5+rqll3
         9Kc9IYA7w8tHk7xPpAy62B5PxEDJAfb9HjxPphKX3W6YnplCeYbDt+aLxWzoFVcOuert
         tODAYj6AWiZnE6p/wPA5uPvVB9en7C/eN5EnGu59lNOB+3MRB2aXMe7EpEJFUmGWBG2R
         33YGcd9pN8jrimb26mUuTFuGpj78eDPdicCOCLwPAg0ERVUkW4Bm0O+CTZhr24SSbqE9
         aE5A==
X-Forwarded-Encrypted: i=1; AJvYcCWevKg5PI70bYBmugZxSPek0LUY8Jt0jxSCmvfvGgZtBeo5WEGntN2LxOob4+rGL34O9ERMahW8gSgEbk3AXzHbD8gLWKn0uBKWW7p3IhiagM+b8YqH6BcktKxuQf5uJLdI54E3GfUFLDzlJArjcUZPI82iwWaF4Pp42FqRu1MBuvcUFnpEfs7BWEijCKcoAo6S
X-Gm-Message-State: AOJu0YxrypJNlq/qnIbjf6do7tk7U5kE0eFPylytS/rAcg2ifbQQvZ19
	/xPz8sNqQyaMfGwz4c0NwoC9rUS4LVIXijfwTTT5eL02n+GW8SEG
X-Google-Smtp-Source: AGHT+IGNIbOiKuBi8XBaHBBWZFuuSUm5/fxYrK1eNRgIcIp/HAFQQAj2B1ndW70Hhj705NIJRAC8gQ==
X-Received: by 2002:a50:99d9:0:b0:57c:610a:6e85 with SMTP id 4fb4d7f45d1cf-57caa9bc77emr933866a12.27.1718177022047;
        Wed, 12 Jun 2024 00:23:42 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7156e6c2sm6912641a12.9.2024.06.12.00.23.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 00:23:41 -0700 (PDT)
Date: Wed, 12 Jun 2024 07:23:40 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240612072340.hsdxusmszixebvrt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240606150143.876469296@goodmis.org>
 <20240606150316.751642266@goodmis.org>
 <20240611144029.h7egl4aif5mjlrwf@master>
 <20240611111218.71e57e0f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611111218.71e57e0f@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jun 11, 2024 at 11:12:18AM -0400, Steven Rostedt wrote:
>On Tue, 11 Jun 2024 14:40:29 +0000
>Wei Yang <richard.weiyang@gmail.com> wrote:
>
>Missed this just before sending out v3 :-p
>
>> >diff --git a/mm/memblock.c b/mm/memblock.c
>> >index d09136e040d3..a8bf0ee9e2b4 100644
>> >--- a/mm/memblock.c
>> >+++ b/mm/memblock.c
>> >@@ -2244,6 +2244,103 @@ void __init memblock_free_all(void)
>> > 	totalram_pages_add(pages);
>> > }
>> > 
>> >+/* Keep a table to reserve named memory */
>> >+#define RESERVE_MEM_MAX_ENTRIES		8
>> >+#define RESERVE_MEM_NAME_SIZE		16  
>>                                         ^
>> Suggest to align with previous line.
>
>It is. But because the patch adds a "+", it pushed the "8" out another tab.
>
>> 
>> >+struct reserve_mem_table {
>> >+	char			name[RESERVE_MEM_NAME_SIZE];
>> >+	unsigned long		start;
>> >+	unsigned long		size;  
>> 
>> phys_addr_t looks more precise?
>
>For just the start variable, correct? I'm OK with updating that.
>

Both start and size. When you look at the definition of memblock_region, both
are defined as phys_addr_t.

>> 
>> >+};
>> >+static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
>> >+static int reserved_mem_count;  
>> 
>> Seems no matter we use this feature or not, these memory would be occupied?
>
>Yes, because allocation may screw it up as well. I could add a CONFIG
>around it, so that those that do not want this could configure it out. But
>since it's just a total of (16 + 8 + 8) * 8 = 256 bytes, I'm not sure it's
>much of a worry to add the complexities to save that much space. As the
>code to save it may likely be bigger.
>

If Mike feel good to it, I am ok.

>> 
>> >+
>> >+/* Add wildcard region with a lookup name */
>> >+static int __init reserved_mem_add(unsigned long start, unsigned long size,
>> >+				   const char *name)
>> >+{
>> >+	struct reserve_mem_table *map;
>> >+
>> >+	if (!name || !name[0] || strlen(name) >= RESERVE_MEM_NAME_SIZE)
>> >+		return -EINVAL;
>> >+
>> >+	if (reserved_mem_count >= RESERVE_MEM_MAX_ENTRIES)
>> >+		return -1;  
>> 
>> return ENOSPC? Not good at it, but a raw value maybe not a good practice.
>
>This is what gets returned by the command line parser. It only cares if it
>is zero or not.
>
>> 
>> Also, we'd better do this check before allocation.
>
>What allocation?
>

You call reserved_mem_add() after memblock_phys_alloc(). 
My suggestion is do those sanity check before calling memblock_phys_alloc().

>> 
>> >+
>> >+	map = &reserved_mem_table[reserved_mem_count++];
>> >+	map->start = start;
>> >+	map->size = size;
>> >+	strscpy(map->name, name);
>> >+	return 0;
>> >+}
>> >+
>> >+/**
>> >+ * reserve_mem_find_by_name - Find reserved memory region with a given name
>> >+ * @name: The name that is attached to a reserved memory region
>> >+ * @start: If found, holds the start address
>> >+ * @size: If found, holds the size of the address.
>> >+ *
>> >+ * Returns: 1 if found or 0 if not found.
>> >+ */
>> >+int reserve_mem_find_by_name(const char *name, unsigned long *start, unsigned long *size)
>> >+{
>> >+	struct reserve_mem_table *map;
>> >+	int i;
>> >+
>> >+	for (i = 0; i < reserved_mem_count; i++) {
>> >+		map = &reserved_mem_table[i];
>> >+		if (!map->size)
>> >+			continue;
>> >+		if (strcmp(name, map->name) == 0) {
>> >+			*start = map->start;
>> >+			*size = map->size;
>> >+			return 1;
>> >+		}
>> >+	}
>> >+	return 0;
>> >+}
>> >+
>> >+/*
>> >+ * Parse early_reserve_mem=nn:align:name  
>> 
>> early_reserve_mem or reserve_mem ?
>
>Oops, that was the original name. I'll change that.
>
>> 
>> >+ */
>> >+static int __init reserve_mem(char *p)
>> >+{
>> >+	phys_addr_t start, size, align;
>
>Hmm, I wonder if I should change size and align to unsigned long?
>

I grep the kernel, some use u64, some use unsigned long. 
I think it is ok to use unsigned long here.

>> >+	char *oldp;
>> >+	int err;
>> >+
>> >+	if (!p)
>> >+		return -EINVAL;
>> >+
>> >+	oldp = p;
>> >+	size = memparse(p, &p);
>> >+	if (p == oldp)
>> >+		return -EINVAL;
>> >+
>> >+	if (*p != ':')
>> >+		return -EINVAL;
>> >+
>> >+	align = memparse(p+1, &p);
>> >+	if (*p != ':')
>> >+		return -EINVAL;
>> >+  
>> 
>> Better to check if the name is valid here. 
>
>You mean that it has text and is not blank?
>
>> 
>> Make sure command line parameters are valid before doing the allocation.
>
>You mean that size is non zero?
>

I mean do those sanity check before real allocation.

>I don't know if we care what the align is. Zero is valid.
>

memblock internal would check the alignment. If it is zero, it will change to
SMP_CACHE_BYTES with dump_stack().

>> 
>> >+	start = memblock_phys_alloc(size, align);
>> >+	if (!start)
>> >+		return -ENOMEM;
>> >+
>> >+	p++;
>> >+	err = reserved_mem_add(start, size, p);
>> >+	if (err) {
>> >+		memblock_phys_free(start, size);
>> >+		return err;
>> >+	}
>> >+
>> >+	p += strlen(p);
>> >+
>> >+	return *p == '\0' ? 0: -EINVAL;  
>> 
>> We won't free the memory if return -EINVAL?
>
>I guess we can do this check before the allocation, like you suggested.
>
>Thanks for the review.
>
>-- Steve
>
>
>> 
>> >+}
>> >+__setup("reserve_mem=", reserve_mem);
>> >+
>> > #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
>> > static const char * const flagname[] = {
>> > 	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
>> >-- 
>> >2.43.0
>> >
>> >  
>> 

-- 
Wei Yang
Help you, Help me
