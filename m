Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461D15A85E;
	Sun,  6 Apr 2025 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743961170; cv=none; b=EaAYANBF9zIOWU/yborrcxcg50pSeeYv8mV1ZvVbyyaXWQYbHasZDttr9NvbuUY/KoCcfkS6swyOHbr37fUFIjLPLS3HXv9Cnn3+mcuhjW53lBxojzwzmCxrT4Yyc6QhCeFPukThSXjrHuRJD9k6NOT+BV8W5fScWlA9zTh1ef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743961170; c=relaxed/simple;
	bh=pSisrNlHCEyGABubq1XV9Bh8BsRHi1pjWlMJ3o6Hrbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnBxHX4J01X2C2evxGN/1qCsNYn59g7l2w0BYJI+qGQESMwOJ9Qz2sjSTiPZyB2FBnEWWP7MH2f0Su5CMafvaEd1AKA2bMy5V9SwPgwnsljSI1f6bDwEPBIdzzCsc31JiQsW+tgdUGQOc9OYw50A3m0KFfFc1TtVombu9LEIAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/50PNZP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/50PNZP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2255003f4c6so31713015ad.0;
        Sun, 06 Apr 2025 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743961168; x=1744565968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STtGZLctY6chK7NNX8djDqnb0wgdBzX+Yk6Hrx5EGn0=;
        b=D/50PNZPJix7lv+Y6Dua7prANCU/+tDj4NuRhKjmjiDHBktljPG+npH6ALn2sXQ/qJ
         Y+DoQOGqNmb/qyvt63zWv1U96XaBTMUnIr7XL+P+pPUfIcop4LEU4GBGlf47ylWoM69U
         x8n1TcCUicCR7CNGv2LvjE/O+BG3rDwQwTl4gwctQImhrJOGrSgNkRFzmyKXfUbyWBhK
         AUs/EmM46sKYrm6dWnbhF46+dESYqcSAFsowbTrnZbrWWCxp7nXyEn7B1mqn6n2JtNFK
         W8ELo34+zK+Pb6QT8uBDY2xYS/dm3NsxD5n4Em88G2iN1jtsU3K+X4m5YIIvJGsaAKH4
         3Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743961168; x=1744565968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STtGZLctY6chK7NNX8djDqnb0wgdBzX+Yk6Hrx5EGn0=;
        b=ZfT2xSm1y1vslRja46p59v90B8nNtvWuDll80daxyGYJN4Z6wjEzYUPWf3s+qSfqTZ
         g9d4ettHeIrLbI15d7y772/rSqGd6Qq3xZPRZhd/KCsEOggMOgGilhqe/Xi8ckcPPK0J
         Btsyu+DlOWoTUvK8s8xBns8VfQzixrqOx9u74qlJnDNhOYi7EFi9eExX2Tuge5UB3ISf
         VWrrOJkf/pqjFyqvuSHsbhboPscjJs4JRAdGQotFyOA0fAOj+rOf5Z8zxwFWD6xef2T3
         fKjAl+j5O53gMfH3OJSkyYnnKctyuWgoH7vMmfEWvjZuJ4Tz/CjKhTGJ2lST+k0mWTYw
         TEJw==
X-Forwarded-Encrypted: i=1; AJvYcCUhW7eebapp7OjpU8x3Dxn5RRnGiXhbmS54sx7cGo+Yn4qed7Ps0XlE9u818g8wnNG4hiKy91eqb8/xmj5p/dAuVTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt3MSUpcBTVCH83jpKiiHuJA4/1c2048p+v7mMdL7vbTPQGaih
	iC1+zEhryaa7kfsV2RE/cCgktfRRqtqs5aLYYkPezP3oh8Si0gmv
X-Gm-Gg: ASbGnctNqVwb3fjKezzAEDLstik8o48AYJIgi4GXEe3RJ589sx5i/+N4/HrmWjV9raG
	w19AwbyDLR6VjFQ4/IZ43gg6Ak6jdAlSESZZldxNljH1fJU7RcrSY5iag0sbRQYKKpdtbmKt/2p
	80cDp55uq6Kf0sRRPtOpRMpbpnQv1xnSSfuFXwWfmtPwq0gfVBDjT1pOwESWvNUiqyq/NTk/vnq
	fBeO36XEJhXGzJM04Q/K/h4TZ+/7Hl82cNfBONkRq9kympEHri72alfKScyc9btLyvu3bqSvM0p
	lBUDqm5880T8HaUQFY1KfirTne92gjFg9iJsg+ObNK9jSN++aNa2jXo+NA==
X-Google-Smtp-Source: AGHT+IGpIwT/IkR8C6qOwpAkCnxQThqD5c0QmECnGDsdK1RYPJOBjOD9m/J0gRWXZet/Hv6n9KjDsg==
X-Received: by 2002:a17:902:f610:b0:220:fce7:d3a6 with SMTP id d9443c01a7336-22a8a06b429mr131647885ad.23.1743961168513;
        Sun, 06 Apr 2025 10:39:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c2791sm65946545ad.80.2025.04.06.10.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 10:39:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 6 Apr 2025 10:39:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 3/4] tracing: Use vmap_page_range() to map memmap ring
 buffer
Message-ID: <4f8ece8b-8862-4f7c-8ede-febd28f8a9fe@roeck-us.net>
References: <20250402144903.993276623@goodmis.org>
 <20250402144953.754618481@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402144953.754618481@goodmis.org>

On Wed, Apr 02, 2025 at 10:49:06AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The code to map the physical memory retrieved by memmap currently
> allocates an array of pages to cover the physical memory and then calls
> vmap() to map it to a virtual address. Instead of using this temporary
> array of struct page descriptors, simply use vmap_page_range() that can
> directly map the contiguous physical memory to a virtual address.
> 
> Link: https://lore.kernel.org/all/CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com/
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 33 ++++++++++++++++-----------------
...
> +	area = get_vm_area(size, VM_IOREMAP);

non-MMU builds (xtensa:nommu_kc705_defconfig):

kernel/trace/trace.o:(.init.literal+0x250): undefined reference to `get_vm_area'

Guenter
