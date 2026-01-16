Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AE23D2B2;
	Fri, 16 Jan 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574738; cv=none; b=V4nDsQWS6Hsfqmjlu0z5YSZcc4VVL7jZkhCFs0YKtYwXJnr0QHX7CjlKLou70bapbrHTp2y7d2jQkz4eQW6Zrgo5gGY/75VBBUv7KkUAR4ASkeDrkDmyTuENECYCHZ+fYOiNbe9QnHGX/X8ccHLWqdUK98/A6csvNb9uM/+pxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574738; c=relaxed/simple;
	bh=dLIP3yuCXQig06JmGi7Dt5CFTqwxB/97u4nRMJ/85o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI2HL5KcOoiKDzTVL4yYXrI+EiJQ3xSWOrnNa4kY7LoFiL/aPRbAR9ghsJqutZeoMKb1AA0RVUbVVHYJ8z8eedXZ/igjl3FCnXoMrjGL1WPzeondkubcSMhs6Z0e/cjm+q4wZ8+y0n+qY2OpGW+toymPzA2WI5kUClWFYUknFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JHn9hny+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JHn9hny+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2066EC116C6;
	Fri, 16 Jan 2026 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768574738;
	bh=dLIP3yuCXQig06JmGi7Dt5CFTqwxB/97u4nRMJ/85o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHn9hny+KZc4fD/9N3/yGG4Ed/hhHgyo20Xlcfi6MQ0Tz8Px4xYfrMnWeTFClUuk8
	 00EV1D5wpqvfLr0GiQqLHyQcyukMIVymVzBr7dJCpGoIs5JGJ4g4MAMNMBZDsazQuO
	 3bfpoDTbahXMz2Ln32On0kIkEny+5/uDL7Cww21E=
Date: Fri, 16 Jan 2026 15:45:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: Re: [PATCH v5 3/6] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to
 sysfs.h
Message-ID: <2026011629-recognize-municipal-2a89@gregkh>
References: <20260116042510.241009-1-ynorov@nvidia.com>
 <20260116042510.241009-4-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116042510.241009-4-ynorov@nvidia.com>

On Thu, Jan 15, 2026 at 11:25:06PM -0500, Yury Norov wrote:
> The macro is related to sysfs, but is defined in kernel.h. Move it to
> the proper header, and unload the generic kernel.h.
> 
> Now that the macro is removed from kernel.h, linux/moduleparam.h is
> decoupled, and kernel.h inclusion can be removed.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  Documentation/filesystems/sysfs.rst |  2 +-
>  include/linux/kernel.h              | 12 ------------
>  include/linux/moduleparam.h         |  2 +-
>  include/linux/sysfs.h               | 13 +++++++++++++
>  4 files changed, 15 insertions(+), 14 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
