Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E373594B;
	Wed, 16 Apr 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812683; cv=none; b=W2Xa9jGDtgufM5JCWNwnV+DH4FdMFKq8WVOTveq74WvzFeywm7asqxKZFY2DTDRVUYgeZGTQpH/CWVQZI6ihoJvdAnZ9fwlCEY9Ky/sa9d82jIhj/qACkYMHDbLWxNPpKsTvkQip8UfIu+hlAwgL0PqBqDDW/1EBsUWZUTHCy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812683; c=relaxed/simple;
	bh=5wXw+YmLaPMTjoh6FG8mJ9VaFdyKw7r3X7pc6Vhl+Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxuDLbaC3lCdLr8otuIbWIg800uO/lXR2I8AYr0u935vjaBX5tcFkc4Z1ZZXzQKbUU+cmEZcUWtUNgwb/j/drzenauGFItK9+j25fCLA9f4eV0qofzFVWdKMRr7od8vVTueyVe6nzH0FlI7KVm9uW8RG2oBppE1JK5MS4Dj16RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9545EC4CEE2;
	Wed, 16 Apr 2025 14:11:21 +0000 (UTC)
Date: Wed, 16 Apr 2025 10:12:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kernel
 Tracing <linux-trace-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH v2 0/2] Table of contents refactoring for tracing docs
Message-ID: <20250416101257.7339e3cf@gandalf.local.home>
In-Reply-To: <20250416024050.19735-1-bagasdotme@gmail.com>
References: <20250416024050.19735-1-bagasdotme@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 09:40:48 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Hi,
> 
> The trace toctree refactoring series [1] didn't make it through 6.15
> merge window previously, so I forwarded it targeting 6.16 via
> docs-next tree instead.
> 
> Enjoy!
> 
> Changes since v1 [2]:
> 
>   - Remove mention of individual docs' toctree as the generated sidebar
>     toctree don't include them ([patch 1/2])
>   - Move uprobetracer to user-space tracing section (Steven, [patch 2/2])
> 
> [1]: https://lore.kernel.org/linux-doc/20250318113230.24950-1-purvayeshi550@gmail.com/T/#u
> [2]: https://lore.kernel.org/linux-doc/20250415034613.21305-1-bagasdotme@gmail.com/
> 
> Purva Yeshi (2):
>   Documentation: trace: Reduce toctree depth
>   Documentation: trace: Refactor toctree
> 
>  Documentation/trace/index.rst | 98 +++++++++++++++++++++++++++++------
>  1 file changed, 81 insertions(+), 17 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

for both patches.

Jon, feel free to take this through your tree.

Thanks,

-- Steve
