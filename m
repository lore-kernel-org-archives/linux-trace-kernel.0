Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B52E03FF;
	Tue,  2 Sep 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822325; cv=none; b=i9egcJG3AT33IEhv+p1O4TU7Cg8pGLURj0YJY53uNGh+l2kZ1ja1aVLaMpTH2HhnRdtKHczsRNxAwfKojQIevXswwhhQO7RtnH66fyXCdGD8h96gs/8Ph1xWbLcCUAMrww1V/qpFUyzhwbW/4Kn6KA/qkKDIYf1+0tjSJKnjlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822325; c=relaxed/simple;
	bh=vFk4wZIKLTuP9VFeA1gxmxb/hgZzlz38yZUVJ/2FXd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKLllRj0vxl2WHTltxRFdhSzlhJkFiGwCiYo1j8To/Ea9G9mhlbY3+f5dYJMGoMdgRr+O2hsQ81WUQqgmAKPzXl4zfjSof/Ij35Q/vxiQEL3A4LgEfMyBg5LK6wTZQi0USl/YCkT4/DwKobDcIKbhclOuAlWKetTeFoYVZj+X6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 38965B6B60;
	Tue,  2 Sep 2025 14:11:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 404B720025;
	Tue,  2 Sep 2025 14:11:52 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:11:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Luo Gengkun
 <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <20250902101151.7b6bfabb@batman.local.home>
In-Reply-To: <aLVqyEGoHKVCFGFR@J2N7QTR9R3>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
	<20250819135008.5f1ba00e@gandalf.local.home>
	<436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
	<20250829082604.1e3fd06e@gandalf.local.home>
	<20250829083655.3d38d02b@gandalf.local.home>
	<aLIFRHcsEo2e2GE7@arm.com>
	<20250829181311.079f33bf@gandalf.local.home>
	<aLVqyEGoHKVCFGFR@J2N7QTR9R3>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yfdqd1rqmcrdaxngseijdutusixhu8z3
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 404B720025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3a4ZlCJqnzjOJTHcJTR8oy/SOfj8p6YY=
X-HE-Tag: 1756822312-777584
X-HE-Meta: U2FsdGVkX1//P+0V3cvSYifPjfQTtkjYA3kwKM05QyUhd38/lHcPSo2h/lta995pbi6WwAdjmyuSvNRcAQsD+hL5ESmOEB5mv/qd53yLYb1p6qvs0wiQYvakljuWB/zDPPzSBmB8oUJlf4gQ3Y41+2g7armRU8zyjPg3RdFnYs87QO4MYtihj2V+61TAZk8OPbCCi0IiCH42iaRK2MY7PWspIgcDxkfFj8gpYMhkqzHYKTNOpAMp4LZv2duSryOYi7OlaXm31KgYo0WBZxl8YClJNNLoaTJg3WHoaSNDZP3P2qUPcfiQBuHUlS0za9z0BOM7c6V0RNjIYwm1tIHYYzPk6Gqunk0cY4xhbjUaUxQpVC/DmJcnV9K7jnlg3dLD

On Mon, 1 Sep 2025 10:43:36 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> > So, __copy_from_user_inatomic() is supposed to be called if
> > pagefault_disable() has already been called? If this is the case, can we
> > add more comments to this code?  
> 
> Just to check, you're asking for better comments in <linux/uaccess.h>,
> right?

Yes.

> 
> > I've been using the inatomic() version this
> > way in preempt disabled locations since 2016.
> > 
> > Looks like it needs to be converted to copy_from_user_nofault().
> > 
> > Luo, this version of the patch looks legit, no need for a v2.
> > 
> > I just wanted to figure out why __copy_from_user_inatomic() wasn't atomic.
> > If anything, it needs to be better documented.  
> 
> If that had roughly the same kerneldoc comment as for
> __copy_to_user_inatomic(), would that be sufficient, or do you think
> both need to be made more explicit?

Yeah, it would have been very helpful to have that. Note, my use of
__copy_from_user_inatomic() was added before copy_from_user_nofault()
existed. So it would likely not have been helpful back then ;-)

I think even adding a comment to the kerneldoc of these functions with
something like:

  You probably want to use copy_from/to_user_nofault(). These are more
  for internal handling, and should be avoided unless you really know
  what you are doing.

-- Steve

