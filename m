Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874776;
	b=K24MY9Y3dHgc/b4InkKbkmc/WB9bOUK/f6JU4PhNuuVL6ebI7vvNA9MeAin41LEzDVPx
	 xe0hd29mJpRzuqWwMvUstOgZ6NEN52BS5hP+9/mF3LFB+bTxG9WESPen5Ktfl2I+17C1Y
	 16oZAZ2xgKkbLm9vCxHzF055lZ5cfJXwvWpkKd3LSrX0tnByIcE0RaPuOZU/WoKtabj5o
	 p7oUk1reoJdARsamFbe85ihdonHMcZwbsnczJ8tzG+QuCNRiV/Hy7AkRx4+HUXsN1GtDq
	 8POM0MsPqvTGv7criLNVacgkX7CdaKgE7WEuOyDi3YSFtmPPjIiQGhD9GhY7nuKkGbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874776;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lR+NEFZOClI/Q7syF7pUxOZkq4s0tLc9i8788RwMvYM=;
	b=gg7MsAb+QvbtpeLJEJ6WWxnDaBgjvEUmNPHZciYR3ck0KQwk9L0NQq5o65RFjp5BNge5
	 RZOnePgWpn931/7tPp7HX3i/ID4xpZEzwWETn79QpHYIcWkPLVJzzvqveM3JFL5NVXty5
	 adPeLYtRbiljJOgpuNjVGiQIuv+y4L9WtL+lH+nWIfAtMdvXjgCPLTZlATheJywljy4AT
	 PZlJQAJaKNubBF6FVi033zKPyG2F4AhcrUmEy1IBNP4y3HOiWmfGCtBgA3f/NxZ0KtkaD
	 M6OVuaTqOQk7QdcDJfR3fpGIVFwTli+6sLVBMdJBB0VCo/1xZlUQ+R8g55mqEGtoQwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA039606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 10:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA039606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-679e6ab6471so444729d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 02:32:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874775; x=1794479575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lR+NEFZOClI/Q7syF7pUxOZkq4s0tLc9i8788RwMvYM=;
        b=BJySUFfRVWPrJm8FO4dyeVfk90sSls2jHVxg4b0oxQZeSL+TrUKXbQmgMhEXGxQqY+
         XHG2aUwCM/6yqi4enDDaSrDCznelRuZj0cHnTQXcKdvlMAGFVHYp3CM6eljRfDGHk3NJ
         rCdhLNgVzfyrnWbSU6Op59VVCNUEfRFyMjAX/jBaTmxHBnXqqKmdCSJPUp+9WlrIImSy
         CL9/zDKl3ZiVyi1yMn1wiijmqgfjBaulRCuWJQuqQR/K+pvAVTq8Uv6RmtKJl19K/o07
         DJXygCDbdY07/dlQ7KnDC6aEsrasmTPx3/Uj7r5MZA0OZ2Wl9+alj+hTvCJgDbsttlCG
         2thw==
X-Forwarded-Encrypted: i=1; AKwUvBw06OBOxyYk6nojv7TJX/Fx6rKyZgHFUgHtgdJv8aXvSenrvkQbULGqQxph8OffoPLrn4i6nNEtxTKm5mV0asrnUvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9M5DsToS7lpCkiAoUQ0KiA4unyHbeQpDpguxgxDGeZ3cL5bgBT
	GL18qGz93vPiTX+C6fWBkWifJYRj5Hm6KWLNLNePEOp+h++4u1ojvgRZ
X-Gm-Gg: AYBFou1nYRf/qjPn5ebhyZcQLb8fPhR1T9ccQUlGxGh0JS7xvybMHsVIe9KtMjyUBAt
	CsCkdFl1Y19QGGSqQ1omiK+wEXlkGJyhx4TO8E63510Ydxo7Y2c8hwyCF+r27oWP+XaSTVAtS5+
	Kbyelh+JYz1Ln2vZn5tTAn0ls4wEKhKM8B6CVeMVjgHrABpc9spbRNINi4rB6TSGvdi1M0ygB8p
	OTuQbsVYP58bNojMsYqJbJzw9m3IPRbcXakp3VW8K8H0EHoDnIo/DdogrWzhk/Wjj1tXqUZIQGO
	n3Ju7voMF1GWK8dCSxDlCz6FXlSxqxp+aeWnS7QuyW/0GvGmfw5jL4L1aj24c9N0MfFjzM2yHJn
	ZV/YKlzlU5Gx6QjX3e11KSs2ZjNhqPvhVPRSazmnZ0WDTVC1Qlm4prWB4Qvke+MPC7zQqTw3pAx
	Uktg4tCaSaLSNfwtZ2FNHcCGtmcL3vFH9eJoA0O5lbSzzKumpydEBMHU4GDlLl5uaGfYzZS27+2
	1+rk+bU0jKqaOanr1GXqsAUsIvYInDQWRF8vMOhUOfa5C/ltn0JjlZ4glT0wEjoO2m16QVFM4H3
	239oPac3Py2qbTi0IDQ=
X-Received: by 2002:a05:690c:3183:b0:8b3:310:244a with SMTP id 00721157ae682-8b328db924dmr11659227b3.9.1793874774842;
        Thu, 05 Nov 2026 02:32:54 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309712e25sm37003777b3.2.2026.11.05.02.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:32:54 -0800 (PST)
Date: Thu, 5 Nov 2026 02:32:51 -0800
From: Breno Leitao <leitao@debian.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <srostedt@redhat.com>, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Message-ID: <auxXYbBvbupetclu@gmail.com>
References: <20261102-ring-buffer-head-moved-v1-1-165973790be4@debian.org>
 <auxJP5fkEQOkvicE@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auxJP5fkEQOkvicE@google.com>

On Thu, Nov 05, 2026 at 09:15:43AM +0000, Vincent Donnefort wrote:
> On Mon, Nov 02, 2026 at 06:30:11AM -0800, Breno Leitao wrote:
> > I am occasionally seeing the following  KASAN warning when running
> 
> a KASAN warning?

Sorry. It is a regular WARN from RB_WARN_ON(), on a kernel that happened
to have KASAN enabled. I will fix the wording.

> > I've understood that rb_handle_head_page() moves the head page forward
> 
> Drop "I've understood". 

Ack!

> Besides, I am not sure about returning 1. If the nested writer interrupts
> between rb_head_page_set_head() and rb_head_page_set_normal(), it can also get
> RB_PAGE_MOVED and skipping rb_tail_page_update() means the retry will observe
> the old tail.
> 
> All in all, I wonder if it shouldn't simply be: 
> 
>   case RB_PAGE_MOVED:
>      break;
> 

Good point, that handles both writers. The outer one falls through to
the existing UPDATE clear, and rb_tail_page_update() finds the tail
already moved by the interrupt, as when the cmpxchg returns HEAD. The
nested one moves the tail to next_page, which is right because the outer
writer already did the accounting for that page. And the duplication
goes away.

> Additionally, the comment with "Valid returns" must be amended.

Will do.

My reproducer used a two-page buffer, where this retry is harmless, so
I will re-test v2 with a bigger buffer before sending it.

Thanks for the review,
--breno
