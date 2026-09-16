Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE537E5E1;
	Wed, 16 Sep 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566178; cv=none; b=g/bjHx6S88fJ0uqFIKaGWPaC7SfLD+PAMwtK81K/yHFJOWIyJg9flyrp6pAwkbjXj1j6Nk+Kid7ja88SyLFl0Me27XMOhpDShNMDlqF6FlDHHOV4cYhD4CHxI465nLPDhsgiOhrOkYspiQ2tg8pvikDemDWTJk8BvukfLwoDG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566178; c=relaxed/simple;
	bh=aXlkeDkxryObEamzgOaYgLsDag+D7VZe9uRAibImt5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bl5LnLHJ/C3EI2KSd/S/ZoI9I+7s5A9krZ3ZkWrg5J+u7oBqoJlMQ4ycJGAu/Y5sigJJKUHquRUNpw+yjhPqmu59PYEUtE46wXJV94JDLiOYEVetqqdVZwgv777hk+lPfoLGrzF61kt4g/xtM+OpGS1iad5n2m69rz8SiqsHTZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=fmZ8RSkp; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="fmZ8RSkp"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8812BA5D87;
	Wed, 16 Sep 2026 13:42:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 1539F1C;
	Wed, 16 Sep 2026 13:42:42 +0000 (UTC)
Date: Wed, 16 Sep 2026 09:42:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: David CARLIER <devnexen@gmail.com>, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ring-buffer: Clean up resize_disabled checks
Message-ID: <20260916094240.5c9f2518@robin>
In-Reply-To: <aqjyi2RD4oSCAY7z@google.com>
References: <20260914175907.1027349-1-vdonnefort@google.com>
	<CA+XhMqxp2XOB9PnfHJwBvK0up8Oej4hGcnsM0a=fdoRDyVoEyQ@mail.gmail.com>
	<aqjyi2RD4oSCAY7z@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6tkuiqxf6egs3ch3xsfabr3usrfqnia4
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1539F1C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Nvzp9Juws5EUm3Ae8/a6j2ku4sC8zXG8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=69xM3xBqQtpH6d2iCA5XP8czX07fM9V+rq3rH/CL0pI=; b=fmZ8RSkpaBOkwGT30uckQZgWz2mA7m4ApxqQ5n4s5OHrno8DBWLZzXymlHVEVmufBBL77DgcIdVVd1+KsnDGNgOyRKM4aAvednO6F5U1k/RZjhruYkqaJH85MxFE6TJhGJAIO1An9FExjVxMkilUSUBHkS/5h5LHZg8qDdXeYeM=
X-HE-Tag: 1789566162-520813
X-HE-Meta: U2FsdGVkX1+K1qm7LJeTq+HUbTV7DeUs2/+N9sUwAwl6mKudjszSw7DgpwONc4xPa1uWiKUcWYmb1M0RVlSgA5LTOmYCu5Tg5RgBpkiUOPqkGhPzc+/s2EPzwdTpTxGS6LDK6kGc9RxnsIDnWfRNb8V7du/2EmFhUO4dYk4IYUX97M7Un0drlUnubpasNQ7D6XPs+UHj6HhzWzprM6CX5bxHcNynozdUDhtf/x09AAzZJuf9dv1a3dD1/MGvQToPeAfMLnPt8bOK9S78lk5EbPTvU9dLsihbPhzph476HzyvTgiqz6381owj0s2w8n2M6uuVXxTe2YjKtrzTWNB5bA/OR6jcnY4x

On Tue, 15 Sep 2026 08:23:55 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > For a single CPU, this now happens before the nr_pages == cpu_buffer->nr_pages
> > early exit, so writing the same size to per_cpu/cpuN/buffer_size_kb on a
> > mapped or persistent instance CPU fails with EBUSY instead of succeeding.
> > Intended ?  
> 
> Actually no, I didn't see that it is also "fixing" this discrepancy between the
> per_cpu buffer_size_kb and the global one.
> 
> It seems to me better to align the behaviour for both interface, but then it is
> touching something that is user interface... 
> 
> Steven, WDYS?

I don't think we should worry about it. If something is mapped, then we
shouldn't be touching that file. Even writing the same value should
error out. There's no need to do that.

Hopefully it doesn't break anything because if it does, then yeah, we
will need to do something different here.

Oh, and can you break this up into two patches. One that adds this and
and one that does the:

   Additionally, remove the unnecessary cpumask_test_cpu in
   ring_buffer_subbuf_order_set(). for_each_buffer_cpu() already
   iterates over buffer->cpumask.

Hey, breaking up patches improves your commit count ;-)

-- Steve
