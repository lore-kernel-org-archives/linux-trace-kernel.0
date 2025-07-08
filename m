Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73865261595
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990058; cv=none; b=qtrNQV/opC3lSbI7Ro9tyBqc6hYPWhlF26UqKb9VnY17+92AT/XjQUxsrCvJ/csOadZ6ClRvoeepXE2F8Ufs5oI3Hd9t5lQIp9bzPBFJesXPyPlJY6hIwFe7/nEXuSe3UvES3yvKcXgVR0t8DO0m2wOXqkami6ILrM6Y/yEFV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990058; c=relaxed/simple;
	bh=gjZLHGLmfbVObDGOZ4Dg5r0jve/c3K3iH7rC6rix6b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be1FjgXZACov9ANUcbffHY+Xu4AZJ2TTKgOVj8nb0hXKDMk6YRFAmLA5HE6NVzMZ/LMTIJYxbqE5srsmBA8PYrIhspScqhVb9jgCpLDtD8q1RKljdb1kCh8F51DCVJ/qbKb88BeGTzeulY70dwkI9j/PxBvbvP/gEA76l+SS+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ef4TnyBY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ef4TnyBY"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so8469593a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751990054; x=1752594854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JviNfoY/DbOqb7IBhvcbJrjlb0wZveDxGuzjGFCnAdw=;
        b=ef4TnyBYTj4iDNrEIclbT9tK1giFtWOLDdEwzLM1+HYwwUHO9PyEMleMNFxSIxsmmv
         lUovRuQd+9tWda/QsNynUMklonaEFih2HMA89xSx7CBvZ3PHAvkuIaddqAolPfSspV8N
         B8jRtLcOn0qoMVfPH2sWThM2yJY187m0krAnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751990054; x=1752594854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JviNfoY/DbOqb7IBhvcbJrjlb0wZveDxGuzjGFCnAdw=;
        b=lxPRYxYOvmPka4rm7jHYjG7JIABPldxHQwey9JaV4CdWaUBei6384by6qYI5vvhcyw
         MA48517orBxe/7B40IgsQYg4gP9j+cyYNfo66eZUfVrsJr5moDODsKxpz5vHEmTLSZmB
         T8YaODgRbIEnKCdFfzVGQHPY0rN8A+Wz2V5Mka03jFO5SNvhmBN7t7ozVsIaMBsJF/Me
         R1VVSCuczGi6Puw+Mcjkk5A3vDPk9ParwPkWWBjLRpj/Xa+qJf0F3OrwpupnKi5Sz+qn
         mMQdwOSicrxCWlme4u930goBP1Lcdfmx0R53GmXFZ0buCsE5dIjmnIuE30t0x10oC+4u
         GXJA==
X-Forwarded-Encrypted: i=1; AJvYcCVVAcvesrjjl4nYqcN0NjZWx5Fv6f+3xFWn8gfBjfXk4hTU5yTN2p14Tl3BEhAZA/CJ0fbizV94rAcmvM2goFrag4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyid9mSLLIwJ0mjjvJ3KRX21XM6zHqUDHefE1KS2d9fwObDhs1T
	cCi0KpJVBQeq3IvMUbXtYooNvUF02Na2gvGuYkI35p9JiswiajFqu6koOZDSAa49oT3DUi6Zy9C
	ckh+fRQ1O7A==
X-Gm-Gg: ASbGncsJlgTCZzpTCXy052mRSNJ4IJ5FmA5xLGPft5Bu8g//cflG9tIEswkwBxMJEBM
	VHJno5HUVmAGGAk5SxgkfDZFzXJxnf/E/pxaiNYVoQ76+5C/FlryBSyGxYaSwAniwxGX/OkPyah
	gtlxUl9Kfu6reNV1nX6ORqpxSFtnTTJv8uytm8XJ9jq0/4cNfSi/YQOcYgn+SJeZ8OjOGKC8lNj
	p3BqOYdSlUXRHH2AfptX8Ah1hICy6eR9Eg69OIEzcFXFESW3tFBGD79/B43q9H7U4sYMXkOc9t4
	ZCMqDsI7eCamECP8qc7H7Iz5Ak2zdcjARil/MlXC07TlSn/0EcKJmtHAOVnwtm3BA5xsrSgDzWT
	XFAqohzpHOrAJdUfYBh66E6pkHKE014bAg22S
X-Google-Smtp-Source: AGHT+IEFVnFH0FMqUpez+Sp8XwtGiJtIkF0tW3EF8+POpGQ4O1eCGAqmizFlXv/o4nrFNdQAAIiZOw==
X-Received: by 2002:aa7:d958:0:b0:608:f493:871c with SMTP id 4fb4d7f45d1cf-60fd6527017mr12841324a12.14.1751990054547;
        Tue, 08 Jul 2025 08:54:14 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61045467919sm1770196a12.68.2025.07.08.08.54.13
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:54:13 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso8111782a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq7F7+DCzN5/Kh61ThJv21peuS6gTJBWxUrZViFN/vvRbexoK7YetGQ+l4upOSt3kD9lkOxZXwR/rXwooHddmnn6A=@vger.kernel.org
X-Received: by 2002:a05:6402:27c9:b0:607:f64a:47f9 with SMTP id
 4fb4d7f45d1cf-60fd65092eamr15258834a12.3.1751990052924; Tue, 08 Jul 2025
 08:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
 <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
 <20250708092351.4548c613@gandalf.local.home> <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
 <20250708104130.25b76df9@gandalf.local.home>
In-Reply-To: <20250708104130.25b76df9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jul 2025 08:53:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
X-Gm-Features: Ac12FXxjWw7PewHMCf7vpGhvfipJRiRQXNVSUY5qO5rT6dy-QSSufIBM28NP0Kw
Message-ID: <CAHk-=wgXcc99EXKfK++FEQzMQc8S16WOwvn=1DcP_ns1jCCYeA@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 07:41, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Would something like this work? If someone enables the config to enable the
> validation, I don't think we need dynamic printk to do it (as that requires
> passing in the format directly and not via a pointer).

I really think you should just not use 'user_access_begin()" AT ALL if
you need to play these kinds of games.

               Linus
