Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB70A397352
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769056; cv=none; b=SjyiXpmAWM11QAkvQG4Ri0qhQFgfUokkBfv6lRzc63ehMg41O5U7yG/ZZ0xCXc/Ij2Nh4cWRiE4DEu7F8/VDAnU2tx5RTB4hkc53sfaqF55ckgvCzGrS8/9d4T0Xrxmqe3R+ZLYTl2nws7fDAfi535++d3/XLdqVDzI1y/Jk0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769056; c=relaxed/simple;
	bh=IiJ6o9p4RdhW/e+YbM46z7SC+oyYsBTOEyeha9FqVlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZpGN2hajwyLCWYgEMgbkd8946P3EanL02YrNnsizzqwobHcs9k8dP+XnbYQAaBPkPeCiVTYeM5EezDJBrebTTU/1EdP7xZTP9KXNSKUzOKtixGe27ExpstqOk0iw9EoqniXHvrvLNKB5cpjpTo0l8yZNI6OVxJKnMrcQ22TcWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=J1/Yr6f1; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="J1/Yr6f1"
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 5623EC01D4;
	Wed, 26 Aug 2026 18:30:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id B847D20025;
	Wed, 26 Aug 2026 18:30:37 +0000 (UTC)
Date: Wed, 26 Aug 2026 14:31:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260826143123.1b3e3854@gandalf.local.home>
In-Reply-To: <ao8TQ-SvhjYgy43-@google.com>
References: <20260826094528.3738023-1-vdonnefort@google.com>
	<20260826094528.3738023-2-vdonnefort@google.com>
	<20260826095947.4FF8B1F000E9@smtp.kernel.org>
	<20260826103736.2b55b464@gandalf.local.home>
	<ao8TQ-SvhjYgy43-@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9arpc6uhcx1uaw3q5wr7uxxjdfp5ge4u
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: B847D20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18XxAdD1sfi8kUlzNUzj98ULs5E5VPo0Mw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2MXGXKcjH51S/C76vlkXxPmKewipWiV9ccLaJ+mi+vE=; b=J1/Yr6f1+J5Rv8jfzxDTn4UeyErGMH3/Nr2uZ9alYACah5lcl4mmfg3MV86YEKt5A6RHZ7bpkyfgSuKaojTsINpiYCdFOzznk8t5l6yxBBQXVyMenkbSpE1hpMEX90SJoQLgJ6IvZk8TYeAKOzrBfuhny7RAuNmNkdAw5FJrrJ0=
X-HE-Tag: 1787769037-13725
X-HE-Meta: U2FsdGVkX19vRzPEJka9ItcAL7AUiglo++gXaRZHmOQvgj3FGI+yZMrXH3+cZclO2C2iGwMFk+tjxY+vOq6jJhWI9Y2ST6teaSvUKOpAjM+u2iaUz+OmfoiwRzm6+c4idUjszeh9cf1E9uL/linc1xq34hyXF6CIbRUQh55ko65rWjBz7owrABefdKNt2aSWA7E5sjDmfGrW1TKgxLlbKtxOci4vZ918UPdWmfT828vvCLXWIswVdJH37O5MbbcyRkTQahNS52C/3cTY9v3yY71MT8uScLIpjiVitFpaL7JfR0ndDNoiUPTg2vIGnb27r0B44vT6AILh7KoO/FpWYqwxp7vKsDo5

On Wed, 26 Aug 2026 17:24:35 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > This is a legitimate concern. But with an easy solution. Perhaps just add:
> > 
> > 	if (full &&
> > 	    (!read || (len < (size - read)) ||
> > -	     cpu_buffer->reader_page == cpu_buffer->commit_page))
> > +	     cpu_buffer->reader_page == cpu_buffer->commit_page) &&
> > +	    data_page->order == buffer->subbuf_order)
> > 		return -1;
> > 
> > If the user is changing the buffer size at the same time as reading raw
> > pages, they get what they deserve! I just don't want to let the kernel go
> > into an infinite loop.
> > 
> > -- Steve
> >   
> 
> Sounds good. Do you prefer to get a v9 or you fold this into the existing commit?
> 

Please send a v9. It makes the patchwork flow much better. If I modify a
patch, it makes patchwork not be able to automate the status updates as it
moves around git trees.

Thanks,

-- Steve

