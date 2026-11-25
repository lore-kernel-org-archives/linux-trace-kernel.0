Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572240;
	b=QJYhYDbQR06WFC2gMrWGzEPWXAgAb5ZOAccYaPlSjB1bbJ3UDVNOVWqpWzU/QAXUdd1+
	 HgAHIb9FGBfe2ca8DyJLLRxAfrxUZNqnIbdWfaVwcL7eSAtWKpI5ldG0Ec0q/yJr7fS/H
	 +gvA9DnDdCT+OdyqfV6ip6CCDVZZe5zKI+RK5LND7MZLTJOg8ttJP5KAQMS6FooR6WwmK
	 nn/r3BqcLvQGVSSFedHIqGWIT90Nn69/xgqrX1kj0vTmgQD6+XnEFblqwdTKygLqTHDj1
	 VIjaTvpsxJipgpWr5Z2F8AbSJV72hbOlYzc+cAndK3unxc6Ue8TybR5m727AjDdIISA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572240;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=ksjN70Q8YTaoF1V1fImXO43nRFo/r2Dqov6ZPVJvENw=;
	b=flALKltrtK6T9Hb1oLVrfiOtXvcntuBYRvY9K26ia740IJZV71urlYxuG2zisGMDBnkr
	 ypsE7lBc0tik6gNhvkfZpaunSZ7rEeagLUt1kfXnANAeGfZoFdJ5uzQMXewPYmXbsJlfI
	 w9fXQwwlb6hcUWSH6xqNSHNfdJoCLZuosZCNBunQK9PLJApXxT1yGVEXQcTows/aiUvaG
	 EtMgtBV+1jzagWrN6A9orM+4sPcfAZ4d47R1fXhiEfJyzGpueD2pFvYGQaTVhkEtEenwc
	 f6jihQRdeSkjv/OwYRaNmIUp3YOC1AyA9144IV74jd73Fxn4Scp/Ey6y2bFLi5Ey/0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bXBZuYpS;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C9606A31E;
	Wed, 25 Nov 2026 02:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 185C9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bXBZuYpS
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 4D15740DAC;
	Wed, 25 Nov 2026 02:03:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 7889E20026;
	Wed, 25 Nov 2026 02:03:51 +0000 (UTC)
Date: Tue, 24 Nov 2026 21:03:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ring-buffer: Remove unused absolute timestamp mode
Message-ID: <20261124210350.718adb37@robin>
In-Reply-To: <20261105202814.1350312-2-vdonnefort@google.com>
References: <20261105202814.1350312-1-vdonnefort@google.com>
	<20261105202814.1350312-2-vdonnefort@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k5swkpkp9mj9kc78z34joia1nsu3ukgo
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7889E20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+sgrOAEvOaCeEZDI2ZFHcG6cHixh3CEtc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ksjN70Q8YTaoF1V1fImXO43nRFo/r2Dqov6ZPVJvENw=; b=bXBZuYpSfGHJ4mfmH2MuGS2jTlrmtNuudORgAsyWsJO4klJcxYCKiTycZ7Vg/6yHMB0JLm2zzvzzk2NZzPyTrw2nAWk7JvCfPgPSXsuG0pszddBi6ZPmt6LNWOdxYZcwkpL11+Ivh5F11EPIydCJBdZyjR1lPiIts1q9/j2NnT8=
X-HE-Tag: 1795572231-948522
X-HE-Meta: U2FsdGVkX18bIGFxdgWuB2N6MW7thpAzhnYBBYXiBOsQFy/d+j3J5MpJ3E+TvT+oiTEulf6Izdq0R1MISi3HHRswQHi4Ehac5/eOI2l8eKEwIYhepSe7y/DMvNB4OtmWF8FOzbsHQLnR3j34k80PLBHQyZATAjit/nJrcUejUi91iHcbtVbCEEMvymZSRUjjlkwirdbnF/gXU+ltW/zjKvwvOwaVnSRZ7p0siEQsN8hDYLmtDcQWTNkMQuq1kyVRyYLdAm7wD4RZC/ByEqVDixbGIGkrjYoKqyZMJtIbJiRwtU7/WghzoKZVoTpzOp/5oqq0i3s3dFFSgMT5qwLlW/j0YGHa/OT/

On Thu,  5 Nov 2026 20:28:13 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Since commit b94bc80df648 ("tracing: Use a no_filter_buffering_ref to
> stop using the filter buffer") dropped the last user of
> ring_buffer_set_time_stamp_abs(), there's been no one enabling absolute
> timestamps on the ring buffer.
> 
> Drop the support to simplify the ring buffer code. Keep the read-only
> tracefs timestamp_mode file to preserve the ABI.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  Documentation/trace/ftrace.rst | 19 ++-------
>  include/linux/ring_buffer.h    |  2 -
>  kernel/trace/ring_buffer.c     | 77 ++++++++++------------------------
>  kernel/trace/trace.c           | 10 +----
>  4 files changed, 26 insertions(+), 82 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 9423722848c6..88c0de3619be 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -712,27 +712,16 @@ of ftrace. Here is a list of some of the key files:
>  
>    timestamp_mode:

I think we should just delete this file too. And every mention of it.

-- Steve
