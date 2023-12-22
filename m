Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11E2C190;
	Fri, 22 Dec 2023 16:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423BAC433C7;
	Fri, 22 Dec 2023 16:27:26 +0000 (UTC)
Date: Fri, 22 Dec 2023 11:28:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux selftests
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3] tracing/selftests: Add ownership modification tests
 for eventfs
Message-ID: <20231222112831.4c7fa500@gandalf.local.home>
In-Reply-To: <935441c3-f14b-4a5d-8031-3b406548a612@linuxfoundation.org>
References: <20231221211229.13398ef3@gandalf.local.home>
	<20231221211604.5062f4e8@gandalf.local.home>
	<935441c3-f14b-4a5d-8031-3b406548a612@linuxfoundation.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 09:15:42 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 12/21/23 19:16, Steven Rostedt wrote:
> > 
> > Shuah,
> > 
> > This patch has no dependencies. You can take it through your tree for the
> > next merge window if you want. If not, I can take it.
> >   
> Tried to apply this and seeing a couple of issues:
> 
> -- missing SPDX

Hmm, I copied this from the snapshot.tc. I guess there's several test files
that are missing SPDX. That should probably be fixed.

> -- this file has executable permission set unlike the existing
>     .tc files in the same directory

Oh, I forgot to disable that. When developing a new test I make it
standalone as it's easier to test the test, and then copy the file into the
directory.

I'll fix the above and send a v4.

Thanks,

-- Steve
