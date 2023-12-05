Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF7675A1;
	Tue,  5 Dec 2023 16:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77456C433C7;
	Tue,  5 Dec 2023 16:25:42 +0000 (UTC)
Date: Tue, 5 Dec 2023 11:26:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentaion:trace Add the git web link to view it on
 the browser
Message-ID: <20231205112608.76927866@gandalf.local.home>
In-Reply-To: <20231205035517.30534-1-unixbhaskar@gmail.com>
References: <20231205035517.30534-1-unixbhaskar@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Dec 2023 09:25:17 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> Thought this might help people to see the entire source tree on browser and
> explore.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/trace/ftrace.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 23572f6697c0..e768a4c91452 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -3731,3 +3731,5 @@ Currently, -mfentry is used by gcc 4.6.0 and above on x86 only.
>  More
>  ----
>  More details can be found in the source code, in the `kernel/trace/*.c` files.
> +Also you can see the trace source tree on browser `Git Link
> +<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace>`__.
> --
> 2.35.8

I'm not a big fan of git links to code in the documentation tree. This is
more for those that want to play with it (compile and install), so I don't
think a web link is useful here. I rather have people download the code and
build it.

-- Steve
