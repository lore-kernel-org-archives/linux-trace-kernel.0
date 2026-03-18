Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B473D902E;
	Wed, 18 Mar 2026 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841508; cv=none; b=QE7sjycj6aZcODWdfIFGtOXiglLJMa+o8C5sPLXQlY+8iNYh0rKS+IoVYUVCqNL1DPGCNeSbsNNvbKkXo+0VLYtJZ08pTu6xKBpyp8GKE4StFXSvo4CYJ/WNL+TRmEzWgymxpfHWGC7avPGRLkPlUvO1xmQxct3TgC0CbjTdVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841508; c=relaxed/simple;
	bh=CpzxWt+RxPFCCdxPEB0kG3cH5wIMy8yapwHkuLs392Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=janHtG8opNHxiz4jvmTt+MLiCUyrSUEPuiPjY4puPUwFRaA18EA8fQOwHO2HSOwH+7IglD+9Kkm7ysVCJVfG17wWoRcNL848MZQWcgfYtVuCCUf7bh+D6Xp35JlZBDGwGGbLR0uuaN5NuMLwtPbLnAYXh3kvLAYdXBTfi/5z9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 7261D1C231;
	Wed, 18 Mar 2026 13:45:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 6F77520033;
	Wed, 18 Mar 2026 13:45:03 +0000 (UTC)
Date: Wed, 18 Mar 2026 09:45:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Josh Law <objecting@objecting.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-ID: <20260318094526.0b9e0b0d@gandalf.local.home>
In-Reply-To: <20260318090243.7c437f2c5e07a1ce00375102@kernel.org>
References: <20260317204403.72375-1-objecting@objecting.org>
	<20260318080351.dae637f4b5909bd9f81b27d2@kernel.org>
	<20260317191626.5b6172a9@robin>
	<20260318090243.7c437f2c5e07a1ce00375102@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F77520033
X-Rspamd-Server: rspamout06
X-Stat-Signature: bzigaibz51sizfj8zbqdde4m1c4jy8ut
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18+jmFZTWYU+XJXTsbQ05eA0utqMf/8IGA=
X-HE-Tag: 1773841503-224748
X-HE-Meta: U2FsdGVkX1/XJcYsXbB3cssMb4ubyWbmH/JjLvwDcKstuO1r384sTfZktZNgPgSJ+Axd8beZPWqzo6zfIY06QHRudCP7OpQjHqkHTDNpKwUsKMsfRnAivpPhd/S7HpTHKD9aZzbUFsnC5eF2M57518oRNQNNTV5O6nYnRaew0btwQNlvt3z6Pk0VD+QHUP3AvMOEpoRor5wReme9yF07sK486cBhBOvFx2lOCK88JzfokMjtIXjAALSvxoSe8VCUQzP03bfd2PhYH/S6emAb0Ihh+t0BUtNhdO38dGniwwYorOac6F/XQZZ1++ekATW5B1Ia6bmNc7J23dOZ2+/7GUeybcpAUxz1

On Wed, 18 Mar 2026 09:02:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > This was somewhat my idea. Why do you think it's over engineering?
> > 
> > This is your code, so you have final say. I'm not going to push it. I'm
> > just curious to your thoughts.  
> 
> I sent a mail why I thought this is over engineering. I think this
> comes from vsnprintf() interface design. If all user of that needs
> to do this, that is not fair. It should be checked in vsnprintf()
> and caller should just check the returned error.

I wouldn't call this over-engineering. The reason you gave is more about
the checks being simply in the inappropriate location.

Over-engineering is if the patch had created 5 different macros to see if
the value passed to snprintf() was size_t and could be greater than MAX_INT,
and it used the trick of TRACE_EVENT() to create the code to do those
checks. Now THAT would be over-engineering! ;-)

-- Steve
