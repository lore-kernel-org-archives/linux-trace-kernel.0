Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801B17D2;
	Fri, 12 Sep 2025 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757638713; cv=none; b=PMeWUpF2pa91+fcr3qZgsDwdqBYTNKBDZ0Q6cZzZhJgZxsupS69/ya2jk40R7OozoBe1sZHKzSE6oVslYrPwPPRVrLTVGMvVIxkdTOc6JmnWIcY7FTKhiLygSWtY/hKZ+JBS0Yu1LoBQs1AqMiFEKt8GQtSPLfuVgkC5hD2uL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757638713; c=relaxed/simple;
	bh=mNMcAhLz75xkpjqqUqqvq0LB84zFQSqJ02YXY1DjF+Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CdsVN7apkBz9m9TrvYfLDBTO0WeJitI/BcdZA1ogh+cC+2mhlYtefHrdbRzoEM/X0tTL1trg2qYZweKpgA//lM9//ZB6aG3wo648AX4m74euKKPIPoBtLt34rGEerorNbxa1fdgMIxWXEvaWMygBqxggqDJPmMkfkRBz1LGx2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuLbT/9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuLbT/9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34945C4CEF0;
	Fri, 12 Sep 2025 00:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757638712;
	bh=mNMcAhLz75xkpjqqUqqvq0LB84zFQSqJ02YXY1DjF+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EuLbT/9WjBULn8MLHy2diSlRQv5tRXmUkvTxnwjZ3Vzkue9+uofpPAKUJhDD8dezR
	 OXqf2vLrwLX8BlJJiP2C8RqGPpXc5oMnztHOoDMKOS6vyafDf+EBwWgpCMz5/Ofk24
	 N3uyelRYv3Y1mI0HABohYNhjw6yqKVpsFQxcfJEoYXSiuH7BpPdB5hWzhmzBdH1wcg
	 wmTSsO4/MHEDVynznuZbEHtIHwkFARCKv9O29uLeUXyNvnMAQJAeU6WosaYj21xMug
	 QHtG45DvM8hWB85iIT94tNsTyhSn4GqsvEQ8q2e3ug5YcrrJeYe+xQgonKPnpc7fo6
	 DjWDbO45E2Htg==
Date: Fri, 12 Sep 2025 09:58:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Tom
 Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 5/5] Documentation: trace: histogram: Link to ftrace
 docs
Message-Id: <20250912095827.3d5a3feb80d5c6c44667328f@kernel.org>
In-Reply-To: <20250911042527.22573-6-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
	<20250911042527.22573-6-bagasdotme@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:25:27 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> In brief "Extended error information" section, details on error
> condition is referred to ftrace docs. Add the link to it.

It seems this does not add the link. Can you make a tag and
link to it?

Thank you,

> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/trace/histogram.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index d158dadaa42447..340bcb5099e7a4 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -209,8 +209,8 @@ Documentation written by Tom Zanussi
>  
>    For some error conditions encountered when invoking a hist trigger
>    command, extended error information is available via the
> -  tracing/error_log file.  See Error Conditions in
> -  :file:`Documentation/trace/ftrace.rst` for details.
> +  tracing/error_log file.  See "Error conditions" section in
> +  Documentation/trace/ftrace.rst for details.
>  
>  2.3. 'hist' trigger examples
>  ----------------------------
> -- 
> An old man doll... just what I always wanted! - Clara
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
