Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989607;
	b=aHyflknLlR4AMzaJ5dq4c4yClXhICQhOxvbk6fsXT23o0EjkDEdna1v19M4Zg1zae3vI
	 JaIb3oTNICisAXfdrS/+O5b95rtOhLJLFG9rl/uQrrqhsbzGqwK/xRlLzHQiSeFcPPYQm
	 OA9AOJ8jgn8jYLuohWBKtjFzK7wxf90jRJjZ/fz2vpaprkohUNTIwUNmw70STFqOWY5Zc
	 n2Htkm1LAwX7fPg6tO4bqf3frg7PkJYG09FstgRmS8Fkas3qu+4TgpqBcnB9hVynn/pwX
	 sb1ZcQoy5YRJ8JuTd+IRI1JZWRRlsQuSlEOie6Cc/QDTsVpdqpAYwNQWZwmcEVCSIzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T+WndX5LT09lxsj+ZTwn3B958Z+4csPsMgcJskqKkEU=;
	b=yNfKHBpKloakqo9n2+hPaD/hNDSrwdnZPz8bjm1D+1PPboLrFS6xu8DgJMjjIcy0Ceor
	 hr6xmWctmL2KgM0NsCd0xPcT+hH6cbBKs25J+lahAjfPGg0j8mCwzZfULq+GJrtL7ngtC
	 L1p1HqgCCuFkFofFe16t9g5btnX7m9EjOseNj5ggsLUr9+sRjeX3hzCVtEgbeOmR5i95W
	 njaaLxKMV/zgVuNiibZx/3nGChe9yRbb/7jm2ACNA+yly05eqhJbcpS2dz/b0iFWoWQzH
	 bQLkdlfs9Mk7isTHppDVfi3z2+72ckHiCGn7EV1NAaWpFKhXovW+wAsj7tAeNZ8aHSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUdO2kmH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE835606A326
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUdO2kmH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2111F0089F;
	Fri,  6 Nov 2026 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989606;
	bh=T+WndX5LT09lxsj+ZTwn3B958Z+4csPsMgcJskqKkEU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MUdO2kmHh+QNuFWEuqyiAZTkenC8+P4HJATZNd4ri8IVrRH+uPFJ/T1oeoXkzpj7I
	 Zb6I7XKe4R4f4FSgfHqWJADmHsrEk2UMBFHcEPa/vZZPiS/t56ZGJTNUz2XhorKrxk
	 1ggTF53DAMEUuQx8ENcP5AA0VkgR9GcKd8Y5/sDGRlIun484A8IVJF2hPn/MT2mhXy
	 AMlkM5SUDbUeRof+3OZtBZldp6YYYFdGmKGRhwna53wh1eGnbYhJSwTM6NSAq9ZcOT
	 uSQH439nKAod8o2wLa3FRczWS+iZq7TLMptsOSM2PPLNHLuYWXxjd/Q6sBpPQ0pGuP
	 lW73aKvTwjodg==
Message-ID: <sashiko-outbox-202028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/21] tracing/remotes: selftests: Add a test for the
 dmesg tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261106180657.2460376-10-vdonnefort@google.com>
References: <20261106180657.2460376-1-vdonnefort@google.com>
 <20261106180657.2460376-10-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:26:45 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] tracing/remotes: selftests: dmesg.tc fails when
  CONFIG_PRINTK_CALLER=3Dy
- [Low] tracing/remotes: selftests: unpinned writes in test_dmesg() race
  with poll
--

commit 3fde60957549859280fe5d4a8fc22ed359270e5c
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: selftests: Add a test for the dmesg tracefs file

This commit adds ftrace selftests for the trace remote dmesg tracefs file
to verify dmesg redirection on both the test remote and hypervisor remote.

> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/too=
ls/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> new file mode 100644
> index 0000000000000..a5dcdd91e516b
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> @@ -0,0 +1,86 @@
[ ... ]
> +    nr_events=3D128
> +    for i in $(seq 1 $nr_events); do
> +        echo $i > write_event
> +    done

[Severity: Low]
Can unpinned writes to write_event here race with the periodic dmesg poller
and log events out of order?

Enabling dmesg starts the 100 ms periodic poll_work, and each write_event
records into the current CPU's ring buffer.  If this loop migrates from a
CPU that was already polled or drained in the current cycle to a CPU that
is drained later in the same cycle, newer events on the second CPU are
printed to dmesg before earlier events on the first CPU, which remain unseen
until the next poll cycle and cause check_trace() to fail its monotonic
timestamp and sequential ID checks.  Pinning the writer loop to a single
CPU with taskset, as trace_pipe.tc does when writing concurrently with a
reader, would avoid this.

> +    sleep 1
> +    output=3D$(mktemp $TMPDIR/remote_test.XXXXXX)
> +    dmesg | awk -v ts=3D$last_ts '
> +    /^\[ *[0-9]+\.[0-9]+\]/ {
> +        t=3D$0; sub(/^[[ \t]*/, "", t); sub(/].*/, "", t);
> +        if (t+0 > ts+0) print $0
> +    }' | grep "selftest id=3D" | sed 's/^[^]]*] //'> $output
> +
> +    check_trace 1 $nr_events $output

[Severity: Low]
Does this sed expression fail to strip the printk prefix when
CONFIG_PRINTK_CALLER=3Dy is enabled?

With CONFIG_PRINTK_CALLER=3Dy, dmesg prefixes each line with a second
bracketed caller ID field such as "[   12.345678][   T42] " or
"[   12.345678] [   T42] ".  Because sed 's/^[^]]*] //' only strips a
single bracketed field followed by a space, the caller ID (or the entire
prefix) remains at the start of each line in $output.

tools/testing/selftests/ftrace/test.d/remotes/functions:check_trace() {
    ...
	sed -e 's/\[[0-9]*\]\s*\([0-9]*.[0-9]*\): [a-z]* id=3D\([0-9]*\)/\1 \2/' $=
file > $tmp
}

Because check_trace() does not strip characters preceding the numeric CPU
field, cut extracts parts of the remaining printk prefix instead of the
event timestamp and ID, causing the test to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106180657.2460=
376-1-vdonnefort@google.com?part=3D9
