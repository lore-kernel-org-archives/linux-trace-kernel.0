Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722827B50F;
	Wed, 13 May 2026 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690429; cv=none; b=EeUjoynTa+4Q6d0rK/HtqdgkShnCyF/R3SdCGIIWzlk2sCjP5G/ZJtxLaxubBymHZBCdlxRTMM5E4r5HOG+GVUssd4bGkzPXE3pFo01r4QQFQgNwkBQ0Xs4QOUV4tIsAuuuRQjR5hmpBrjiFt22MVWJnPgoH+KZLHEFcqbdLIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690429; c=relaxed/simple;
	bh=EEK/4mMfay7RKBB1Dud9hvs+sUZ/ld4Rg9vb5ZpPBWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWQGcAyhMKwPJZovdw+4KnN6dCvjuKPZ54ZWZtO19dB0IVTKxwdkZ5gTsuBQEwwYGpBSnR5CC41giW6s3CuVCn4j6z1Lrn8kqNW1bEtm8t93+JbXYLqeQjlhQtkuuesu7V2+lhKQJ3ToAvUpexs+UHYnn9KVzXBOccyFyYELaCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C2B6A1A03AC;
	Wed, 13 May 2026 16:40:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id E51142002B;
	Wed, 13 May 2026 16:40:18 +0000 (UTC)
Date: Wed, 13 May 2026 12:40:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Chen Jun <chenjun102@huawei.com>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: Introduce a new filter_pred "caller"
Message-ID: <20260513124017.770e3098@gandalf.local.home>
In-Reply-To: <20260512084750.c17a93d0ccdacddfd52d3d40@kernel.org>
References: <20260508122623.74290-1-chenjun102@huawei.com>
	<20260512084750.c17a93d0ccdacddfd52d3d40@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k9t3n1njapru4dhbdmtqkstdtq5ts65b
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E51142002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/82pJDiolqvdKJI+A3HtwU62ZIaEIcdwY=
X-HE-Tag: 1778690418-817114
X-HE-Meta: U2FsdGVkX1+ZRN+SdzA15dp4/sZzpyigFAn0A6u/T/Ui+kQLRimEESCZJdRRcSmQgE/lqFNwdHJV7O46NakkgeXds0rmgnKQEYsDdpB3SgLvSQoSbu3BtOJVi8I2sIRdE6gNY75GPr4UHprD18CQUQHHSt22b6Gp147b9hF0Y/ZtBmihTEBMtRk4tiYgPIoYjgIykYhY50aVaVW/kw26DiDmduxANFq4ZYfTSG3bAzODSbXpxWRozcjD2DaXP3mGet3NCZm+GnvU/kwLdAJC3nLjoJPtbV7cb04Fzv+cu+Zmjfbm3F1CLTaL4I+zfkBMO4i5XSbb5ptn0TQZI+Kk7sgs2yld9nksMCdOXhFde9pcN4aOZ21Ppvtnmy4NlB8r2sak7weXOWI=

On Tue, 12 May 2026 08:47:50 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 8 May 2026 20:26:23 +0800
> Chen Jun <chenjun102@huawei.com> wrote:
> 
> > Low-level functions have many call paths, and sometimes
> > we only care about the calls on a specific call path.
> > Add a new filter to filter based on the call stack.
> > 
> > Usage:
> > 1. echo 'caller=="$function_name"' > events/../filter  
> 
> Thanks for interesting idea :)
> 
> BTW, we already have "stacktrace". Since this actually checks
> stacktrace, not caller, so I think we should reuse it.
> Also, I think OP_GLOB is more suitable for this case.
> (and more useful)

Actually, it's not a stack trace, it's a function that is called from other
functions. But since "caller" sounds like a direct called function (stack
trace of the first instance), I think perhaps it should be "called_within" or
something similar. :-/

Also, OP_GLOB can't work because it only works for a single function. At
the time of parsing, it finds the function (and should probably error out
if there's more than one function with a given name). It then records the
start and end address of the function so it only needs to find if one of
the entries in the stack trace is between the start and end of the function.

I don't think this is possible with GLOB. We don't want to do a search of
the functions when the event is triggered.

-- Steve
