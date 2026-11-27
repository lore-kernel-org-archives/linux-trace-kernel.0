Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786936;
	b=a20RUHKTu3liVKkBQFnR44nLeXq7ALlPQVxvCbfEhC7pNd+brq8sZPOOhwTdhuFKQzk3
	 JBjK9GtD9Ro7KCuAYjCOQoXsUZ6gyAM4E0lOkHdmAGbTOXCjTik4NaUxLTqGPLIDlDpfO
	 shJkzaZVkwxDJVhe0N2Pf66XPiXyiaqHZkQjrkDDueaHeYuuZaiilpNcfZv+NjXP2/X1z
	 mA8v/7Q7UVVV086I10EiC9tPSwbcaLGTzxcHtMv3eDj/x7aTOnCTNP0l0aZhFBsHN7ksB
	 66PaJfFBoRSGMkfuz9xH3P7OUvA0oP40vtIncx5Qv0j40WEKLcdSVatH62t0F0qDSxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786936;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=RQlG0v4Trtbaptdh5GqnribpcB9Q2TYYpJ7BqbeuP0w=;
	b=14w9Vylaa2F/xlNBvM4plm6Dnu/CjMwfCOzaijvhbbPKwz+ORIcTlCB68IhR3TlLAJeR
	 cxYPSggm9ht7vTAor6QU2AjM9Yw0yzZMU3jzWkeZ9XUOCL1NAORFPjztZYuVBjsBptpeH
	 52gD9BSF0aOfP1MhZmbIobfy2XlRnOOE3vBzM2Ittgf2tdKUWDKYTfQpgVj9OkYL31eKi
	 lovv1Ottu/Izf9wIlZ+w6tE5n2d8onIP7+sCRvD5eFwWoV0j8sh75mE7NKlWWtZOiwEdV
	 +Hq6Xn5mxPBNlioRpbLOnSjn9/DP5RHhViFSFB09H7ndiv7CaW4Lu4jU8zWqS99yTaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="A5EYb/eT";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091D606A31C;
	Fri, 27 Nov 2026 13:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8091D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A5EYb/eT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED7C31758;
	Fri, 27 Nov 2026 05:42:12 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DF053F632;
	Fri, 27 Nov 2026 05:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795786935; bh=xC6wYRcGfViCjcXm1JDHAhxmgvTwmoH9FHOORhqqP+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5EYb/eTLfRSLdOvhq6fwaXlbRUI9DcXJYTUSIlisNg1iHWL+X/bv91TO1mVDbeha
	 zTQvTfAg7y1yEiUToexDQQ5D/5GFU34Q4dl7QW2UkkUU3TISrFKZHE6j3NsfM7yO7F
	 NG1HBqENS5cK/xtQ57FZPlCA3ei27z0wHeqqMHfk=
Date: Fri, 27 Nov 2026 13:42:02 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Hongyan Xia <hongyan.xia@transsion.com>, Song Liu <song@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: Always inline preempt count and reschedule
 checks
Message-ID: <awmIqm3y8NLf4115@arm.com>
References: <cover.1795631277.git.kmehltretter@gmail.com>
 <9546998cffeaf365f8f67901a48ef103945dc342.1795631277.git.kmehltretter@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9546998cffeaf365f8f67901a48ef103945dc342.1795631277.git.kmehltretter@gmail.com>

On Thu, Nov 26, 2026 at 03:30:53AM +0100, Karl Mehltretter wrote:
> The preempt count and reschedule checks are plain inline functions,
> which permits out-of-line copies in instrumentable text. The checked
> notrace helpers added by the following patch use preempt_count(), while
> preempt_enable_notrace() uses should_resched() with
> CONFIG_DEBUG_PREEMPT and __preempt_count_dec_and_test() without it.
> 
> Force all three operations inline so noinstr callers keep them in their
> own section.
> 
> Reviewed-by: Hongyan Xia <hongyan.xia@transsion.com>
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
