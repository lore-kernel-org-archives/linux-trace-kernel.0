Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F64191484;
	Fri, 21 Mar 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567114; cv=none; b=KgWk+fZH9GqJtWyw1qM+LCjVbS2qp5gdpnyVZDnIsgazFIaW6xrRcFbvAYACdzFt75grsarLN2AXKutvXiirPjFpN2E4eMqvAq4t/8u0iq75BIaBbQyzJH6U27YT5UaLZYvV/GBfRpcudNf/4Ck+n1WF5cQGcPkAprqTXC+3iKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567114; c=relaxed/simple;
	bh=t09fvudtu+qD0++I9aX5vn1moqJaJWDsCMSyxzjXEQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fygzh3qaGU6rvxc5hsUHjEGsf7NgS87Imhf9tUDNi+szrV+buJ32mWGVD4yWdZnqfSlDxg6ACMTtUAmpBeeaes25qb9JzpwjBP2R9RNM+Ig8pqTR37hLD65JJPRD59WF/JMfHlKCahDKRrKjVtXl3Zrwx7veWHPNoGeZgTVWvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7430C4CEE3;
	Fri, 21 Mar 2025 14:25:11 +0000 (UTC)
Date: Fri, 21 Mar 2025 10:25:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] docs: tracing: Refactor index.rst for clarity
Message-ID: <20250321102507.6f02060d@batman.local.home>
In-Reply-To: <20250318113230.24950-2-purvayeshi550@gmail.com>
References: <20250318113230.24950-1-purvayeshi550@gmail.com>
	<20250318113230.24950-2-purvayeshi550@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 17:02:30 +0530
Purva Yeshi <purvayeshi550@gmail.com> wrote:

> Refactor Documentation/trace/index.rst to improve clarity, structure,
> and organization. Reformat sections and add appropriate headings for
> better readability.
> 
> Improve section grouping and refine descriptions for better usability.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  Documentation/trace/index.rst | 94 +++++++++++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 15 deletions(-)

For both patches:

 Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org.

Jon,

Feel free to apply these to your tree.

Thanks,

-- Steve
