Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794031672;
	b=WRtKor6RxbkJN7ZnYlzJMoWdVMeBO9Gx6CrWJWOJ3dtDSlMWUYXN5twy5lkkkH9ylKkt
	 7sxZJPNX1DUkBByoWYBcLl+1LEz+W2g8TwXAf2Zk1/rrUR9OwI9XHDklQP8haGmuaptBS
	 6NCRNclA8b88Sf5xX0evWjnzddEdohum1S/yFkIewSQAKJ0SNeiBy6IP0DuwMFpILXMsv
	 AzW2Xr/aVXHsGecYHOf7kBikTqrliDUkH39Kc/V3oiFPJB82YJUX0zt4UvffKqRg/YOlc
	 lbqP6jQTT4aKnkYJLskjnMjfr3aSb8FnxZ5T4jsQ0r3uQOyPCH1rzUwU7vG1Ru/7Okg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794031672;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eivSpggppJzKXZCIzl3c5b2mGwyNAujIo12m1cSxZWs=;
	b=NhWJWETLxVz8wF2ECaDehEBdFY/Nan05PmddZF31CPz0VvDX6TrYWDt88vnpdwhM4ELe
	 nrAkxYntJZ/6JBYf/ajqllQBGJQSVo/prW5WFmaKXupseAbpaX8PhbqZ8mTqcVC7LteOm
	 eUBAiIbtFUeJHR8Uq9ST4pISnKrL/jShKAHCuVJlLud15UhjaiT5DVawpU0FQcb/Z55y3
	 fvkHzRHjns3xkFkQAZzeezDYWD2I6fO+ygbejg2lKo403W+gvymxR6FqqUAZfHAVSU4WO
	 PUxrNd4JGQ1vkdW51u6p6ClUUtuJC+i2Yw69MZtF4GyIbkzhgiC3QXpU9cFs3B5SYYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyv7x4XB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97E606A326
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 06:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyv7x4XB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448EA1F0089F;
	Sat,  7 Nov 2026 06:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794031671;
	bh=eivSpggppJzKXZCIzl3c5b2mGwyNAujIo12m1cSxZWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hyv7x4XBiVn6O/GXkb07XTO5MsgvyC1rFVAwqXNtWylJiVybNf1R5FzXRq43Sp1KQ
	 LthLr1aSk+rvYObsr3vqN0rHfLKvtdqzQ4bgUsQwIgAW1t/bri5NVu4Olwog921UCB
	 S2sC6sHCJQhsB3J4qtiXbu3e/rmrZ51/vqwthMOXjOzek/3aTw40fBwYb7EJBY2bLt
	 MGbEIKF+U3X3DDrGa0Hr/fSnPRC7m/KqvXgrWLokuuQZHe56zk5XW2vft2+5hhEmp8
	 eEdYz1BtnRnfUA7qxKWYy4KwOdQTMVDSlOUnd5xbj+DRa5khxoJtHJEhvtsGoYccpp
	 L6L55dRjyG7Ow==
Message-ID: <sashiko-outbox-202648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] selftests/ftrace: Add a stackmap basic
 functionality test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Pengfei" <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261107055139.3138633-6-lipengfei28@xiaomi.com>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
 <20261107055139.3138633-6-lipengfei28@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 06:07:50 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/ftrace: clear_trace() race after enable_tracing() in
  stackmap test
--

commit dccfeaafcec2ce879803de3ca52edb3da1c1743d
Author: Pengfei Li <lipengfei28@xiaomi.com>

selftests/ftrace: Add a stackmap basic functionality test

This commit adds an ftrace selftest that verifies stack_map deduplication,
reset behavior with active and stopped writers, statistics reporting, and
deferred freeing with open readers.

> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.=
tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
> new file mode 100644
> index 0000000000000..f5d1ebd8728e8
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc

[ ... ]

> +    echo 0 > stack_map || fail "stopped-writer verification reset failed"
> +    n=3D$(records)
> +    [ "$n" -eq 0 ] || fail "stopped-writer reset left $n records"
> +    n=3D$(stat_val entries)
> +    [ "$n" -eq 0 ] || fail "stopped-writer reset left stat entries $n"
> +
> +    kill -CONT "$worker" || fail "could not resume reset workload"
> +    enable_tracing
> +    i=3D$((i + 1))
> +done
> +
> +# Reset leaves old cookies in the buffer; drop them.
> +clear_trace
> +
> +# Wait until some record is hit twice, i.e. reused.
> +i=3D0
> +while [ "$i" -lt 100 ]; do
> +    [ "$(max_ref)" -ge 2 ] && break
> +    sleep 0.1
> +    i=3D$((i + 1))
> +done
> +
> +kill -STOP "$worker" || fail "could not stop final reset workload"
> +wait_for_worker_stopped ||
> +    fail "final reset workload did not enter the stopped state"
> +disable_tracing

[Severity: Low]
Can clear_trace race with the resumed worker and leave the trace ring
buffer empty when max_ref reaches 2?

On the last iteration of the reset loop, the worker is resumed and tracing
is enabled before clear_trace runs.  Any sched_switch events recorded in
that window populate stack_map and increment ref counts, and clear_trace
then wipes their <stack_id N gen G> entries from trace without resetting
stack_map.  If a stack reaches ref >=3D 2 before clear_trace finishes and no
further sched_switch event occurs before disable_tracing, the loop exits
immediately and the later check for <stack_id N gen G> events in trace
fails:

tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc:
    trace_pairs=3D$(sed -n \
        's/.*<stack_id \([0-9][0-9]*\) gen \([0-9][0-9]*\)>.*/\1:\2/p' \
        trace | sort -u)
    [ -n "$trace_pairs" ] ||
        fail "trace has no <stack_id N gen G> events after active-writer re=
set"

Calling clear_trace while the worker is still stopped and tracing is
disabled (before resuming the worker on the final iteration, or by
stopping it around clear_trace and resetting stack_map) would avoid this
window.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107055139.3138=
633-1-lipengfei28@xiaomi.com?part=3D5
