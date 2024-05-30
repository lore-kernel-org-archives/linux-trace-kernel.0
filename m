Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656617C9E4
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 May 2024 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073842; cv=none; b=SXyRO6CbXFqM8Y7BLq/97qGY47VMrjtdWmfZoq9Zi20EfxJjMZ9BEv66OnhVWYAgPncGKXyyGkKCHrGjetL7lEPe0Yqrl/gcpbv046J64MBMnouZCuKHSPjiiufACKI1rclnGbvNPlnjKmiFD/on4CUjdVt0obo8oh5Fks9JDDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073842; c=relaxed/simple;
	bh=M826r25itK13hoOYuqcjkMuU1j79TbnYdc9D0gumr34=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gdNeEImNDQ1RwnzqP68HMOPqc7Es1GZNPgovoRUv9Cp10oN61LgWrmz3MH2F3LmERwndsN5utME4x0ZrN8E6iolTbjwjtazHQmX9Dt3FBzKt/uesMxKj890ucCulTdYp2ax3qyzejCT8PS/fPEL7bBrR5mBWYuWxz+M7lz2CrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWs0LJuY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWs0LJuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E377C2BBFC;
	Thu, 30 May 2024 12:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717073841;
	bh=M826r25itK13hoOYuqcjkMuU1j79TbnYdc9D0gumr34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lWs0LJuY4xsgPy+6MLbOo5vN7qwcL3CIeqLv+S4ExJF/QHRfRgA3czyocBO2Tn8VV
	 tCHZeZ1bJKcYvGaaj2Tda3NaxYQEYE9O+SMZ7P6ObgWerkyMXnSMIaHo5etjcSxqO6
	 K65MTCGTayhtmngcLNQ0Fle5YETh80B3Cw4HmYj0/hIhB9K+hddqpdbPibJjVPoc4d
	 pjBXgQZrcLxcw7T365ZdXsDbtTo3hQuxeQ0TK8OuhrFP4qF0TeLxJYpSQKoBvl0hc1
	 k+9/q/NSwCrMiKnwmFvuI48JXEo5aGuMHz/PLROWOEjAEYrBgHtk3lMmsCn0/smD0x
	 t8M52TuUwQptg==
Date: Thu, 30 May 2024 21:57:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: don <zds100@gmail.com>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: How to trace kvm:kvm_exit using fprobe?
Message-Id: <20240530215718.aeec973a1d0bf058d39cb1e3@kernel.org>
In-Reply-To: <CAH8woH1vBJSZOD=ZXVRt8NOPfi89gWbKmpHGJZVs=Wqj00DG7Q@mail.gmail.com>
References: <CAH8woH1vBJSZOD=ZXVRt8NOPfi89gWbKmpHGJZVs=Wqj00DG7Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi don,

Thanks for reporting!
I confirmed that the raw tracepoint probe event does not work on
the tracepoint in the module. (not only kvm but also other modules)

Let me fix the issue.

Thank you,

On Tue, 21 May 2024 17:28:48 -0700
don <zds100@gmail.com> wrote:

> Hi,  Mr Masami Hiramatsu，
> I see your presentation "Function Parameters with BTF Function tracing with
> parameters",
> and I started using fprobe and dynamic_events to trace functions.
> 
> I have a question regarding tracepoints using fprobe/dynamic_events
> I can trace the kvm:kvm_exit event using trace-cmd:
> 
> *trace-cmd stream -e kvm:kvm_exit*
> But if I echo to dynamic_event will get "Invalid argument" error:
> # cd /sys/kernel/debug/tracing
> 
> *# echo 't:kvm kvm_exit' >> dynamic_events*-bash: echo: write error:
> Invalid argument
> 
> How to solve this problem?
> 
> Thanks,
> don


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
