Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D002F5B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Sep 2024 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727325509; cv=none; b=nQ1WbHekC4egrwCKqiZm6a7lRMMvsong5obQKWO0jeOadiJfT9RAt3Dk/MjXAkUhzPB+dkwA5zKIpPwBV7Wbk7+L1tDrf7gX+QB2Ccswt+ecCrqsnQoEtF1gILgvFahDDflfdb+Y55xvQtctF+eiGoUXvtTqnGgRIwSUi/fHeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727325509; c=relaxed/simple;
	bh=vSCkVwFmEQJD+dE+a0o9esPwIxYeucnAoX4pOaSW/Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9YA2dGRz+lI/sMR/iC5fW+Q+6K+m6LNWvWhGeTDLYXA8nWNM0i1ZJJo6inHC1XFkjv9iXICpjGHIolKgwwxYRhwsLiNdjxRzIE+VOGd0DwlITtbQIfADc32aP+WuJ1hf/T6re2dJZwkeMXDuJ1RWkCPP8TNUMqF7975H4imegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4B6C4CEC5;
	Thu, 26 Sep 2024 04:38:28 +0000 (UTC)
Date: Thu, 26 Sep 2024 00:38:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: furkanonder <furkanonder@protonmail.com>
Cc: Clark Williams <williams@redhat.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/timerlat: Enhance Error Handling and Readability
 for timerlat_load.py
Message-ID: <20240926003823.50a14245@rorschach.local.home>
In-Reply-To: <2eV3oMRbTimO2AnpsTNrv5qQFnWBqljnkXxLciVNWDGDWP4rTQS1nfvRZAsJ9-Mx9U9GsxMyQZ5UZ94FSBjZrFeuJHKloPzE45D3k-3LnIA=@protonmail.com>
References: <2eV3oMRbTimO2AnpsTNrv5qQFnWBqljnkXxLciVNWDGDWP4rTQS1nfvRZAsJ9-Mx9U9GsxMyQZ5UZ94FSBjZrFeuJHKloPzE45D3k-3LnIA=@protonmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

Thank you for your patch. First, Daniel is unfortunately no longer the
maintainer of this code:

  https://lwn.net/Articles/979912/

This patch is not formatted correctly, so it can not even be reviewed.
Please take a look at Submitting Patches:

  https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

-- Steve


On Sat, 21 Sep 2024 23:43:02 +0000
furkanonder <furkanonder@protonmail.com> wrote:

> The enhancements made to timerlat_load.py focus on improving error handling, readability, and overall user experience. These changes aim to make the script more robust and easier to maintain while providing clearer feedback to users.
> Key modifications include:
> 
> Type Declaration in Argument Parsing:
> Added type declarations for command-line arguments in the argument parser. This removes the need for manual type checks later in the code, improving clarity and safety.
> Before:
> parser.add_argument("cpu", help='CPU to run timerlat thread')
> parser.add_argument("-p", "--prio", help='FIFO priority')
> After:
> parser.add_argument("cpu", type=int, help='CPU to run timerlat thread')
> parser.add_argument("-p", "--prio", type=int, help='FIFO priority')
> 
> String Formatting:
> Replaced string concatenation with an f-string to enhancing readability and conciseness.
> Before:
> timerlat_path = "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.cpu + "/timerlat_fd"
> After:
> timerlat_path = f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu}/timerlat_fd"
> 
> Enhanced Exception Handling and Consistent Error Reporting:
> Specific exceptions are now caught and printed with clearer messages, providing context for errors when opening file descriptors. Added exception
> handling for the data file descriptor opening to ensure uniformity across the script.
> 
> Before:
> $ sudo python timerlat_load.py 122
> Error setting affinity
> After:
> $ sudo python timerlat_load.py 122
> Error setting affinity: [Errno 22] Invalid argument
> 
> Before:
> $ sudo python timerlat_load.py 1 -p 950
> Error setting priority
> After:
> $ sudo python timerlat_load.py 1 -p 950
> Error setting priority: [Errno 22] Invalid argument
> 
> Before:
> $ python timerlat_load.py 1
> Error opening timerlat fd, did you run timerlat -U?
> After:
> $ python timerlat_load.py 1
> Permission denied. Please check your access rights.
> 
> Changes for the read Infinite Loop:
> The original generic exception clause has been replaced with more specific exception types to provide clearer feedback on errors.
