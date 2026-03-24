Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7858405AD9;
	Tue, 24 Mar 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365740; cv=none; b=Zkb84Xz7B4q0TOGJfA4UgvgJn+oZXxr91Qm61beAt8mB2ev5AT8KDR8ddIsvR6L+Ngtkb/08oUk/hkNoioPnGS+pWV1iawAVBzQI4QQM7f3U6djoA+QAVxHk7B+WqazwaOGeOJGiL9kHR2FnqyNbybohm6saLJnjwvJ/gEZe3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365740; c=relaxed/simple;
	bh=5gp3DqJPCe/toMX/HduC+gVZ5oMl0PiKk0s4X1SjLMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYXTi3KkPfNjn/8nvQ7kVK27+jYX+jQNXamNv1nkuprgfnEkXD0MkQ1W+f9PD7s8pp3AJBp+nQixSc89lSBdyMT9pKCzWopG5FjVaa6nwF+Ij2moCQaxsEjLscXdVkuBjp3Mjr+FKrm3TbbuZZFQLGsvgmnYu6oWRgnBMz1DhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 065ADE0274;
	Tue, 24 Mar 2026 15:22:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id AA58630;
	Tue, 24 Mar 2026 15:22:07 +0000 (UTC)
Date: Tue, 24 Mar 2026 11:22:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, John Kacur <jkacur@redhat.com>, Luis Goncalves
 <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Wander Lairson Costa <wander@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc
 <linux-doc@vger.kernel.org>, Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH] Documentation/rtla: Document SIGINT behavior
Message-ID: <20260324112249.5fe25641@gandalf.local.home>
In-Reply-To: <20260324123229.152424-1-tglozar@redhat.com>
References: <20260324123229.152424-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AA58630
X-Stat-Signature: f34oq9zmhj6jcdj9fsi97uzdhcn1o5mi
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX181Shg/JIEhs5Hh1/spZpiESdjHce3nxvg=
X-HE-Tag: 1774365727-469128
X-HE-Meta: U2FsdGVkX18FZWy5sfmGAjRF1lOT6u/xk99/lTD7bZZfbKeltJgBVZGScW9Af7fiieOfgVwW4r3mkc3uotn57bqwhvTh8etcbqk0Zj8gZGvHR/GzQH8jQaNZVDlggwVrV1jNBHGzIOtPCZC75uvaAv/RbNGzXY2uA86rfSvTEpa8IF7eCo3FE7fPwtZzyZ8B8wd7xGGfQOWMaP90qS6iTUaU/8hqodc/+DN+TdohL5yOTXuJy2N2fMBrFeN+d/8MOwEWB7QUWoWyU7UJGypEi1BC3HMWUzT9PERVEqKZr4nCrRJYRGHdFlmZa85uhAdWT884P2g8EH2vReeN4dHuFBFMWh9uALcCIV9WmMFWaDJIoIsEmlauvlDjwE0mhRWNhE4A5HeBDVu1Iav3YdX4jdHlXyxBH+KR3shQTD/LLoo=

On Tue, 24 Mar 2026 13:32:29 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> The behavior of RTLA on receiving SIGINT is currently undocumented.
> 
> Describe it in RTLA's common appendix that appears in man pages for all
> RTLA tools to avoid confusion.
> 
> Suggested-by: Attila Fazekas <afazekas@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
> 
> Note: There was a bug in SIGINT behavior, fixed in upcoming commit [1].
> 
> [1] https://lore.kernel.org/linux-trace-kernel/20260310160725.144443-1-tglozar@redhat.com/

Hmm, this may be interesting enough to add to the change log itself.

> 
>  Documentation/tools/rtla/common_appendix.txt | 21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/tools/rtla/common_appendix.txt b/Documentation/tools/rtla/common_appendix.txt
> index 53cae7537537..8c90a02588e7 100644
> --- a/Documentation/tools/rtla/common_appendix.txt
> +++ b/Documentation/tools/rtla/common_appendix.txt
> @@ -1,5 +1,26 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
> +SIGINT BEHAVIOR
> +===============
> +
> +On the first SIGINT, RTLA exits after collecting all outstanding samples up to
> +the point of receiving the signal.
> +
> +When receiving more than one SIGINT, RTLA discards any outstanding samples, and
> +exits while displaying only samples that have already been processed.
> +
> +If SIGINT is received during RTLA cleanup, RTLA exits immediately via
> +the default signal handler.
> +
> +Note: For the purpose of SIGINT behavior, the expiry of duration specified via
> +the -d/--duration option is treated as equivalent to receiving a SIGINT. For
> +example, a SIGINT received after duration expired but samples have not been
> +processed yet will drop any outstanding samples.
> +
> +Also note that when using the timerlat tool in BPF mode, samples are processed
> +in-kernel; RTLA only copies them out to display them to the user. A second
> +SIGINT does not affect in-kernel sample aggregation.

But does it affect the user space side of reading that information?

> +
>  EXIT STATUS
>  ===========
>  

Other than that ... LGTM,

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
