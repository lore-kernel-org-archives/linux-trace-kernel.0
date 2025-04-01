Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA359B71
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Apr 2025 00:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467910; cv=none; b=FEUP2mwGAq0hV9B05xKkwW8wnxnWzlTXr84iyuM9j7swjgUv3xrgP74QAtiKpalr8V7er3qdW5ReMnJNZVqQbfNtlFbPJm8++emeI668QxHnCPGePqdQqMZXva4zOLTM7isMrc0ZPwA0po//uHCZA6hRq1EbMG1bCnjBLuolZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467910; c=relaxed/simple;
	bh=EI1mPvdCbyYHIwBWxdtH54j+BVCkqp7WsbZyJafCRLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdUB/FtA2B+WwAFMfQUk2dCf0IKGLMNFFM+ez8aBkBH9bggK5ZB9M/YHkSkJrioqXMqP+41s3HE/wAfv6HQHDan4rgilzGNSz8ed3xYCmeokIoKQa05ZkYvslPycPFjYGCCSIOAQbrjrr7UClyMd0QK8Pwu65M3sBr88nD9w03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qd9qCY8w; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qd9qCY8w"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso8293234a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743467907; x=1744072707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmYjDTtlr4FUxPBxvb78kyKW+ePiRCaB/F3Y0k4Lqp4=;
        b=Qd9qCY8wjTeC90Z1vh0pumvZ9pqvovnXsRK5xy5+MQILhH29/QK9ynCNHBi1YnCknG
         /s+RDEWR0LGo2J3+t+3en6qdlp/mHYvYKZHxb3hE7XYXr4GPCU2X2vSky5Mnq7UwXtbo
         g7kXIacmX2m1Y+MxmIMaM0XIi9ztAwtVCpZH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743467907; x=1744072707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmYjDTtlr4FUxPBxvb78kyKW+ePiRCaB/F3Y0k4Lqp4=;
        b=gSwziiFfxj1nyFvtIDZNb5z0gFzaQ1X8nzG7gejb0tzVLpIVNyeRftWu//sslZ3f7g
         0o7THUPi4JU7DSTCMm28I0ipyeH22DVYhs63g3SOLE+vOitOe/AkRBJLXiW5z2oqD3Pi
         oXbQtX8v3Qn3V6BdjXyRlw5ITZQlJyxZRnZA9Jb0b9TPIFi55+JlgbqHm7rEGpNgZ6Ge
         RyPIqZ7rajejWU6V18kE01v5++OxHMqLWVO+7fM47ht5lO8HvW8BLp4A9oYW5zia9rcm
         eMB5/IUB6zSroJ/cYI+znS8PMauiZ2X5HfDNr1uNVCRNOrYenVerFPYvRcP43CGCfMQO
         ZFxg==
X-Forwarded-Encrypted: i=1; AJvYcCVONLsfKZV73g19UK3/j5077I8/b+TKwwXzzcJqLLxZrplWxGpjAOb1a59q+/ir8acCxuGFblqV+QHQUY8IpIEHB/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWB+FlCSnoS/jV5Y38tQi4QtlZ1bIuXSe9/5uQiC3SZ80CgQN
	L4dGDq860bmxkM4dqG6FZoWrtf545EQW6DtyDYNTImFgUAceIgj7QtHoBNfSegzVAqXsjvFjFgK
	nrgQ=
X-Gm-Gg: ASbGncuehHpQLji3D3KyUz2N32GRfGeVrYEUyCKFocu2Lap4685YaGPM2VnzKTT3roX
	FVTwv7We4DwWcyTPrMrX1RdsSsc5droBzXHogkFeW0yQlyvlfiLY0AL0eYDJS43oCowRAMj1Uh8
	+AfiE60Pydm5slmM7QAGf7q9tpEjQypLqyPezFoxnU3Sw3mt3vRluonMCvYItLGRxwx0GpCTq0t
	spxeZhh+UqKHRzDOIe70VpAUYdQG+maKU+epmQxxLjixxq01S64MC+a3EqrX57KiO44rnhJgWXr
	9LH1wWO/VJ+6RvNnoUbxguraOIkVRk/ub4O2rBLaAAhPtUXQKbXGCUwrsIfneg9cRsfpBv1PrPm
	uGgpVOmSx10PHd/jZSes=
X-Google-Smtp-Source: AGHT+IHrVx71Fx73KQwQWd9Og5CFFb4JOXnORKs3d4KruMmAVq9N0Wil1a94i1SxFhTpP0rmSLe7IQ==
X-Received: by 2002:a17:906:a46:b0:ac7:7d3e:7335 with SMTP id a640c23a62f3a-ac77d3e7c90mr185820566b.7.1743467907033;
        Mon, 31 Mar 2025 17:38:27 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967fce9sm686739166b.130.2025.03.31.17.38.23
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:38:24 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so825005966b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:38:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLvwVUuZwzT4bxi+bQq7uBrVvYljpyrv2Qp7Z7/K/L032uAg4D7OiZT/gycAvT51KCgY0X1Mr38sI8ZNVxSEaij+A=@vger.kernel.org
X-Received: by 2002:a17:907:9491:b0:ac3:84d5:a911 with SMTP id
 a640c23a62f3a-ac738a3fb45mr1010426866b.28.1743467902999; Mon, 31 Mar 2025
 17:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home> <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home> <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
 <20250331203014.5108200c@gandalf.local.home>
In-Reply-To: <20250331203014.5108200c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 17:38:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
X-Gm-Features: AQ5f1JqkcRUTrAOWfRx6dOFz_CgrRYBalx1pwXYdM-tsf3km_onhfKZdgX2Gx8Y
Message-ID: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 17:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Of course, I would expect the same to be true of the page/folio cases,
> > so I don't think using flush_cache_range() should be any worse, but I
> > *could* imagine that it's bad in a different way ;)
>
> At least we can say we covered those other archs, and if a bug is reported,
> then all that would need to be fixed is the flush_cache_range()
> implementation ;-)

Well, there's also the whole "is it I$ or D$" question.

I think flush_cache_range() is basically expected to do both, and you
don't care about the I$ side (and I$ coherency issues are a *lot* more
common than D$ coherency issues are - while D$ coherency is happily
the common situation, the I$ not being coherent is actually the
default, and x86 - and s390? - is unusual in this area).

So maybe powerpc people will be unhappy about flush_cache_range()
because it does the "look out for I$" thing too.

There's a flush_dcache_range() thing too, but I don't see a single use
of that function in generic code, so I suspect that one is currently
purely for architecture-specific drivers and doesn't work in egneral.

So *this* is the kind of "bad in a different way" I could imagine:
things that probably should be cleaned up and be available to generic
code, but very few people have cared, and so they are used in ad-hoc
places and haven't been sufficiently generalized and cleaned up.

           Linus
