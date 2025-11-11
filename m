Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513203659E7;
	Tue, 11 Nov 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874858; cv=none; b=ehdKl1RxSBh4PnuhdhqzdFp9By1ZpuQ+Rw+iY3rs3VS70Qi4hquZov5BQq+mhEhcpy14W10zI0tq+t0FDfapqSRo9FG3L26G7362DV7ttuUrpT86jfxyq/xfEGJ7GHAytNrS9y63bOBfGS1vAsGh/Zs2Aptqf29C6454p9nHFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874858; c=relaxed/simple;
	bh=RdP21Ou/LCWPijV4U0AV3BnsRA50hwedJ/BvkxuLexY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beYbvsBnkrryu4fpHachl5oMKtWOZekD1j4SbYU5o636ESVxTQQYp6K4Ahs6QnqVk9sIUk8jyp46AnhPxgmlyxccZOe6Aby72/A2JmOUTcSSyEd0FfNJeLa9spOUwFVHl50RMxKfulYzN/71Bm9H3ecN1azlUUadg2XjW7Ow4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 94B7A1A0624;
	Tue, 11 Nov 2025 15:27:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 7CC5C20016;
	Tue, 11 Nov 2025 15:27:32 +0000 (UTC)
Date: Tue, 11 Nov 2025 10:27:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yongliang Gao <leonylgao@tencent.com>,
 Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251111102739.2a0a64cf@gandalf.local.home>
In-Reply-To: <20251111081314.j8CFfAD6@linutronix.de>
References: <20251015114952.4014352-1-leonylgao@gmail.com>
	<20251110183854.48b33b50@gandalf.local.home>
	<20251111081314.j8CFfAD6@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 93iykqfd8ceuhfporiimdq1ydp7a4psr
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7CC5C20016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188dX1bD/SwmX7HXHXilJtoAHX/YYaiNn0=
X-HE-Tag: 1762874852-941565
X-HE-Meta: U2FsdGVkX19EYztomkJkw56ktu5OzmaON7MEz6NgDVd+CimUpGbdQfmPZ9BkhmKBxzgKiIDhODgZY/hamCRbivoZw2pC8PyG7hTYP3UIJmst6EVVlAsO/s9ja9jURwrPhCCl9Wb+XRhXxg1QTMI9XqVq1mBQms5q0uPkyGZeexGjj9IjLdpuOovAiMSgKoYvGiz5j6h6xZGVdjjL4zxgecD96d/CfAAccqgLQz3vpP25S2cfnJ2WeBxmSwt+fquRa/ayosK6r3fQF3TOGcOn/S6ro2hKXR76UR3RUkjjMXik89PjtsqfUhUpEoOInCAt

On Tue, 11 Nov 2025 09:13:14 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Nope, no read-write lock that can be used in atomic sections. Well,
> there is RCU.

Well, it can't simply be replaced by RCU as the write side is also a
critical path. It happens when new tasks are spawned.

Now we could possibly do some RCU like magic, and remove the lock in the
read, but it would need some care with the writes.

Something like this (untested):

bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
{
	union upper_chunk *upper_chunk;
	union lower_chunk *lower_chunk;
	unsigned long flags;
	unsigned int upper1;
	unsigned int upper2;
	unsigned int lower;
	bool ret = false;

	if (!pid_list)
		return false;

	if (pid_split(pid, &upper1, &upper2, &lower) < 0)
		return false;

	upper_chunk = READ_ONCE(pid_list->upper[upper1]);
	if (upper_chunk) {
		lower_chunk = READ_ONCE(upper_chunk->data[upper2]);
		if (lower_chunk)
			ret = test_bit(lower, lower_chunk->data);
	}

	return ret;
}

Now when all the bits of a chunk is cleared, it goes to a free-list. And
when a new chunk is needed, it acquires it from that free-list. We need to
make sure that the chunk acquired in the read hasn't gone through the
free-list.

Now we could have an atomic counter in the pid_list and make this more of a
seqcount? That is, have the counter updated when a chunk goes to the free
list and also when it is taken from the free list. We could then make this:

 again:
	counter = atomic_read(&pid_list->counter);
	smp_rmb();
	upper_chunk = READ_ONCE(pid_list->upper[upper1]);
	if (upper_chunk) {
		lower_chunk = READ_ONCE(upper_chunk->data[upper2]);
		if (lower_chunk) {
			ret = test_bit(lower, lower_chunk->data);
			smp_rmb();
			if (unlikely(counter != atomic_read(&pid_list->counter))) {
				ret = false;
				goto again;
			}
		}
	}


And in the set we need:

	upper_chunk = pid_list->upper[upper1];
	if (!upper_chunk) {
		upper_chunk = get_upper_chunk(pid_list);
		if (!upper_chunk) {
			ret = -ENOMEM;
			goto out;
		}
		atomic_inc(&pid_list->counter);
		smp_wmb();
		WRITE_ONCE(pid_list->upper[upper1], upper_chunk);
	}
	lower_chunk = upper_chunk->data[upper2];
	if (!lower_chunk) {
		lower_chunk = get_lower_chunk(pid_list);
		if (!lower_chunk) {
			ret = -ENOMEM;
			goto out;
		}
		atomic_inc(&pid_list->counter);
		smp_wmb();
		WRITE_ONCE(upper_chunk->data[upper2], lower_chunk);
	}

and in the clear:

	if (find_first_bit(lower_chunk->data, LOWER_MAX) >= LOWER_MAX) {
		put_lower_chunk(pid_list, lower_chunk);
		WRITE_ONCE(upper_chunk->data[upper2], NULL);
		smp_wmb();
		atomic_inc(&pid_list->counter);
		if (upper_empty(upper_chunk)) {
			put_upper_chunk(pid_list, upper_chunk);
			WRITE_ONCE(pid_list->upper[upper1], NULL);
			smp_wmb();
			atomic_inc(&pid_list->counter);
		}
	}

That is, the counter gets updated after setting the chunk to NULL and
before assigning it a new value. And reading it, the counter is read before
looking at any of the chunks, and tested after getting the result. If the
value is the same, then the chunks are for the correct PID and haven't
swapped in a free/alloc swap where it's looking at a chunk for a different
PID.

This would allow for the read to not take any locks.

-- Steve
