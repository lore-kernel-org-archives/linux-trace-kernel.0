Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE7223323;
	Tue, 30 Jun 2026 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854169; cv=none; b=d+kgi4NPUL2wWYaQS2A4TQSr1yD66S+Ro9u5q/8G+gf20IOmhmh8feIlkgcRuBK9dG6EbOTiHsrOnQ5tWeLnCvSOrwbIzI9m468GDFgFnNAOD/WiIlj1dAQxpQIsd7Vulfp9C1TNrbBLAt/xVtbk+A939IEtA28RjE98XyuJckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854169; c=relaxed/simple;
	bh=F4Sv6udOW91L+XLCw8XMr1Hsox64rPOE0WwocVP3v2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHst52RlzB385ZONNw3W/mH1/XVqfSSlYrpNiCFX1tP0pJPEIJGRy+FT+XvBmO9HCM52C69mSI0qHxnUnNyCLNbQLeplnISbt51OVyjW0FWJAskLY2SG5bWYvYApeYDnD3i+9BKXYlxNTFvU6xLTG1NnbHywLj/O1qknmlNgRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 7051414012F;
	Tue, 30 Jun 2026 21:16:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 8CBF533;
	Tue, 30 Jun 2026 21:16:04 +0000 (UTC)
Date: Tue, 30 Jun 2026 17:16:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 petr.pavlu@suse.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: serialize read-page order with subbuffer
 resize
Message-ID: <20260630171603.26530150@gandalf.local.home>
In-Reply-To: <CAMuQ4bV-HJWbS7NHPGtoyKz-_+LR335phbXeOi83EbV6kn+3gg@mail.gmail.com>
References: <20260628004653.28065-1-alhouseenyousef@gmail.com>
	<20260630101425.2f7cfbea@robin>
	<CAMuQ4bV-HJWbS7NHPGtoyKz-_+LR335phbXeOi83EbV6kn+3gg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8CBF533
X-Stat-Signature: y8e76dx3c3yw6yp3mjgdibsz49jm5k55
X-Rspamd-Server: rspamout04
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+F+4wqDMcxAGZsYzDLWrmzESxuh67lbTw=
X-HE-Tag: 1782854164-752502
X-HE-Meta: U2FsdGVkX19Ol9J/H9ZAMtI/5bcn7GBGYzsaVff0/iJk0U1GTw0qEKXqYtTXQtDEqCxbziM7AZUD9mq6TAVLdB7CWXy0WpkVuGXZ34vz5b6hV24+wnFkigzTT/1j2IG2pu2rTwmm+zk6uQOTCPVzIsEeNZ2WtymnB8bS9B00HDi347JuOV4nwMEOO4a2eT1P0PZq4lVszk+h7QX8LQE8rXuB9FtI0PYl3LBY77kteuTDY08iKCv7H9LpOel87IJuW2VmtDWFULFL1dL2lWYd44VkJSUalgTeUCfQyfDVK3kXKoZSmYfqd6otqY8gK0yUtuhgKfVvhfd9UdhyXFR0ixVq53J7bpgZMi9zesR//jXgIyj2jhq9sGF7IjcpaQHB12o5XigB6Mk=

On Tue, 30 Jun 2026 13:45:05 -0700
Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:

> One issue turned up while checking the suggested locking:
> ring_buffer_subbuf_order_set() writes buffer->subbuf_order before
> taking reader_lock and never takes cpu_buffer->lock. An allocator can
> therefore take cpu_buffer->lock after the new order is published but
> before resize clears the old-order free_page, tag that old page with
> the new order, and return it.
> 
> I can keep the allocations outside buffer->mutex and hold the mutex
> only while snapshotting subbuf_order and taking or returning
> free_page. That removes allocation from the critical section and
> serializes the order/free-page pair with resize. Would you prefer
> that, or should free_page and the order transition be synchronized
> another way?

Nothing should be reading when the subbuf_order is being updated. Let's add
a flag to state that it's being updated, and make all reads simply fail
during that time.

-- Steve
