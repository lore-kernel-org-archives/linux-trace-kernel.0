Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9FC1DF756;
	Mon,  6 Jan 2025 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191723; cv=none; b=uSXcXjXQVrbTbtJCr/kixG8nfMP72Ih9JEmQRH6ePdEpK2YdxRbmf20JYrrsfbIMH3G6wN31VYjerJ8jk1viFZoAcK7niVTdaBQTqZ4eN7SZ1j3i5WXdEp9SfbUp0WTL9HExRfUXhcNq2A8+6GVoBEPLrL58YTl1yHq35N6vof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191723; c=relaxed/simple;
	bh=X0NRSIP+pJsjBex5qHIHzw3L0qXPV+iCJrEv+Xami9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgyUyK1Oe8fG15pC+5wWTe+IMb1lFKawKfMQacQT/wn6mqct23c5vPJ3zmObbYk3szkM8z72UM/P1NR+4arlOj+0wh7YKPoiZaDw+bf1r/qzLrhSeLB72IOxH1vWU8CZjN+6LKZRVWsrYUphIYfLyj6ZOg/P6iSfkQOdWoA0Pvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF5AC4CED6;
	Mon,  6 Jan 2025 19:28:41 +0000 (UTC)
Date: Mon, 6 Jan 2025 14:30:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] Provide __free(argv) for argv_split() users
Message-ID: <20250106143007.3d430500@gandalf.local.home>
In-Reply-To: <173594530753.1055889.17844868397124331132.stgit@devnote2>
References: <173594528527.1055889.2175884987203674189.stgit@devnote2>
	<173594530753.1055889.17844868397124331132.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Jan 2025 08:01:47 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Provide __free(argv) macro for argv_split() users so that they can
> avoid gotos.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/string.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 493ac4862c77..7035a70e30be 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -312,6 +312,8 @@ extern void *kmemdup_array(const void *src, size_t count, size_t element_size, g
>  extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
>  extern void argv_free(char **argv);
>  
> +DEFINE_FREE(argv, char **, argv_free(_T))
> +
>  /* lib/cmdline.c */
>  extern int get_option(char **str, int *pint);
>  extern char *get_options(const char *str, int nints, int *ints);

FYI, I already have this change in linux-next:

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commit/?h=for-next&id=9e49ca756d207f4313fb7af48648a67da8e4e250
  https://lore.kernel.org/20241220103313.4a74ec8e@gandalf.local.home

-- Steve
