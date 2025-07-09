Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FC28DB56;
	Wed,  9 Jul 2025 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070348; cv=none; b=ICqdXLWGxYkN7D8V0yXYeOldp4dF00q1niNkBBRU9cFXkb1F36jRi6C239HNLRlFo9qRK8xL/IBoSw83CQIWHfO0pSf/Fapl22THGErEoTYS2AMBK4LqMLJ5NViMyZeiIOIkwC6vblTfe58aXYsq3sb4aoJ8IDvyg/bltSlKGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070348; c=relaxed/simple;
	bh=VRsZlWd0sKloPJJMyC2U4nSucDYa1R2NfHw8RJbt4XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBRNdUVC2SDrnv1UdLj1Cn3owTPEW8RvPVanWt9ROmYE/hiOUVjrK26YzztYPPYQUTwstAoOpNFIuXNtUwx69Ggml4D8Q+hJGv5munBemZsAKQNUbh67FGaBxXo5z5fvozPGW5B/avvG+eR/Ca5YcAsz28Ni4OAvy5oGMWs7w6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BAAF61A0261;
	Wed,  9 Jul 2025 14:12:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id D6C9D1C;
	Wed,  9 Jul 2025 14:12:16 +0000 (UTC)
Date: Wed, 9 Jul 2025 10:12:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
Message-ID: <20250709101216.5949e86f@batman.local.home>
In-Reply-To: <CA+wEVJab6Gwkd7q58=v8uVhfmKpwNRAqtK67f15JtZcKSB_ziA@mail.gmail.com>
References: <20250620085618.4489-1-gpaoloni@redhat.com>
	<20250701195939.3e297e20@gandalf.local.home>
	<20250709100626.fc0611eb6801b7a8dad9164f@kernel.org>
	<20250708212539.054a7d5b@batman.local.home>
	<CA+wEVJab6Gwkd7q58=v8uVhfmKpwNRAqtK67f15JtZcKSB_ziA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nu7mjtp6rhcgkci7nawaq5yabzu95ksp
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: D6C9D1C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dopg29juvoVm7TUeKEpfoZGxpUo5A030=
X-HE-Tag: 1752070336-670080
X-HE-Meta: U2FsdGVkX18aQM8jb46m/z+hSFesLyStWtj7y7/B1lofbMY/GhdCruWcLsso1zK3FjgG/ItC7tRpyag5+AZb+fQAG1U1Iw/TqTRk7g4uj4gJTgFjWpykRT0FvujaW9dxbnoz5OXkEn9hRxxrtDwEltEWaz4lwQlwVBSr96n7Lh5JbdVxRlmobDT389KJZSIm53rHL/V55R7NjuL/k1VwPnpbAONcJDp4APfEzw9X6fO/7t7mkzlO+5AeFoFCWVkzqUJTNMxXt6xAIIiJ8r/F6nWNwS3pJsNnob1rL5nXtIXkUYXqBt/drjbOm+sMYlCHL5iWLDyO4jBWEUDjCC3rLV5BPiusm3yu

On Wed, 9 Jul 2025 15:35:50 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> > Hmm, now here's an interesting point. So this is to define requirements
> > of a function based on what the function is doing. But does the
> > function have to have strict requirements?  
> 
> IMO one of the main goals for these requirements is testability.
> In order to have testable requirements we should state what the
> valid input values are. In this case:
> 0 -> disable, 1 -> enable, everything else -> Error.
> 
> Now checking the code again it seems that the switch statement
> is missing a default "ret = -EINVAL" (or else it should be changed
> to boolean, but I guess it would have a wider impact on the rest
> of the code...).

Well, it's mostly used internally and the only places that call it uses
0 or 1, so there's never been any issue.

> 
> >
> > If it can handle "0" or "!0" does that mean that's how it will be
> > defined? Or can it just state "0" or "1" and yes "2" is UB. That is,
> > it's not part of the requirements but if someone passes in 2, it could
> > act as a 1 as it's UB and implementation defined. Not a requirement.  
> 
> Right now if 2 is passed the function would silently return success,
> but do we have a use case for this? I am trying to understand
> where the implementation defined behavior would be....

The issue is that all the callers pass in the proper value, and that
can be easily verified, but by adding the "anything else ERROR", it
would require adding more code that is not needed.

I rather just switch that and soft_disable into a boolean than to add
superficial error checks.

-- Steve
