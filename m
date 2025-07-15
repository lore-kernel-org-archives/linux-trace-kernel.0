Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EA4367;
	Tue, 15 Jul 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752540861; cv=none; b=nQsOoLSdkKFqJtNuMX3R5fWPhJ8wKjRYlh15JZlqYnF0c9LCGFhMDk3pJFGANwBBX2sOXGMrZeZOELE85t1p5+ai8Gmer1hMWN82RBnMSOvJZhkrvxlLG4UBeVxE8PCDx345JX+sVr+7Uq1YLgo/aHZ5xq7LUUs+cj6rmoJiLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752540861; c=relaxed/simple;
	bh=5b48nLlJscjR9P3xrbH7jjA3n7uXVI0nklFrpo/B3Mg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rh2j5dxk1BaBH7eFzMBOS8rGVsmW09nCcD8dimxR/MYV5DoVrRf7uBFIq7F7M/zg8iE0lVA/nG167hqh6qALa7HOYlG/O3D6WXz4LMh8hM3ZVnmBvFuiqAOnLqd+Ewijs3iiUFFSK1fMLn491yEtaWPZG0A7STnHpcDiX6R8GYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMU4X6x4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMU4X6x4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DB0C4CEED;
	Tue, 15 Jul 2025 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752540860;
	bh=5b48nLlJscjR9P3xrbH7jjA3n7uXVI0nklFrpo/B3Mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YMU4X6x4twboBy9Ts5+PNQavD1lD4a9kkdMnvo6EEIQG86WfdyFI4omWYAFCJE5Xn
	 r2tPF0N8Yxmk16RzAx0SuVmIKWlT3A0GRytnREJSzGvq4nMAqueIS9Jt5a4cWiM7sI
	 rXBtHQo47EOa3xfn5igW6sV3tqcBkpe0pnrZ6bcpNZu9uFM+tb1qbVx6qbnQwojYi6
	 sDrrAYYcB8gNTebZ2aBWmtZzBP8KK5tGLh+DuHVoiT05ha5Q4+XGjmkZRksHA1sou3
	 eX5bHgAYPHDwkUK1Re4svADBDUuk6QErrRW0CyJ6j0Etyv6/oSRU8PKS5oKcO4eMZv
	 05f9P/yLpXiUQ==
Date: Tue, 15 Jul 2025 09:54:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: <jiang.peng9@zte.com.cn>
Cc: <naveen@kernel.org>, <anil.s.keshavamurthy@intel.com>,
 <davem@davemloft.net>, <mhiramat@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] kprobes: Add missing kerneldoc for __get_insn_slot
Message-Id: <20250715095417.a14bed2f6437bb0545fa163c@kernel.org>
In-Reply-To: <20250704143817707TOCcfTRWsO5OAbQ2eYoU9@zte.com.cn>
References: <20250704143817707TOCcfTRWsO5OAbQ2eYoU9@zte.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 14:38:17 +0800 (CST)
<jiang.peng9@zte.com.cn> wrote:

> From: Peng Jiang <jiang.peng9@zte.com.cn>
> 
> Add kerneldoc for '__get_insn_slot' function to fix W=1 warnings:
> 
>   kernel/kprobes.c:141 function parameter 'c' not described in '__get_insn_slot'
> 

Good catch! Let me pick it for-next.

Thanks!

> Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
> ---
>  kernel/kprobes.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ffe0c3d52306..ab8f9fc1f0d1 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -135,8 +135,12 @@ struct kprobe_insn_cache kprobe_insn_slots = {
>  static int collect_garbage_slots(struct kprobe_insn_cache *c);
> 
>  /**
> - * __get_insn_slot() - Find a slot on an executable page for an instruction.
> - * We allocate an executable page if there's no room on existing ones.
> + * __get_insn_slot - Find a slot on an executable page for an instruction.
> + * @c: Pointer to kprobe instruction cache
> + *
> + * Description: Locates available slot on existing executable pages,
> + *              allocates an executable page if there's no room on existing ones.
> + * Return: Pointer to instruction slot on success, NULL on failure.
>   */
>  kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
>  {
> -- 
> 2.25.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
