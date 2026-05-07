Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C4239E7F;
	Thu,  7 May 2026 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118497; cv=none; b=GZIolnE45JzDpvOka7v5jpHCCOPYiJhMBTg4FErKAXJ7Tbp7Id95DznVtZJJlr+J6+Q+/+RCmwINAl+6FNnpaVYfpRETn+8PExwVngDcw77CXuFQzE/EoZIwm2j16E1L4TFfmYCyfZ/ArqJCQNmwPKH2JQqp41k0EHKnqcfYMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118497; c=relaxed/simple;
	bh=5HhwpwRsS7l51LNkTWq7isiIqE6MqU9L41kkHsOjBHo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TFxOfz0ptjCd5tlCUxPEYcHw9xemq3U7bSkI//Rg/v89eKRn9/QacnchoDE4pzq09KyL1OKFhn1pWKiSFdfRKRm3Lwbq/8KaRkXAXnD1ggRjVD/FOvk5+3PRHWMSFprvyaJoTjfg7ReAfCXoGotzMENsHyb9Py4KxQW2Blh4Gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWugQRt/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWugQRt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6E1C2BCB2;
	Thu,  7 May 2026 01:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778118497;
	bh=5HhwpwRsS7l51LNkTWq7isiIqE6MqU9L41kkHsOjBHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aWugQRt/ObDuUE47cSe7pMkOH9qSHwAbj5d0teAwrGducRN8dyYgee9IK0WwmIsFg
	 gZTmmh2f0ahahBpdya+rgiqDSJpKfZ4ZKYZEjDIq/2KHG2NzlePCYUsSBXwMhybnSv
	 JjH2AMrsb/9sMioZmIdfcwQyGNiCwBmr6wQ3YBWGyk2MIqZn9ZStB+o1kZGHJeWrw/
	 VLjjAjSrdKs+y7euJTZpyOyDEKmE+Q5B0HXbaan+mFlJohYCXot8T5+E23uJEhL5qe
	 m6lcSH7Ivi8B1i/FNOX1Zlkwql4J9r9mwnU5FO/SnMU9VNZ+v6+DqP76LebSl20+HI
	 23B15sU9J0cmw==
Date: Thu, 7 May 2026 10:48:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] fprobe: Add unregister_fprobe_sync() for synchronous
 unregistration
Message-Id: <20260507104814.528d32f1500f9350254a1c3f@kernel.org>
In-Reply-To: <20260428142736.11f5211a@gandalf.local.home>
References: <177729179863.401400.6063130067239479972.stgit@mhiramat.tok.corp.google.com>
	<20260428142736.11f5211a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 14:27:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 27 Apr 2026 21:09:58 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > +/**
> > + * unregister_fprobe_sync() - Unregister fprobe synchronously with RCU grace period.
> > + * @fp: A fprobe data structure to be unregistered.
> > + *
> > + * Unregister fprobe (and remove ftrace hooks from the function entries) and
> > + * wait for the RCU grace period to finish. This is useful for preventing
> > + * the fprobe from being used after it is unregistered.
> > + *
> > + * Return 0 if @fp is unregistered successfully, -errno if not.
> > + */
> > +int unregister_fprobe_sync(struct fprobe *fp)
> > +{
> > +	int ret;
> > +
> > +	guard(mutex)(&fprobe_mutex);
> > +	if (!fp || !fprobe_registered(fp))
> > +		return -EINVAL;
> > +
> > +	ret = unregister_fprobe_nolock(fp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	synchronize_rcu();
> 
> Hmm, do we really need to hold the fprobe_mutex when doing the
> synchronize_rcu()? This could cause other updates to have to wait longer
> too.

Good catch! Indeed, there is no need to hold the mutex.
OK, let me update it.

Thanks,

> 
> -- Steve
> 
> 
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(unregister_fprobe_sync);
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
