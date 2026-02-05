Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27271E5201;
	Thu,  5 Feb 2026 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770252052; cv=none; b=GFPxoAxEI+q+uy08Dq9/OX3OqzgcQW2MRqNjSnYpp10yRrq7iX/QvAIzamssULTB73c1ofFaggGSvdyGOCYtiJxHYrYWJWGzSN5/j17K/Z7ypk7/yGY5b6OE5A97Vdcv290a4Imso50URJMXj0cHRgsq17K/R1cB3+Q3xYFE8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770252052; c=relaxed/simple;
	bh=wPUAR+6nSzzfP/xggrMdPNlqyAZmcFoiQcB1OKYZTsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv+i9OI9PBI+LtSfjvl2HjUDcQXj+1u/STUX42idvieMXZQ6gyr/rHKT8yT02C1MQSe+WX4btgFVwR7GrDXZbD0nTKLzT+g/pjQLYKZ+C49eXdFlxr7J+Jx73gDYAKFCO+IqRvVMpLrXo1Ckb0nY6WzJ6Mgx9TCdDytb+WaCIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 80681B8666;
	Thu,  5 Feb 2026 00:40:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id B5FAE8000E;
	Thu,  5 Feb 2026 00:40:41 +0000 (UTC)
Date: Wed, 4 Feb 2026 19:40:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 09/30] tracing: Add events to trace remotes
Message-ID: <20260204194040.30aff151@robin>
In-Reply-To: <20260131132848.254084-10-vdonnefort@google.com>
References: <20260131132848.254084-1-vdonnefort@google.com>
	<20260131132848.254084-10-vdonnefort@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: B5FAE8000E
X-Stat-Signature: gs59tekaskcuwcy645fm8izpg3hrje74
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+nXosfAYo2fUF2Ivd/Xmy2vCcs9gSfwy0=
X-HE-Tag: 1770252041-244299
X-HE-Meta: U2FsdGVkX1/iA16V/WxPX1xn7eUAz8YuJnJRROkLvYFXycB4HpiSKeqNps6QKewK7Rc+mpitAlABvyauscnWVU+eG7yKgtT9esslqC5i0qdwFo4jzvfl8p22J+uRmdu2Uiz1iGD1Rf9WsmoLBklMsEJnEI95aVbJHpLdztEXRb/3czaENG33tIaapl1OOv6yha4zRdA7b7QPzEPTg29wT2e7A869w8J20fUHdbDbHa7+LhFgfFaPGpzwSHvzTQk/Gf/OaAm7Ig+mXuKUJEJNh/1AdkrMaeEhTn5LKg5Wr1yh5FKQguAs48myZBRjeNdR5U3sxsPYIyowNtoS3YU3ZlYU6Cv2JRgSYEJ4w/boDlMJlYO8vwRPFx6BaJ1nHw1U7eh1+OkluPHn43ftIPOHFQ==

On Sat, 31 Jan 2026 13:28:27 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> @@ -487,16 +494,19 @@ __peek_event(struct trace_remote_iterator *iter, int cpu, u64 *ts, unsigned long
>  static bool trace_remote_iter_read_event(struct trace_remote_iterator *iter)
>  {
>  	struct trace_buffer *trace_buffer = iter->remote->trace_buffer;
> +	struct ring_buffer_event *rb_evt;
>  	int cpu = iter->cpu;
>  
>  	if (cpu != RING_BUFFER_ALL_CPUS) {
>  		if (ring_buffer_empty_cpu(trace_buffer, cpu))
>  			return false;
>  
> -		if (!__peek_event(iter, cpu, &iter->ts, &iter->lost_events))
> +		rb_evt = __peek_event(iter, cpu, &iter->ts, &iter->lost_events);
> +		if (!rb_evt)
>  			return false;
>  
>  		iter->evt_cpu = cpu;
> +		iter->evt = (struct remote_event_hdr *)ring_buffer_event_data(rb_evt);

BTW, you don't need to typecast the return of ring_buffer_event_data()
as that returns a void pointer.

>  		return true;
>  	}
>  
> @@ -508,7 +518,8 @@ static bool trace_remote_iter_read_event(struct trace_remote_iterator *iter)
>  		if (ring_buffer_empty_cpu(trace_buffer, cpu))
>  			continue;
>  
> -		if (!__peek_event(iter, cpu, &ts, &lost_events))
> +		rb_evt = __peek_event(iter, cpu, &ts, &lost_events);
> +		if (!rb_evt)
>  			continue;
>  
>  		if (ts >= iter->ts)
> @@ -516,6 +527,7 @@ static bool trace_remote_iter_read_event(struct trace_remote_iterator *iter)
>  
>  		iter->ts = ts;
>  		iter->evt_cpu = cpu;
> +		iter->evt = (struct remote_event_hdr *)ring_buffer_event_data(rb_evt);

ditto.

>  		iter->lost_events = lost_events;
>  	}
>  

Other than that...

Review-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> @@ -536,8 +548,11 @@ static void trace_remote_iter_move(struct trace_remote_iterator *iter)
>  	}
>  }
>  
