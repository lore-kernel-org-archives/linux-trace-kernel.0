Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9F17C219;
	Thu, 26 Jun 2025 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955665; cv=none; b=IZdh+6Pek9abXXDKknvBbQsq0rvMessc/U/ZvxkoLRByUtv8TAvBs2lIs3Y1A0kUBOCm4sJtKo+wPmXxneIWPW6Xsam3fYHG1z58EHY5d6IwKeicidEFi/t9s8t/LachyyBzIpvxuy8sE4qsq+bvBWG4ElTLcW05N9acrhkOCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955665; c=relaxed/simple;
	bh=JYE5pcEbbQ7PexQD5Qqy3qPqvYjgWviF0W373vmEc1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgIqeCZI2Fb8pQCYnxwaVvRsiZaV5EbOyGH0WdDAoxU3D34MsIFTH2uhDbil8Kb61eVA+KyIulYzqmOSF2W3TBjT/rBnEKL91MpPlxweYA4cAHV+hehwJXwhnywVsNUyu4T3ZEYZf1RiglIyfjRcVeHCoIGau8QfN3ETjB8fMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4FDA11214B7;
	Thu, 26 Jun 2025 16:34:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 577BF35;
	Thu, 26 Jun 2025 16:34:19 +0000 (UTC)
Date: Thu, 26 Jun 2025 12:34:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>,
 john.ogness@linutronix.de
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250626123445.5b01849d@gandalf.local.home>
In-Reply-To: <20250626160459.soHxOROG@linutronix.de>
References: <20250626151940.1756398-1-namcao@linutronix.de>
	<20250626113520.315db641@gandalf.local.home>
	<20250626160459.soHxOROG@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ni1jw18jkg4prw3mndxhtffzm3wfigec
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 577BF35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/b2JM2aeyr08bwnM39TYmxS3CKt1qrqTw=
X-HE-Tag: 1750955659-626339
X-HE-Meta: U2FsdGVkX19kpHORzFaT2SOLZyYQZLkmaBnDkJV0j7piw4tcdgUp0NgSnUHy3cQtSgv3ItzdlnZtMH6DKLqsyAbrflQlDoLTfCKslDS/CxA9izbhAswxw6fQZBicp/CVYiIc9mQTUDLEHzUj9wc+48d3lJxNXCsTCwz/q7TOmBI89Ga+oWmiYr4A13dJ8iuDj9ypi9PkBpKjCIZX6UYS4Lrp0d7KqLyWTRyfa1BrQVrmdK8LNTeYq2Yz9sMVLEZ5uN0SgbH33IpXd7YtDluc+Ztq7vh9fuMIWFJg3FMat1LkAvnqQTjCN+NVgKELZqG9

On Thu, 26 Jun 2025 18:04:59 +0200
Nam Cao <namcao@linutronix.de> wrote:

> I think you have it inverted? I assume you meant:
> 
> "Without the barriers, the tr->buffer_disabled = 1 can be set on one CPU,
> and the other CPU can think the buffer is still enabled and do work that
> will end up doing nothing."
> 
> Your scenario can still happen despite the memory barrier:

Yes, but the point isn't really to prevent the race. It's more about making
the race window smaller.

When we disable it, if something is currently using it then it may or may
not get in. That's fine as this isn't critical.

But from my understanding, without the barriers, some architectures may
never see the update. That is, the write from one CPU may not get to memory
for a long time and new incoming readers will still see the old data. I'm
more concerned with new readers than ones that are currently racing with
the updates.

> 
> CPU1                          CPU2
>                               smp_rb()
>                               read buffer_disabled, see 0 --> let's do work!
> buffer_disabled=1
> smp_wb()
>                               do work -> end up doing nothing
> 
> >From my understanding, smp_wb()'s purpose is ensuring the ordering of one  
> write and another write, e.g.:
>     write(a)
>     smp_wb()
>     write(b)
> 
> For our case, there is only a single write. Therefore I don't think
> smp_wb() is useful.

Well, it does make it visible for other CPUs that do not have strong cache
coherency.

-- Steve
