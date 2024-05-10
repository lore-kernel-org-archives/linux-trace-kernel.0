Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E01C6B8;
	Fri, 10 May 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366576; cv=none; b=IYBIk8w47GzJ6fWrm3EER+/ad43vKamYN1XTiLuxkkzCI+0gmx4sctRYlAcf3Me4eI2CUpNp1mYMxX96vZqo2R+KW3lGnQGwjJIwVBpP4inpifWsz2pqM8QfFQTlfk/m22zl7rOaTAQ3TZi3C4hsM0UDSu7u0nb9LaV5+Ss7VoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366576; c=relaxed/simple;
	bh=gms4cnzhR0dzSd+wzL/32mivfCz+W751yaMNuoAxlII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEe8V3CREX//w6EOLjE5MC898aGqW7kmF3L8bIJLsFKKqCwzp9EAfwBImkwP0PppW/ItTAOxXRF6Z7tEmEdB3Olw3Pp19MrlioM1ZIn87WXNyoe9TJJtExu0VUMxKG/9jKpMNVfj6q+gA91FwoAjOqiTjZ5oBuveeUWhtCCQLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C08CC113CC;
	Fri, 10 May 2024 18:42:55 +0000 (UTC)
Date: Fri, 10 May 2024 14:42:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: David Hildenbrand <david@redhat.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, rppt@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240510144253.4b865a40@rorschach.local.home>
In-Reply-To: <Zj3-8GHR_EiWY7lB@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
	<20240430111354.637356-3-vdonnefort@google.com>
	<20240507223402.206d6ddc@rorschach.local.home>
	<cc719813-ba73-461f-8b45-4728f926c151@redhat.com>
	<Zj3-8GHR_EiWY7lB@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 12:03:12 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > I'm not particularly happy about us calling vm_insert_pages with NULL
> > pointers stored in pages.
> > 
> > Should we instead do
> > 
> > if (WARN_ON_ONCE(s >= nr_subbufs)) {
> > 	err = -EINVAL;
> > 	goto out;
> > }
> > 
> > ?  
> 
> I could also nr_pages = p in the event of s >= nr_subbufs... but that
> really that shouldn't happen so let's return an error.

I'm good with this. It should never happen anyway.

-- Steve
