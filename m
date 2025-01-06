Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0E23A6
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jan 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174697; cv=none; b=b0d50HLUnHD3EPwwk92Qc23P2NpG+ko/mlUqgr68ppLCQVkMRkb5WoXV4ovn7xINpsdLr9ZSakc/u96KlLuG1HoihT5jHmyDV/DLzx8J8+QkNM6B8HxSEseDBmvoC/aIHgMTjDF7AJ9gfRVID0RR9EGbuymTrK8yWbdYYevzG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174697; c=relaxed/simple;
	bh=qYP3pm8CQ5/S3pjftC25OcQ0oTDOQfwiIcKpcMw1SD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dez9JN8LijvTM+WI5epjZQdfwzB7yUoGJFrlQEYuvOtK9PvYMFArTmFeKRmGHtW+jTPRTAcJULdK6ayTJsuooBpX62GQSjJPPcFXeKA9NBcc0GbuRfROWtKPmdyIn4iEAxG4CUjX5HHtwhOOK2gOkF16ZhKFWMAvWHtXkHxXSpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9n8wu2O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9n8wu2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736174692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2o3yiaohQZ2N++6HjYdKi1hunz1pVF3VvnpUJk9wCc=;
	b=U9n8wu2OZEZQTzVuFkH9vOhArlJU4AslHuk8oyshnVvWYv3xk/QhEe4hB2zvvS+7qMBIy0
	7NsuEEG3DuUOlw2svaRi95rxTvUw6MUWXmJXM8cS/V/uMOZvs9IsGG2lzcdhDyvjzK1Yej
	wVwM8BmfM0OPHIp/Wjn7g8F464gnfJ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-LfKVbnWwOXKwjpirVS1iew-1; Mon,
 06 Jan 2025 09:44:48 -0500
X-MC-Unique: LfKVbnWwOXKwjpirVS1iew-1
X-Mimecast-MFC-AGG-ID: LfKVbnWwOXKwjpirVS1iew
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9317B1955F2C;
	Mon,  6 Jan 2025 14:44:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B9AD3195605F;
	Mon,  6 Jan 2025 14:44:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  6 Jan 2025 15:44:13 +0100 (CET)
Date: Mon, 6 Jan 2025 15:44:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
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
Message-ID: <20250106144406.GD7233@redhat.com>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
 <173608127627.1253657.12054758575695672674.stgit@devnote2>
 <20250105141422.GB23059@redhat.com>
 <20250106102647.GB20870@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106102647.GB20870@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/06, Peter Zijlstra wrote:
>
> On Sun, Jan 05, 2025 at 03:14:22PM +0100, Oleg Nesterov wrote:
>
> > Perhaps we can establish a simple rule that every DEFINE_FREE() or DEFINE_CLASS()
> > should add another #define? I mean something like
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
> Right, so I've been playing with neovim and clangd (lsp), and I'm very
> disappointed to have to tell you that that also doesn't get it :-(
>
> One thing we can and should do is something like:
>
> diff --git a/scripts/tags.sh b/scripts/tags.sh
> index b21236377998..f01d694abe65 100755
> --- a/scripts/tags.sh
> +++ b/scripts/tags.sh
> @@ -212,6 +212,8 @@ regex_c=(
>  	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
>  	'/^\<DECLARE_IDTENTRY[[:alnum:]_]*([^,)]*,[[:space:]]*\([[:alnum:]_]\+\)/\1/'
>  	'/^\<DEFINE_IDTENTRY[[:alnum:]_]*([[:space:]]*\([[:alnum:]_]\+\)/\1/'
> +	'/^\<DEFINE_FREE(\([[:alnum:]_]\+\)/cleanup_\1/'
> +	'/^\<DEFINE_CLASS(\([[:alnum:]_]\+\)/class_\1/'

Yes, thanks ;)

Ctrl-] still won't work, but at least ":ta cleanup_argv" will do.

Thanks,

Oleg.

