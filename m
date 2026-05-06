Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88763B19A0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102044; cv=none; b=KjUlpdS62+hJWY5bDcP0daOKNuJSsg3cJJ3QSDznTX0ybK0BaHoLIBQycyvjpllyBMU7pJf4TtFSYYwfO+zj6MfPTXBAJQ3BH3CKy8Jh3HanW0J1uhq/oc/WDEWBagWfKDn8O67hBU8yFRrPJuVnzaCtJLMJ3BdcY61x+BokLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102044; c=relaxed/simple;
	bh=mrs33gwyXYYksIamyxpT/skyjGMUYhds2gPM1h88ZjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuIGTHIAAXBRwh58thtVULn3OumGYKf7uJfMvIx1i/659oobXwhyZ1dkpHe+Z0v99Mn0x1DXYXIzTMVhghfQd3Idpuu/0WYoiJIUccENsL1CQ8cVd3Fd8VoG9geIIW+IXy1f5pDAWcz1A05nzGyMaXCTynD/v/HEveeRgksitqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+oV3yvC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+oV3yvC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so1528565e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778102041; x=1778706841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X97wysjOr3lFu30H+gcrFHrWvOgZ1GUmxbYI7Sxyn5c=;
        b=M+oV3yvC+DbwjHWMdh6KoH6BPTK9tcsiQZUmoYmA8AtkZWsfKWMFDUbzza+XCJ4Lqm
         LZvl2IEbjpT8TgEb7uoI9PSoEslhtXKWoX/F/QyZ8OspxeWcoJCYcxfPjJ9ZKQPysLtr
         QwiyZBrEiuM7OTEl0QlJ2e2LzDrA9w0cRn80oRkrE5iure/ZPesZfelHsvZwgLHpKMlV
         YuWwoIYQJ9+lxdWanYvmmd8Ck9yeaE93hKqe6Fr1170++GysffX0qUmVuBBScKazYnX/
         65Xq3fizV7LYVij1jPq8nIcvnLhuC2uBvDD9pf0YU7jATtTJlTnC2A0VwdDLKJ0EvLsk
         P/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778102041; x=1778706841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X97wysjOr3lFu30H+gcrFHrWvOgZ1GUmxbYI7Sxyn5c=;
        b=ljF53IeYcz+F80eVQ9bK6iJuhKtDJ2q88NpuaOp0ybYedQyb9WxTmtE1uE0w+e4ySb
         LKayyJ9qCg+tNjOh8WZMKBwO0oRSHHkZsL88yZxpSwHewr1H7+zjTDYiYQQVI2tftxwi
         0wIsjzfEzrOkTwLqPs5T1D6t/nyTMwI78SbBnoCGvBXydV1WhrIYDDXBkUCy2LLzg0Lx
         8+J1UlmzYLf/oO2Ph6vts5BFNvpITtG4qVxRU6P+/FtLb9UBTDz4eONdgSlQg5IVmwdM
         jmZToj/bP5uc5fKUNcxrK2eaCLP72AC9fAr8JNgDMlk1ssIhG9hHPNMteh4r/Goy35EY
         Fwjg==
X-Forwarded-Encrypted: i=1; AFNElJ/Z1S71hFTto3J4ElWiRZbxP6qMJ9b8Mb+tKZCF8FKvNceXCmEz3NOiR/aXo9kS7nhBfge1P0ZbhTkvqPLdi9JLXrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQexQOwH5RFVKd3ULySAPtwMHwdCIoIjisY26PdwpcirG1uULX
	pO1SZD9UTtlorEZENiy3Pdo2yW787nMiusEUUnqKBCe5//DMLR5O7pa3
X-Gm-Gg: AeBDietCxfAyl7PQTAVUo7sW9D8v1JaGWQXZsSFgAIOH/EpBFvl9QzZKHUIE0RZcrI5
	e3aQS2VJm/+gWKz2qhqDyAGz9I6wc+yhmCc+3IqlJ2jlj0jt/4meBSD9exQ/yT7KXrZ41DtxHqL
	5LWHF5MWFrcN304zYbLqBWZdQ+7oZDP8NyICahmgkXvZtPKDY1OpKRG4PFCAjE9FJnVT4KZSWD6
	wsiFcZbX1a+lY8hH30te3Hog6IjZMSCUgkWSzPr4xyLJ5qbE81WDe/0F7W0GgOy19oCvRhCIpC8
	N+ZZpUVnYxLEWjfrQCnPS/w3t4OJmG29lN3m3wl+/VOJ09NqMsKzWZdleZqwpzTi4YaqLjUffuD
	+0qb3rfDNQflrJpbfhMfkkmsMQl7O54dXQvZ9MTHWjQe/8Yv+i6nmQ0uDL7hpWaJT6rBK2b3dUa
	Q5Us0hHa8rONpua8bWlRrmnjyujzUvUB2Yl0BXFtmPt5wVD7QzVT8i5zIwtI16CIzmqoxthNI=
X-Received: by 2002:a05:600c:8b8b:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e51f4143fmr85845735e9.24.1778102041063;
        Wed, 06 May 2026 14:14:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53826022sm78527045e9.0.2026.05.06.14.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:14:00 -0700 (PDT)
Date: Wed, 6 May 2026 22:13:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, Namhyung Kim <namhyung@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, "Carlos
 O'Donell" <codonell@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, Indu Bhagat <ibhagatgnu@gmail.com>, Peter
 Zijlstra <peterz@infradead.org>, Dylan Hatch <dylanbhatch@google.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Message-ID: <20260506221358.55ba5187@pumpkin>
In-Reply-To: <9f85f092-c376-4350-9a12-479d7b70399a@linux.ibm.com>
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
	<20260505121718.3572346-5-jremus@linux.ibm.com>
	<9f85f092-c376-4350-9a12-479d7b70399a@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:09:16 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> On 5/5/2026 2:17 PM, Jens Remus wrote:
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> > Add an x86 implementation of unsafe_copy_from_user() similar to the
> > existing unsafe_copy_to_user().  
> 
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h  
> 
> > -#define unsafe_copy_to_user(_dst,_src,_len,label)			\
> > -do {									\
> > -	char __user *__ucu_dst = (_dst);				\
> > -	const char *__ucu_src = (_src);					\
> > -	size_t __ucu_len = (_len);					\
> > -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> > -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> > -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> > -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> > +#define unsafe_copy_to_user(_dst, _src, _len, label)				\
> > +do {										\
> > +	void __user *__dst = (_dst);						\
> > +	const void *__src = (_src);						\
> > +	size_t __len = (_len);							\
> > +	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
> > +	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
> > +	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
> > +	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
> > +} while (0)
> > +
> > +#define unsafe_copy_from_user_loop(dst, src, len, type, label)			\
> > +	while (len >= sizeof(type)) {						\
> > +		unsafe_get_user(*(type *)(dst), (type __user *)(src), label);	\
> > +		dst += sizeof(type);						\
> > +		src += sizeof(type);						\
> > +		len -= sizeof(type);						\
> > +	}
> > +
> > +#define unsafe_copy_from_user(_dst, _src, _len, label)				\
> > +do {										\
> > +	void *__dst = (_dst);							\
> > +	void __user *__src = (_src);						\  
> 
> 	const void __user *__src = (_src);					\
> 
> This was suggested by Sashiko AI review.  Any objections?

Try compiling it :-)

-- David

> 
> > +	size_t __len = (_len);							\
> > +	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);		\
> > +	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);		\
> > +	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);		\
> > +	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);		\
> >  } while (0)
> >  
> >  #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT  
> 
> Thanks and regards,
> Jens

