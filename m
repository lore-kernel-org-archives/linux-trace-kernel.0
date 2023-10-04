Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30B182
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38633C433C8;
	Wed,  4 Oct 2023 01:02:03 +0000 (UTC)
Date: Tue, 3 Oct 2023 21:03:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] tracing/timerlat: Hotplug support for the user-space
 interface
Message-ID: <20231003210309.4335307d@gandalf.local.home>
In-Reply-To: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
References: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 17:02:46 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> The osnoise/per_cpu/CPU$/timerlat_fd is create for each possible
> CPU, but it might create confusion if the CPU is not online.
> 
> Create the file only for online CPUs, also follow hotplug by
> creating and deleting as CPUs come and go.
> 
> Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")

Is this a fix that needs to go in now and Cc'd to stable? Or is this
something that can wait till the next merge window?

-- Steve


> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
> 
> Changes from V2:
>   - Better split the code into the generic (per_cpu/cpu$)
>     and timerlat (/timerlat_fd) specific function (Daniel)
>   - Fixed a cpus_read_lock/unlock() usage (kbuild test)
>   Link: https://lore.kernel.org/lkml/6b9a5f306e488bc77bf8521faeade420a0adf3e4.1695224204.git.bristot@kernel.org/
> 
> Changes from V1:
>   - Fix compilation issue when !HOTPLUG
>   - Fix init interface | hotplug race
>   Link: https://lore.kernel.org/lkml/b619d9fd08a3bb47018cf40afa95783844a3c1fd.1694789910.git.bristot@kernel.org/
> 
>  kernel/trace/trace_osnoise.c | 149 ++++++++++++++++++++++++++++-------
>  1 file changed, 121 insertions(+), 28 deletions(-)
> 
>
