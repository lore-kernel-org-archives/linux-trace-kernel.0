Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF4D3C0602;
	Tue,  7 Apr 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576831; cv=none; b=BiPvF5H3ufw0b37LArcvN7GzT1pzwKH/Fy2DFxSbcdUo+mXrOM2ZDa8j731oJg7quwGk/a0IVaS0QHCRgbbb/vX0Av1+ZQffd/vclzif9HMk4yJQPdrCeV9HpiZV8LAsMg9mzVxDrORql6yuW9OxHmVVwDlV4+48yqpbhPM9SYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576831; c=relaxed/simple;
	bh=7QdUQu4v4RC+MLrL/mwbYjVHQzEnZN7pTHsm0bn27Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVPOItHememcNeqnc8OqUjE3B9+CSmst+y44EYxiRRXM4el6o8liGvx5Kv68e5RBXcqc46xE0nsVvXDCBrLjrb0NqOV3/Pre3xwR4+53Bp/t08onsy4wynS93ykNQWCRugn1+mGdUT3qkNGNHriY4xuMpT9fRmjn+M1YvUqQZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 68C711B8BA4;
	Tue,  7 Apr 2026 15:47:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 96DA21B;
	Tue,  7 Apr 2026 15:46:58 +0000 (UTC)
Date: Tue, 7 Apr 2026 11:48:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Cao Ruichuang <create0818@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Preserve true payload lengths in long data
 events
Message-ID: <20260407114812.580c27d5@gandalf.local.home>
In-Reply-To: <20260407091550.67963-1-create0818@163.com>
References: <20260407091550.67963-1-create0818@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 96DA21B
X-Stat-Signature: j4syg4ww95xeahdbhpfs5ph4wky7esbx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18NHeQbL8gUtHGXVGtCh9p3KLKhkodjSgI=
X-HE-Tag: 1775576818-756129
X-HE-Meta: U2FsdGVkX1/9rKCwKKdublgl/jHmXE24KI4qr+vNt4zDQ9ZNhrAQkaSjdhCyf6OwIfvlsoLmHXg+16B9wLpwUk8fZqWnkBGQDzI7FyM3d/tm9He92k0V5JBq6ozGEym2A0Qu5JP1W3OTR51QgXjQudXfv3GaqiQloDd00a6gvollZxwO5VIczjdVbvm59debO0ls6+Pvcopt5zX6zOHK8D968G86WYz8JySdfeLja2OpZqLQnGlY9F+E9Blwq2oeBNOgDi1SaSp1WhUlTbLC8kNpKnIIGM33JvIXURhzw1iN/9pZ0kxgkoCM5rc5uFHHxLIss1t8/AMEmGlCpR+PT+snbRpYdR28

On Tue,  7 Apr 2026 17:15:50 +0800
Cao Ruichuang <create0818@163.com> wrote:

> Long ring buffer data records currently store the aligned in-buffer size in
> their length field. That makes ring_buffer_event_length() report padded
> sizes, and small TRACE_PRINT / TRACE_RAW_DATA records lose their true
> payload length entirely when they use the short type_len encoding.
> 
> Teach long data events to keep the true payload size in array[0], and let
> the ring buffer derive the aligned in-buffer size separately when it needs
> to walk or discard records. Then add a long-reserve helper and use it for
> TRACE_PRINT and TRACE_RAW_DATA so their zero-length-array tails always
> preserve the real payload size.

Sorry, I'm against this change. I made a conscious decision to have the
ring buffer meta data record the size allocated and not the size requested.

If an event needs to know the actual size, then it needs to add that
information itself. That's not the job of the ring buffer code.

NAK.

-- Steve
