Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98368635D;
	Fri, 25 Jul 2025 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448431; cv=none; b=RkTgZSpqLwgohhgMpcMopHXzCPQ6gqIUWgyRsSFIqGaHAfJb/yreV+QcX8UCbBBF61kGlRrsGBGGQ0hjoFfZ4bY+jVOvhSiauM1sreF4E27b2ZEnDAEs5zzHHylkwBigKxTABLToN06c4YrhycjdhcAwaIHKwQ0UIYhSwj1334U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448431; c=relaxed/simple;
	bh=knUYahf+MguxiIDnk05qiukxSE9mY7K8IL5uVUew2mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOHnR0zJqluEmi8j5KQ8MZMpoYZFby0Nf7SZyUAVRmZOeJzka0BchrRRB8QszxCKc4M0QtcEPcnd+WzrkH5m/+wSQKlX4tc+1gc3h+wCGfDHJqFa9+z6cJdv+62L/SP6C4eTq0F939Y54dR45VBRuqV95G+dUD3kPfy6cKtSfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 196D2140764;
	Fri, 25 Jul 2025 13:00:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 28C6F2002B;
	Fri, 25 Jul 2025 13:00:19 +0000 (UTC)
Date: Fri, 25 Jul 2025 09:00:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: sched: Hide numa events under
 CONFIG_NUMA_BALANCING
Message-ID: <20250725090024.64157cd6@gandalf.local.home>
In-Reply-To: <708b26cc-e888-44d1-a7eb-ba37dea23a89@linux.ibm.com>
References: <20250612100552.39672cf9@batman.local.home>
	<708b26cc-e888-44d1-a7eb-ba37dea23a89@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ynguarhiuu4jshf7curd3p3yp6bttj1r
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 28C6F2002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/EJ+fNlUCAt/6QpuJy6Yd+7NGpHqGTenY=
X-HE-Tag: 1753448419-174715
X-HE-Meta: U2FsdGVkX1/tb8rOoL9JOd1AL8EEuTRS+UHfk5GH0RZ9SGSV51slbU/88pPYv8YyqbPeN2LaxNy1IvnUzcRJCMH0rrkVtVlarAn2UKS6w+XGY9WzWK1BfSkxWAxqoCJWYtGjLsQC7GEW+17T79Y6NecFEvlYTIiz1/b2UNV2YnfxzBuH82jYxOnietieRw9tNn6dnlzYUHDIgFCMo632QALV+9y0dgIL2j8xXtRJEkHGLL6YRfKLys6FWH5qcs07jksM13IpSzMOAk25oGgtoULX4wZ+XEf4irpHJkTX0Dhz5YYayF7Cln6HQd0D3i2r6aV7Zo4ZAKadyGGeBFl2vtfeDYpQq4x2W5xED4N19htE0g+kC6ejK5oC1UBdXbWhDuiqNYGK0b12eQJB8oSFIA==

On Wed, 23 Jul 2025 15:14:26 +0530
Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> On 6/12/25 19:35, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > The events sched_move_numa, sched_stick_numa and sched_swap_numa are only
> > called when CONFIG_NUMA_BALANCING is configured. As each event can take up
> > to 5K of memory in text and meta data regardless if they are used or not,
> > they should not be defined when used.  
> 
> they should be defined when used?

That was supposed to be: "they should not be defined when unused."

Thanks for pointing it out.

> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Thanks!

-- Steve
