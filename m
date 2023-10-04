Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D1413AC3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7935DC433C7;
	Wed,  4 Oct 2023 12:18:54 +0000 (UTC)
Date: Wed, 4 Oct 2023 08:20:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] tracing/timerlat: Hotplug support for the user-space
 interface
Message-ID: <20231004082001.104fce96@gandalf.local.home>
In-Reply-To: <20231004081731.141dfb99@gandalf.local.home>
References: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
	<20231003210309.4335307d@gandalf.local.home>
	<3fbe67a4-225c-14c1-cb5a-3f667ad80b0e@kernel.org>
	<20231004081731.141dfb99@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Oct 2023 08:17:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> #!/bin/bash
> 
> find_debugfs() {
>     debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
> 	if [ $mount == "debugfs" ]; then

I guess I should update this to look for tracefs. This script is actually
older than tracefs.

-- Steve


> 	    echo $dir;
> 	    break
> 	fi
>     done`
>     if [ -z "$debugfs" ]; then
> 	if ! mount -t debugfs nodev /sys/kernel/debug; then
> 	    echo "FAILED to mount debugfs"
> 	    exit -1
> 	fi
> 	echo "/sys/kernel/debug"
>     else
> 	echo $debugfs
>     fi
> }
> 
> debugfs=`find_debugfs`
> tracedir="$debugfs/tracing"

