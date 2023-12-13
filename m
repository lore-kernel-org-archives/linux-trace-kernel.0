Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E449319C;
	Wed, 13 Dec 2023 00:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864EEC433C8;
	Wed, 13 Dec 2023 00:49:09 +0000 (UTC)
Date: Tue, 12 Dec 2023 19:49:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Mark
 Rutland <mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
 <pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
 <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: Re: [PATCH 09/15] tracing: Introduce names for events
Message-ID: <20231212194952.5f6d599b@gandalf.local.home>
In-Reply-To: <20231213000452.88295-10-graf@amazon.com>
References: <20231213000452.88295-1-graf@amazon.com>
	<20231213000452.88295-10-graf@amazon.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 00:04:46 +0000
Alexander Graf <graf@amazon.com> wrote:

> With KHO (Kexec HandOver), we want to preserve trace buffers. To parse
> them, we need to ensure that all trace events that exist in the logs are
> identical to the ones we parse as. That means we need to match the
> events before and after kexec.
> 
> As a first step towards that, let's give every event a unique name. That
> way we can clearly identify the event before and after kexec and restore
> its ID post-kexec.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  include/linux/trace_events.h         |  1 +
>  include/trace/trace_events.h         |  2 ++
>  kernel/trace/blktrace.c              |  1 +
>  kernel/trace/trace_branch.c          |  1 +
>  kernel/trace/trace_events.c          |  3 +++
>  kernel/trace/trace_functions_graph.c |  4 +++-
>  kernel/trace/trace_output.c          | 13 +++++++++++++
>  kernel/trace/trace_probe.c           |  3 +++
>  kernel/trace/trace_syscalls.c        | 29 ++++++++++++++++++++++++++++
>  9 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d68ff9b1247f..7670224aa92d 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -149,6 +149,7 @@ struct trace_event {
>  	struct hlist_node		node;
>  	int				type;
>  	struct trace_event_functions	*funcs;
> +	const char			*name;
>  };

OK, this is a hard no. We definitely need to find a different way to do
this. I'm trying hard to lower the footprint of tracing, and this just
added 8 bytes to every event on a 64 bit machine.

On my box I have 1953 events, and they are constantly growing. This just
added 15,624 bytes of tracing overhead to that machine.

That may not sound like much, but as this is only for this feature, it just
added 15K to the overhead for the majority of users.

I'm not sure how easy it is to make this a config option that takes away
that field when not set. But I would need that at a minimum.

-- Steve

