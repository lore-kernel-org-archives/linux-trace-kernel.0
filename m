Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965925F7AC;
	Mon, 24 Mar 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823565; cv=none; b=R3FXFmrppb0IR5o0M3SpeWBF7H1v9AI+Fm8MORDHQupUpivM1UuZKql04TqQF8oTCH3j4XfPO8oDm/rBgXT2x6SOzoZUhMrDdwSy8yrU1zlKVAi3XmXUD3w/U3lytvidQBKwgDqHfNg+cc4maH5L26u2JqOaofY/gfZhCFIJEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823565; c=relaxed/simple;
	bh=EzpZ5jy/OB0YYBQlrkWGvh1GOdX8+dvl0ffEE/Sm/+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8MmK83YavMNYXiMwN8X6pxuPUIaDvBuLGH8qJ+QXEDhNJnWmyAmo7WmdreZocnscnqVS3Mb0DAo+dCzpPUmK2SEbRHkRFU2EsgL3aQnl+DyKujJwWSU8QfkpiTx4BToC9sQNRFU6YYVJcUSBWqzeRyYa/gvHN6Iv4pASDQ2RNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007D9C4CEE9;
	Mon, 24 Mar 2025 13:39:23 +0000 (UTC)
Date: Mon, 24 Mar 2025 09:40:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix synth event printk format for str fields
Message-ID: <20250324094005.045cd547@gandalf.local.home>
In-Reply-To: <a5af352b-9f0d-4280-8d7b-e72597e6265d@arm.com>
References: <20250318180939.227696-1-douglas.raillard@arm.com>
	<20250319211858.6d8166e3fb202e6e5a658557@kernel.org>
	<9d234136-05b9-46b6-849f-901df83bf54c@arm.com>
	<20250324144551.fc290f9cf9f57b3d2f205354@kernel.org>
	<a5af352b-9f0d-4280-8d7b-e72597e6265d@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 10:18:50 +0000
Douglas Raillard <douglas.raillard@arm.com> wrote:

> > https://lore.kernel.org/all/b6bdb34e70d970e8026daa3503db6b8e5cdad524.1601848695.git.zanussi@kernel.org/T/#u
> > 
> > So, I think it should always print the STR_VAR_LEN_MAX value.  
> 
> That makes sense. It's tempting to keep the actual length value though as native Rust strings are not null-terminated, so
> it could make it nicer to emit events from Rust code. From a cursory look, the in-tree Rust code seems to be using both
> &str and &CStr (the latter being null-terminated for FFI needs) so I'm not sure what's the plan around those
> and what's the established convention if any.
> 
> > Steve, can you check it?

So I did take this patch, but thinking about this more, I may remove it.

The __get_str() doesn't expect a string end. The parser should limit it, as
the length of the string is saved in the ring buffer. Just like other trace
events where dynamically size strings only use "%s" and __get_str().

I think the real fix is to replace the "%.*s" with "%s".

-- Steve
