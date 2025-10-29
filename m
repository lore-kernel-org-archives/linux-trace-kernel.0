Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA51DF994;
	Wed, 29 Oct 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747750; cv=none; b=lOuxx7x9E3y4jJODa173Wng5hTu+UFHMqWqLGvwXtDoDCLy3PqOIwoxHqy/GPTgZbpsR96O2yICl9LPLkhTmqCcVQUiVwIZPAWbhR3gUg3v1iqlFqPf/w6iFgzE/6rBawwiGzNvqyvju+JCcIk4WUk7nFwARl+3a0hZwyJBe4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747750; c=relaxed/simple;
	bh=/K2tNKpSH7o52ver8MEmXEoa5wWhvu+EL/PZwy8lTuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTcXc+okXgNhr2cxMTSbtuDE0znGluJownCXvzPWrhcXWRLLQAjzVMPlB7hMijNRlTpULJvfq0dkU3K601sGp2dxHN5VunE2kP8s2rja0cID4rR0z4IvEUqGXMhpHye/ub6h1hUea0+p3rGjNUIuOgL4PmCwBb5ZSPtlAklt1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 9C44B140773;
	Wed, 29 Oct 2025 14:22:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 88CA920010;
	Wed, 29 Oct 2025 14:22:24 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:23:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com,
 jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: use ftrace if
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-ID: <20251029102304.2db99b7d@gandalf.local.home>
In-Reply-To: <CADxym3YcR+WYjRv-0+SOiE1yoO85FaqffCF2XbLZ9H7+qHet6w@mail.gmail.com>
References: <20251029021514.25076-1-dongml2@chinatelecom.cn>
	<20251029100045.1bacc491@gandalf.local.home>
	<CADxym3YcR+WYjRv-0+SOiE1yoO85FaqffCF2XbLZ9H7+qHet6w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 88CA920010
X-Stat-Signature: g4475fqsyit9fhjxs19fgwpit7od6mt6
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+CZcth+8LZL07aYVm63mr9pIYIh09s7ik=
X-HE-Tag: 1761747744-170205
X-HE-Meta: U2FsdGVkX19ddoRVo88WcsKPVVcsqnBhvb+psz/OqmsSQshP0ZpQkT7xMAAaHxMzif85O3cZbw/GfEBUxdjH1MIDY6GoptXBSRx1fbS+84C4AxtOhCSIxnCTfd6CdFSsuHPTkOU70GFDHCU7ajeYyDCmHj8okErDeixeaN+6F6DUGPh5ZZd9JLPrhh0o8kS2wZ++fQ+kPjH4+H5E2Cg2aPsKnrUFJNRy2ETbsNgiLSxZ/lWD1tFsieYFZ7yBLfmmBIIOyTz2buqm3c4LEnbiYq0pxoZCPQEjVf9wjgAk9nyjcWFQuvRSa6kkd01jyxvyu9xyV4AA22g0HRt+F7doA9NawAoqnCFWt2BP3eoLygAv8LvYElPelXFg+7KaQrOd6NRYJocOQok=

On Wed, 29 Oct 2025 22:09:40 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> Hi, it won't fail here, as FTRACE_OPS_FL_SAVE_ARGS has
> following definition:
> 
> #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> #define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
> #else
> #define FTRACE_OPS_FL_SAVE_ARGS                        0
> #endif

Bah, I should have known that, as I think I requested it :-p

[ chalks this up for a senior moment! ]


> 
> Which means it will fallback to FTRACE_OPS_FL_SAVE_REGS if
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS not defined.
> 
> I have commit a PR to the bpf CI, and all testings passed and no
> building error happens:
>   https://github.com/kernel-patches/bpf/pull/10110

OK, thanks,

-- Steve

