Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07847328B53;
	Tue, 10 Feb 2026 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770700458; cv=none; b=ioypV+iRNEPPv7HhxYmEInUqmOHcC2NHPmG6c7YPWXU97ZIQXG7MNMkLtQ2dqewv3oWyVzeUfH7bRUedsqP0e+tVILkFDzpzb5V1UoKJI1VXzalyBdUfa4oyagnJLyOxJCxFbJlj55Gp9wcmdmfi7V2zVAVkWUzXPM7RqtWKwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770700458; c=relaxed/simple;
	bh=4Bpfjy7FGSZsA6QwX3dHe3fgaxo7YpODbk1Go8A6nXQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LbT6AC/MIjmMsWnzTr65OrTVGb3XfG26HNWQ4CiuK8E1KvQLJyg2lQGJflL8plKd/PRrt201dis+Fcrd2rIFlZIsVxGHL1K0NiPLogzg9jtwZLvPn+PLsmO3dTLIx/ZS1p72SLn4oMmh8WXkP5OzDn+aUHSPTOjbxm/cUSFIc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0HC2lB/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0HC2lB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C8AC116C6;
	Tue, 10 Feb 2026 05:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770700457;
	bh=4Bpfjy7FGSZsA6QwX3dHe3fgaxo7YpODbk1Go8A6nXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q0HC2lB/TIOw+uDswwda35VN9h8v+5tc3/B8g4bUIrerdXG6vvSGAvLUimSi1YW4X
	 pWjJDjipmWXv++uy9K+/TPFmtTIjbyQaWlRbcreKOwH1wK2qKkXVbaHSopVzZwQ5WW
	 bEjWiU6VpdxvsciteNGtcH2+18JJGuH6G4UX+qm3bGaYmBQqrcgi2m3+ZnyrSwUXsK
	 41gnV1YIG2mWsrQfNR/FYhKhvufKmXcI9ref5QRWo4dz1qX4wRScou5cDdB1WAcS7e
	 NVMnXSciOj191D9lycd6R0r+FjI7wc4r0fPdWqeL6PMpVParV/Ua5aDiuVxj3rcSpS
	 X5+xAa98yYbbg==
Date: Tue, 10 Feb 2026 14:14:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] tracing: Make the backup instance non-reusable
Message-Id: <20260210141415.01a6907dcb558866e1abb994@kernel.org>
In-Reply-To: <20260209184247.4c6daccd@fedora>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991655479.4025429.105619035638065215.stgit@mhiramat.tok.corp.google.com>
	<20260204211721.74e501f0@robin>
	<20260209180844.c582bdbb6a4a5b737db7a0a7@kernel.org>
	<20260209184247.4c6daccd@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Feb 2026 18:42:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 9 Feb 2026 18:08:44 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > @@ -5152,6 +5157,9 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
> > > >  	cpumask_var_t tracing_cpumask_new;
> > > >  	int err;
> > > >  
> > > > +	if (trace_array_is_readonly(tr))
> > > > +		return -EPERM;
> > > > +  
> > > 
> > > Shouldn't these checks be done in the open function? Doing it now is
> > > too late, as -EPERM on a write is confusing when the open for write
> > > succeeds.  
> > 
> > I've made a small program and straced. Surprisingly, for the super user,
> > open(2) does not return error on opening a readonly file with O_RDWR.
> 
> *blink*
> 
> So if on open, the trace_array_is_read_only(tr) returns true and you
> return -EPREM, it still succeeds? That sounds like a bug!

Hmm, OK. Now I found how sysfs handles it.

	/*
	 * For regular files, if the opener has CAP_DAC_OVERRIDE, open(2)
	 * succeeds regardless of the RW permissions.  sysfs had an extra
	 * layer of enforcement where open(2) fails with -EACCES regardless
	 * of CAP_DAC_OVERRIDE if the permission doesn't have the
	 * respective read or write access at all (none of S_IRUGO or
	 * S_IWUGO) or the respective operation isn't implemented.  The
	 * following flag enables that behavior.
	 */
	KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK	= 0x0002,

So for the similar reason, I will make tracefs to check the permission
even if CAP_DAC_OVERRIDE is set. (But this check should be done in general,
instead of each open() operation)

Thank you,


> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
