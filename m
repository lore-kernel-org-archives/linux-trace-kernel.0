Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE361D514B;
	Fri, 29 Aug 2025 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505575; cv=none; b=dfFUirEdmDKI/85PPV9zQc8fzjfwAABOUvRY4ZUhK3soSATE19ktMepjxdyiRRXczq8lxRQoo8qjnpILCShur/rKb+TZkDSud0xk+rv2t10xb8vVk5Pu54QtjN9Hkk/q9wqeKnlMYkUh2zpn1Zp0XHoPesr5Ku8qchRvvigYSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505575; c=relaxed/simple;
	bh=Jbs11YUKOmnts3oTww/hHMt2F8PREMt/JsMRsofbfAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKMxB9/PRgeWad41IOeF4iNnlwgmr9KuAxGm4cwayx1+7+L5D4WD0xzwD9ajcZA3ApqzX3QGE34o3TidMcOSsOO6arUCJZwFMz4QcyDoFbIATE+swiV8Nh0sU3UvdFL0WPAe52OOmW7FV4HOs5IbBGlI2DMozDuQ/4AQ2NHroq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 3F9C91DE8E3;
	Fri, 29 Aug 2025 22:12:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id E18871B;
	Fri, 29 Aug 2025 22:12:48 +0000 (UTC)
Date: Fri, 29 Aug 2025 18:13:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <20250829181311.079f33bf@gandalf.local.home>
In-Reply-To: <aLIFRHcsEo2e2GE7@arm.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
	<20250819135008.5f1ba00e@gandalf.local.home>
	<436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
	<20250829082604.1e3fd06e@gandalf.local.home>
	<20250829083655.3d38d02b@gandalf.local.home>
	<aLIFRHcsEo2e2GE7@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E18871B
X-Stat-Signature: c6a9kj37bdpft57yro8x4x8gytdtbg61
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+BzqdLgt0UUBPnn0bUVIRcLzHPfZXhaf8=
X-HE-Tag: 1756505568-420285
X-HE-Meta: U2FsdGVkX1+14SMITpDCqwGTTTH7u0ktZr86FlAwNfKMViAM1uVorStxHxg11gX6GdOLBRu2vlQ4xdJkmMqr/kU+y6jRplHrVO6FKm5/xCTVupKlj21B55P9/239Ph4KAg7piebRvoYzfvpmWdh73CYiF9GDVXIS6AsG36AeDl7MA11cHJx+KQl7CB05DS7uf5OeA46zbfRfB0jkQ1b9lHGdHXgPj7lT8mpIcUiLZRmDDaebBdyTa3H4A2MpDf/AhLsQ6HYnUkKrsD7DR3NW4TVog5jibbaUF6510386z0o+mr7p5el21WqVcmSS32KyBFviWF5hdcpJXO25vdTSofz/Fxy/jL39Bk/pMYZXKc1UaQsG0vIIkFErOrK6toaF

On Fri, 29 Aug 2025 20:53:40 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:
valid user address.
> 
> BTW, arm64 also bails out early in do_page_fault() if in_atomic() but I
> suspect that's not the case here.
> 
> Adding Al Viro since since he wrote a large part of uaccess.h.
> 

So, __copy_from_user_inatomic() is supposed to be called if
pagefault_disable() has already been called? If this is the case, can we
add more comments to this code? I've been using the inatomic() version this
way in preempt disabled locations since 2016.

Looks like it needs to be converted to copy_from_user_nofault().

Luo, this version of the patch looks legit, no need for a v2.

I just wanted to figure out why __copy_from_user_inatomic() wasn't atomic.
If anything, it needs to be better documented.

-- Steve
