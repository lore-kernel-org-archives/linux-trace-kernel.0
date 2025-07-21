Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0121E7C08;
	Mon, 21 Jul 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108699; cv=none; b=qwAT5ceWlNEMjX4gcWCJbXAfPdzwP2UWeo0PK3FZEcnF+PEYv2+P0CoIZr+hgZM7qOyJJtbPuCDUp/Kkd43BSQYDsHxAoqmIPjr9OwV8SaEP/4t8gjIgwhQ26PDer3nfPjNmrymm9KraLbZGlI2KTs2NoQuUuMV8tuvApAcR4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108699; c=relaxed/simple;
	bh=IIRQKIHDwJIpzWc0h+9pk2yBJbHOuKoIX8Rw8Ot7tnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVaF86cJsBYP5pDTbNytETmQ9otzZGc82BauM6C+kvKxAOxV8pExLzPMykcSRESiaKwBVA5h2FrBf5qC0zKBuOq38vQkC7xxTM6Hu6j/neJHJWpl89inaFK4UNcdxtgDgEH6ExxlmVkR+5U+e3XEpqGBrUu9r5PQuDeMEZGnE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b9Wm/i63; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1+t2GZxL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b9Wm/i63";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1+t2GZxL"
Date: Mon, 21 Jul 2025 16:38:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753108696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JnQfa88CK48lLWCdoVnJ0Q8OmTDIlbfDOk36YC76Hk=;
	b=b9Wm/i63wJ1T1VxUo42XZFeoswLbiA+nHEcR6mb/hXwgyYcLCnqe6FcQoILbxumqMrNxdZ
	JlToNad1iT/GFt5mZOi3OKkXEn3kCRqgjaPwtRombiIpJQAbWBNwtKJziBXu/lUZKvJGXV
	aL6FfJRhl8zzKpfWNX8j/IizVT1ObAxKSA61zpGe3z4msvpr2dPjE4dN1ZLfF+hZ9yCEOS
	iU1v5UrtVZYdVUURacaANbbzNN0kCH3hemFCOQLH3OCgmclIr+/9o+s7peJWCW5VfXTUEw
	/OlODzKmgUnsNZN2OUYHJoNOGFg0OnbshtQElnwYi6gqyI9igyhVc4yNX3hOtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753108696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9JnQfa88CK48lLWCdoVnJ0Q8OmTDIlbfDOk36YC76Hk=;
	b=1+t2GZxL6RcbpCeTHPI4+DzV2jAVUcFEgh0fAP24MZ4ftNegcQb7f3xwbigfJFlygMuDR8
	leM/PYvsfnWO/VDA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v4 08/14] verification/rvgen: Organise Kconfig entries
 for nested monitors
Message-ID: <20250721143814.waTN9e5C@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
 <20250721082325.71554-9-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721082325.71554-9-gmonaco@redhat.com>

On Mon, Jul 21, 2025 at 10:23:18AM +0200, Gabriele Monaco wrote:
> The current behaviour of rvgen when running with the -a option is to
> append the necessary lines at the end of the configuration for Kconfig,
> Makefile and tracepoints.
> This is not always the desired behaviour in case of nested monitors:
> while tracepoints are not affected by nesting and the Makefile's only
> requirement is that the parent monitor is built before its children, in
> the Kconfig it is better to have children defined right after their
> parent, otherwise the result has wrong indentation:
> 
> [*]   foo_parent monitor
> [*]     foo_child1 monitor
> [*]     foo_child2 monitor
> [*]   bar_parent monitor
> [*]     bar_child1 monitor
> [*]     bar_child2 monitor
> [*]   foo_child3 monitor
> [*]   foo_child4 monitor
> 
> Adapt rvgen to look for a different marker for nested monitors in the
> Kconfig file and append the line right after the last sibling, instead
> of the last monitor.
> Also add the marker when creating a new parent monitor.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Some nitpicks below. But regardless:
Reviewed-by: Nam Cao <namcao@linutronix.de>

> -    def __patch_file(self, file, marker, line):
> +    def _patch_file(self, file, marker, line):
> +        assert(self.auto_patch)

Nit: follows PEP8 unless there is a reason not to: assert self.auto_patch

>          file_to_patch = os.path.join(self.rv_dir, file)
>          content = self._read_file(file_to_patch)
>          content = content.replace(marker, line + "\n" + marker)
> @@ -146,7 +147,7 @@ class RVGenerator:
>      def fill_tracepoint_tooltip(self):
>          monitor_class_type = self.fill_monitor_class_type()
>          if self.auto_patch:
> -            self.__patch_file("rv_trace.h",
> +            self._patch_file("rv_trace.h",
>                              "// Add new monitors based on CONFIG_%s here" % monitor_class_type,
>                              "#include <monitors/%s/%s_trace.h>" % (self.name, self.name))
>              return "  - Patching %s/rv_trace.h, double check the result" % self.rv_dir
> @@ -156,10 +157,15 @@ Add this line where other tracepoints are included and %s is defined:
>  #include <monitors/%s/%s_trace.h>
>  """ % (self.rv_dir, monitor_class_type, self.name, self.name)
>  
> +    def _container_marker(self, container = None) -> str:
> +        return "# Add new %smonitors here" % (container + " "
> +                                              if container else "")

PEP8: container=None

And this function name is misleading, it is not marker for only containers.
Perhaps _kconfig_marker() is more appropriate.
