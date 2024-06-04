Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF73179BC;
	Tue,  4 Jun 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524142; cv=none; b=o47TtoTIWoHOW+vKOyk5/6aD4ChBhk2yENN76/uHCXmylFCeI1awxjKYAcmUQBDBLOhIFYNNZ9TqLCUTIuR6jGmam1BCYDzj++GvF5zjoADUSH/ZN2+jrsVqxgwZKDywerXr6vK3WW9TXkZiQVFER714Ee+MZs3DuGPBW6TOfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524142; c=relaxed/simple;
	bh=qcp+UzM4xs7eHbK/5zAhD0ChiUogwbeZjzyp4fNvko8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLsrrB/hOvGORrdAHj5+WFQYab9h3z8hc0F3AGSFai8D2op155B87fW3d4EeQkF6lpp1y8vHVwyP190n4yYcrIg0iVVJUFdXonzsjf1TFzy8dpMHtNNfLcISsE9eFSmHpHdyw6+1DuzsKoE4OXSPUriOOZWZiWTNBNDyW/4fapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=H1DXBN0q; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="H1DXBN0q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717524138;
	bh=qcp+UzM4xs7eHbK/5zAhD0ChiUogwbeZjzyp4fNvko8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H1DXBN0qrpkHb1DP3ffwmLu34qJNIxKYImS1RbipV5DwDdW97Q+To4Q618q7A26pe
	 qjGlrE0JFS/7pLIU2HuTUHXJXdImwlw82h3SNo5WEAPegF5gSW5IN5+Dx7q/enMupW
	 wpIPAL008Q6I6iW+mVLd/HJsvcYIegDNlj2pZrG7XHLf/a/EraCwFIuRf5op6fct+K
	 AUXVHncX/+QwKlJDPDubt12oicVEezHoNh02ZICqqcga3fjfZ6CYlHmLsyJdp7wpDh
	 NBLuBO40/vMKwLfhRapC9UdUbxEAGh89SOxNu+varXmf2/7bpdZi7Q3wfIo1c6kLnX
	 Myc9baY/JqNPA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vtz2L0d0lz12ld;
	Tue,  4 Jun 2024 14:02:18 -0400 (EDT)
Message-ID: <5fc7a866-ecd9-4b57-9740-369544df1264@efficios.com>
Date: Tue, 4 Jun 2024 14:03:05 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tracing/fprobe: Support raw tracepoint events on
 modules
To: Steven Rostedt <rostedt@goodmis.org>, Luis Chamberlain
 <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, don
 <zds100@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
 <171723016594.258703.1629777910752596529.stgit@devnote2>
 <fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com>
 <20240604084955.29b9440687522a1347e0e7cd@kernel.org>
 <419b80da-9cbf-4bb2-aabb-dc04f0fb0f37@efficios.com>
 <20240604123418.22e16e97@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240604123418.22e16e97@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-04 12:34, Steven Rostedt wrote:
> On Tue, 4 Jun 2024 11:02:16 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> I see.
>>
>> It looks like there are a few things we could improve there:
>>
>> 1) With your approach, modules need to be already loaded before
>> attaching an fprobe event to them. This effectively prevents
>> attaching to any module init code. Is there any way we could allow
>> this by implementing a module coming notifier in fprobe as well ?
>> This would require that fprobes are kept around in a data structure
>> that matches the modules when they are loaded in the coming notifier.
> 
> The above sounds like a nice enhancement, but not something necessary for
> this series.

IMHO it is nevertheless relevant to discuss the impact of supporting
this kind of use-case on the ABI presented to userspace, at least to
validate that what is exposed today can incrementally be enhanced
towards that goal.

I'm not saying that it needs to be implemented today, but we should
at least give it some thoughts right now to make sure the ABI is a
good fit.

>>
>> 2) Given that the fprobe module going notifier is protected by the
>> event_mutex, can we use locking rather than reference counting
>> in fprobe attach to guarantee the target module is not reclaimed
>> concurrently ? This would remove the transient side-effect of
>> holding a module reference count which temporarily prevents module
>> unload.
> 
> Why do we care about unloading modules during the transition? Note, module
> unload has always been considered a second class citizen, and there's been
> talks in the past to even rip it out.

As a general rule I try to ensure tracing has as little impact on the
system behavior so issues that occur without tracing can be reproduced
with instrumentation.

On systems where modules are loaded/unloaded with udev, holding
references on modules can spuriously prevent module unload, which
as a consequence changes the system behavior.

About the relative importance of the various kernel subsystems,
following your reasoning that module unload is considered a
second-class citizen within the kernel, I would argue that tracing
is a third-class citizen and should not needlessly modify the
behavior of classes above it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

