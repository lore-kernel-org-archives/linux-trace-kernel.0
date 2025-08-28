Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA828A3FA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413536; cv=none; b=HsGjnEVPq3mGvQG27nDcm9PxRBKEXSmiLU2nZBmAxg2vBQbSDi+uLQMSiRYLx9pPP2RCJlcEm7SND4bc3zqakLRFPryHvIZgftFTwipuXBLl4fjJrbhkMWefy84L2ujWNiKYLmHyqMRVRc3NGRrEYHgxVwvTyowhxUjtxO9uBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413536; c=relaxed/simple;
	bh=hNgqbG4EGq28u1EQouYSBUbpkt0arWTr713X7x0bHTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1E0fCrJFuf8z3sJVCld+N31qbfnSVlOEblhubotsO0ajBao7J6MmvdULM6Vu8e6zxoqnpS7IhH//TtFSEmglB+zCstU2ow93lDxe/9IRkeM98/sd+Zi+VzmerfFYTf442pa/289VfP1Tgvk9/5BVxOXB8RrDyttE+nzzGnyN9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zxsq0aiS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zxsq0aiS"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afeceee8bb1so204010366b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756413532; x=1757018332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWiKHYlJvcne9jpaEYcqWHC8AcX+j8YMHCgi+HL4MNQ=;
        b=Zxsq0aiSu5bMmr8E7XWVix6S7rgGBS07fsUm8yl8xwHTXyLMquAWBA66soOkZWtXKP
         wL4xuAOlUDk41UhizNog4jwJ+FO9kzVxetiESvYspnqhGA78yGc6u/erINCkGijF4jdR
         uVm+mkuVA7QxSWImcaVKbo/hTM3PcTugGy8Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413532; x=1757018332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWiKHYlJvcne9jpaEYcqWHC8AcX+j8YMHCgi+HL4MNQ=;
        b=VYXNGeMfzMoe0rh7tbSiFt+HjlBQQPJxBlaqstKLsvutbgtwhAy/isn9AUAbdxL4Mg
         /0g4e5ktby716UJ123bZR1jLzSnBrBlOKqB88wQ/9ik2jitzwzPEiobTVvgJhnU+kqn1
         cR4UCBIQrHCwLri6zNa48DkJ7QSSHVeOwCKnIVPRFBVaqr9OZP4Rg3gdeIg4uTpzuOUY
         d3LnyhKgqJb9SpJwXBgcvE10GH/xgrZpvtdYEKtVPHvmfljMIpDeiY6+u+CoMeE2fyP8
         JOmuEezdd7eJAUYRySNSlMT5Lv4PiI2WVtDaETWzfkUFj9EMZqVou3lsA8w6XaOFlqlJ
         8liA==
X-Forwarded-Encrypted: i=1; AJvYcCWgGWOUR2KKozzj5tgoi8yiWihZBGyRv/t3+5IcYHis3YhyL3vcG6o4KapOExHZMdHuvjAy+aPI4dYtnmNnhA4zk1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77YYtNZBwhuIkMav2IGGzrELE0Ov4Xwm1dlf0PjRcSoGdria/
	Q8E+7qwRp65frdMKJrsXrClSJ5aGKQtQU6JBoQ/weOMRUHUKFNJH7fYBf+3MxvHyPfgAIQKpqXa
	G88vd/FI=
X-Gm-Gg: ASbGncvK3Vu3y+W3z+W/SJEcJ2RlGHARQBPGGl+EOQ0l3AwT8pbxIPCr92AVh/zYY/r
	tL/DEM6DpN9CrCRlCC2ZF/kdLBkhnmhE2TUzK6b74DsoQFMyQTcf1XKjQI5NjX79Q60NJUFVO79
	V1FwJk6KK45dhNmNOjRIR/mJUsxSJdlWTso5jajOAuNthaAckd2Wh5g4dJm9tlUGnlAldg9D8km
	5MorhQOu4zCAsL3wH2s/wejIa5EGi8M6V0035X0my6578Jv+4cKXirs5T29BIvY9/E8pRG4gVJg
	mwTmYfV+RrVRrp8F6cCrCyy6SwrKr8oLm2cGdY+6dH4vbrQBMMCnmABEkOq+JRMkr2sZORpI2uX
	/UiLSxoxI+R6GF8qBkZlRWnqVl9vIoFzof9NGrVIsVRsCF7MxgexeLV4D1fF7xzuRleZbRxURkW
	c1rqsN/duois27VkbGAA==
X-Google-Smtp-Source: AGHT+IF3x9JPtSj9VP/8B+bbKgcLydqteFxmJPwfeA3X0CgoFIMpJ1pWVABiEUTAHvPF/jqTcM0XhQ==
X-Received: by 2002:a17:906:c110:b0:ae3:a240:7ad2 with SMTP id a640c23a62f3a-afe28f7bb52mr2298739266b.2.1756413532443;
        Thu, 28 Aug 2025 13:38:52 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbcba56sm34571866b.53.2025.08.28.13.38.49
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:38:50 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a16441so202712266b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:38:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3HjgpvtrgJsig7Nk4lIM1jgZ0Vww/nFpIjGmxu+5zHtdJjDV86Yof2bVm8DDWoKp3kTbmjqNHextmOINrVCULuyg=@vger.kernel.org
X-Received: by 2002:a17:906:fe45:b0:af9:5766:d1e2 with SMTP id
 a640c23a62f3a-afe295f1a73mr1975930266b.47.1756413529327; Thu, 28 Aug 2025
 13:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home>
In-Reply-To: <20250828161718.77cb6e61@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:38:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
X-Gm-Features: Ac12FXy_trL7Swvm3pmfwOKxyHb_uZ8GQJCJzY2njmQb_NBdcNYF0cJIcpF5WXg
Message-ID: <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:17, Steven Rostedt <rostedt@kernel.org> wrote:
>
> >
> > That should be simple and straightforward, and hashing two pointers
> > should be simple and straightforward.
>
> Would a hash of these pointers have any collisions? That would be bad.

What? Collisions in 64 bits when you have a handful of cases around?
Not an issue unless you picked your hash to be something ridiculous.

               Linus
