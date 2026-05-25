Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F113A7F68;
	Mon, 25 May 2026 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779692329; cv=none; b=jDaCdHSGmEUvimgTjFJxP2OnKpfhYXtsQvzV7s7dep9ohZzCIIzRLhVqEBWh6HX1FtTsSCoUeUp/wgBKJLkQ/iENFlFgzfqQeTwQhZ06CKwBaZDLn5k92sn3nXCY2le4cOTeoE953d5CqCu6q8XH+HYznIGxcMDFTwjkr/9gI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779692329; c=relaxed/simple;
	bh=uCtAxEldoRH22CpG4fkZRj0mePT37G2v8r21dOq1gSw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m9ckw0Qlec8oRR2aRNXxwDkKXJ9FBk7ab2d7YliuL9CvMa7rrTtwbPzyuk/ZEZFS4wjjRyT8xgVlrpw+hAAPXCbTCQC3q9gLA38S24nWhngAudxgyTkzZoznaDsenZivfcHk4Ikxq4wOL9Gjqz/GQn38dpB9hBYuKpcO8l001VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flBwgnmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flBwgnmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DDC1F000E9;
	Mon, 25 May 2026 06:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779692325;
	bh=OKHcCSh/5UARppAcfMiYEQyBQ3tGtdQ1BhYUBy/jnPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=flBwgnmtE57H9zF3clGAshvA4+Rj4r4ALj+FvTjwn6RoyyWuO0am5BXa3Sj08tk9C
	 yAU+WaJPGwZ8AT/lGGvqZWYAhL4kAPjDAe35WPt1oMFb+bWJPjII07jrH5lpQLTKKh
	 jXdmuFkTEnFvpfE/6auq978iBSq3fR8KfD8uq+qtx+S/yl6LXCiVrdIysQD49sQ07t
	 jywWWJpy/Q5FdZyQ3wLq9m7/uvSHIC3LwTPxUy+8ddXo6vCBo9+Zmt71Kb6I1XVjmo
	 ZL9fQoLmTkzWr/gGktSLWggu+qPyFfVv3zgMUDhOL5UzxlfPKY4svcYxi03mcFhh6T
	 fdKU8LuzANmrw==
Date: Mon, 25 May 2026 15:58:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org, cmllamas@google.com,
 zhangbo56@xiaomi.com, lipengfei28@xiaomi.com, lkp@intel.com
Subject: Re: [RFC PATCH v2 0/3] trace: stack trace deduplication for ftrace
 ring buffer
Message-Id: <20260525155841.b15adcd50d25485aab287043@kernel.org>
In-Reply-To: <20260522104017.1668638-1-lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
	<20260522104017.1668638-1-lipengfei28@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Pengfei,

On Fri, 22 May 2026 18:40:14 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

> From: Pengfei Li <lipengfei28@xiaomi.com>
> 
> Hi Steven, all,
> 
> This is v2 of the ftrace stackmap series. It addresses the Sashiko
> review at [1] and incorporates the kernel test robot's toctree fix.
> 
> The series adds stack trace deduplication to ftrace. When the
> stacktrace option is enabled, the ring buffer stores a 4-byte
> stack_id instead of a full kernel stack trace, while the full
> stacks are exported via tracefs.

Sashiko still made some comments on the series. Please review it.

https://sashiko.dev/#/patchset/20260522104017.1668638-1-lipengfei28%40xiaomi.com

And reply to the comment on this thread, so that we can discuss it
here.

Thanks,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
