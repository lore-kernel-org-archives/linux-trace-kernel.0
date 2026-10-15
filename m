Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0241C71;
	Thu, 15 Oct 2026 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068732; cv=none; b=WZw7lME876imM7kyvOr+1ytXyN4MtcOCDbZAPUrdUu6opt3biyzJ/VDPb/2DZPKuDdgdDTI1PkUMLGw2a/JXrWYPPlrB0bQ6IYMh1xEtiPTUCAaIuICX2eLNjxMa8YdInelykK/ZSNIquh3Jyl7UTaRsM/ZpaU8/rZ0qcUWiDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068732; c=relaxed/simple;
	bh=iWZRrwl/vTkouEmuKYQns0pbF6s/xoUawdrp9gB3ndw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evPFlXzJOfiORqwWqcJVgT9zUBRRJU+21eoD6pw9jimnNl6CvXI59W+2igl9IYtpTIMHSxW8qq0uFgOmIMTTlDuGmVxZ4B99GnP5ZERXpcUNzEuBUouAtrcxSdie44ZI8LoF/qTsiDwo6fYhDfQW/wOrQHVBoAJnaMsKlu1YxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=AP2SWa5D; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="AP2SWa5D"
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 814F412070F;
	Thu, 15 Oct 2026 12:52:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 9B9126000B;
	Thu, 15 Oct 2026 12:52:01 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:52:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ring-buffer: Skip si_mem_available() for
 persistent and remote buffers
Message-ID: <20261015085200.1abe5550@gandalf.local.home>
In-Reply-To: <atCRQ3HRmWgKEJGl@google.com>
References: <20261013102047.1488347-1-vdonnefort@google.com>
	<20261013102047.1488347-2-vdonnefort@google.com>
	<20261014175126.49c26f93@gandalf.local.home>
	<atCRQ3HRmWgKEJGl@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 9B9126000B
X-Stat-Signature: qdddxgm3qoks6q1yygdhu3s3xuzxygar
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19mmf2ku17l9uFNMZ5/9WyN1nYQgxiaMq0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=3zUkmXmZ+XpjifwGV5vNAZcbhV+oMqVEA6Nq6qlxsFI=; b=AP2SWa5D4EB/fDmeBs1mSdyhav6cJbm2sHIn3WVXtNVTuMukiBvoy/irvcCRdadbFtlWly+LEpje4L4jBeJKulioM9/mNwRfzmcYXrQLYWO64QNqN8mfDQPeK2bAYxiVP1cGUdo2F3ALzrUYLt1/gLxnNS0iCj8PG4bR6l4Qqa4=
X-HE-Tag: 1792068721-603792
X-HE-Meta: U2FsdGVkX1+Z9FU8vNKmVtdF2S8DSPzfIdUxiwuAzGpDnhNfZZeMw+Tm9JXn+GYYFJV7bn1Y9m09j86lbsvuFc4vhGm0qLmNPa2vaQ7oaLrlyYOY03JnuQ2QgUujbGpiiB47PX7y4n5fYjg7tvM21GIhmZ1MsIC3HsLnR5VqFLjv/Pxo8XTTB0lBQJ9rll0imqAW2tdOo6VnodEA0Diud4MsWamzpyheUTaAVBNuusqkXVqKJG/gwNwGyYMHQutBZr2TRTRxaz+IyZ/Bn4fwB7A8PQv8fdRt7Yes2AkXvEORPh2k8eoTslAvZbcPnbHA+2oK5i2TIXSWppxekbvqpQP0v+aDm2Cu

On Thu, 15 Oct 2026 09:39:31 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:


> > Not caused by this patch but we need to update this to:
> > 
> > 		user_thread = is_user_task(current);
> > 
> > I may add that.  
> 
> I can send a v3 if that helps.
> 

I already pulled in the other two patches and tested them.

This can be a clean up for the merge window.

-- Steve

