Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819255;
	b=gT1gMThqTw9VXiKCA9Ig57E3UBdsHQ+raaKEQzeNCzDT3IomTyRzw3AvtC8WAz9mC69P
	 n3Z8dUVwSoff21SuQ57gOG4k7VZgvabi3I2LYs09mrU2ksvmW9OTorymDsU5ztF1fa+a4
	 QIjTf633WaddqF8mn0d6mtaGrhKh83cgYRlNrkk1QqbGYKAQpdN+58vbPG+Tb0LUDTZqO
	 tbaSpdzo7q53f+sIIjd1xx5CnVrqKvu7UQAzNqz+w0SXUlU0PCnTbd5syZnu44wvVWSV6
	 0hjM0nLNeZwzuNikePgn/ZtrrfVhAJ3XadsgpGSulGneagI8M927MJrYryePLV2ZmIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819255;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=KTMoYuqLBqHwubZEfsHYR3hUPmGsP7yq0iAcZ4gBpeM=;
	b=ksSUVq8eOD/9xRHVdweyNcthqb3mZnHz15tG8QXXSfa3Dyzm3v0kMN/fGbdUn1TrMMcc
	 Nb2LmtyHEak5Qo3pUFKZaoYUPriIXYpBC/K6unftmJgQ/mbjVPErJSbVIEB3kOx7nrfJV
	 Oauyix/cBNwbRPiESCkrEzpy0O4VI1S6qZAPbDXpUtDl6+DLsOv7Pj2J6ZbuCQ3+JQcR3
	 rLg5kq5aAR07uF2PtFJJEsqtkOjyIT8wnoSNAgg2aObMzyGaKBiwX12K7DevByHvopgL9
	 vPhe4qQlkePKxDbBHYF6Dx/4JpeThVI8A1gFCKi2UspYmkFLt/b4PapctsJVblMts6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=m5+qLLKP;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB68606A32C;
	Wed,  4 Nov 2026 19:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDB68606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=m5+qLLKP
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 00B171A0834;
	Wed,  4 Nov 2026 19:07:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 2D1E11C;
	Wed,  4 Nov 2026 19:07:25 +0000 (UTC)
Date: Wed, 4 Nov 2026 14:07:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ring-buffer: Drop redundant
 ring_buffer_iter::event_size
Message-ID: <20261104140723.1251aee1@gandalf.local.home>
In-Reply-To: <20260922072944.1281427-4-vdonnefort@google.com>
References: <20260922072944.1281427-1-vdonnefort@google.com>
	<20260922072944.1281427-4-vdonnefort@google.com>
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
X-Stat-Signature: c7u8gcx8b9jhqsrjw3oowrehg7k1eteq
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2D1E11C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19cBUwXlfpWuCOJ3iY/2y+2/kY84DRFsYA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=KTMoYuqLBqHwubZEfsHYR3hUPmGsP7yq0iAcZ4gBpeM=; b=m5+qLLKPVot9ut2fRdIhFoy+1rz6Dy+9PIbhbLeSkI1r4URtWHL2r66kcksP8x0l3YrRUhlgXOwNSpSh+0eDvRTrLVcyUZ3oF63qRM0LABJorlOdRn1dNVVvrzYYmWsnAuhBIU4dC8MGCDyyQOkoNChidS95CMGrf2l7D/F7B6Q=
X-HE-Tag: 1793819245-479012
X-HE-Meta: U2FsdGVkX19B8I8IHEGAx+cpDyW2IigsZPl7vHqYekWf8gTqR+yLLtExYblpkEzCBlC4OgfrvUX7v0FYg0QVZRmZ0GZuGbUMC1sYHmZ96wkO/LiLWv7F8w3O+82NlxvkflvNLTs4PLaNzZlCHpRKvyz6kSoL8WPgouMAIFPgKQDWE15+flFTdUXWlcmxolXyc1uBHueQQZqgkPnl53Ig/LT7SJZJ2riMKYuzgX1VSljOV1iz96SKKJ+7TziS5tNIcoUGGS/OUJyzLAICuos7alO1q2//yvA3FSYAiayrSzW9+mQN0F4Q+WO0M4rt/IyZcOkpGnS3oj3HhAqZjcwgMgrworfibLXk

On Tue, 22 Sep 2026 08:29:43 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> event_size contains the maximum size the iterator can read for each
> event. It corresponds to the maximum capacity of a ring-buffer page.
> During non-consuming read, resizing is disabled. It is therefore safe to
> just use rb_subbuf_capacity(), making event_size redundant. Remove it.

Hmm, I don't like the code dependency here. Yes, we disable resizing and
the event_size isn't going to change, but if in the future that is no
longer the case, then this becomes a hidden bug.

What's wrong with just having a field that keeps track of the size
allocated? It's more robust that way and doesn't have any hidden
dependencies.

-- Steve
 

> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  kernel/trace/ring_buffer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1a158a24b3c8..3129589e2d0e 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -680,7 +680,6 @@ struct ring_buffer_iter {
>  	u64				read_stamp;
>  	u64				page_stamp;
>  	struct ring_buffer_event	*event;
> -	size_t				event_size;
>  	int				missed_events;
>  };
>  
> @@ -3558,9 +3557,11 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
>  	 */
>  	barrier();
>  
> -	if ((iter->head + length) > commit || length > iter->event_size)
> +	if ((iter->head + length) > commit ||
> +	    length > rb_subbuf_capacity(iter->cpu_buffer->buffer)) {
>  		/* Writer corrupted the read? */
>  		goto reset;
> +	}
>  
>  	memcpy(iter->event, event, length);
>  	/*
> @@ -6488,8 +6489,7 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
>  		mutex_unlock(&buffer->mutex);
>  
>  	/* Holds the entire event: data and meta data. */
> -	iter->event_size = rb_page_capacity(READ_ONCE(cpu_buffer->reader_page));
> -	iter->event = kmalloc(iter->event_size, flags);
> +	iter->event = kmalloc(rb_subbuf_capacity(buffer), flags);
>  	if (!iter->event) {
>  		atomic_dec(&cpu_buffer->resize_disabled);
>  		return NULL;

