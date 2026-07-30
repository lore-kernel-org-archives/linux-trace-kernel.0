Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FEB35C68B;
	Thu, 30 Jul 2026 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785377095; cv=none; b=NfoUFpgSLCA/alPbbj0fn4J/tuSQwzT0eH+JjxH/KBZVMIM7Ah85soQAsJsIY3775asE+RDdZW3W1aSV3JzxQzw2YqHEAId5LWPGYIaP8ikYpzp+lHsSYysTqAymETXmhHv/HOB4WrS/pe2OPg5fbvA/o+LqKHK9RIeHcDZmDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785377095; c=relaxed/simple;
	bh=zU+NXLxbD6T98Nj2IkXeSl85Avx09Xj+pSc8IUtjEM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPZAcVeqnt4DdU+/+RtzJOH+4x854Imekj32UBBp9wmupNqxWCg1L6w/UR+G6JIWZwraHP+7BI/PmFm5/ffI0SxPpBACu9a6MTdAxUAYbKOXyAM+NUQoeXpEvnVo6wXvnX7ep6zpKMf+k73eiftc14S2Nn+Lg4M2kG0EUQn+oKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 695EEA0842;
	Thu, 30 Jul 2026 02:04:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 9924D18;
	Thu, 30 Jul 2026 02:04:49 +0000 (UTC)
Date: Wed, 29 Jul 2026 22:04:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/snapshot: Avoid CPU buffer swap during
 reserve/commit
Message-ID: <20260729220448.13d19821@robin>
In-Reply-To: <20260730011912.2325121-1-wutengda@huaweicloud.com>
References: <20260730011912.2325121-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9924D18
X-Stat-Signature: 5oe1hnykwjst1xkp3ahsspoix49qqqq8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX196k5MIcTKcxopGRtZe9inSefTzXn1XYjw=
X-HE-Tag: 1785377089-501438
X-HE-Meta: U2FsdGVkX1/qUsYBEpbPmiT3gjaKQz0UBrliS3rOLZ31PGg59iMU5LhbBEQqz4HIOqh8f3BeMPM/dA2w0DgoJl4xCLPQrwflUJSst/KI/4ipt7+KAuYm6KOYQArxWoo7m9p48oocvrwU1vF6Uyy1csT6YCnzrzQlxA0Goao845TLcXkYVWJzzMg45Fg2qTBxCQkaG1FZ6WnUC4cbxWWWkYJKxuLGvA+n5WpbhHJk8RMWpYzEuZTpa34MXATMQ6EzTu/YPfl18NnN0kSBkFjyU7XBJSFpYnGEIqMvvU1ylj9ieXR58o5fsDWg7SviiSc7WJKQx5OlMzEI3gQ0OO+QfY93uDJGIX1+

On Thu, 30 Jul 2026 01:19:12 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:

> Commit 3163f635b20e ("tracing: Fix race issue between cpu buffer write
> and swap") fixed most of the race conditions between snapshot's
> ring_buffer_swap_cpu and ring_buffer_lock_{reserve, commit}. It achieved
> this by replacing the asynchronous swap with smp_call_function_single to
> trigger an interrupt on the target CPU to handle the swap.

I'm curious. How did you discover this race?

> 
> However, this interrupt can still break in at any point during
> ring_buffer_lock_{reserve, commit}. Currently, ring_buffer_swap_cpu()
> relies on a cooperative check where cpu_buffer->committing is combined
> with a condition in rb_reserve_next_event() that verifies if
> READ_ONCE(cpu_buffer->buffer) != buffer to ensure state consistency. In
> principle, once the execution passes this conditional check, no issues
> should arise as long as cpu_buffer->committing remains non-zero.
> Unfortunately, there is a window where cpu_buffer->committing can drop
> to zero, which subsequently triggers a warning during rb_commit:
> 
>     ring_buffer_lock_reserve
>         cpu_buffer = buffer->buffers[cpu];       // cpu_buffer_a
>         rb_reserve_next_event
>             rb_start_commit // inc committing
>             if (unlikely(READ_ONCE(cpu_buffer->buffer) != buffer)) {...}
>             __rb_reserve_next
>                 rb_move_tail
>                     rb_end_commit(cpu_buffer);   // dec committing => 0
>                     /* smp_call interrupt hits here, successfully swaps! */
>                     local_inc(&cpu_buffer->committing);
> 
>     ring_buffer_unlock_commit
>         cpu_buffer = buffer->buffers[cpu];      // cpu_buffer_b
>         rb_commit
>             rb_end_commit
>             RB_WARN_ON(cpu_buffer, !local_read(&cpu_buffer->committing))
>                                                 // triggers warning
> 
> Instead of maintaining fragile complexity to allow the swap to intervene at
> arbitrary points, simply replace smp_call_function_single with work_on_cpu.
> This ensures the swap operation runs in a process context on the target
> CPU, guaranteeing it only executes after ring_buffer_lock_{reserve, commit}
> has fully completed.

No this is not the answer. The issue is with the ring buffer swap code
but you band-aid in with a fix to the user of the code. The fix needs
to stay with the ring buffer. Yes that means it needs to handle the
case where an interrupt comes in at a page swap.

It needs to find another way to know that it's in the middle of that
swap, and return an -EBUSY from the interrupt.

-- Steve
