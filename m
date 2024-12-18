Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D91F869D;
	Wed, 18 Dec 2024 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541173; cv=none; b=cMyFtz2o36z6kWIHVi81NCzPjSPJ6gy4zimi8/hwRmm8hoHy3VglIGedZienuH79BPCDCSb44SgYIQ3U/PAA0kgOOWGdWnlX2iYVyI6kolODyUIWKl3aAX6TbYVR/eJDphLvQjVwi9TPZGS/IujYtS6akG+UOL7mbL0GvBQKHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541173; c=relaxed/simple;
	bh=daCTuccUA7Hn4WVrOd6TsCBLKO5p4HZUUrr6bDi8JrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M177O5yE45JEjOykS8S7pyoKTUc7C+H4Q+uYgS+wc4xYK9l6w6c4a1bf31bSfBJGyTMKuyfIuRgOM+kb04cHx8eER5hJYqbfO0tpDJQp8vQ4tw262n3zk/+WlvkWdRVMi8I5nvlkFbJHwmdq2K8t/MrEuIMbiZvJKTYWhlVgtu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D12C4CED0;
	Wed, 18 Dec 2024 16:59:31 +0000 (UTC)
Date: Wed, 18 Dec 2024 12:00:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: fix array bounds checking
Message-ID: <20241218120009.47b76bba@gandalf.local.home>
In-Reply-To: <CAO9qdTGwQJvVZt2HtnBUdJGLti0ZWuPeqVFginJYcwY2xLnwRg@mail.gmail.com>
References: <Z2BpY5LimG7E3LpC@google.com>
	<24508411-0980-43EE-8224-C3B81E456AFF@gmail.com>
	<Z2E4cWMkzGqAafFQ@google.com>
	<CAO9qdTGwQJvVZt2HtnBUdJGLti0ZWuPeqVFginJYcwY2xLnwRg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 22:42:53 +0900
Jeongjun Park <aha310510@gmail.com> wrote:

> > Could you share that reproducer? Or at least the steps. As this situation should
> > never happen a, follow-up fix will be necessary.  
> 
> [1] When tested with a reproducer, pgoff was 8, subbuf_order was 0, and
> subbuf_pages was 1. However, nr_subbufs was 3, so oob-read or uaf occurred.
> 
> [1] : https://syzkaller.appspot.com/text?tag=ReproC&x=14514730580000

This was fixed by Edwards patch.

> Okay. In that case, I will just remove the variable declaration related patches
> and send you the v2 patch right away.
> 

I'm not sure this is needed nor is it a bug.

	while (p < nr_pages) {
		struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
		int off = 0;

		if (WARN_ON_ONCE(s >= nr_subbufs)) {
			err = -EINVAL;
			goto out;
		}

The WARN_ON_ONCE() suggests that this should never happen. And I believe it shouldn't.

I'm fine if you want to make the change to:

	while (p < nr_pages) {
		struct page *page;
		int off = 0;

		if (WARN_ON_ONCE(s >= nr_subbufs)) {
			err = -EINVAL;
			goto out;
		}

		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);

But it's not a bug fix. It's simply a cleanup that can wait till the next
merge window.

-- Steve
