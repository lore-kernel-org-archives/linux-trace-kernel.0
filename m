Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FC4195C9;
	Sat,  8 Aug 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786201144; cv=none; b=km2dlA8hdYzcG3ilJEVvGd03wh2znwFO8AFPSNmZlLSNFOqyqB7IaJL0atwA2OIXKZnDh6LCjBIF50sWqlkw7EwNzB19Rws+aPfGaxjJyXVlPKEnrAXKY+i2gPHV4g5SOQarQr8HILIt6lNBRM0VxuLYndkFtii/BUuP/i2N5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786201144; c=relaxed/simple;
	bh=TFaEeqovJvVCqa8ofuIKNn/LxijcO8j6rVCkYoYNhf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjeQ1CD88MrOLO0TyCZQcLrQ1rtbwEkaSxJCTvA7aVAVyuSmsFMQdObows8p+HICBA9nz/E9IxBLym20AhWsk2TCUZlykQpSa2OiX2dmsEC6ca5itr4WMI6DKsv2Na16byc9iZtkOtWFZfeS3dLao1O+NCXcgL0waj8wDl5ZX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D71B0A239C;
	Sat,  8 Aug 2026 14:58:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 0D96A80012;
	Sat,  8 Aug 2026 14:58:56 +0000 (UTC)
Date: Sat, 8 Aug 2026 10:58:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tracing/snapshot: Use work_on_cpu to avoid
 -EBUSY during snapshot swap
Message-ID: <20260808105855.09f8d794@robin>
In-Reply-To: <20260803005640.2445666-3-wutengda@huaweicloud.com>
References: <20260803005640.2445666-1-wutengda@huaweicloud.com>
	<20260803005640.2445666-3-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wtppxqodqstrc1bzukxnw1z3w56f11g6
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0D96A80012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18zIgMwhnkcsGFtt7YxGnhddSDM6AuxJHs=
X-HE-Tag: 1786201136-605410
X-HE-Meta: U2FsdGVkX1+sfl9hndA6d//bpm5CEv/L4vOXSdCuwfsvlT5bwko8ng9fiqs/moeS22n1cHYnv6AFWEY/mx/mDEZXCs71eusXU3KikOUbk1EN2qAFcD+X2rfRH3wz/jHo+Vyb2nH/BbCHsnANAx2G9DU3gKZAwY+uKNntnGFYbVaJCl0SqQxDUdIiP9QH1OzcyhvtLif2EqI3SyH0xYEdEfsLmAzEiJdznRR2xpMvgOJEV47bGQAr777zGCqj3Uez4h9twUQxBbPSzZFYcs3aRIZG+OShCfkoIGPLpsuxwvGvQVxwFOLDVMIhEMahd2YyHmMKhTWN26j1pRzha5cw2rjpKHL8wye7fKXcAjyNry3dzajIEEyz4K81ylPUFATZKj2PT+S3uaw824MfclW36A==


Sashiko brings up a good point. This will break the recording of what
task is being interrupted.

  https://sashiko.dev/#/patchset/20260803005640.2445666-2-wutengda%40huaweicloud.com


> --- Patch [2]: [PATCH v2 2/2] tracing/snapshot: Use work_on_cpu to avoid -EBUSY during snapshot swap ---
> commit b61ca8359fdea427c80a410f6d4052c68af5eae3
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> tracing/snapshot: Use work_on_cpu to avoid -EBUSY during snapshot swap
> 
> This commit replaces smp_call_function_single() with work_on_cpu() in
> the snapshot write path to avoid -EBUSY errors when a target CPU is
> actively writing to the ring buffer.
> 
> > diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
> > --- a/kernel/trace/trace_snapshot.c
> > +++ b/kernel/trace/trace_snapshot.c
> 
> [ ... ]
> 
> > -static void tracing_swap_cpu_buffer(void *tr)
> > +static long tracing_swap_cpu_buffer(void *tr)
> >  {
> > +	local_irq_disable();
> >  	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
> 
> When calling update_max_tr_single() from a workqueue thread, does passing
> current result in the trace snapshot recording the kworker task instead of
> the interrupted task?
> 
> In the previous smp_call_function_single() implementation, current would
> represent the task executing on the target CPU, but now it will capture
> the kworker thread.

And thinking of one usecase, what if you had a high priroity task you
wanted to snashot? This wouldn't work to do that.

Now we can still keep the ipi and send data that holds the tr and
state. It waits for the ipi to finish anyway. Then it can check if the
swap happened or not, and could report a fail, or it could try again?

> 
> > +	local_irq_enable();
> > +	return 0;
> >  }
> 
> [ ... ]
> 
> > @@ -689,8 +692,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
> >  			update_max_tr(tr, current, smp_processor_id(), NULL);
> >  			local_irq_enable();
> >  		} else {
> > -			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
> > -						 (void *)tr, 1);
> > +			work_on_cpu(iter->cpu_file, tracing_swap_cpu_buffer, (void *)tr);
> 
> Can this result in swapping the wrong CPU's trace ring buffer if
> iter->cpu_file is an offline CPU, or if the CPU goes offline concurrently?
> 
> Because cpus_read_lock() is not held, if the target CPU is offline, the
> workqueue subsystem may execute the work on a fallback online CPU.
> 
> When tracing_swap_cpu_buffer() then calls smp_processor_id(), it will
> evaluate to the fallback CPU's ID rather than the intended target CPU.
> 
> This could potentially modify an unrelated online CPU's trace buffer while
> leaving the requested offline CPU's buffer unchanged.

This too looks to be a valid concern.

> 
> >  		}
> >  		tracing_disarm_snapshot(tr);
> >  		break;

-- Steve
