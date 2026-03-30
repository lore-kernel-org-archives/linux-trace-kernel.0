Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2183382391;
	Mon, 30 Mar 2026 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895722; cv=none; b=ERH0Z2pq1sOn6vSzUz36Tpj03IMyG4To2frg1+Qx0zIpRSmilFm2UgiVsZB0NhfTWC5dstD1ZEfzODxb6X63l+zhys/pg7o3AtoGRKkrmfFYEphcOdRFvUrgfM5wI3AGvhzccl+WNu3towW+IjHf+O8knyF6Xtm0fslJV2dvRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895722; c=relaxed/simple;
	bh=EOqj3nBvuQfsTeUDP+okcSbKnOSzy+P47F21/QpVQg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3ic86yJ1alyS19plORo3NV1S+hZ1u+b5Ya+8Rp3ZeJpN7nvHpS2aK2yoxC/L9nuylm+42HCZFXDsEXR8p2d3nipglYgtSeThnj3zGqRv3Uvw5UynAYhketaxlfEuGHuc14p2Ws+r6foxM6+d80kZALSui+13wX8CvUC8dTbj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B6C868C58F;
	Mon, 30 Mar 2026 18:35:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id C7F1826;
	Mon, 30 Mar 2026 18:35:17 +0000 (UTC)
Date: Mon, 30 Mar 2026 14:36:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 4/5] ring-buffer: Reset RB_MISSED_* flags on
 persistent ring buffer
Message-ID: <20260330143613.42fe5640@gandalf.local.home>
In-Reply-To: <177487501981.3463592.2886576368556755178.stgit@mhiramat.tok.corp.google.com>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487501981.3463592.2886576368556755178.stgit@mhiramat.tok.corp.google.com>
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
X-Rspamd-Queue-Id: C7F1826
X-Stat-Signature: 55upi39x8omt961at3c3qge51q5ucp4p
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LxE9r6BJ+WZx2D88s9R35zeAlDnm4jsk=
X-HE-Tag: 1774895717-370769
X-HE-Meta: U2FsdGVkX1/mtvWvVBZREd6O2hoWI6Hr6T/WbgeF3dHah5VJ8D5MnHNnORMM6hdeHxJpi+KdpsdtwjimIK4lJK1WxrN035qHIqquQagin9SjTe7hFQn12GnEX5TJCAyf+b7keg5L4FxQzWGsmyPyxntxJAMIFSiG2xuUTqEkvvQ9hFQknu/1OKE3wqYls/qJFCZdgQsuCy9vwsfBo5/OOvTqkGjSkGAYzi8EyknmKR+krEUdXIT8elenORxpfE7vzGp51gis78ZamQKska3E2uEWRUGbTbKKPWlhEfLNktsV+UFhXkzVpa/nogRsh/aVlmIGoSgRs8hjSDee2SvSQ4wqeOqo0uHr

On Mon, 30 Mar 2026 21:50:20 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reset RB_MISSED_* flags when the persistent ring buffer is
> validated at boot. Since these flags are used only in reading
> process, such process should be stopped when reboot and never
> be restarted. Thus, these flags are meaningless in the next
> boot. Moreover, it can confuse the read process after reboot.

Is it meaningless on a second boot?

Let's say you have a crash, and there's an invalid buffer. On the next boot
it is flagged as invalid with the RB_MISSED flag. But then you reboot again
before looking at the buffer. The next boot will clear this flag. Now
looking at the persistent ring buffer will not show any missed events.

Ideally, it shouldn't matter how many reboots are made. If the persistent
ring buffer hasn't started again, it should always show the same output.

-- Steve


> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v14:
>    - Newly added.
> ---
>  kernel/trace/ring_buffer.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e5178239f2f9..5049cf13021e 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1903,6 +1903,7 @@ static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
>  		local_set(&bpage->page->commit, 0);
>  	} else {
>  		local_set(&bpage->entries, ret);
> +		local_set(&bpage->page->commit, tail);
>  	}
>  
>  	return ret;

