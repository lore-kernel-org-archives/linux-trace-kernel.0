Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E82DE70D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302703; cv=none; b=prvqx/AyQSIabM42lJC5040Gcvpq4InAyxVpwFxSJkHOeYCUEFhYiXM4VyYcWjg/mAhyFUw+ZWNa/ZphYz4Y/K1mOHhqmBWKqg0Z10G14tqtwAUZNzDQcga7O05xbQSnk+GBtNYszVG8AiRR6HlAp3Gukz0kHE+ueT7d/ifSCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302703; c=relaxed/simple;
	bh=d5tS/VYQvy11KKQdbITdO/cb5iPgnZacDSb2hI1SQqQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddhIpiLktsK2kEQmMmC3vPRBS55Vaq2JWkNZhsL8hDwlVYlduBjk7dzSyE00w0SIAQEZcoSa7m6C1puisyzbqq+jUW7KUe2a5u9lJSBXIzv2YcZYFpO5GoDIzBR0paVW5zEjO3IJ7BZkH6hQey0PlZ9PFYlC/DicItcbaPy3G/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3n9ziM5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3n9ziM5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4908b92904fso45941595e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780302701; x=1780907501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAW5Os4pfjenGgpPUMRcNNYStYiDsva7wTl5T8rnAg4=;
        b=e3n9ziM5q5lYUTkuy/hA3RlCALxNikIWvqDE3QUaJXe3tk/p12rM+cwTQmuH+N966B
         fitQ7pfkbYaRmYSpHhIf3klMBkdon8RguTOgj7CAMBjsy3kn7zwr1ShVCVuYqPL1cuDm
         n3B3Ab6uayfZ0z26kQGOfvOBPWV+jwqWZwLfQey8waeSd9GvHF2VpDj0v/VCqEUDIJQh
         TG+yVL2zJVt4MIzOtKiQfzt7BKOh75kzIIoqgBZIHl21ylCv3JrxxGRAF+Gy+PwgZmAd
         uQjgm+3L8rus1bceNdunvAzBbr2q93BLLAJj2d2G7RD8fkTTSg3WsGScKZAqtQrulvOb
         aIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302701; x=1780907501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAW5Os4pfjenGgpPUMRcNNYStYiDsva7wTl5T8rnAg4=;
        b=pCuba0ib6reu98xdlxgM2a1ruoJQwobdmdMg7zLwZJ2tmgYbgBSYhwUmFAWPa6eBun
         mKgdinfirUYk9fX5T8oTaojl/cwG1yza+KsNDPXeAbi8LjcsWTT3kTUev85/hEqQ8OHy
         fA2e29nCzNkoVEHK8ujwOa+uNa0bQkJYJ5Bh5PHnXoOHV7aCquXy+eEWWKSc0OpwHLYH
         YdGKHI5kdOKgDWU/PwMFOU5T4lxSZ6IRf2CsScQAPGKZOn15en6CAAMDYDOatnby5Jms
         euGSxe/AqRBWNNvDbIz4a3SYkW9ZTY24mcQUcCQI+dLORDNIGq0y6rbLBNB1ASmslFP7
         VnHg==
X-Forwarded-Encrypted: i=1; AFNElJ/RR9jxt/knl76K8eHx7Fsmy0MJkCuKfWYYzQJV9gft7Zaobph8qRc6hoV3qyE5CwaHrMpHifbUxQ/lUfmS6J+CsIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSKxz3cp0wdbYebjgYyikUIMNV/gWB45myzVLGSM4kxY5VaeJF
	rb+bxEEvo1wcKF++qZ8jv2+3ovHYWP24CiZ2zR4Ff1v4+HOd2L+1fenA
X-Gm-Gg: Acq92OEPoqv79ao7/kJzjiv+zHp3xN4Ac1JgJeIb5bXTiJ58rAhxHt/yHTDx7oGFIkA
	quLJZS2uxd5mZiEscMC8mckpoLVEealg3a8tClREqEQ9pvAMC8rVUYbGnCLnv+Oca5Z1M43Ir4M
	GC6xcRsCqkXia7Lzs5uFEj6Zin8KaKoLFWJ5FsCmPqabo7ddvN/Ecv0iCIIt0e/gI2YtQiTn2X9
	fF8iZN18l7bsEf6PEWvD7Ra3Xj1o7JzaAt2W1tHoq7aWgJTK47bLSzaMtSmSgHL0iIxbQLA/+L9
	4ae3zBUbMXYd/ajgO4b/0QVZqeLT0FvV6ntmNpeuaic9owbzFZEAreQGM0Yg8hBTAO1gMe11asS
	2EOAjyY3ux5pffqqxHTy5yZ7GtdTNv+31bWwk9Gy9tsMUyx+wokGy+Am9vl/UfdIKVJ7Wd0KVDb
	gBBm+Jd/X0TDz4I2cJgxsGooC6jA==
X-Received: by 2002:a05:600c:450b:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-490a29213bamr196953175e9.13.1780302700991;
        Mon, 01 Jun 2026 01:31:40 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d696f25sm349567065e9.5.2026.06.01.01.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:31:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 1 Jun 2026 10:31:39 +0200
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 13/13] selftests/bpf: Add tests for forked/cloned
 optimized uprobes
Message-ID: <ah1Da9KoU3wjjBV4@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-14-jolsa@kernel.org>
 <87ldd3665m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldd3665m.fsf@cloudflare.com>

On Thu, May 28, 2026 at 03:00:05PM +0200, Jakub Sitnicki wrote:
> On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> > Adding tests for forked/cloned optimized uprobes and make
> > sure the child can properly execute optimized probe for
> > both fork (dups mm) and clone with CLONE_VM.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index efff0c515184..033d32b4cc27 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -4,6 +4,8 @@
> >  
> >  #ifdef __x86_64__
> >  
> > +#define _GNU_SOURCE
> > +#include <sched.h>
> >  #include <unistd.h>
> >  #include <asm/ptrace.h>
> >  #include <linux/compiler.h>
> > @@ -936,6 +938,88 @@ static void test_uprobe_error(void)
> >  	ASSERT_EQ(errno, EPROTO, "errno");
> >  }
> >  
> > +__attribute__((aligned(16)))
> > +__nocf_check __weak __naked void uprobe_fork_test(void)
> > +{
> > +	asm volatile (
> > +		".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
> > +		"ret\n"
> > +	);
> > +}
> > +
> > +static int child_func(void *arg)
> 
> Nit: Could annotate with noreturn:
> 
> #include <stdnoreturn.h>
> 
> /* ... */
> 
> static noreturn int child_func(void *arg)

yep, will change, thanks

jirka

> 
> > +{
> > +	struct uprobe_syscall_executed *skel = arg;
> > +
> > +	/* Make sure the child's probe is still there and optimized.. */
> > +	if (memcmp(uprobe_fork_test, lea_rsp, sizeof(lea_rsp)))
> > +		_exit(1);
> > +
> > +	skel->bss->pid = getpid();
> > +
> > +	/* .. and it executes properly. */
> > +	uprobe_fork_test();
> > +
> > +	if (skel->bss->executed != 3)
> > +		_exit(2);
> > +
> > +	_exit(0);
> > +}
> 
> [...]
> 
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
