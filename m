Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07915532A
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Jan 2025 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736086507; cv=none; b=ueYNYqmlbLcU8/t9EFt2R0JJZ4tXTFbwfUmGzdfycBQ0J0ywjg5Dhee0xX+wiK7dj3Eey5cvEu5ivZcLgmPFcaZj50qoAD1BQUtd3mO2/xdIIXBzG8aWutvtJcFoHg/+aum3yuCSIOujPCa7LQ2v2qcjqJjOKJfkIM7eFFVP64g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736086507; c=relaxed/simple;
	bh=Cwt6zGhswuXHFT5MPd3pyLuUFvOSQGnXnMN3X3ndu4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2d8gq6Flq/tSvXluLxd3Os2Lc3m4De82pehK39ckIH9SSiBUUmKdbdTVFf9ZVge9XuC3BBt9ON5S2atAYOsGzR229R86de0QxFwPUyk+4TrqVy9q25JYPRrgQObe5mC5MWa1JUXTvDqaXF5hFz397EEyNclHeLnPHeFcDc8keM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICe/qEKn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICe/qEKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736086504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tSzj3x9fbDLRI8TQLtBSw5QmDyqxUUxjf968LhVajBU=;
	b=ICe/qEKnqD36eKydZgUAJ6P71EKRF/yaORDAmN4sW7FFKTSXIKaa/w785FEdTFuHB1KbwZ
	jXqwjfenkrHfXwawCTOWrADYmalutapIJG0W4OHqiESgSQAjshEeoPWBcdKFkhcS+5yAT8
	IVbkeWh2DZM2v6XMCH5Pw15dc1+FXJQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-p8NXdqQ4OJiVL07gzL3o-w-1; Sun,
 05 Jan 2025 09:14:56 -0500
X-MC-Unique: p8NXdqQ4OJiVL07gzL3o-w-1
X-Mimecast-MFC-AGG-ID: p8NXdqQ4OJiVL07gzL3o-w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 992E119560A2;
	Sun,  5 Jan 2025 14:14:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DA22D300F9B7;
	Sun,  5 Jan 2025 14:14:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  5 Jan 2025 15:14:28 +0100 (CET)
Date: Sun, 5 Jan 2025 15:14:22 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: DEFINE_FREE/CLASS && code readability (Was: [PATCH v2 2/6] Provide
 __free(argv) for argv_split() users)
Message-ID: <20250105141422.GB23059@redhat.com>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
 <173608127627.1253657.12054758575695672674.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173608127627.1253657.12054758575695672674.stgit@devnote2>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Masami,

Sorry for abusing this thread. Your patches look fine to me, it is not
that I suggest to change them. I will use your patch as an example for
off-topic discussion.

On 01/05, Masami Hiramatsu (Google) wrote:
>
> +DEFINE_FREE(argv, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))

(IS_ERR looks unneeded but this is cosmetic).

OK, so it can be used as

	void func(void)
	{
		char **argv __free(argv) = argv_split(...);
		do_something(argv);
		return;
	}

And I cry every time when I read the code like this ;)

Because, to understand this code, I need to do the "nontrivial" grep to find
"DEFINE_FREE(argv,".

Perhaps we can establish a simple rule that every DEFINE_FREE() or DEFINE_CLASS()
should add another #define? I mean something like


	DEFINE_FREE(argv, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
	#define __FREE_ARGV	__free(argv)
	
	void func(void)
	{
		char **argv __FREE_ARGV = argv_split(...);
		do_something(argv);
		return;
	}

This way I can press Ctrl-] and see what the cleanup code actually does.
Can save a second or two. Important when you try to read the code you are
not familiar with.

Same for DEFINE_CLASS. For example,

	int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
	{
		CLASS(fd, f)(fd);

		if (fd_empty(f))
			return -EBADF;

		return vfs_fchown(fd_file(f), user, group);
	}

If you are not familiar with this code, it looks mysterious until you find
DEFINE_CLASS(fd, ...) in include/linux/file.h.

Oleg.

