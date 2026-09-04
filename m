Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F140489879;
	Fri,  4 Sep 2026 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547232; cv=none; b=C0gyXaixEFm6pvryigP00KVLbqpPa1R5jeKFLegpyqKHog50SX76qkGLzTTiAjMlJFqvU2NEZlRD/ET/3Yt3wfwn+47i8TjvI939bUGhbUIWDJ/iv7KiRw1OBcXs9Wl8oLSYh+FMdMZBJrPyzUvwmNBB3zKckocJHwbT08TYdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547232; c=relaxed/simple;
	bh=8mXz5zb8zl5UP3IZ0CuGXdzY9D8uyerTwl28Aquu7wU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaDRhtAQxfPGnDHfpnnYPN3h6iMjpo+5i2NgrvQCNt8iw63JPcbSNDzxlSYZt1w0u1ihri46sd7dpNlxEtnp+NbdGOPPno52juO+8TqFSHBprP6b0tavPhwO7MNtEPtfaumasiF6OlO8IuQY5cxKTEPbQPTvwRSjgSsJd15CVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=nQU2mtqx; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="nQU2mtqx"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0D18580198;
	Fri,  4 Sep 2026 18:40:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 3D1851A;
	Fri,  4 Sep 2026 18:40:21 +0000 (UTC)
Date: Fri, 4 Sep 2026 14:41:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/4] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260904144126.56d92644@gandalf.local.home>
In-Reply-To: <20260904143527.40e73d36@gandalf.local.home>
References: <20260904164450.1345852-1-vdonnefort@google.com>
	<20260904164450.1345852-3-vdonnefort@google.com>
	<20260904143527.40e73d36@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: eyydgz8tde3id3sk7zq3b8k3tus7ut4x
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3D1851A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183k2CfBgp3/+p+8WpUj2ST9HziTZ2ajg4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=MBLenhcDQkAvFlJBVdJCxtFBA+6fe+o93A8jgAFULDY=; b=nQU2mtqxXLgpoKW16ADed5vnaA8JLQolPaBQNtdGCg4Iq/egfb96jtsYFiFNOVQwYuozJGUB3RTu80LKL0sWznkW530Nk9iDoDcQWnPIZEq8WaVm+7cI2EftRr2iJeyQt2ss6xm5t47BS53i6v0SHneM6DWj1J/o4b12qhmmDn0=
X-HE-Tag: 1788547221-512877
X-HE-Meta: U2FsdGVkX1/mKBReKpS+SB3ZerW3I53RPqZj1qR0rwVLImgo/oygeGW7xkaxncQ/59SiSnUsQrg8bqy7aYh0hkrSQ066T0UNADx4mBIn2YEGdNrA+mupCy7S0GCEJWmBpFUMxpqZdEJsaQjgT/J47q5NzJCJZDqxqKa6/nn4KR+MgOYJCghpAP5hUmLiXR08YAWrHHHBhHRtB2BtyQCSQQH8PQNGrNkZ99bRm/Ufw56WXaD1pZuld7EUO8AahoOCHCB4thTsMRifTvugCq7acbHU1nd/rcBCCBS/WYhdR5gRHcdqUFjzOJgY8zTmE5UMiItMEbFbLwcyk4r/qs+sXXo7rVgatTVuG6+FHrKM60Bl9VbxDSoNiJ8i7lKFKJqo

On Fri, 4 Sep 2026 14:35:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +		} else if (!i) {
> > +			/*
> > +			 * We failed to read because the length is too small
> > +			 * or unaligned. If this is the first iteration, it's
> > +			 * an invalid userspace input. Otherwise, this is due
> > +			 * to a subbuf order change. Do not report an error
> > +			 * and just finish the read.  
> 
> This isn't quite true. It can be an invalid length and not the first
> iteration. If you ask for a length that isn't subbuffer aligned but greater
> than one subbuffer in size it will work the first iteration but fail at the
> end where it couldn't get a full page.
> 
> That is valid but would also trigger this path.
> 
> This is the only issue I have with this patch set. I'll just take it as is
> now. We can fix the comment later. I want to start testing it and get it to
> Linus before the next RC release is out. If it fails the tests, then we can
> fix the comment as it will not make the next release.

After re-reading your comment I see what you meant. But it is still
incorrect because it sounds like the only way for it to not be invalid on
the second or later iteration is due to a subbuf order change. That is
actually the unlikely case.

I'll add a patch to fix this.

-- Steve
