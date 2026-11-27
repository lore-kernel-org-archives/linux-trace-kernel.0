Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787325;
	b=PxLK0jh5DEnSxDsxNwOuxAPfx57uYOFJzZOISaweMkutLmjI720oVCZPYt5EpaMle4G4
	 I6h7PO8Ni6OC4BLz5786M4fzpyvy9VaF4lZ7LAzJ0/8OFAKOmAMtEnH3gF0qv2rVgGqT+
	 GRycFkMxDYIu2EhajzMJOU2RrUmwEnBaDBb359jNAyRUfdpCUMmRWNz3H77BbILljjsv/
	 bqnGLTkEzI2qTD9uqRDxs3Nm6J7VZSMErNqSPbKnWwuRVDw+Fq5veN9q8DvP/0/LBOeC0
	 PAlT8mxv+X1bpBI9oJlYQsPb9eixgyRt/obY4r97dRHDFziJj2WFXwORHVV9SzwnwWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787325;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=n8upGWMU5dYxg7sxJkaACPRFOxU85RCI1TbEo0G7FDc=;
	b=0r8TjlzlIQbVNgkRZXa/VpPiiUlk4D+2SSkGd6daGOFrGqTOozHUtSB9OELsIpCVl7qT
	 uWXaFxyQ9cabB+EXt6k64rtG9AsukgAvLe5jXyeNX/RJElo/bz8mgimjwN3ldcmITvf4Y
	 YBNRNMh1yZW3jSHlUBN5s++uKjg9r15LbJQISxuWpwz3X1tYWfiAkYOmCLWPd2W7UiI0I
	 0k+eKYxQPrjm/46B/2PrOkQB0ROqEUT8fharv6Ra7Rb8aFRMWqitWlDHi7o+U845MUXZV
	 8L1p7hL8vIe7KuCnVh+pxbNJ6tDq2WSmTniHYIa9KM1py55aKIKXRHOSl8xpJJtrVag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=z36wo7be;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB0606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 13:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=z36wo7be
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 840401A030B;
	Fri, 27 Nov 2026 13:48:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id D410A20025;
	Fri, 27 Nov 2026 13:48:33 +0000 (UTC)
Date: Fri, 27 Nov 2026 08:48:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dominik Maier <dmnk@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 dmnk+artist@google.com
Subject: Re: [PATCH] tracing/probes: clear dynamic data_loc on stage-2
 dereference fault
Message-ID: <20261127084832.0944600f@gandalf.local.home>
In-Reply-To: <20261126035556.407947-1-dmnk@google.com>
References: <20261126035556.407947-1-dmnk@google.com>
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
X-Rspamd-Queue-Id: D410A20025
X-Stat-Signature: huhtwes63xdk46ngkc6podei7diasgd1
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+OlqIFUD6PUSOlX5Joog6tDw+oD6/gowE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=n8upGWMU5dYxg7sxJkaACPRFOxU85RCI1TbEo0G7FDc=; b=z36wo7beAmHk5IawJ3lKNrKQ9Da6C9xvrGWXP0gf/VdE2Wm5Kz3+jhVV7qowBGEvQIw+QXHatje6K1aXbf2Yjxblg/U2x0BN8lyS8Q8CnlebO19RZUdrz1vqh1L3Rvh9j/CnXjTFXEmNt9UkaahWtpZ8dgrIdwbG7cuEZTWQupI=
X-HE-Tag: 1795787313-635803
X-HE-Meta: U2FsdGVkX19eGgUDVbYRECxOSc5Pt9hd8HQX7qaOs0e4VNFjm14dOjNCUBXosSa2hZujea4qY979R4s2X7rE7tZ8yb1Iw57MQEiZz2CCL4WFX81vlu2cICioM5hIbaukOpE8YC5jWzXVzRR+kY3zHAA0hWorKrcZphsxh5yrcklVZ/fs2/4Xi7SGlMS0FlKYToljf8eYN+rycXRnEQTcMxnSSsW3/A+Z2uyOrLZaBCVCgsgXKfKlJPxolr0g0TZ5rLU9nwx1pc0qq1esykhoszQcf4mlluPXbakP1WaiMhdTm3TWCz6xzU9QVgUXH2alYnY436NzUdiCsyuPGwwjjfJbqFbbjdB2

On Thu, 26 Nov 2026 04:55:56 +0100
Dominik Maier <dmnk@google.com> wrote:

> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 8acc0f0..4e0c49a 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -164,8 +164,42 @@ stage2:
>  			lval = llval;
>  			goto out;
>  		}
> -		if (ret)
> +		if (unlikely(ret)) {

I get rid of this return and handle failed reads differently, and the fix
is upstream already:

  23c8af89aac3f ("tracing/probes: Zero out faulted dereferenced fields")

-- Steve

  

> +			struct fetch_insn *next = code + 1;
> +
> +			while (next->op == FETCH_OP_DEREF ||
> +			       next->op == FETCH_OP_UDEREF ||
> +			       next->op == FETCH_OP_CPU_PTR)
> +				next++;
> +
> +			if (next->op == FETCH_OP_ST_STRING ||
> +			    next->op == FETCH_OP_ST_USTRING ||
> +			    next->op == FETCH_OP_ST_SYMSTR) {
> +				if (code + 1 == next) {
> +					s3 = next;
> +					if (dest) {
> +						u32 offs;
> +
> +						loc = *(u32 *)dest;
> +						offs = get_loc_offs(loc);
> +						*(u32 *)dest = make_data_loc(0, offs);
> +					}
> +					code = s3 + 1;
> +					goto array;
> +				}
> +				if (dest) {
> +					u32 offs = get_loc_offs(*(u32 *)dest);
> +					u32 zloc = make_data_loc(0, offs);
> +					int cnt = 1;
> +
> +					if (next[1].op == FETCH_OP_LP_ARRAY)
> +						cnt = next[1].param;
> +					for (i = 0; i < cnt; i++)
> +						((u32 *)dest)[i] = zloc;
> +				}
> +			}
>  			return ret;
> +		}
>  		llval = lval;
>  		code++;
>  	} while (1);
> 
> base-commit: ebb7a8dc1e74c705daffe11c2faf38ec2628f838

