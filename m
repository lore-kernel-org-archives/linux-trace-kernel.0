Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20EF21CC6A;
	Fri,  7 Mar 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360899; cv=none; b=rds1ECPBM++ADOqhqd3gDXdcFZG3DA5w2oKR2vzPhBPoCfZFTb++sIUATMpevxWdzfc2v+WIX+C3ORTQfWFkQb5ZCCmTjOEewcqBF1qBm2c3jQaMe+K3yQfsHfT02dsLgHk9bDIWdWLtpN60hcZ4yKYoBbcc1lBRQh5c11Mdb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360899; c=relaxed/simple;
	bh=MqWiw97/5nkd/S999750AWUmyzNvhzGACFhzgY/rhws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGQxyeh47j1/o4XGzYCgw48kD6dtcw+WumsVSSDIwi4BPhYGVJCjSSWCL7ytb6yYieJlAOUDeb6ekUfIxR72alaCrpuFFGTsVC+d1z+wJMomLlvxG0oHnDEHMQc75SdTDJYfjJYN0wWo4vZ+O89kUAtj/cEjpz9EybOAP3cod7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B460CC4CEE3;
	Fri,  7 Mar 2025 15:21:37 +0000 (UTC)
Date: Fri, 7 Mar 2025 10:21:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] tracing: Remove checking the activity when module
 map is updating
Message-ID: <20250307102137.2b3dde8f@gandalf.local.home>
In-Reply-To: <173886113592.496116.11615563462036645436.stgit@devnote2>
References: <20250207015330.5c71ad55ed2f516da1410711@kernel.org>
	<173886113592.496116.11615563462036645436.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Feb 2025 01:58:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Remove unnecessary active check because tr->flags already checks it.

I've thought this over, and sure, if we start tracing on a persistent ring
buffer, then it can add all modules loaded from then on even if it it's not
tracing.

Can you merge patches 1 and 2, rebase it on ring-buffer/for-next and
resubmit this as one patch?

Thanks,

-- Steve
