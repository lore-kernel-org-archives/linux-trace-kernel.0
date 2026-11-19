Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125381;
	b=jo7RhctkkBoheO+0lrXsnjJhOLUEUvNMjN0xumLiKYgSew3trszwMIyVNJpLao5xIKv0
	 EqovSnlHuk7If9YVKhPpXLxIteh+aNuEcqqNt84k1WFeFyFHHgOMk/+xcFREEXnUCltEX
	 Ns2+5x15YRnoI6nfC/JzCd/o4iEW1gwk8Ag2qDrRboqf/DhenAlmtlM25fjkIN7ymFKUg
	 lo8m3xW+a04gAU5oCCF4JtyjypouYqzAO/RPbQjiZMCeucnUI/q6y91HzUXE3j7+lceRP
	 zZzDTpquCnDof/0ogVwkMvU3b2k9tUFsVD2nMG20jXBhxvapIxLnBQGnrUs+yniKv6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125381;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=N7dbMmYIG6BB2Tf2XMsRRWZPC73QWIsWOtFiN1PUJsw=;
	b=X4/tFtUusOLNjqDyeX4WzbWQG4tR2qfbQYCAhUjPrtCAa+ABQT1jOvdcmu0JusYA2k9b
	 +ruI1oWCrdXIpdK8H/KtZDxCtQNkjayTExNiDM19XQMf0zuwgaiP1sZNsUjAUJDmAVlRr
	 VOIhPdTpHXVv3+IVVFCcBBP1J2dh5Sn5H4kym39/S3H+M423NE/DUBHOH66fV8LG04XWt
	 K02h9dINKveA5L8W2Jk+StRiEjcqdMz5PADYrNzTnLgDy+ivdoH/IzSSfa6a6TVjAzAle
	 rTcSgqjb4rFgBWlaq8cLTJVpmKTmtTscWg1haMd1Z8/YchXqEuoUXkfMNfDMhVHW2Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=eeV5+1lP;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE40606A325
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 21:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE40606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=eeV5+1lP
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 49EC9160C7B;
	Thu, 19 Nov 2026 21:56:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id A069420028;
	Thu, 19 Nov 2026 21:56:17 +0000 (UTC)
Date: Thu, 19 Nov 2026 16:56:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dominik Maier <dmnk@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 dmnk+artist@google.com
Subject: Re: [PATCH] tracing: check kallsyms_show_value() for numeric
 addresses in .function filter
Message-ID: <20261119165616.34c3f1f4@gandalf.local.home>
In-Reply-To: <20261119151901.7488cf38@gandalf.local.home>
References: <20261119192233.2664654-1-dmnk@google.com>
	<20261119151901.7488cf38@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3wc5ocrdkjogzpooasyzidbsqpjeuw8s
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A069420028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+6NJI9jAApQK/FBbeF3sljg4X8V7hgvyQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=N7dbMmYIG6BB2Tf2XMsRRWZPC73QWIsWOtFiN1PUJsw=; b=eeV5+1lPw/ct/6DvoK4ieOTP++h1sa0lFYvAAQg6zx0US3ysFhJGiMy3Mc2L2Lqnpif6KF0eeVLI7WSeEXpY8IK4yg+B61z3iNh1xc9ABxM18+ET42WOClYZ01lovZyVc9nDuE4OCVG9IyTQW9dpSl7q/Z2glVEOYeM7QhaC54I=
X-HE-Tag: 1795125377-753204
X-HE-Meta: U2FsdGVkX18CbtUINN0O6leQpy/5Zn4CuoMPegp4Se+jPyI+hyVhg9Mw4GT2+ULV4Dntdm4yda67J0saeUY5nSewetrvH/C9XbzCWbYr6DusqbU0NEczKBXhp+S7r9GStQaYLqRYTtRT1av+wYoMEjgD6DH+qEFDq1m/zcQdyVXEDdct/YYTiKLgY25yjfSPRNn5AZT0EDguykztER8VcDsYMf7fhc+jqISofW/cjRL0b5cwKPKho/qt5iJIuKeU5dagPU9gmKk3N7Ch7PK7JvMwJut80153ShrWbCcEbAXiawFrFh2Wbutsg7y8EzqKg8aKB+zRBKGMSfce1K0tmYcmXo3GNgGPoVwNoICQE4Hb4znw6vBz7O2Ta305a1a6mpncINiEK7BEI0BIImef7A==

On Thu, 19 Nov 2026 15:19:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 19 Nov 2026 20:22:33 +0100
> Dominik Maier <dmnk@google.com> wrote:
> 
> > In parse_pred(), the .function filter modifier accepts either a symbol
> > name or a raw numeric kernel address (such as 0xffffffff81000000) and
> > resolves it through kallsyms_lookup_size_offset().
> > 
> > While tracefs defaults to mode 0700, task-scoped counting tracepoint
> > events can be opened via perf_event_open() under default
> > perf_event_paranoid = 2 and configured via PERF_EVENT_IOC_SET_FILTER.
> > Allowing raw numeric addresses in .function predicates without checking
> > kallsyms_show_value(current_cred()) lets callers without kallsyms
> > address visibility test whether candidate kernel addresses fall within a
> > valid symbol despite kptr_restrict.  
> 
> God I HATE AI!!!
> 
> This is a perf bug, it needs to be solved in the perf code. How many times
> do I need to keep telling people with AI bots this! I think you are the
> third person to send the same patch.
> 
> The filter logic can expose kernel addresses. If perf isn't allowed to have
> access to that, then it shouldn't be allowed to filter.

I also want to point out that if you do filter by function name, the
address of the function is what is recorded in the perf ring buffer that
user space has access to. So all this change is doing is giving a false
sense of security.

Another reason to not allow trace filtering (or tracing for that matter) if
you do not want to expose kernel addresses.

-- Steve

