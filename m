Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468657;
	b=WjEaesJmkT3QbR6XoTHPuEJDSf0+uZl0hb/S58RZHJ1I4Coh4zooTVT4zs6NWhngxKVq
	 i/igLKE0vF5jM0DfWh6CCbLxn5eVTf/lb6EjfW7bAc4Ad9YWuJnkhcGqlcAd85QRfGFkL
	 KVyFVmYomCvrQUIB1rLqM9F5dwTnMxARrWMu2wCJb0iqOiRfiBfAXpavwWXkHVZTM5q9Y
	 86k2O+4UM5yec8HvkDRBCa9twJNCTk4JzyGZBRWworCsD+3ylGPtoxAzH8aIswfGkNWwp
	 ZcUR2RPSBbQmSU6s9Sxj7vX18Wyyh4sUqMEyUPuYg5X5YIjcwy9Etp+R3oUX2xEGLRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468657;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=a6zCvKM+K6mK6mpjxjnM+krnyMuiiKGUND5cLXKnmmg=;
	b=gv3Js5VHts8OMjKAJ/1Qwuzm1tksu/dNK8CAfT2tBg9UIG2UqiCIVqFytAi1d80RcvXH
	 jIyS8VL2D7fW1zSVa5rPAw/MZBorkq7Un3nCk6lyXnJHsFJ1nWxHiCmpb9eQWR6wjPe/B
	 gsN+fLAAYNQbrJAhKFQYNUZRA6Zg9ahUMmpdWNjI8BRz94g2yfNc3Yq8YClFn7WywAFb8
	 mHHCtN8dmrDfsgRxrH02sCEnlEhJCTv4KW1fCKD1Rj7fo3lF0icKX+t0rO9aZ6GuUPdmj
	 S/Yg+eVoeBvhZ9XMVGlNLH3oUxAJB1scGEkGwQZTNgdoGVl48TZXeqAWCvdLaFgVbKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=t4frZ2xX;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B53606A31E;
	Mon, 23 Nov 2026 21:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B53606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=t4frZ2xX
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 912721C4414;
	Mon, 23 Nov 2026 21:17:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 227CE17;
	Mon, 23 Nov 2026 21:17:31 +0000 (UTC)
Date: Mon, 23 Nov 2026 16:17:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lawrence Lin via B4 Relay <devnull+deduce.gmail.com@kernel.org>
Cc: deduce@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Stanislaw
 Gruszka <stf_xl@wp.pl>, David Laight <david.laight.linux@gmail.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 1/2] module: Add module_kallsyms_on_each_addr()
Message-ID: <20261123161729.4763c2af@gandalf.local.home>
In-Reply-To: <20261004-ftrace-mod-bsearch-v2-1-c1de73e72e73@gmail.com>
References: <20261004-ftrace-mod-bsearch-v2-0-c1de73e72e73@gmail.com>
	<20261004-ftrace-mod-bsearch-v2-1-c1de73e72e73@gmail.com>
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
X-Rspamd-Queue-Id: 227CE17
X-Stat-Signature: 5su5xkzc45x77d8at9gk5z3i8okaq7jx
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19HZ770PR0wTdHmsbcBpWwldlRmgOLS2Mo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=a6zCvKM+K6mK6mpjxjnM+krnyMuiiKGUND5cLXKnmmg=; b=t4frZ2xXt8aXFUVr2MsHJe+cJH3s0cRp83zXtrg8hIynowMMMn8S2Us5S/OaqJwR9IN5x4fvtuD/eQnutA8gxvl6jp3y9uxs2j+a1q5OgCwdwF3Iuaz/ONHeg9ZO2lv79mjzi118641vERSGgTegyoIszTqEkuZj8He6oyvpaIw=
X-HE-Tag: 1795468651-835848
X-HE-Meta: U2FsdGVkX1+eoyM2NM3ZPDqAD/MqBsRXZQbIEsaKry+Vm3bJ86U2S9cPnta/wAtFJZr4VsC+3wtwogvsgMfHARQGoeWfa400O3aLXm/xL9uHVYMFSDjdo4vgyVNHieSlDpu7/FjoW1t92cq0qQyrjEQFEpMXUnELcfRKARJ2bdkhrGK6j8QDEc1qA6pQ5vj9Kedhw25ifwJk5/0vjVxHzS3xHNUtXIRlpuuP0NzuaapKRonRZeVKU0JX9rXIZNP/pOCc/mTrJkWv8j5GduuKhDqWrg74t8B9oSk46vIYkmsgu2u7XmLDqAX+nDh3ZqUkY0sZinqVXHNUFx7QcfD5iWCV2kRTH9nc

On Sun, 04 Oct 2026 14:51:00 -0500
Lawrence Lin via B4 Relay <devnull+deduce.gmail.com@kernel.org> wrote:

> @@ -286,15 +298,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
>  		const Elf_Sym *sym = &kallsyms->symtab[i];
>  		unsigned long thisval = kallsyms_symbol_value(sym);
>  
> -		if (sym->st_shndx == SHN_UNDEF)
> -			continue;
> -
> -		/*
> -		 * We ignore unnamed symbols: they're uninformative
> -		 * and inserted at a whim.
> -		 */
> -		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
> -		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))

Can you rebase to v7.4-rc4? The above function name was changed by:

  db91da8f05185 ("module/kallsyms: Rename is_mapping_symbol() to is_ignored_kernel_symbol()")

Thanks,

-- Steve

> +		if (!is_lookup_symbol(kallsyms, i))
>  			continue;
>  
>  		if (thisval <= addr && thisval > bestval) {
> @@ -458,6 +462,28 @@ unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
>  	return __find_kallsyms_symbol_value(mod, name);
>  }
>  
> +/*
> + * Call @fn with the address of each symbol of @mod that find_kallsyms_symbol()
> + * may resolve an address to. Unlike module_kallsyms_on_each_symbol(), this
> + * also works while @mod is still being loaded.
> + */
> +void module_kallsyms_on_each_addr(struct module *mod,
> +				  void (*fn)(void *, unsigned long),
> +				  void *data)
> +{
> +	struct mod_kallsyms *kallsyms;
> +	unsigned int i;
> +
> +	guard(rcu)();
> +	kallsyms = rcu_dereference(mod->kallsyms);
> +
> +	/* ELF starts real symbols at 1. */
> +	for (i = 1; i < kallsyms->num_symtab; i++) {
> +		if (is_lookup_symbol(kallsyms, i))
> +			fn(data, kallsyms_symbol_value(&kallsyms->symtab[i]));
> +	}
> +}
> +
>  int module_kallsyms_on_each_symbol(const char *modname,
>  				   int (*fn)(void *, const char *, unsigned long),
>  				   void *data)

