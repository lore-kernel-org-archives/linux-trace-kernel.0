Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640472;
	b=zlMdQb6+DethwXdGmUUn2rQyh8lX5VfuFEZ6nkp8HJQqPJv9SA8sua0ZvfnR3dXIsJ2C
	 Fy4b4YyMhrafc1x0JZD3CNqDvr2INzGFthrHud+Ya6GtAmd32XG6lrGXq0DLJYVAvLSCJ
	 6MqZ0V9oDbY+BsqBXzEagpkYiTCxdjvIvqz+Y61Pc8ehNb92jE1ac7XDPl8odlsRhTh/k
	 OS6SNXvqRryQ6wgaD/+jJux2TUWI3oUTmhzdJl7GH1G7d+8W1jIOZANCFdShKXIc3IOVb
	 ShB4Oe5aFjHtnlT6WTNy8YXO69VWfpUPGYH3lsIvjc4mOUBrRSLJQJJZwo1u09q8a/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640472;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=gyynnWw1IwEuOIm71kj420EQ/jKqlvd+zpN7hzxu5dU=;
	b=P53V54VcLgvqtPUT82fndAdKjjib7sMzhUgRKxV0STXyYnF48vDXZub0n3uk3cQEBikZ
	 cu+X1KTjIicXlPRTlPtYmbSJJLlEUQTkGRnhNtffPZ5yfpEjJ+2ik3ICwjQ9sTtKenHB5
	 nRdLjNXFvto6QX1HfD3DiUYy+CxFxL9qo/yDFNv7eFu35TcfeSemDTWm8zfFtGjToPmx/
	 OulFOa9GPi+xvrcmDmN4I/nA0v0VTT3M60u0LwhCv6Uv/jSM54k8H5kfktpx6hx64eQCJ
	 2cacjpNwxZ6LQe/F/5710ELRPARQ1Nhzkkk6TOjgZrn8jg1ZGGxPuGYrj+o+HVCdTBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Ab6qbPph;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612D606A32C;
	Wed, 25 Nov 2026 21:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5612D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Ab6qbPph
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 7F3301C3D89;
	Wed, 25 Nov 2026 21:01:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id B401230;
	Wed, 25 Nov 2026 21:01:07 +0000 (UTC)
Date: Wed, 25 Nov 2026 16:01:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/21] tracing/remotes: Add printk, dump_on_panic and
 boot parameters
Message-ID: <20261125160106.01c468e2@gandalf.local.home>
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: B401230
X-Stat-Signature: wwpfufqqgq5f6hgq8sg8a9axfnjn7act
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/7cbng2B5iyqOHuLe/ruR6GbmFD0udSo0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=gyynnWw1IwEuOIm71kj420EQ/jKqlvd+zpN7hzxu5dU=; b=Ab6qbPphpdBffCvzRCypyR01b3EmdxewC1ELFo6txrt4xP8qGZGeu5h5Pa3Imbb3whpnrzn1wU7UDi2l83HJIBvRzDdLCu/myfzIqmg5QopCRKcXmRrSKLkb1gZZcWuIz6g+eXV3XbIgx0GS+0L5cZ4ELKqmmM+6pt9EQTKEhnM=
X-HE-Tag: 1795640467-282171
X-HE-Meta: U2FsdGVkX19u79LZ8tOspIAhCeImDDydmmEiq5pJxSjLZEarFFwnD9LpU4MbCsOaw1UQs2Q1y7ambv7JoUuuI6uzLanXUjOxhpXb+JcM975ZCcRUKOzSbOuSEGD9Wr3s/EJpQFfxzNXemm4d7vxLK6n7a74Y/gMci9qBIbKpX/2dGdoS+Eixmg9bQkGJWd0nE63nA/WKhrPHFOJStug14WQhMxu6A7SKqR8x2B+Xl9gRRdDmoq0uOfu43W0Datepjun/OkTPmKKJXKe/Ir/Z96e6gaGAAYVAFK98YBoDGFswI8dkEHWO1i1Hp0Eiq0A39KCb3e89iqSPIYK8gz59RP0kTfUyK3pu

On Tue, 24 Nov 2026 15:28:24 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Vincent Donnefort (21):
>   tracing/remotes: Gate tracefs files opening on trace remote
>     registration
>   tracing/remotes: Release tracefs,eventfs on registration failure
>   tracing/remotes: Use kstrtobool for boolean tracefs files
>   tracing/remotes: Initialise pos in trace_start()
>   tracing/remotes: Annotate remote shared fields with
>     READ_ONCE/WRITE_ONCE
>   tracing/remotes: Use a single per-remote polling work
>   tracing/simple_ring_buffer: Add support for compressed length
>   tracing/remotes: Add dmesg tracefs file
>   tracing/remotes: selftests: Add a test for the dmesg tracefs file
>   tracing/remotes: selftests: Prefix hypervisor folder


>   ring-buffer: Use irqsave for the reader lock in
>     ring_buffer_poll_remote
>   ring-buffer: Avoid reader_lock deadlock during panic
>   ring-buffer: Use panic-friendly locking in ring_buffer_iter interface
>   ring-buffer: Add kerneldoc for ring_buffer_poll_remote

Do the ring-buffer specific changes need to be part of this remote patch series?

They probably should be separate.

-- Steve


>   tracing/remotes: Use ring_buffer_capacity() in trace_remote_has_cpu()
>   tracing/remotes: Add dump_on_panic tracefs file
>   tracing/remotes: selftests: Add a test for the dump_on_panic tracefs
>     file
>   tracing/remotes: Add poll_ms tracefs file
>   tracing/remotes: Add trace_remote cmdline options
>   Documentation: tracing/remotes: Add detailed tracefs layout
>   Documentation/kernel-parameters: Add trace_remote
