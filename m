Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48251F03CB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Apr 2025 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616021; cv=none; b=tlzCj22U+xAc4AEti/dTb4GcPInSMhIngHChkeICYivKlaFO8hybO8/+JZcvleppBxzGnOi7DhpMWgsbIrjuH/vh6IbUQwMGBrXAa2YwcbHCkR+uYFIWiBm/sGMaszzHYXYn1ZRPvNXfzcUGxSJZ+zENjiDUdX9qjrkbBRBawkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616021; c=relaxed/simple;
	bh=EOlZcnFOrqCflQFwOYTy+1h7jZlZEe2uY8Lc98YJXQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjeS0KQWrjin4eqL2U/km18/gG+wEfL/9+dd1aMx2Jk2LxuJfdJtPZyGNAMyj2R6Iu1ZvnZTWyrcWmmmUVpWOpxASpm5O++96UyatRuAuCTTU0LvyfXU0LDfVTUUkkCKEUVMyjBtlOMylFXLWfrmHrxj87B4g0y+hwHZxXvKJ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iGeuX9i8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iGeuX9i8"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso135091a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Apr 2025 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743616017; x=1744220817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xorHSeXHZOAo+fDlPKYms7iJ4xhfFELkMJgrAoSH+BU=;
        b=iGeuX9i8A5GO+tyZhqym/5POB6RZ/hU3tBxXHU0f1J3BYeqvd7eVsYybr05+56bh3M
         6esQBHs4AOsdoBrCNjkCU6R4RrNUzqcdLlOOU33NBhDLnOGZUO5A+6kmyWGBPJRrW6mL
         ngB7obD9Fn6A1XiKjT3d8nQAB7c5CwziHPFro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743616017; x=1744220817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xorHSeXHZOAo+fDlPKYms7iJ4xhfFELkMJgrAoSH+BU=;
        b=Q7YgZEivTKBdpzuIQ+G6HV4VkhduMKC5zs0YviTNoe9W/3/za2aeZFg5N+xj86z89W
         qiHaSUojCci9vKiTGjIScxGfYIG8tQbWWEMJRW7DYNjp59A+wH923tiLcZ5xZwnAdEie
         1+qNfTFFqE8mJ79dmDOdGGzsCNhp71p6G2A4Q/6AGF6E3Lk1FAYs98c4KGqdS9sK3yI8
         GWIRz72z5rjv+PcEWoaKHnsKmuJMByfEangx5rul4SEYAk2MNkhxMjM7nCRZTkZSnoP8
         UTx0bA/fxcQIvSVhfXKR7I+6C90JMsCz5PWsjRSmhLDWtLKb3CO/QnCRPAh4MvU3qAOJ
         M5ug==
X-Forwarded-Encrypted: i=1; AJvYcCUMwsL/9Mwt4ykYay3Hl9naE3e3ec4OlSXXU+lJYql6jmMrBsKk5Zc04IlPcyf1Hi6upMs7nHysbOa3bvU5qmi8bx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP17VtfANWTk0jndNdht3PO3wX30ft7Wa5azSz3SP4moBKfXwa
	DG00xGuL58lTgw65K2JgL1pyDV/QmZK42PX55MxBskliEsUSPAcOTLmUqGiaQO1TXGlRttFbGQY
	6gr0=
X-Gm-Gg: ASbGncuRsyEe63K6csvJsAL4iGwJc8Hu6jtxxuGG3u7ic5OoHk8YTHZoxbjAr49qn2m
	NetiL/wpop7H+PqS4h1CB1RAvnaomqxnU9mNp/Wdb2UV3CR7EyiOkuRDIiuyiqEyTWfaGGJ8DYT
	SIeUqIfiplO1AUJMfBkTyPSn6ikCZWnBWgfaAW5xc+r+A8plYScPjylbmQSpfZ0NgKtTr0optgD
	eFLW3mcsF+ZOCsqOgiyljFoL2zgMYzY5SfBIW1PUdchYTEP9kXQw7OsQBDAOTR0X7YvcISZmEtb
	u6b3/nQmqrNEnmleJ8yCGy9vMgAAn2A/fK/eYZZhrkVdnd0rW14eO/weu40UslKehKguTbAQml/
	fj1NjpktOVBDnTolAyoY=
X-Google-Smtp-Source: AGHT+IF2hdQ+ai1VjtqW7AgsTamTVsE90fQeaJBDYM40o7fMSsXAgr7ModFugUVt5pO6nsd7aAbdrA==
X-Received: by 2002:a17:907:2cc7:b0:ac3:b50c:c95b with SMTP id a640c23a62f3a-ac738c6f05amr1649894766b.56.1743616016786;
        Wed, 02 Apr 2025 10:46:56 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b027sm934038466b.47.2025.04.02.10.46.55
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 10:46:55 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so4612666b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Apr 2025 10:46:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWg2G0koVGctPkOXqF7WWI9tUycqXo4Z11dMxjBnS1MSfMWR9XUnMiQg7TYDBd2QiUpSMAIx0kivAvRkuPmLSL1ym0=@vger.kernel.org
X-Received: by 2002:a17:907:7f87:b0:ac3:f0b7:6ad3 with SMTP id
 a640c23a62f3a-ac738c1b69fmr1516270266b.40.1743616015142; Wed, 02 Apr 2025
 10:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401225811.008143218@goodmis.org> <20250401225842.597899085@goodmis.org>
 <CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
 <20250402125548.02cc57d0@gandalf.local.home> <20250402130337.5de5a8cf@gandalf.local.home>
 <20250402131431.218d3458@gandalf.local.home> <CAHk-=wh8=QAC0jjcjDRnmsmd2xDf97j8h25=aSFGeh9x+1X8UA@mail.gmail.com>
 <20250402134030.26a9b141@gandalf.local.home>
In-Reply-To: <20250402134030.26a9b141@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 10:46:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAW=WHnmP3+B8dF_U91FEzkesUW0JPGMsip2CJ9e0hgw@mail.gmail.com>
X-Gm-Features: AQ5f1JpSafEjStqfGbLJ11HrwQUxXblIlVdAsWMZyIwfr8HJB2qb6iMxdcPchKA
Message-ID: <CAHk-=wjAW=WHnmP3+B8dF_U91FEzkesUW0JPGMsip2CJ9e0hgw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] tracing: Use vmap_page_range() to map memmap ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 10:39, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This has nothing to do with admins. This would only occur if the kernel
> itself created a buffer from some random physical address and then tried to
> mmap it to user space (which would be a bug).

Do *not* try to check for bugs like that with virt_addr_valid().

It literally snakes debugging harder.

You're much better off getting an oops,. and then you have stack
traces, distro bug trackers, and various other automated tools that
give you information.

Trying to "validate" buggy data is crazy. It's absolutely the opposite
of safety. It's going to cause more bugs, it's going to only work for
the validation scenarios you thought about, and it's going to make it
harder to debug the cases it actually catches.

And if you are trying to catch kernel bugs, *any* data could be that
buggy data. So the whole concept is insane.

Yes, you could make every single line be a "WARN_ON()" with some
random check for the particular data you are using.

Or you could just write good solid code that is actually readable and
maintainable, and doesn't have random pointless checks in it.

          Linus
