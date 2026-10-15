Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E224F4753;
	Thu, 15 Oct 2026 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070399; cv=none; b=nfURmz8yCzsuv0/dXtCQ/i1ux7bF3SCegox49muh1sMq7foJ7gx6jxWiVgP1sUPBFubyy2aJqI4WfC10CUsaLOlid/tfKlyxsl4WSJ2x9XlGySKFWphtOpQ1lFb/pSyOBxfcufxw5A6qqu8TEEHEv8QHsRQ4nFdPve+O+oH01n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070399; c=relaxed/simple;
	bh=thlshmYiShdhzTv87rwDm5joF28hsjtCtYse7dFqCn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=D1gitOCZFLnMwnwzUWv+HrvACMCBlTSG4md2KX6yHVA7e/jnuesTgZ26N/AuueXQJcW4G5IkM6TAk3fgAS2DHs9t4TcPfAFa+9zb6FC/aQ843VRD3pG4uC6wAakR5zDEUVOv9E1urouviIXcjPpU6bxdvN5lvHtxzGs5mkShWbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2+OvKqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2+OvKqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183661F000C4;
	Thu, 15 Oct 2026 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792070398;
	bh=XmTFPFQKWNQCbwKOGMyIvwptcs1NVuc7umRcO5tIaEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2+OvKqtQbt4MeL45W1VNDsC8TbMWIM6miExxgO6+CoHN2bvfRNW455gOXdFAgA5u
	 jBaaj8CITkLsB6ZmIGx26zvKIjThAV+sL8Vpuzb/+lupc0/ktQBAOTchax63Ku7U6J
	 QXQY3rcDX0oBW9ib/tTHERY7WSHWa3RLNpIq/YtBEmEvqqiIOkKp8GqwZOOzSh/fHd
	 WhP5PQJm6+B3at7BH07/upxc/fPk6A+n5UpzDy19iEo8WgB4pwRbnjeVLr581GSN9I
	 x/RzGYMpedzPMAGzrm1Xy6FwPdKBUEbLDKseX9HkuRA3stx/YU62HYrZXrV4XvgJ4W
	 wais4Bak8XRVw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Nam Cao <namcao@linutronix.de>, Naveen N Rao <naveen@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject:
 Re: [PATCH v5 1/2] riscv: kprobes: reject probes inside LR/SC sequences
Date: Thu, 15 Oct 2026 22:19:54 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261014094415.374-2-yuanxiaofeng@eswincomputing.com>
References: 20260828091202.1124-1-yuanxiaofeng@eswincomputing.com
 <20261014094415.374-2-yuanxiaofeng@eswincomputing.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261015131956.183661F000C4@smtp.kernel.org>

On Wed, 14 Oct 2026 17:44:14 +0800, Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> wrote:
> A trap taken in the middle of an LR/SC sequence clears the load
> reservation, so an SC following the probed instruction always fails and
> the enclosing retry loop re-enters the breakpoint, livelocking the CPU.
> Reject probes of the LR/SC instructions themselves and of any address
> between them.
>
> arm64's kprobes rejects its equivalent exclusive load/store instructions
> and, in arm_kprobe_decode_insn(), walks backward from the probe address
> (bounded by the enclosing symbol) to reject any address inside an
> exclusive sequence.  RISC-V cannot walk backward because
> variable-length instructions make instruction boundaries ambiguous, so
> walk forward from the enclosing symbol, a known instruction boundary, up
> to the probe address and track whether an LR is still outstanding.
>
> A Zalrsc-constrained LR/SC retry loop holds at most 16 instructions, so
> an LR more than MAX_LRSC_GAP instructions ahead of the probe cannot
> start a sequence containing it.  Count instructions, not bytes:
> compressed instructions would make a byte window ambiguous.
>
> The LR/SC instructions themselves are rejected in
> riscv_probe_decode_insn(), and an address inside a sequence is rejected
> in arch_check_kprobe().
>

Looks good to me from kprobes maintainer's viewpoint.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>
> ---
>  arch/riscv/include/asm/insn.h          | 33 ++++++++++++++
>  arch/riscv/kernel/probes/decode-insn.c |  2 +
>  arch/riscv/kernel/probes/kprobes.c     | 63 +++++++++++++++++++++-----
>  3 files changed, 86 insertions(+), 12 deletions(-)
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
