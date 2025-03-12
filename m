Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F602356D8;
	Wed, 12 Mar 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801752; cv=none; b=secaKax4Qm8bWyWLzOBOZGLbfHwXqxThuNH3j90Pl3tMpaM+xBbfI6GtsK7OonJiJ5RMKwWX+SAHGpD/Yrxz3Vn4JgGYV6iip6E2Rysh+X1rHWKx0xQcK22nPMnkD7IBw7nL2G74hrh5qvRBxDb0qzq7QdF38GwYownQhF7GRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801752; c=relaxed/simple;
	bh=lLJWHEM+0LtiO3tRkYJg2vMxDcl8li5cHF/S91wLMtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfno2KSyGs4e5ubrAVdwen+ULqzK5y3KkKQCiR33SVYRzv9EclZAS2J6gN5oqovDyX9ljZpkfgSQHb/8SHcHEcqDvk7FG8Y6hhpMUbE4uxI2CFLSjFpNtAro+2/egT1rby4VTAN8gSzKPXztFl4nielPYuQfmbJHzz6JvitVwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2264C4CEEA;
	Wed, 12 Mar 2025 17:49:10 +0000 (UTC)
Date: Wed, 12 Mar 2025 13:49:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
Message-ID: <20250312134907.06d27d78@batman.local.home>
In-Reply-To: <20250312124717.7208-1-purvayeshi550@gmail.com>
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 18:17:17 +0530
Purva Yeshi <purvayeshi550@gmail.com> wrote:

> Reduce :maxdepth: from 2 to 1 in index.rst to simplify the table of
> contents, showing only top-level document titles for better readability.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  Documentation/trace/index.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 6b268194f..5ddd47ee7 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -14,7 +14,7 @@ This section provides an overview of Linux tracing mechanisms
>  and debugging approaches.
>  
>  .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1

If you made this the first patch, you would only need to modify one place.

This is a patch series. If the end result is going to be maxdepth 1,
you shouldn't add a bunch of maxdepth 2 and then in the next patch make
them all maxdepth 1 as the only change.

Just change the one maxdepth 1 first, and then you can update the code
with the new maxdepth of 1.

-- Steve


>  
>     debugging
>     tracepoints
> @@ -28,7 +28,7 @@ The following are the primary tracing frameworks integrated into
>  the Linux kernel.
>  
>  .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
>  
>     ftrace
>     ftrace-design
> @@ -47,7 +47,7 @@ A detailed explanation of event tracing mechanisms and their
>  applications.
>  
>  .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
>  
>     events
>     events-kmem
> @@ -65,7 +65,7 @@ This section covers tracing features that monitor hardware
>  interactions and system performance.
>  
>  .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
>  
>     intel_th
>     stm
> @@ -85,7 +85,7 @@ These tools allow tracing user-space applications and
>  interactions.
>  
>  .. toctree::
> -   :maxdepth: 2
> +   :maxdepth: 1
>  
>     user_events
>  

