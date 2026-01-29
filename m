Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C598633A030;
	Thu, 29 Jan 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710216; cv=none; b=qDWHtlpR4K7BcBfYQRXare0VEYCLGcEmHqgLnxrOxmqxj95NhADOMKTF5nZq8MyFSsZv8EbHysfbDU7YDReGUiN828O4sITylkZqgBXx+TIF2BAPoltD4MNnXrkc0Tzc4Q4rTp2+3cm91jg9VVMYGX2l6T3g7T5skg9I67bX9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710216; c=relaxed/simple;
	bh=UQLG6sfZItLnr3UHKZWagBVTZ4bEr1vCN1ddIrdGN6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdUa/ffL9zS8CoBECrCi6f2JT/vkKgbDl0Du0gzB6ek6XqDo3Kgzm0QEGmyhess+agUIEN0ugnp5NFN8RqkQEEVjGGbron7EK23+WJxUMkGp579kjcbnAtaT40GNgCTA76mo8pKmMrl+cZv1dqZI56GPfTKK6kyRl82OhoYWVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D15A51B05DA;
	Thu, 29 Jan 2026 18:10:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id C96662000E;
	Thu, 29 Jan 2026 18:10:09 +0000 (UTC)
Date: Thu, 29 Jan 2026 13:10:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, mhiramat@kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 dhowells@redhat.com, kuba@kernel.org, brauner@kernel.org,
 akpm@linux-foundation.org, linux-trace-kernel@vger.kernel.org, gaoxiang17
 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v13] dma-buf: add some tracepoints to debug.
Message-ID: <20260129131022.302e0a6c@gandalf.local.home>
In-Reply-To: <20260109115411.115270-1-gxxa03070307@gmail.com>
References: <7e126504-1966-4c63-8db5-dfe57e206169@amd.com/>
	<20260109115411.115270-1-gxxa03070307@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C96662000E
X-Stat-Signature: 7zxw1f8qpegmfp89wafbiq7cbue3tx3c
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Bq6Shjs13wZTE8qaBJ3dI8UFmbrVZV+Q=
X-HE-Tag: 1769710209-415785
X-HE-Meta: U2FsdGVkX19na61YaDkoNKEtYADwBcTU22ie7xg0+6jtjYMWTEj+0HfSETh5E6FW7V/dUnoQr6B2GoQ27355AalL21SUT5I4KyVrEeq0aCFN3DUsniKBxg+ZYoXqX5n+D1yY+u+J1X2qayRCMTZ3nzwQ2+c4gcpn/dSquzu4kMwtamm41DZpB0vAFmE6rmgsMqoN5Azo045IzRzhr7kJBxJ9QF4efvA+Nl94T8N22cKL5MHkQrDIKMq3wEG/Q3FQdbM4aln03CI8d9JjUXsjHKqgCxmNsMyoyx/gRhb2aWiazHibIca3gJzpFfOpqVH7nDfXPCmkb2K6W+WLZJkKX2zhsliT9wCOd8ms9Kw55ZSCueM3qhV3MfrZrv7RbKg6Sm7XviNnT4grRqRPN1bsmKGis+wDRK0RUgGeIypsQ2k=

On Fri,  9 Jan 2026 19:54:11 +0800
Xiang Gao <gxxa03070307@gmail.com> wrote:

> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> Since we can only inspect dmabuf by iterating over process FDs or the
> dmabuf_list, we need to add our own tracepoints to track its status in
> real time in production.
> 
> For example:
>    binder:3016_1-3102    [006] ...1.   255.126521: dma_buf_export: exp_name=qcom,system size=12685312 ino=2738
>    binder:3016_1-3102    [006] ...1.   255.126528: dma_buf_fd: exp_name=qcom,system size=12685312 ino=2738 fd=8
>    binder:3016_1-3102    [006] ...1.   255.126642: dma_buf_mmap_internal: exp_name=qcom,system size=28672 ino=2739
>      kworker/6:1-86      [006] ...1.   255.127194: dma_buf_put: exp_name=qcom,system size=12685312 ino=2738
>     RenderThread-9293    [006] ...1.   316.618179: dma_buf_get: exp_name=qcom,system size=12771328 ino=2762 fd=176
>     RenderThread-9293    [006] ...1.   316.618195: dma_buf_dynamic_attach: exp_name=qcom,system size=12771328 ino=2762 attachment:ffffff880a18dd00 is_dynamic=0 dev_name=kgsl-3d0
>     RenderThread-9293    [006] ...1.   318.878220: dma_buf_detach: exp_name=qcom,system size=12771328 ino=2762 attachment:ffffff880a18dd00 is_dynamic=0 dev_name=kgsl-3d0
> 
> Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>

This may already been accepted but just for the record. For the tracing POV:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
