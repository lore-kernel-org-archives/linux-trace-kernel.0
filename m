Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224437EFE8;
	Thu, 21 May 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366652; cv=none; b=eRjV/lqyPEU6qDrP2aHhJI82sYa3F90rvmXRbPiVP/XkQKfZGDeiJOI21yWSuFcsu04NFEX/1ePlnPeaN51ELOsvzScWMSPV8uYS5MTnfgafkdcigp5H+/P8WrUuHw8obarOBz/He7RoeyPBTNR7r3vSFsdnj4m/2doNjyPUxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366652; c=relaxed/simple;
	bh=gr7Ix1ejAluxk+XltZL622Uq3sjSY89KR4EuWxW7nhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzxyGmVn1vpenxMzm/ldwp/D0S1q9RzBn2X9f/+fshTQdlbbAEMtg86S5zvUdWtsnwIbi4ysEQw+JfHEYIOaoxC/CVAYtZRJF7/9MKWPtXpVGfKAsPdNMrJUQ2oXC/pfPP43pDAf4xYjTMs/0IiFwFcN0MVNQVkObL732ERhTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 9AE5F8EA92;
	Thu, 21 May 2026 12:30:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id C18E620025;
	Thu, 21 May 2026 12:30:46 +0000 (UTC)
Date: Thu, 21 May 2026 08:31:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix unload_page for simple_ring_buffer init
 rollback
Message-ID: <20260521083107.286c5f1b@gandalf.local.home>
In-Reply-To: <20260512141614.1759430-1-vdonnefort@google.com>
References: <20260512141614.1759430-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C18E620025
X-Stat-Signature: oyseqnn4y8o4sr8x3sxd9detqpxmecms
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+yUiZr4pRIxUEb80bbjSZMljICyaIrtYY=
X-HE-Tag: 1779366646-840302
X-HE-Meta: U2FsdGVkX193wHeTjUhRdwpgzgXUCRDfMQwt1VWj+61/NGKD4gmVJaDFaAwMjq9hkY7njEa9Xa1VzGV/hdTT9DuMoy+RY7ppul53eRpSfSSbQwwIt3cPP6BZFiZfJv/iZe3XNFujoPoauHIxUO7uqP04YJq6PVu3ftNIn061f4SKt8B3ue+saI6c/LDdvtTeYyWBFhQxj/NBqapIRMt2LsXzmEqn6vdrSkUH6HeY2CRySjy6VRdGj/5j/YWMhHvVXnq804ZkNkXEauUZSenDIwKBkgxpCuqfFEgQ9XuUwzmYtRwUEwYTE0hrs3rMKco/oHWC+Tu5NA8gztdESkkAp0CXXHwLfQI4o2ozjjxJTZwSznww6mf/A/VSl4QlpnbiLxSN/k46OZBBsNez+c5sZD84QpUfzc4lJNyTHprpfFv5iRTDNtxvekjAGlp8n4SLnINb/mov7Sw=

On Tue, 12 May 2026 15:16:14 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> The unload_page callback expects the return value of load_page() as its
> argument: ret = load_page(va); unload(ret). Fix the rollback code in
> simple_ring_buffer_init_mm() where the descriptor's VA is used instead
> of the loaded page address.
> 
> Fixes: 635923081c79 ("tracing: load/unload page callbacks for simple_ring_buffer")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
> index 02af2297ae5a..38cf9abe0be8 100644
> --- a/kernel/trace/simple_ring_buffer.c
> +++ b/kernel/trace/simple_ring_buffer.c
> @@ -431,7 +431,7 @@ int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
>  
>  	if (ret) {
>  		for (i--; i >= 0; i--)
> -			unload_page((void *)desc->page_va[i]);
> +			unload_page(bpages[i].page);
>  		unload_page(cpu_buffer->meta);
>  
>  		return ret;
> 
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581

Vincent,

Did you make this patch because of the Sashiko report?

  https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260512135420.99194-1-devnexen%40gmail.com

If so, I think we can add a: Reported-by: Sashiko <sashiko-bot@kernel.org>

-- Steve
