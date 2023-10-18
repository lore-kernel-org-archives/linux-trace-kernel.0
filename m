Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3B3B7A3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7434FC433C8;
	Wed, 18 Oct 2023 16:59:03 +0000 (UTC)
Date: Wed, 18 Oct 2023 13:00:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-ID: <20231018130042.3430f000@gandalf.local.home>
In-Reply-To: <20231018144030.86885-1-flaniel@linux.microsoft.com>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 17:40:28 +0300
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Changes since:
>  v1:
>   * Use EADDRNOTAVAIL instead of adding a new error code.
>   * Correct also this behavior for sysfs kprobe.
>  v2:
>   * Count the number of symbols corresponding to function name and return
>   EADDRNOTAVAIL if higher than 1.
>   * Return ENOENT if above count is 0, as it would be returned later by while
>   registering the kprobe.
>  v3:
>   * Check symbol does not contain ':' before testing its uniqueness.
>   * Add a selftest to check this is not possible to install a kprobe for a non
>   unique symbol.
>  v5:
>   * No changes, just add linux-stable as recipient.

So why is this adding stable? (and as Greg's form letter states, that's not
how you do that)

I don't see this as a fix but a new feature.

-- Steve
