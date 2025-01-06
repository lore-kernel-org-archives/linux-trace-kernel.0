Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B21DC99C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jan 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174075; cv=none; b=jlhYwwsUXUGHnPBNmoHGYBxgd+Hw8RL9QsoJ77mvF2yrtJeBF5GO+BeUUtNApgol1Q0megUbse39Uy5LVXty33zfiqbU/mdGqpgRzq2DD35gjleCufdikmI3K9eaKF6jqMDAe9TOrkyMPPXqcY8TJMWfh3wsmvcj4MM5b8IECvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174075; c=relaxed/simple;
	bh=UddgXHeNXrTdAWQwdkvd8e74yT9U7yR5EFPjHeFx/nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPcnzqyxecQjH/St0sgxdLl60taKblC6MsJ/joR5uZvL8i9B8K9FiMbLaTuCyg3IAXmUrKBO9DoxBjETruEu7UmSSn3WsWCcaQOU0fAX4Aq/YGsLiXG230j1NisnP5JISSJOhyasYpyO2T3Zhp67Kls1LLqmaRaeORA4VXAY7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F02VCGg5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F02VCGg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736174072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wvkgs5qtUulkp9Uj7lTJhOX9N0/Ly3x5DYBBQu8bINU=;
	b=F02VCGg5k5vgNKyAFoJwUv/rx/wuXRNWZVc39jRkZBGeiakvy8iWnMjSxJ7mSOzKrcfkJq
	74cGL+XOHWuvxrc1VDZr5vhgaf/EDxRAlojipcypgEkBCdnGoMlp/KiiOCkRIXWrFtAQpK
	exH3nelIamHznWdNzzISUMmDmc7+HkI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-KQVnzx1bPfu8wRuEEy8J0A-1; Mon,
 06 Jan 2025 09:34:24 -0500
X-MC-Unique: KQVnzx1bPfu8wRuEEy8J0A-1
X-Mimecast-MFC-AGG-ID: KQVnzx1bPfu8wRuEEy8J0A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9C471956088;
	Mon,  6 Jan 2025 14:34:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6083D19560A2;
	Mon,  6 Jan 2025 14:34:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  6 Jan 2025 15:33:56 +0100 (CET)
Date: Mon, 6 Jan 2025 15:33:51 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: DEFINE_FREE/CLASS && code readability (Was: [PATCH v2 2/6]
 Provide __free(argv) for argv_split() users)
Message-ID: <20250106143350.GC7233@redhat.com>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
 <173608127627.1253657.12054758575695672674.stgit@devnote2>
 <20250105141422.GB23059@redhat.com>
 <20250106211946.2a1b1351421298150ca8c6bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106211946.2a1b1351421298150ca8c6bb@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 01/06, Masami Hiramatsu wrote:
>
> On Sun, 5 Jan 2025 15:14:22 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Perhaps we can establish a simple rule that every DEFINE_FREE() or DEFINE_CLASS()
> > should add another #define? I mean something like
> >
> >
> > 	DEFINE_FREE(argv, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
> > 	#define __FREE_ARGV	__free(argv)
> >
> > 	void func(void)
> > 	{
> > 		char **argv __FREE_ARGV = argv_split(...);
> > 		do_something(argv);
> > 		return;
> > 	}
> >
> > This way I can press Ctrl-] and see what the cleanup code actually does.
> > Can save a second or two. Important when you try to read the code you are
> > not familiar with.
>
> That sounds lile a problem of your tool. Do you really need to find the
> DEFINE_FREE()

Yes, ":tag __free_argv" wont work. it is defined by DEFINE_FREE(argv) above.
I need to find this DEFINE_FREE(argv) to see what __free_argv() actually does.

> > Same for DEFINE_CLASS. For example,
> >
> > 	int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
> > 	{
> > 		CLASS(fd, f)(fd);
> >
> > 		if (fd_empty(f))
> > 			return -EBADF;
> >
> > 		return vfs_fchown(fd_file(f), user, group);
> > 	}
> >
> > If you are not familiar with this code, it looks mysterious until you find
> > DEFINE_CLASS(fd, ...) in include/linux/file.h.
>
> DEFINE_CLASS() is somewhat mysterious to me too :) But if I understand
> correctly, it is for intermediate macro for implementing guard().

Well, in this case you just need to find

	DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)

in include/linux/file.h, after that the code is clear.

> BTW, I agree that 'argv' was too simple. Basically the label name of
> DEFINE_FREE() is better to be a function name for free.
> Let me fix that.

Up to you, but __free(argv) looks good to me.

Oleg.

