Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641D2D372C;
	Wed,  2 Jul 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469172; cv=none; b=cyphPplvsqZmT1CjOlAsCaFgI4Uq4nd+bLRB//nzf+xPSrH7pA2Tr2Czj7XZTSXIrTUa6FHmy3fXV4PN6phuiYMgeVAJqOHIKk8KIzuaf6lWjGcP+27B9SAzzSr/FT7zqRAg6tUwAYPEcnB6FyCP9IAxZ2+orgj24zXltVBkY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469172; c=relaxed/simple;
	bh=ymsnVIG0erULraCd4BNu3B+drsHLAexyq03O+NpiP0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2Z7V9LIBT3bi8bS8V4vA9uxoEpA3xW4chMExWtSV+c3iSX3583bZUgjCRxlfQ20VLb6gtCd8T+CUOcdWpfEUdvje+kc/ZJtwmuYPb45poUrLpsIWNnltZU4qhDHMyID5B+QrhyDvV/vvDc38yWMOUkjQj24Oy+ckkmVmDEqnHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 74B55123D32;
	Wed,  2 Jul 2025 15:12:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 706952000F;
	Wed,  2 Jul 2025 15:12:46 +0000 (UTC)
Date: Wed, 2 Jul 2025 11:12:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 acarmina@redhat.com, chuck.wolber@boeing.com
Subject: Re: [RFC PATCH 2/2] tracing: add testable specifications for
 event_enable_write/read
Message-ID: <20250702111245.1fa23138@batman.local.home>
In-Reply-To: <CA+wEVJarZben=F3Dw0A8_tvAAR7-qb4PrjCj0AGFoq=DH1RJwg@mail.gmail.com>
References: <20250612104349.5047-1-gpaoloni@redhat.com>
	<20250612104349.5047-3-gpaoloni@redhat.com>
	<20250701181119.7b0bc5d6@batman.local.home>
	<CA+wEVJarZben=F3Dw0A8_tvAAR7-qb4PrjCj0AGFoq=DH1RJwg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 706952000F
X-Rspamd-Server: rspamout02
X-Stat-Signature: 1madwbwa4gt3iih9kydkp3qf4qjw6wz6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/1FB+LOdu3E8ndipBvVyP/V38SBjmAr/M=
X-HE-Tag: 1751469166-946527
X-HE-Meta: U2FsdGVkX1/1cNiMpd+Evb2QXlsQ6lNsAcRkdpUgwP2lWcDAIXGUy4k2+zRji8MXWkzX/JFCyGVdlyyieQwm1lATxyGyjNoaxlreRY+7q1RUQu+/leMwfLhBnyleO+g+kRzu8W7YJhummudVJwsGW/4T+igjzRjeMKMf/K/JJGQ8jD5butSJsIa0+Gg7dJKlvNDIVN/011tK0rBHhub1fV25bWbPHURa21AxePK5i6GcQHc/MxnN2GE855ifmgZjJMTKBomwLIiLsvqQZhvdk/rg8HdfGf6THKEOaJIuqEK5uysQa8qVTx5Bgeo0iNl0zKXi1nrECJIDAf5uN7cqv2DKLZ7SnIm7HDBgN/PDZNPYmMbtSeth1pVBlwz3WPNKUzb9ohGAHdw=

On Wed, 2 Jul 2025 16:59:29 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> Mmm got it. What about
> 
> * Function's expectations:
> * - This function shall lock the global event_mutex before performing any
> *   operation on the target event file and unlock it after all operations on
> *   the target event file have completed;

Since 99% of the time that a lock is taken in a function it is
released, I think that should be the default assumption here, and only
when a lock is taken and not release, that should be explicitly called
out.

And also we should remove "This function" we know that these
requirements are for this function.

  - The global event_mutex shall be taken before performing any
    operation on the target event.

Should be good enough.

If the lock can be released and taken again, that too should be
explicit in the requirements otherwise it is assumed it is taken once
and not released until the operation is completed.

> *
> * - This function shall format the string copied to userspace according to
> *   the status flags retrieved from the target event file:
> *    - The first character shall be set to "1" if the enabled flag is
> set AND the
> *      soft_disabled flag is not set, else it shall be set to "0";
> *    - The second character is optional and shall be set to "*" if either the
> *      soft_disabled flag or the soft_mode flag is set;
> *   - The string shall be terminated by a newline ("\n") and any remaining
> *      character shall be set to "0";

 - The string copied to user space shall be formatted according to the
   status flags from the target event file:

   - If the enable flag is set AND the soft_disable flag is not set then
     the first character shall be set to "1" ELSE it shall be set to "0"

   - If either the soft_disable fag or the soft_mode flag is set then the
     second character shall be set to "*" ELSE it is skipped.

I think the above is easier to read and is a bit more consolidated.
Stating the status then the effect is also easier to read.

-- Steve


> *
> * - This function shall invoke simple_read_from_buffer() to perform the copy
> *   of the kernel space string to ubuf.
> 
> (pls note that the check on cnt has been removed in v3 that is out already)

