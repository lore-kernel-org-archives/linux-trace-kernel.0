Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322083;
	b=j6vCZ+nUjgUC5QSY5fMi+5M1kHu06cAAhOfWHDmRyir2wU61IsXSaZni14eptESkE8Qf
	 YeB13V9QabtQJcE7I6bwYPLqqJMuXt09KWFU6SrM+Zu26yTsNggvqSwYz/hCD3r0ov0af
	 rDRW5n4Aum20NcZHG2GNsI2/XzhoWIuoS2gKkQVyQQl72Pt+FsDOaoiKoMY85YPCP6Dfv
	 O7KDV/Tj3KH6CaIbHPz1g+RXBK2CwuLszZbXzlazuMgUeUQJ4gZ/jNt4TqBUv1nz2yvKd
	 0uYSCoMKSgGfoIOlUHkeH4rJ5Rn5Dd/+KAOALdpqHdUzZ9BOyGb2wce8nUM+9ZxteEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322083;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Vdd3kyoZA+FmufzVBQTN+34rF4mMwG7QhmRXSycjpqg=;
	b=DN093DefWg9nGGckgTUpuxUjUtikypmce7OUd3E2GWsHyN1b2NRC2VSGUM0wWv5To0GH
	 uiGRnNHr8jYhUYcpC+Q53cXibOK/mp87l24HAINlUiqRTikbmSPIn0++eloo8CAUlE57j
	 QjB0lxbJefII5s4I4OZZQTpZF1FZBV3wwjAoiAu0nRbA4YJuzNWxiOn7BVIJMMLfBNT8+
	 L8i7jUTjXHptlhgfNUvN7bEvLJSLV99u4Qpw3axMCagUleyOEjhlgtHiyO+JVU7sOjANf
	 nH7COPPvxVELi1jWTV8qm8OxBuTimR2K1f4bvT66tNmMt4uh4/WmGNQnGjQljtQKHRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsjXuMl4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FE8606A31A;
	Fri, 30 Oct 2026 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsjXuMl4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D496E1F000C1;
	Fri, 30 Oct 2026 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793322082;
	bh=Vdd3kyoZA+FmufzVBQTN+34rF4mMwG7QhmRXSycjpqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RsjXuMl4Ih9wcfsL7qU6JllcpPOZ1JmvI+yMRM3kER+FrkvdeUdXdm4St3Qbem0/b
	 HQFc4fNsJkIWAhRUwYGdri2dnqDan1D66LF4/17DxiKRwa9Kii85qFaVRDigJFWC7M
	 D0zpFU928h4JYShARwF6ssLrJtKSk+yakPevcgoGKCXoJIrdUPijR2Fu3tUKJUdaXg
	 fAIkQ6idKJESnWP6Gm+p02JW5dcV4t/VXMDlOFVdjHKRlsGunX+UYsYz/4al2KjQ6L
	 wYq1YFinfjH8lHTg73UGXqHFWR4LgPui8+oLxqfxcO0lyUFwa0azA89El7JICgSUp+
	 N//uAczFsn9RA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/2] tracing/selftests: Fix instance test to actually test races
Date: Fri, 30 Oct 2026 10:01:19 +0900
Message-ID: <undine-1793322079170721165-fee1052e7bb8c899@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261029203205.757392992@kernel.org>
References: <20261029202849.245864353@kernel.org> <20261029203205.757392992@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, 29 Oct 2026 16:28:50 -0400, Steven Rostedt <rostedt@kernel.org> wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The instance selftest creates and removes the "foo" instance while
> enabling sched_switch event and reading its trace file. The issue is that
> the read of the trace file prevents the removal of foo, and it constantly
> fails to remove it. The stress test is not really stressing the situation.
> 
> Instead of running the creating and deletion in a loop as a separate
> process and sleeping for one second, call it directly in a loop that forces
> it to happen 10 times.  Also update the removal to keep trying until it
> removes the instance, otherwise if it doesn't remove it then the next mkdir
> is a nop.
> 
> Convert the reading of the trace file to use "head" instead of "cat" so it
> is limited in how much it reads and add a .1 sleep in between reads. This
> gives the removal of the instance time to succeed.
> 
> Fixes: 91e6f1ce86577 ("ftracetest: Add instance created, delete, read and enable event test")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/instances/instance-event.tc | 26 +++++++++----------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> index 42422e425107..b0e9d3abbf2f 100644
> --- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> +++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
> @@ -25,15 +25,16 @@ if [ $result -ne 0 ]; then
>  fi
>  
>  instance_slam() {
> -        while :; do
> -                mkdir foo 2> /dev/null
> -                rmdir foo 2> /dev/null
> -        done
> +	mkdir foo 2> /dev/null
> +	while ! rmdir foo; do
> +		echo could not rmdir foo

nit: If we retry this, do we need to warn it?
(maybe we can add a limitation of continuous failure and make the
test fail if the failure exceeds it.)

> +	done
>  }
>  

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
