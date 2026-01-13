Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB623314B;
	Tue, 13 Jan 2026 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268986; cv=none; b=pirpSotjWviFN8Jh6FlZtzFMAl+icfz+KxvsUjxDaXqmty5xjJFCGjcusn/AmzEd4twi3pCp2oh4b84YaeDjr8p4JsO+BAxNxHhEpsRZCjLNcOYdFeANVI5FYqIU6taJ1Wy1zpw9P6PrVzPSrm8P52GUHwO3etGjragwLZfb98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268986; c=relaxed/simple;
	bh=5I8p2tqBNive2q0EWgybvUYUZT/9DX4bawoOlpAjBIY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JxbhtT86GfDqfqP62MnRlUiz8/VUxscU/YjFuPqcM8msRNtLTlSDoW1R9eyY3Zi6gpXy0FaE1kmYQ4QBeFnv28WLdbVs2iWCxliki9VGBnBCATm8mv7ZghztL5czI1W7UCQvtmPzmUJRaFhOpBYZNN/RTCfmLpeJtalhEzWO4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwYEMfKn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwYEMfKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CE3C19424;
	Tue, 13 Jan 2026 01:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768268986;
	bh=5I8p2tqBNive2q0EWgybvUYUZT/9DX4bawoOlpAjBIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hwYEMfKn8hYAJ1QiZ1ltYOv/Xgt5MfIDcP/RuySWbPmGVdvFeRSg1ycrEIBaDDrPK
	 ZiQXtm6V6F/LRiCgP1eZB6xW3sX6YXRi302vrwngm/o73w5j/ETy7int/AAbhJ//vl
	 ESIHAUnB3MOUeX4ht+M6wFkOXbl9+c6ppnRbHa6qwyRzLc1Qcx7HWYBxLr4jaSqqLB
	 jFf2c79DPtyiaKkkT6yBFopYY86QCI6z7P8FVsAxIwlnLXPseElFMRmwT7giQS2FJc
	 SU9RPXj9bI7BXzX2Pbh+v/eO0cHoY77474QWgqcxl2E5Dky8tv+8dBa2LIVaJMmbFL
	 QWSodvNJ+C6DQ==
Date: Tue, 13 Jan 2026 10:49:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Naveen N Rao <naveen@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Use dedicated kthread for kprobe optimizer
Message-Id: <20260113104942.9eaed0b4c92e85ce33a368cb@kernel.org>
In-Reply-To: <176805562740.355924.11587476104510049915.stgit@devnote2>
References: <176805562740.355924.11587476104510049915.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 23:33:47 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> +static int kprobe_optimizer_thread(void *data)
> +{
> +	set_freezable();

Steve pointed that the kthread usually don't need to be freezable and
the workqueue is not freezable too. So I decided to remove this.

> +	while (!kthread_should_stop()) {
> +		wait_event_freezable(kprobe_optimizer_wait,
> +				     atomic_read(&optimizer_state) != OPTIMIZER_ST_IDLE ||
> +				     kthread_should_stop());
> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		if (try_to_freeze())
> +			continue;
> +
> +		/*
> +		 * If it was a normal kick, wait for OPTIMIZE_DELAY.
> +		 * This wait can be interrupted by a flush request.
> +		 */
> +		if (atomic_read(&optimizer_state) == 1)
> +			wait_event_freezable_timeout(kprobe_optimizer_wait,
> +				atomic_read(&optimizer_state) == OPTIMIZER_ST_FLUSHING ||
> +				kthread_should_stop(),
> +				OPTIMIZE_DELAY);

Also, forgot to add kthread_should_stop() check here.

Let me update to v2.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
