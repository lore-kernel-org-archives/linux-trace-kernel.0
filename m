Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B984355814;
	Thu,  6 Aug 2026 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785980607; cv=none; b=gsXs3uogreJ+iXuNAsX9PNNWEkN8x6KuNGonTCavCv/r5RGN2xAWVC7h3kDBUkyYZnaW34gFe1sA0ufAztltky44oFC8MIrW8d1mD71uap9aFaDaVUFbiaeXUznFKHAr76QUU8PtBVGllWoZPz+fT88P0JKMUxn1ZXH+3xS1HBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785980607; c=relaxed/simple;
	bh=aUVQpZ9TGXFG+OuzKwY7OTMtKFIj6/7LtQwruWp4Css=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRzpln1rQVtHqiAt3zL+dSMC+xdQVSckD9DQ2lrlG++5C9Gl/okD7DSTRpS4FwOn570fmblxHPFFbLtvreZ3QzBJKal1ywrz/rsJzGJrIpihjbPeXEXM8YLvAzH3liq01Tv9zetKf3sZFAu51M7Bla/tD3j4jQASNGpB7V39Cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8AA804061A;
	Thu,  6 Aug 2026 01:43:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 9C67D1A;
	Thu,  6 Aug 2026 01:43:15 +0000 (UTC)
Date: Wed, 5 Aug 2026 21:43:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+0168fe25f9e5d46bd5fe@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] KCSAN: data-race in ring_buffer_unlock_commit
 / ring_buffer_unlock_commit
Message-ID: <20260805214314.256f1608@robin>
In-Reply-To: <6a715377.d35e88fd.de8b.000a.GAE@google.com>
References: <6a715377.d35e88fd.de8b.000a.GAE@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: no9a39gipwb5if7ipamf8axdbb5m8mw6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 9C67D1A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18vpxLW1WSe9vHnQTLdhLRq+dNl4ARLoK8=
X-HE-Tag: 1785980595-728088
X-HE-Meta: U2FsdGVkX1//BMWrRi70P+Wp/9JiFrOWWbG8NM4F+Y1TRT4rDGt7qj5CDy/qbULBFYfZEgDvPEY1xPxi6CoStCt5KUDcvyfXmEl3qcHA+mGXlpHfY3REcJ7ljV+WA8HZcJN9SYd40YwNMH+XQCVmZxocaSKgFLnyBJ7SVXaeyGJb++Iur/AiYcdEbSUtGgF3QAAnt74Rc3jUF60OLft6/Bl+5BRacmcVYVsAJ1bUZksgReGvMjl/Jr3NWKbKHnwPIE7Kbgmdkw4my8U2Jzk10z/ACOIeCB3Bqv9BgrHLbgJuQODORWnty8bSekGWMrUUVJkw79m2Y6dKd3Sfg844HE6/kqIDT1HptTu6VaNq0bstFpjXp/7AXwYpH+F+JWefPsGi0yBe0W1p9N1eAgCkpcBT4jcfO7BfwK6MZrspPrvWAqsBUa5JaS3wrjvO/NEJhnF3QZYS/hirqxKaBbkCwJqLAtU2M/SLtx6byo7pAQEsW/6NHxwoNUsfH7DsAyXeoD4SHSHgLMu3TJdKzgd1Q14Ty2ZwCN18lkyvq6nYtgsQVCLp+WKXPZdN0jAO66vri8QTPO50Ybf6CBQ3zZKKSsYFvp4Sex04IulhbJhx0UOtGi4kW0SZbIok6oyMDwGPA8DwhjLpaF3wJp2gNf2+hQ==

On Mon, 03 Aug 2026 19:50:31 -0700
syzbot <syzbot+0168fe25f9e5d46bd5fe@syzkaller.appspotmail.com> wrote:

> 
> Unfortunately, I don't have any reproducer for this issue yet.

Looks to be a false positive.

> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d1a0ae21bd78/disk-848acc8f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9be505d18eb6/vmlinux-848acc8f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8ab6a3838bc0/bzImage-848acc8f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0168fe25f9e5d46bd5fe@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in ring_buffer_unlock_commit / ring_buffer_unlock_commit
> 
> write to 0xffff888100074cb4 of 1 bytes by task 8271 on cpu 1:
>  rb_wakeups kernel/trace/ring_buffer.c:4295 [inline]
>  ring_buffer_unlock_commit+0x6a/0x440 kernel/trace/ring_buffer.c:4495
>  __buffer_unlock_commit kernel/trace/trace.h:1697 [inline]

> 
> read to 0xffff888100074cb4 of 1 bytes by task 8264 on cpu 0:
>  rb_wakeups kernel/trace/ring_buffer.c:4294 [inline]
>  ring_buffer_unlock_commit+0x54/0x440 kernel/trace/ring_buffer.c:4495
>  __buffer_unlock_commit kernel/trace/trace.h:1697 [inline]


> 
> value changed: 0x01 -> 0x00
> 

The code is this:

        if (buffer->irq_work.waiters_pending) {
                buffer->irq_work.waiters_pending = false;
                /* irq_work_queue() supplies it's own memory barriers */
                rb_irq_work_queue(&buffer->irq_work);
        }

The detection is against the reading of waiters_pending and setting of
it. When a task is waiting for data, it will set waiters_pending when
there should be a wake up, and it doesn't need to be woken up
immediately. The first writer that sees this set will call the
irq_work_queue() which has all the necessary memory barriers needed to
make sure it is queued properly. But we do not care about this data
race here. We do not need to have memory barriers here because this is
a "lazy" call. That is, it doesn't hurt if it misses the check or
multiple tasks enable it here. Things will work out later.

I guess the "fix" is to quiet this warning.

-- Steve

