Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948593CD02
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Oct 2023 21:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2EDC433C8;
	Tue,  3 Oct 2023 21:40:23 +0000 (UTC)
Date: Tue, 3 Oct 2023 17:41:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ross Zwisler <zwisler@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>, Mark
 Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH] visl: use canonical ftrace path
Message-ID: <20231003174129.11c79c18@gandalf.local.home>
In-Reply-To: <20230829204600.3210276-2-zwisler@kernel.org>
References: <20230829204600.3210276-2-zwisler@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Could this go through the linux-media tree, or if you give it an Ack, I'll
take it through the tracing tree.

-- Steve


On Tue, 29 Aug 2023 14:46:01 -0600
Ross Zwisler <zwisler@kernel.org> wrote:

> From: Ross Zwisler <zwisler@google.com>
> 
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> Update the visl decoder driver documentation to use this tracefs path.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  Documentation/admin-guide/media/visl.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/media/visl.rst b/Documentation/admin-guide/media/visl.rst
> index 7d2dc78341c9..4328c6c72d30 100644
> --- a/Documentation/admin-guide/media/visl.rst
> +++ b/Documentation/admin-guide/media/visl.rst
> @@ -78,7 +78,7 @@ The trace events are defined on a per-codec basis, e.g.:
>  
>  .. code-block:: bash
>  
> -        $ ls /sys/kernel/debug/tracing/events/ | grep visl
> +        $ ls /sys/kernel/tracing/events/ | grep visl
>          visl_fwht_controls
>          visl_h264_controls
>          visl_hevc_controls
> @@ -90,13 +90,13 @@ For example, in order to dump HEVC SPS data:
>  
>  .. code-block:: bash
>  
> -        $ echo 1 >  /sys/kernel/debug/tracing/events/visl_hevc_controls/v4l2_ctrl_hevc_sps/enable
> +        $ echo 1 >  /sys/kernel/tracing/events/visl_hevc_controls/v4l2_ctrl_hevc_sps/enable
>  
>  The SPS data will be dumped to the trace buffer, i.e.:
>  
>  .. code-block:: bash
>  
> -        $ cat /sys/kernel/debug/tracing/trace
> +        $ cat /sys/kernel/tracing/trace
>          video_parameter_set_id 0
>          seq_parameter_set_id 0
>          pic_width_in_luma_samples 1920

