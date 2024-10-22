Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067601957FC;
	Tue, 22 Oct 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592405; cv=none; b=YjspoVEwcC3OT1ZQsl19+mOCXKkhaEIRLuDW6ffBQvgnezrZFqOGJE9Ank+Arfq/3Bg0dGIrM+fuLtBDxWT9ivpjMx2EaGk1lFMjfje0p+ka37hBLUNI7329ExqCEC6cI2cGp3u3UVR4yKJh1gXEVd+AzGDpnSAilTNfFRlWVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592405; c=relaxed/simple;
	bh=UZijIk85NiITc/54y4AI3motwnUKVY9NAds+RxOjrTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtO0jP8lWIiUbedRwN8phqN/HzO1bJOHg+5zJGkXAKOaOb54Dj0fQyfJlFkejkdQisv/M0N175Qwa8NdZgnPe/FcwJl4jEbxOzByyEToM9SY+LKIanrMIxBwXdZJjEUgcRs0ZQfC7ub1DvXTtIAu9F5RGRVBR+Z0f2UvtjeefPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB86C4CEC3;
	Tue, 22 Oct 2024 10:20:02 +0000 (UTC)
Date: Tue, 22 Oct 2024 06:19:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 1/3] tracing: Replace TRACE_FLAG_IRQS_NOSUPPORT with
 its config option.
Message-ID: <20241022061959.31775f7a@rorschach.local.home>
In-Reply-To: <20241022095241.RFY4Iiu_@linutronix.de>
References: <20241021151257.102296-1-bigeasy@linutronix.de>
	<20241021151257.102296-2-bigeasy@linutronix.de>
	<20241022031418.12154e63@rorschach.local.home>
	<20241022095241.RFY4Iiu_@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 11:52:41 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > 
> > Please just remove NOSUPPORT and do not touch NEED_RESCHED.  
> 
> Then I put the lazy bit where we have not NOSUPPORT.

I'm afraid user space will confuse this with the NOSUPPORT.

-- Steve
