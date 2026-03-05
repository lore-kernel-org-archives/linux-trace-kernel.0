Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA23803F4;
	Thu,  5 Mar 2026 17:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731961; cv=none; b=dYBaw3yLrLyeABiqKTlypP8NebgwPHns/SY10eTkz08tTpeQ8fCMqa27I+9OU+zixTjgEUoRw3M4v0/u1juSBRTpzB9wsFmuZZfEY9nIeL1/Kj5aOOsGr4LHxCgwlwuUBM/eNpMQi/SpJdj+hJIqBlHwby4NpO6lLbADYD/pKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731961; c=relaxed/simple;
	bh=IbvuJcfEtGd/mvNIUBGgVykAuvxDHy31Eu7JadDiGPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM4iDRi8lp3ymVkuDtkIc3X6nG29uupQMgrpbyd0YtyvXE+fKRXOO8111JEdJeGQZzTlxeXvIZuwgM5qbL7lko3uqTmfZsG6j20qHH95hLZ9UW59UkfGTm4QpPmzCsMrE7UNhDGo24DWNtCG1A6MyNKRupmul6Wndp5cvg9MB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0C1321C1C4;
	Thu,  5 Mar 2026 17:32:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 6869B2000D;
	Thu,  5 Mar 2026 17:32:36 +0000 (UTC)
Date: Thu, 5 Mar 2026 12:33:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] tracefs: Check file permission even if user has
 CAP_DAC_OVERRIDE
Message-ID: <20260305123314.41ab284d@gandalf.local.home>
In-Reply-To: <20260212151515.b384ac24de9b736d10387d21@kernel.org>
References: <177071300558.2293046.12057922262682243630.stgit@mhiramat.tok.corp.google.com>
	<177071303130.2293046.2400906233143699263.stgit@mhiramat.tok.corp.google.com>
	<20260211104623.73fd4fc3@fedora>
	<20260212151515.b384ac24de9b736d10387d21@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 313q8tywgfyd5km4fcwxr9s6ym14obt7
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6869B2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YWMAtVtClkUP6hnHDumoufIML+MPyCYw=
X-HE-Tag: 1772731956-286931
X-HE-Meta: U2FsdGVkX1+/QSCrCkaLUH/TZ2JoE36Bcyw/CmcmT7KZkNJOjCZd/jYzyI9Vy6hyn1Yif2xMWa63i7Ys0W5gvw+Gkd1ANiAJsqlZkh/7otznYNIdWCDZ9tjymoEYhJZNQoRw49xae49XKCtCPSgArgLUNckmFfd3p9jCEVHoFUWTQvl8dhWW84KUfd+0Mj0WeAu05S43DMpgVqsGo7fF9UWHH1gxs5xum1JIflQKfuX7cKVjd+fvzUmUv+j98v78L27HnG0mJRtat2xPgz+JKZEN9GEdGRxP0mrMcESfAdh3/+JoTtZHbvDTe76axy8i0Os0fz5ir4p7bd3GpFeq+CS7NfYcGr4X

On Thu, 12 Feb 2026 15:15:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > With this still not working this late in the game, it will need to wait
> > until the next merge window. I'll take the first two patches of this
> > series now though.  
> 
> OK. I will send the next version without the first 2 patches.

Hi Masami,

Did you send a new version of this yet?

-- Steve
