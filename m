Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8111CA81;
	Tue,  1 Jul 2025 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751407887; cv=none; b=Ysv/RhKwFZa49A+oUujGt9m8NVKCMIMnN2NgYHwbyDECFdpLrjbV27ZCeTvnGgoks1fqZr4RxZvJWGq8OxNb4B5gf8NCL0eFucxrr1qFVAXgwKAs/V5IcYhDM2VdajZlkjnb6OaTCoJ+3yd4/wszQOrI0Df35tFAIU1lX3H3yd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751407887; c=relaxed/simple;
	bh=fwzeZnsPwoY03IrV93gOz4MH43a/7r1n5nJHBDXSrJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4t/+GrAfGXOSPnvSjVGKwsOUT3MwNDoXvpBkkbfi9NTW8r8fupSFhWsB7DZDoFJ8NkKMOcDZMVe+Y7cawD/PnqPDMaOJfsZJo64F4K1LfKCYZpm060o496umg4XN4nnN5RVXmCpIllpp9nvmZJKyhbcwJmI6Xj93rGOtsYpikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id EBA4B16066C;
	Tue,  1 Jul 2025 22:11:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 0F8F560016;
	Tue,  1 Jul 2025 22:11:20 +0000 (UTC)
Date: Tue, 1 Jul 2025 18:11:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 acarmina@redhat.com, chuck.wolber@boeing.com
Subject: Re: [RFC PATCH 2/2] tracing: add testable specifications for
 event_enable_write/read
Message-ID: <20250701181119.7b0bc5d6@batman.local.home>
In-Reply-To: <20250612104349.5047-3-gpaoloni@redhat.com>
References: <20250612104349.5047-1-gpaoloni@redhat.com>
	<20250612104349.5047-3-gpaoloni@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: w6jcuxx8rb699hp9p9dhyz3a3uiqfsdo
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0F8F560016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX189n404bB2lDgycaIoKc0jEy6ui6CG92Vw=
X-HE-Tag: 1751407880-615471
X-HE-Meta: U2FsdGVkX18q2sKeAnqXOYlQBfW7JoKiB6kNFFT04Zt8cTzVabZJNeN6WPdRX+prZ6dtXnZwk/gSMiCn9awSITF6QE13oPjhfcKrEIWYs0OZXeNdmkBPV+sNlAK1SWM45LTAkkAH6kaVi0xhlqaF8AkPVmamELB7ZvrJT10RKnqcnGcc721UnnFM7TcqrttjwAhQYNF4MeEhR5qdz8ZZoF7SmTrVjerwNJtuaI74EKu9C+7iHPPxUVjwKbHW6X3uYCc8FERlpEyf+JiFRYxMyic4eQcKqog8nTT/n8k+Xdm+dRLZlt934wA763BxkLpmgeQze+ZKzPrUeB5nqirBlufGCeEWjlC2

On Thu, 12 Jun 2025 12:43:49 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> This patch implements the documentation of event_enable_write and
> event_enable_read in the form of testable function's expectations.
> 
> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> ---
>  kernel/trace/trace_events.c | 72 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 5e84ef01d0c8..eb3c5e6e557d 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1771,6 +1771,46 @@ static void p_stop(struct seq_file *m, void *p)
>  	mutex_unlock(&event_mutex);
>  }
>  
> +/**
> + * event_enable_read - read from a trace event file to retrieve its status.
> + * @filp: file pointer associated with the target trace event;
> + * @ubuf: user space buffer where the event status is copied to;
> + * @cnt: number of bytes to be copied to the user space buffer;

Why is the above ending with semicolons?

> + * @ppos: the current position in the buffer.
> + *
> + * This is a way for user space executables to retrieve the status of a
> + * specific event
> + *
> + * Function's expectations:
> + * - This function shall lock the global event_mutex before performing any
> + *   operation on the target event file and unlock it after all operations on
> + *   the target event file have completed;
> + * - This function shall retrieve the status flags from the file associated
> + *   with the target event;
> + * - This function shall format the string to report the event status to user
> + *   space:
> + *   - The first character of the string to be copied to user space shall be
> + *     set to "1" if the enabled flag is set AND the soft_disabled flag is not
> + *     set, else it shall be set to "0";
> + *   - The second character of the string to be copied to user space shall be
> + *     set to "*" if either the soft_disabled flag or the soft_mode flag is
> + *     set, else it shall be set to "\n";
> + *   - The third character of the string to be copied to user space shall b
> + *     set to "\n" if either the soft_disabled flag or the soft_mode flag is
> + *     set, else it shall be set to "0";
> + *   - Any other character in the string to be copied to user space shall be
> + *     set to "0";

The above could use some new lines. Like between each bullet. My
eyesight isn't as good anymore and I find reading gobs of text more
difficult. Newlines give my eyes a break.

I know this is being written so that a tool could parse it, but also
needs to be parsed by aging developers. ;-)

> + * - This function shall check if the requested cnt bytes are equal or greater
> + *   than the length of the string to be copied to user space (else a
> + *   corrupted event status could be reported);
> + * - This function shall invoke simple_read_from_buffer() to perform the copy
> + *   of the kernel space string to ubuf.

Hmm, and it is also verbose. This is a relatively simple function, and
it caused quite a bit of requirements. I wonder if it could be
shortened a bit. Otherwise more complex and larger functions are going
to be overwhelming and likely not acceptable. And those are the
functions that I think this will benefit the most!

> + *
> + * Returns the number of copied bytes on success, -ENODEV if the event file
> + * cannot be retrieved from the input filp, -EINVAL if cnt is less than the
> + * length of the string to be copied to ubuf, any error returned by
> + * simple_read_from_buffer

Returns should be formatted better where each return value is on a
separate line.

-- Steve

> + */
>  static ssize_t
>  event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
>  		  loff_t *ppos)
> @@ -1808,6 +1848,38 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
>  	return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf));
>  }
>  
> +/**
> + * event_enable_write - write to a trace event file to enable/disable it.
> + * @filp: file pointer associated with the target trace event;
> + * @ubuf: user space buffer where the enable/disable value is copied from;
> + * @cnt: number of bytes to be copied from the user space buffer;
> + * @ppos: the current position in the buffer.
> + *
> + * This is a way for user space executables to enable or disable event
> + * recording.
> + *
> + * Function's expectations:
> + * - This function shall copy cnt bytes from the input ubuf buffer to a kernel
> + *   space buffer (or the whole input ubuf if cnt is larger than ubuf size)
> + *   and shall convert the string within the kernel space buffer into a decimal
> + *   base format number;
> + * - This function shall lock the global event_mutex before performing any
> + *   operation on the target event file and unlock it after all operations on
> + *   the target event file have completed;
> + * - This function shall check the size of the per-cpu ring-buffers used for
> + *   the event trace data and, if smaller than TRACE_BUF_SIZE_DEFAULT, expand
> + *   them to TRACE_BUF_SIZE_DEFAULT bytes (sizes larger than
> + *   TRACE_BUF_SIZE_DEFAULT are not allowed);
> + * - This function shall invoke ftrace_event_enable_disable to enable or
> + *   disable the target trace event according to the value read from user space
> + *   (0 - disable, 1 - enable);
> + *
> + * Returns 0 on success, any error returned by kstrtoul_from_user, -ENODEV if
> + * the event file cannot be retrieved from the input filp, any error returned by
> + * tracing_update_buffers, any error returned by ftrace_event_enable_disable,
> + * -EINVAL if the value copied from the user space ubuf is different from 0 or
> + *  1.
> + */
>  static ssize_t
>  event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  		   loff_t *ppos)

