Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2351097E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0B5C433C7;
	Wed,  4 Oct 2023 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696413776;
	bh=i6Mni9W0l9dpI1XoYC4wjLOEG3ztUx3lg98F4Pkk/Q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nHrgxTiR2U1OakAgiKgKo94aKU72TZgNkZ95tWP+OmPIeTmN/pvN/JNKQj5e93G4u
	 sELhrOTtdxE9CNnMr7S6EZ0RTOnxxpVGkY/279gzhUt3VZIQWq4MnGsPPVwWYJMvaJ
	 cWdP4ZMIkG3L018MzQTxwcNuls7TpUODQLK9wW85M1dw14etl6rjMr3UaonjYMGjQ6
	 nnaUwngCYRkzKmyUNda8LCRgXsLV8wGsenDd6wChzmxtd1xVZyCfz3HJJgjfYNW/os
	 bHSGz4vIjB20BYLIdgAZ0zzuR4028CKz+rHArNNvTjVUA5mq/G2WPwOb0RaCP9io4w
	 AOqkiz/vr1a9w==
Message-ID: <3fbe67a4-225c-14c1-cb5a-3f667ad80b0e@kernel.org>
Date: Wed, 4 Oct 2023 12:02:52 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] tracing/timerlat: Hotplug support for the user-space
 interface
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
 <20231003210309.4335307d@gandalf.local.home>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20231003210309.4335307d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/23 03:03, Steven Rostedt wrote:
> On Fri, 29 Sep 2023 17:02:46 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> The osnoise/per_cpu/CPU$/timerlat_fd is create for each possible
>> CPU, but it might create confusion if the CPU is not online.
>>
>> Create the file only for online CPUs, also follow hotplug by
>> creating and deleting as CPUs come and go.
>>
>> Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")
> 
> Is this a fix that needs to go in now and Cc'd to stable? Or is this
> something that can wait till the next merge window?

We can wait for the next merge window... it is a non-trivial fix.

-- Daniel
> -- Steve

