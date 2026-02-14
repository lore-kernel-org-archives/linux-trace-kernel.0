Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48EF1D5ABA
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Feb 2026 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771098555; cv=pass; b=YPVJ54CxXdA7YWzTykv3RtJAMY6v2eS9JY8Mq/Y44XZCqfC3ED4FwpNTYIHCK4/yuC6oa/bBvp+2QbpQwi/HjajdfbfjnLEqhY1qmwYPhxVebpbhrOBQ/PEO+fWAtGUV0zlzoR1XiEPBM6HEp/hORtbq5BfF5DsKbLx6bAzbqOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771098555; c=relaxed/simple;
	bh=GC+jahyn08TEzaCyFw4EljLb34TFRdxXPLg0f+cKCG0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwIFaPqUZsjb13Tw03r2/6NYmjug0mRbBEX+lbcpELbrotyggZHQR+Tse9OaWRELScqRTMYxgCjC2DTli2XL21nV/PZi/FJNrK9gbCyS02CaXSNYVSqwI80OaQTM5Fo0h8CHdpHgQ2AParqtKGbAui9mffYOXQ7VROyEK+up6eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+nF1ENU; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+nF1ENU"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-948bfb6b6bcso568634241.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Feb 2026 11:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771098553; cv=none;
        d=google.com; s=arc-20240605;
        b=h4V9arYZ+pT1E+asNuULd6DRlLi5SrmEGM3lxx4GgIoA5y4Zw0Yfmfqw4W1UbgVD+h
         1Uo44rWrR9p8B07Lyh5+80m2CZzk9dykrsK5QBVVqE3/7NNzQpnwcEN3g0VEhL8uplyX
         8A8DjpNSLAYUiG2HB3fi/7ZXtvZOQu8ELh1YIIME/VURq3YAcEjBVMqGao/q0E4clMMN
         Z3stWq+0qwkkHqgol3EhHHzv+aS4WkLp7CCogFKEmj/+4/iehkMYq5u3F/K1ocinnc4H
         d2gWdR0m6wBq6Z5SLRB0rZYdHEaDRf/UaMjEKV6DTCZ3B/bFd1A4IXiwFKBWyEMA0Jro
         TH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZtvRpN/RyTbUwVvDF0717LJmDHhTx67+ZJt2k7G+yEQ=;
        fh=l/47HFpHb1ijV8+rlh+CP+kzivCHcu+E48ZtOysIK0c=;
        b=PUHaXQH0kIPZUcuOMJSbvEiXNJEiUxkRGF+Tb0YUODxjMpsKhv7njK+FscRJFvdhPY
         ueh4yk8D+sTpJn7EV6tln2Dlc+3K/DLQs5MZ+cIVxT0MbOTurXlODYt15UogYs9gHfE2
         XX76TAqBLXdq1n7YKo9GWASmZCXHFFHPN/3dgW65H+U0SQ3wf2ihbKvEKVJqwXhkiM2w
         yb3eDMVDCF29PuVmR9IBuMhpQ4SU4ZMmgUx8H+XIQEXLL56KUpX/fTsAefMbAS1dvY6g
         pilBGkQpvrZcNYF43DwflFNDXCdQADJUmi6zCayHvpURiSZ9WY09iXGMC+lO0bscRUVV
         ojrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771098553; x=1771703353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtvRpN/RyTbUwVvDF0717LJmDHhTx67+ZJt2k7G+yEQ=;
        b=v+nF1ENUr21oPwBbnMwcXIhFYefKeTMhJR5EjCm1w3ircYOhwF3dMGDWR9JqHc1sAg
         YSSLd1Vh59Mcl5syECgCb8eJtD3k4h5qx+z65ix07/+ciARNcqOvAswEKGVAP31HoUSY
         vhyaG8DAGDWDE3PrKdHcQ6jm4AXEe23Vixzuv3eBxCOU0y0jOX1LmLTZb3c8yEU+9tkg
         yew9JK7XTeFJ65CpkoPt92hPal7tgfprKTCP7vN8VcVMJj2y0UfwBtQqGjTwnVF1bCli
         l3qyEE4Byo2zm8QYwJ10pCHEHT7OTcI0jia9IpcNJzrKlC79HNBpat1PgTLTrnS8n9iq
         CBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771098553; x=1771703353;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtvRpN/RyTbUwVvDF0717LJmDHhTx67+ZJt2k7G+yEQ=;
        b=dfNwJEepOLYxtlsjIPt9agHPqx1QU3HulwNINzwaDcNiu+Wrlzys18OUtgXcljaiZL
         DWw4nPjJeH+22LXnsVtS6X+QEfMNJBhfy1M0AsXYRLN3no+Rh13hrE7MyOuNnIK7aQNG
         JaJnDpgj8tk1ORpjVplyz4WDGMC/SQXomps35C57RI8HuPCNsmbwgG3Nl5QVFylxPMcG
         yJh9QN7fBhbf6G+mD/VybUPIoLgWtPmEeWXv8l1/pCFHDA0fGX4oxV6leTdfaML6UTnf
         1g+kBfByjOyHlBX3OaGbHC8qr7d4n9KmzUAr+hUp1q27CizLg+4HBBxkTEhvXqHhp90j
         kxHw==
X-Forwarded-Encrypted: i=1; AJvYcCWDjKaV111ZJYFRwvReBNE9hNJgY1whIloRjOjJM6lNwrnJr5AfqhEnmdLLk1xjDcd0hjOjICU2SnZ2vzClG1QjQiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9X6kSz8LNSXqH8Atj/l5spFMB6CHCXn7+Fz1rIpLBmP/bIB2E
	3i2XjFEeJD9/3vy7XvpEFb3JTk7Txk5nDAqd3STJWRWWGwCH8Wb+Sg4NWEFjf36/aJdKTHc2R7f
	d7Lj1fu3y2zzhUYrXcJCGHp8t1O/th/7q3olcnvO+
X-Gm-Gg: AZuq6aL+kAWUMvCIfnbBDXQcfr/01JEm3oijjCARNA5NYIDpJvwEbU8nWpJj8sNybcW
	AUWGJ1i+NvyidLTPpYl8o2OUeEW97IZKEfA13e2iwF7hKqcMvO3XEj+iXsENbSsYDrTOxuDp825
	WBHQpprXVSaglcZN3ezZH4pcxrrbzivVlDa1NcAjxBgqN+QLgIuDmzv+UzyL7d0ZY5aoUS3vg7r
	+unTzzY6lH1muMQfiSUgq3pEP9YxKhBd2dEq9DBQfrZ38x040io+SHMZ0n9Z3MmpjhyAuSMmWq8
	D2DdF3wOGTlPzflAvBydx4gvNjhMbERnRhseEJa6pkoMOaweXfJJ
X-Received: by 2002:a67:e997:0:b0:5f1:72a7:f879 with SMTP id
 ada2fe7eead31-5fe16ee32cbmr1706405137.28.1771098552104; Sat, 14 Feb 2026
 11:49:12 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 14 Feb 2026 11:49:10 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 14 Feb 2026 11:49:10 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <995398ca18fcb192444799a520cab5ea8e43df7b.1770071243.git.ackerleytng@google.com>
References: <cover.1770071243.git.ackerleytng@google.com> <995398ca18fcb192444799a520cab5ea8e43df7b.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 14 Feb 2026 11:49:10 -0800
X-Gm-Features: AaiRm51Rsn2OYZ_XKS4QmK9tZorCQvqfnTm3HcOw4Q6pQqac2ibQJ7lRc1m0N7c
Message-ID: <CAEvNRgHcxjkE8OPVxYqdCs+HvbaYqhNPW1mnocoKOoy5d6FoZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 33/37] KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> The TEST_EXPECT_SIGBUS macro is not thread-safe as it uses a global
> sigjmp_buf and installs a global SIGBUS signal handler. If multiple threads
> execute the macro concurrently, they will race on installing the signal
> handler and stomp on other threads' jump buffers, leading to incorrect test
> behavior.
>
> Make TEST_EXPECT_SIGBUS thread-safe with the following changes:
>
> Share the KVM tests' global signal handler. sigaction() applies to all
> threads; without sharing a global signal handler, one thread may have
> removed the signal handler that another thread added, hence leading to
> unexpected signals.
>
> The alternative of layering signal handlers was considered, but calling
> sigaction() within TEST_EXPECT_SIGBUS() necessarily creates a race. To
> avoid adding new setup and teardown routines to do sigaction() and keep
> usage of TEST_EXPECT_SIGBUS() simple, share the KVM tests' global signal
> handler.
>
> Opportunistically rename report_unexpected_signal to
> catchall_signal_handler.
>
> To continue to only expect SIGBUS within specific regions of code, use a
> thread-specific variable, expecting_sigbus, to replace installing and
> removing signal handlers.
>
> Make the execution environment for the thread, sigjmp_buf, a
> thread-specific variable.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  .../testing/selftests/kvm/include/test_util.h | 29 +++++++++----------
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 18 ++++++++----
>  tools/testing/selftests/kvm/lib/test_util.c   |  7 -----
>  3 files changed, 26 insertions(+), 28 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index 2871a4292847..0e4e6f7dab8f 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -80,22 +80,19 @@ do {									\
>  	__builtin_unreachable(); \
>  } while (0)
>
> -extern sigjmp_buf expect_sigbus_jmpbuf;
> -void expect_sigbus_handler(int signum);
> -
> -#define TEST_EXPECT_SIGBUS(action)						\
> -do {										\
> -	struct sigaction sa_old, sa_new = {					\
> -		.sa_handler = expect_sigbus_handler,				\
> -	};									\
> -										\
> -	sigaction(SIGBUS, &sa_new, &sa_old);					\
> -	if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {				\
> -		action;								\
> -		TEST_FAIL("'%s' should have triggered SIGBUS", #action);	\
> -	}									\
> -	sigaction(SIGBUS, &sa_old, NULL);					\
> -} while (0)
> +extern __thread sigjmp_buf expect_sigbus_jmpbuf;
> +extern __thread bool expecting_sigbus;
> +
> +#define TEST_EXPECT_SIGBUS(action)                                     \
> +	do {                                                           \
> +		expecting_sigbus = true;			       \
> +		if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {         \
> +			action;                                        \
> +			TEST_FAIL("'%s' should have triggered SIGBUS", \
> +				  #action);                            \
> +		}                                                      \
> +		expecting_sigbus = false;			       \
> +	} while (0)
>
>  size_t parse_size(const char *size);
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index aec7b24418ab..18ced8bdde36 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2314,13 +2314,20 @@ __weak void kvm_selftest_arch_init(void)
>  {
>  }
>
> -static void report_unexpected_signal(int signum)
> +__thread sigjmp_buf expect_sigbus_jmpbuf;
> +__thread bool expecting_sigbus;
> +
> +static void catchall_signal_handler(int signum)
>  {
> +	switch (signum) {
> +	case SIGBUS: {
> +		if (expecting_sigbus)


Transferring/summarizing an internal comment from Sean upstream:

This assumes that tests are indeed using the catchall_signal_handler as
the global signal handler.

In the next revision, I will make TEST_EXPECT_SIGBUS() assert that the
default signal handler is installed, so that developers get a clear,
explicit failure if/when something goes wrong.

> +			siglongjmp(expect_sigbus_jmpbuf, 1);
> +
> +		TEST_FAIL("Unexpected SIGBUS (%d)\n", signum);
> +	}
>  #define KVM_CASE_SIGNUM(sig)					\
>  	case sig: TEST_FAIL("Unexpected " #sig " (%d)\n", signum)
> -
> -	switch (signum) {
> -	KVM_CASE_SIGNUM(SIGBUS);
>  	KVM_CASE_SIGNUM(SIGSEGV);
>  	KVM_CASE_SIGNUM(SIGILL);
>  	KVM_CASE_SIGNUM(SIGFPE);
> @@ -2332,12 +2339,13 @@ static void report_unexpected_signal(int signum)
>  void __attribute((constructor)) kvm_selftest_init(void)
>  {
>  	struct sigaction sig_sa = {
> -		.sa_handler = report_unexpected_signal,
> +		.sa_handler = catchall_signal_handler,
>  	};
>
>  	/* Tell stdout not to buffer its content. */
>  	setbuf(stdout, NULL);
>
> +	expecting_sigbus = false;
>  	sigaction(SIGBUS, &sig_sa, NULL);
>  	sigaction(SIGSEGV, &sig_sa, NULL);
>  	sigaction(SIGILL, &sig_sa, NULL);
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index 8a1848586a85..03eb99af9b8d 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -18,13 +18,6 @@
>
>  #include "test_util.h"
>
> -sigjmp_buf expect_sigbus_jmpbuf;
> -
> -void __attribute__((used)) expect_sigbus_handler(int signum)
> -{
> -	siglongjmp(expect_sigbus_jmpbuf, 1);
> -}
> -
>  /*
>   * Random number generator that is usable from guest code. This is the
>   * Park-Miller LCG using standard constants.
> --
> 2.53.0.rc1.225.gd81095ad13-goog
