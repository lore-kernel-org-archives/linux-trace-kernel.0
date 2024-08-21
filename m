Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AF1D12F4;
	Wed, 21 Aug 2024 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270568; cv=none; b=YseLbovTga8VwE79ecxIAqQVnksFV1ALNdSi+bK0wvjKx+gYT/hlGcpCeRfE1Tya9oQN7NXEToPXr3ysPeyuWeDNPCS3IjKifFHAhHgM80epW6oKOfycP8p16685pJFX2GHOKdwYCN5aMYM23aF8x0iht4GXmyKj4ALnJjxrNH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270568; c=relaxed/simple;
	bh=tI5ZaN2q9beYFxeyC9+OeG4IAqlbIBMFtwZqiRU4IRw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAU6neCKzEttI/JCeBObKOLmFQkupADqRtS+O00ewOTHz3J2tvyOv+P19OcU/k6stVZkbvmtVLUmmnTL+G65UMwBbD4upCNS/c2D06PLtObu4tvv3STot+7di+kSjaiMCLpaRvHwYoYgfvifLv8uruCoye/SYla43Be0VcOGyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632CBC32781;
	Wed, 21 Aug 2024 20:02:47 +0000 (UTC)
Date: Wed, 21 Aug 2024 16:03:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: tglozar@redhat.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240821160316.02c03c44@gandalf.local.home>
In-Reply-To: <20240820130001.124768-1-tglozar@redhat.com>
References: <20240820130001.124768-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 15:00:01 +0200
tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> When running timerlat with a userspace workload (NO_OSNOISE_WORKLOAD),
> NULL pointer dereference can be triggered by sending consequent SIGINT
> and SIGTERM signals to the workload process. That then causes
> timerlat_fd_release to be called twice in a row, and the second time,
> hrtimer_cancel is called on a zeroed hrtimer struct, causing the NULL
> dereference.
> 
> This can be reproduced using rtla:
> ```
> $ while true; do rtla timerlat top -u -q & PID=$!; sleep 5; \
>  kill -INT $PID; sleep 0.001; kill -TERM $PID; wait $PID; done
> [1] 1675
> [1]+  Aborted (SIGTERM)      rtla timerlat top -u -q
> [1] 1688
> client_loop: send disconnect: Broken pipe
> ```
> triggering the bug:

I'm able to reproduce this with the above. Unfortunately, I can still
reproduce it after applying this patch :-(

Looking at the code, the logic for handling the kthread seems off. I'll
spend a little time to see if I can figure it out.

-- Steve
