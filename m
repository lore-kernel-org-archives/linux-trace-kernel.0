Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711E3275AEE;
	Fri, 13 Jun 2025 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816119; cv=none; b=NkmSBIj/8B8ZH5T5eI6t6ghVh1vfehg1qztPd2adiJA2/LenXxBIixjIZLqxFr2RsSGB5kiLftXe8ZUQZnzENUDGvNFmaS35PY2JlZeWzFkWZV5pyehckL+Jcs1uRCkcYCiCwIBn7pnjPLXyOPljfGe1FVKe7Zh3jofoaJGdxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816119; c=relaxed/simple;
	bh=Gh2nhsaaPI2Pw0FhumH8XUZtTKmK6FkuDXlv3k8MGiQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ofs078qyyhhhEapn6EICAkmQAXX9T7etu1HHa6Xu8NzuenhDOwkj1YG9bC6d+SZ4ZI2GkIQkE3p8RdNaM6Pqjmh3BZBaGoQbV2rihtWzulbr9kjzhdHFmhWCiPCF0vqBwbg0ETFdZwjAIbbGlakyPOl/sWtSDnGq3oFarAQz50I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU47ixca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU47ixca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF4C4CEE3;
	Fri, 13 Jun 2025 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749816119;
	bh=Gh2nhsaaPI2Pw0FhumH8XUZtTKmK6FkuDXlv3k8MGiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oU47ixcaUvCGseubQ2LyG2gNbHEcJGf2TsMn8RrAl5J31EwbOBd2heAKBq3AWO7Mt
	 7MgRlYbcUkCW9KK33IOAu8bR4ZOAHFSmoyqJS8oVlELKXAXRfZ9lUP5vSE13ZVujzp
	 Bd3T2SkS2XDIybg0O3U/4B53fxSL6nM0ZdpyZpjfJGas8qCxI5g+5s66iBIhZUF+RX
	 FPZOdN7lPud3DVqabqG0mo1yyLcv1OkQJOZt9pQ7jhP1ME/+rbvoFGut7o6qQNgld0
	 A8PmzwGMw5q+WnqSoEQK52n7B3aGVQf/iUQbAMZhDyFpFt4KYGs+l40+SCm90QbuHE
	 LI/03q26+xUfw==
Date: Fri, 13 Jun 2025 21:01:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-Id: <20250613210154.dd5150d88f74673c1019a191@kernel.org>
In-Reply-To: <20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
	<20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 17:27:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> In do_int3(), if we hit a disappeared int3, it is evacuated after
> all. This means kprobe_int3_handler() is hit, and call get_kprobe()
> to find the corresponding kprobes. But,
> 
> ffffffff8150a040 <get_kprobe>:
> ffffffff8150a040:       f3 0f 1e fa             endbr64
> ffffffff8150a044:       e8 07 b0 e2 ff          call   ffffffff81335050 <__fentry__>
> ffffffff8150a049:       48 b8 eb 83 b5 80 46    movabs $0x61c8864680b583eb,%rax
> ffffffff8150a050:       86 c8 61 

BTW, I think this get_kprobe() should be "notrace" because this
is called from int3 handler.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
