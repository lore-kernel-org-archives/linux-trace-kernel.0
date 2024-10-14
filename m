Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97528156872;
	Mon, 14 Oct 2024 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941492; cv=none; b=rrvdbRSPUgKQdkTh8571yAeZBsg+WRjoH3C3l993iJiUT1ZbZjmL7kU6MuPZh5Rs72UxbA2VPd+hhJMHY6waJoeTLlnT2P8LYHIaJvwyp7OI7Ui2fP3XTK/S1ziKlTmWZMFye4Aj4QPjIn6pa0pTTtATcBfigShG4YnXvsMTdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941492; c=relaxed/simple;
	bh=EgMQlfc0cmrFZVzE8nyOZnscIVnJZk6lOm9VCl01x7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kuj8Z5srRbOzxrLf4AbwlIrQ1Yguc+VmaYd6SfNcj1q5xoHY7FvtSFRCv4Sm5mYFGq5pNZwNnBsejNauO9aewGdPDz/l3JSd9UbDPRWSmrjb44ahZn8bwdFChNjKf5WDpTqhQxj09IRM5oYZVzWM3CAqfH3ZqLlF7RAUPqOTqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgd+oAMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgd+oAMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C263C4CEC3;
	Mon, 14 Oct 2024 21:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728941492;
	bh=EgMQlfc0cmrFZVzE8nyOZnscIVnJZk6lOm9VCl01x7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgd+oAMGq93Ttuj7W2ajGu3dzQ2KxgauThHh5ERDQah5zBX7eHC4JRNlV+bf0bmdK
	 mW54ynU//45aGK2pJw4mXWLkBWJ0pt1bsOXztxkelP+9/AyjSZNlXhnfjfcz7y5t3g
	 vOYjZEZYnaWfQLT0YJUBB9IPv2XC5eLoJSX0D7ZJFCmHdlPHXSkSVlbaSxFLu1HHb0
	 b5oQJly/RtrhQIjrbC6u6Yl0FMeeqOYIB4K8OSgQRjgbBn/2QSP8AQWhfnyKm9wNd/
	 h+tTQMfcm3UNYXkiJ01EZ000u9JpzbNHA6Ke68fBeRFYXWOWdPjkek7BQqWpwJttYx
	 nGhimkwCOC03Q==
Date: Mon, 14 Oct 2024 14:31:29 -0700
From: Kees Cook <kees@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tracing: replace multiple deprecated strncpy with
 memcpy
Message-ID: <202410141423.2C30F35EE0@keescook>
References: <20241014-strncpy-kernel-trace-trace_events_filter-c-v2-1-d821e81e371e@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-strncpy-kernel-trace-trace_events_filter-c-v2-1-d821e81e371e@google.com>

On Mon, Oct 14, 2024 at 02:13:14PM -0700, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings [1] and
> as such we should prefer more robust and less ambiguous string interfaces.
> 
> String copy operations involving manual pointer offset and length
> calculations followed by explicit NUL-byte assignments are best changed
> to either strscpy or memcpy.
> 
> strscpy is not a drop-in replacement as @len would need a one subtracted
> from it to avoid truncating the source string.
> 
> To not sabotage readability of the current code, use memcpy (retaining
> the manual NUL assignment) as this unambiguously describes the desired
> behavior.

We know the destination must have a NUL-terminated string. Is the src
NUL terminated? Looking at parse_pred(), it seems like no? And we can't
use memtostr_pad() here because the source buffer size isn't known at
compile time. Okay then. And there are no NUL bytes in the "str + s"
span, so yeah, it looks like memcpy() is best.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
