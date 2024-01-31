Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5862912BEA8;
	Wed, 31 Jan 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717626; cv=none; b=gMuee71rhQjKAV0ggKSzlbzY/hcNZc8QYQiHyiNcC+GWaA5xcBvKFRgjXx3xhFfJ1+aF5rm5oVif2TdJubLJJyMcXQ9S/PDs1PwrH3znR+G+n/PEsIza9Ypao9Y5UMMTxrKqJ+m+BmVN0vzmWi+bAAtDH0xINifQy0OcIU4koQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717626; c=relaxed/simple;
	bh=Y9p7Qys8VYoI5vR/TxJmHQmVhklAbcJAcFqAVVpM4GY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hndHPRYdPgT67lK4rGoAy3KeXay/0Eaff+FFpz1dQ2YgIml3bVni+zmMpNGBySPF/gRuSadIOU+pGNkNrGsPIGevf/PmW5dZzaDY7XzE/NNUhKPg3ilUpLF9pbpVI3vBRc2j9qu1IUlR6QKKfOKOUsrsihYOzUoEs2K2jwjNpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAB6C433F1;
	Wed, 31 Jan 2024 16:13:44 +0000 (UTC)
Date: Wed, 31 Jan 2024 11:13:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240131111358.5506645a@gandalf.local.home>
In-Reply-To: <20240131105847.3e9afcb8@gandalf.local.home>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<20240129152600.7587d1aa@gandalf.local.home>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
	<20240129174950.5a17a86c@gandalf.local.home>
	<CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
	<20240129193549.265f32c8@gandalf.local.home>
	<CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
	<CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
	<20240130132319.022817e8@gandalf.local.home>
	<CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
	<20240130143734.31b9b3f1@gandalf.local.home>
	<CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
	<20240131105847.3e9afcb8@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:58:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -788,6 +717,7 @@ static void init_once(void *foo)
>  {
>  	struct tracefs_inode *ti = (struct tracefs_inode *) foo;
>  
> +	memset(ti, 0, sizeof(*ti));
>  	inode_init_once(&ti->vfs_inode);
>  }
>  

Note, that inode_init_once() also does a memset on the entire inode, so the
initial memset is redundant on the inode portion. But I didn't think it was
really worth the time to complicate the code by optimizing it. I guess if I
changed the structure to:

 struct tracefs_inode {
+	struct inode            vfs_inode;
	unsigned long           flags;
	void                    *private;
-	struct inode            vfs_inode;
 };

I could have it do:

	memset_after(ti, 0, vfs_inode);

But this can be done as a separate clean up and doesn't need to be done now.

-- Steve
