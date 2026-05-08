Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27228171BB;
	Fri,  8 May 2026 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778200435; cv=none; b=pgzly6H9+9oLI16vWgNaGdPP/ZBo9l0Z5HbJIuDPx8DIYKT7pyGB/ZEJCkhaE/RxqH1KimsDSv9+i9YGXe4P4qJswvO5X6k48pkVTSkaBbh5F00QhNxe69kFJPkSZoWVnWoDJccZLi9sj99pj7KP6rpnguG0TBdMeJEZ9ldqayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778200435; c=relaxed/simple;
	bh=4yVKlDBPodn92aHkB9CfoMEo3fAc5fA1bRmJ249Zmqw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VyxfmpXnFpbrjAup1J7LC1qzmatmSySVtMlM+mKJndbDW7OzhlXKLuhbMeqMNdmqw5WOo8wrptbmFCOU3Vpeg+bWFmT8Z5zNfsoiWnjfTSFELiENcD2Jtxanc2bwSDbU+thHuDbUA042oLnG5OlMJpYI+tS0ox+nIZ74uFrfS3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkVsZi5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkVsZi5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6841EC2BCB2;
	Fri,  8 May 2026 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778200435;
	bh=4yVKlDBPodn92aHkB9CfoMEo3fAc5fA1bRmJ249Zmqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DkVsZi5wdHEGGdtf8S6NVAtfEick4K5rJmbVPaa/BgRPTKJ1KcOQa8bJGWsemw8mL
	 JiHMMxW3CV2fBRvBoH5BpjVrr0vcZTqnYgHAibB0AfnE0x4JnxLv4dXWquvxOXKARb
	 W1uEWEq/76/uiuxW5Avsq0ej+Gekj88HJgzzOvSUZaHLIJj1HyEfYJjzQ/bXm1qVjJ
	 DQEolXzJcdfCIDagzAJH+nnXpU1HbTeVHneFSjcI88heJbSUMUXzUqV1BPLe65Vx45
	 pvDwCzIoibmIt9Xc+8RmS4kqf3zYn037XjgmShrKnsYRJvJr7WdtDSTisgkE9DaNyN
	 wPUUR+dIOvRFA==
Date: Fri, 8 May 2026 09:33:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Naveen N Rao <naveen@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] test_kprobes: clear kprobes between test runs
Message-Id: <20260508093350.1d03d6c239134a5bc02c61de@kernel.org>
In-Reply-To: <20260507134615.1010905-1-martin@kaiser.cx>
References: <20260507134615.1010905-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 15:44:33 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Running the kprobes sanity tests twice makes all tests fail and
> eventually crashes the kernel.
> 
> [root@martin-riscv-1 ~]# echo 1 > /sys/kernel/debug/kunit/kprobes_test/run
> ...
>    # Totals: pass:5 fail:0 skip:0 total:5
>    ok 1 kprobes_test
> [root@martin-riscv-1 ~]# echo 1 > /sys/kernel/debug/kunit/kprobes_test/run
> ...
>   # test_kprobe: EXPECTATION FAILED at lib/tests/test_kprobes.c:64
>   Expected 0 == register_kprobe(&kp), but
>       register_kprobe(&kp) == -22 (0xffffffffffffffea)
> ...
>   Unable to handle kernel paging request ...

Oops, good catch! Thanks for fixing!

> 
> The testsuite defines several kprobes and kretprobes as static variables
> that are preserved across test runs.
> 
> After register_kprobe and unregister_kprobe, a kprobe contains some
> leftover data that must be cleared before the kprobe can be registered
> again. The tests are setting symbol_name to define the probe location.
> Address and flags must be cleared.
> 
> The existing code clears some of the probes between subsequent tests, but
> not between two test runs. The leftover data from a previous test run
> makes the registrations fail in the next run.
> 
> Move the cleanups for all kprobes into kprobes_test_init, this function
> is called before each single test (including the first test of a test
> run).

Yeah, this looks good to me. Let me pick it.

> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  lib/tests/test_kprobes.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/tests/test_kprobes.c b/lib/tests/test_kprobes.c
> index b7582010125c..06e729e4de05 100644
> --- a/lib/tests/test_kprobes.c
> +++ b/lib/tests/test_kprobes.c
> @@ -12,6 +12,12 @@
>  
>  #define div_factor 3
>  
> +#define KP_CLEAR(_kp) \
> +do { \
> +	(_kp).addr = NULL; \
> +	(_kp).flags = 0; \
> +} while (0)
> +
>  static u32 rand1, preh_val, posth_val;
>  static u32 (*target)(u32 value);
>  static u32 (*recursed_target)(u32 value);
> @@ -125,10 +131,6 @@ static void test_kprobes(struct kunit *test)
>  
>  	current_test = test;
>  
> -	/* addr and flags should be cleard for reusing kprobe. */
> -	kp.addr = NULL;
> -	kp.flags = 0;
> -
>  	KUNIT_EXPECT_EQ(test, 0, register_kprobes(kps, 2));
>  	preh_val = 0;
>  	posth_val = 0;
> @@ -226,9 +228,6 @@ static void test_kretprobes(struct kunit *test)
>  	struct kretprobe *rps[2] = {&rp, &rp2};
>  
>  	current_test = test;
> -	/* addr and flags should be cleard for reusing kprobe. */
> -	rp.kp.addr = NULL;
> -	rp.kp.flags = 0;
>  	KUNIT_EXPECT_EQ(test, 0, register_kretprobes(rps, 2));
>  
>  	krph_val = 0;
> @@ -290,8 +289,6 @@ static void test_stacktrace_on_kretprobe(struct kunit *test)
>  	unsigned long myretaddr = (unsigned long)__builtin_return_address(0);
>  
>  	current_test = test;
> -	rp3.kp.addr = NULL;
> -	rp3.kp.flags = 0;
>  
>  	/*
>  	 * Run the stacktrace_driver() to record correct return address in
> @@ -352,8 +349,6 @@ static void test_stacktrace_on_nested_kretprobe(struct kunit *test)
>  	struct kretprobe *rps[2] = {&rp3, &rp4};
>  
>  	current_test = test;
> -	rp3.kp.addr = NULL;
> -	rp3.kp.flags = 0;
>  
>  	//KUNIT_ASSERT_NE(test, myretaddr, stacktrace_driver());
>  
> @@ -367,6 +362,18 @@ static void test_stacktrace_on_nested_kretprobe(struct kunit *test)
>  
>  static int kprobes_test_init(struct kunit *test)
>  {
> +	KP_CLEAR(kp);
> +	KP_CLEAR(kp2);
> +	KP_CLEAR(kp_missed);
> +#ifdef CONFIG_KRETPROBES
> +	KP_CLEAR(rp.kp);
> +	KP_CLEAR(rp2.kp);
> +#ifdef CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> +	KP_CLEAR(rp3.kp);
> +	KP_CLEAR(rp4.kp);
> +#endif
> +#endif
> +
>  	target = kprobe_target;
>  	target2 = kprobe_target2;
>  	recursed_target = kprobe_recursed_target;
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
