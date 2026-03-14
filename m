Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC352F88;
	Sat, 14 Mar 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480882; cv=none; b=fMiYjBY8EFJ4erP0HJQ+RbVNr9lYqgJi8Jx/IQr/g8cYLWcAxipCeUpSftJNh2EzUuoAmdoYtcr/9BzfdcfNPV9TTcGmHxojr80ORLqYK1eYqpa9+lyuhrqK9xS5Yee7vzjO7fQsTHRIHwMyRNIeNL5LMk8FbnWMQDBnxPisz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480882; c=relaxed/simple;
	bh=stzjALevVcUta8dyg5XDLFvvXknWlYhMzz/N1m8KGpw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JrX9W8exAL1X5QSciib0K6qg0G6bd/sls+oXqr20IMl1yJyOOmAkLP6z2s1xTu01uPfCn0XlZNnewr4jxpakI6z75enyTJiGUI36xjtnGcrvgCSXhxORH3+zSt+uf4NlEJTNWwb3g5zmDVxjKdzJtGb5yxuKYNyoq7J5qQI0d1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2JVXmo6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2JVXmo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BACC116C6;
	Sat, 14 Mar 2026 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773480881;
	bh=stzjALevVcUta8dyg5XDLFvvXknWlYhMzz/N1m8KGpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N2JVXmo6NYNbtrSBaHr6mFtKtx2+QWnr+j9+BJ5Wsfx4MevtcJo/3cErOEapCoxNI
	 GUaH9GOLxnghp2Rs9RXGkzEf2B/VopLgCfapNhXJrPJDt7/MHuWMXStL7UQEGZgFd7
	 n4SKXCPSDzli4c/KsPeUFVRqeHIDWwbwToFDXAKY/OllKs0XROCuOzWQMPTkCh/kBQ
	 61wjMsWeQdSHzcE28zxbM/LcYpjqqwVPAFrK+jJIOQB+3DOz/6hdpTO8le2rP2lm0X
	 PUz8wkL/7jW8rpzAgBpHa5/ZI3wGsnAOyFSvUxf3/VIGbn5MTp5orvB3rNvjVthxuR
	 3Taeg+yjj7I4Q==
Date: Sat, 14 Mar 2026 18:34:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: bootconfig: Add EBNF definiton of
 bootconfig
Message-Id: <20260314183438.2babb627d8a58290f20be111@kernel.org>
In-Reply-To: <177347919991.458550.13051415412509206815.stgit@devnote2>
References: <177347919093.458550.1919253264724868769.stgit@devnote2>
	<177347919991.458550.13051415412509206815.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 18:06:40 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add the EBNF definition to Documentation/admin-guide/bootconfig.rst
> to formally define the bootconfig syntax.
> 

Wait, I rethink it may be better to be a separated section
so that it can be referred easily.
Let me update it.

Thanks,

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Documentation/admin-guide/bootconfig.rst |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index f712758472d5..5c5f736ca982 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -22,6 +22,21 @@ The boot config syntax is a simple structured key-value. Each key consists
>  of dot-connected-words, and key and value are connected by ``=``. The value
>  string has to be terminated by the following delimiters described below.
>  
> +The syntax is defined in EBNF as follows::
> +
> +  Config = { Statement }
> +  Statement = [ Key [ Assignment | Block ] | Comment ] ( "\n" | ";" )
> +  Assignment = ( "=" | "+=" | ":=" ) ValueList
> +  ValueList = [ Value { "," [ { ( Comment | "\n" ) } ] Value } ]
> +  Block = "{" { Statement } "}"
> +  Key = Word { "." Word }
> +  Word = [a-zA-Z0-9_-]+
> +  Value = QuotedValue | UnquotedValue
> +  QuotedValue = "\"" { any_character_except_double_quote } "\""
> +              | "'" { any_character_except_single_quote } "'"
> +  UnquotedValue = { any_printable_character_except_delimiters }
> +  Comment = "#" { any_character_except_newline }
> +
>  Each key word must contain only alphabets, numbers, dash (``-``) or underscore
>  (``_``). And each value only contains printable characters or spaces except
>  for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
