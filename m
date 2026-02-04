Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2D1850A4;
	Wed,  4 Feb 2026 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770243628; cv=none; b=N0Uu8bOuZ8VH3FrYuwC5PPthNXmRYbbum8zR1Zb+mEs5yKSWKZRQiSsFobFl4zxNyumvjnX4BiYWMl2iZQRsxZHpqMLIpS9tB5VWKKWMGGnx0oR0Q/+X9CTU9qgSbMWRuBQLeEl359WejivYWUULne8jiOamz2BMLqAps+mUcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770243628; c=relaxed/simple;
	bh=Ya+01ePZCnk6FiZZjtHc+VIXKiD5EOLS0KTS5Ku5x+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGzXwykWDBaNDjPMsUGz/X7hcPoRnJSMxh/MMNEBYgFAoED+2lX+geW9iYJhOolO7ud2kDs31CamXZEh9K4Q//47LJOw4aBpvblySGfxql/t7EH3UR3PQvUWgXy1IcpScS3du9i/0dOvJLiiQF8yVHJmqSCOmSPONWwmLs8CahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 1A8271A02EF;
	Wed,  4 Feb 2026 22:20:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 5744720032;
	Wed,  4 Feb 2026 22:20:25 +0000 (UTC)
Date: Wed, 4 Feb 2026 17:20:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, Julius Werner <jwerner@google.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] bootconfig: Terminate value search if it hits a
 newline
Message-ID: <20260204172057.5bcbfcfd@gandalf.local.home>
In-Reply-To: <177019402883.80694.10977484286951965499.stgit@devnote2>
References: <177019401833.80694.554894321526842218.stgit@devnote2>
	<177019402883.80694.10977484286951965499.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5744720032
X-Stat-Signature: 1sh4ggkffxckttbk4u34iuj7z4uw6f5g
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19INLcnQ8JhCm1czoWqYJLu//383T08qQA=
X-HE-Tag: 1770243625-833672
X-HE-Meta: U2FsdGVkX19pW3Nobfr4ZkGdjbsFA+wynOogvVwRxwUQ7++kr1TlSy6aDOWUC/hYde/MfkpjO35orwxuT7EJk6RjkrunvpLnVL728DoiuzuIloX1/cCOKNTQAhUysgWsUvmeQfSpGCGfeLJp2Fwi5ik+aQhi9jaP2WrizO478pxxGdHzVFh0MQaJfy6l0lhW1b+qYwRgYI45/iYtlisrcBPVj3lcLBW0Ugci7zqh1XLmEloq3aaOYvjNBontWQ0W25A/wyRFVjvtH0xvq7HxL76vpcLS1xClS4FaivX3e/M1yKeuSYrufNv/vrxdg72wa7QgylBk+kdjuB8rvdMgUlgBkvE40qXr

On Wed,  4 Feb 2026 17:33:48 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Terminate the value search for a key if it hits a newline and make
> the value empty.
> 
> When we pass a bootconfig with an empty value terminated by the
> newline, like below::
> 
>   foo =
>   bar = value
> 
> Current bootconfig interprets it as a single entry::
> 
>   foo = "bar = value";
> 
> The Documentation/admin-guide/bootconfig.rst defines the value
> itself is terminated by newline:
> 
>   The value has to be terminated by semi-colon (``;``) or newline (``\n``).
> 
> but it does not define when the value search is terminated.
> This changes the behavior to more line-oriented, so that it can

     to be more line-oriented

> clear how it is working.

  so that it is clearer in how it works.


> 
> - The value search of key-value pair will be terminated by a comment
>   or newline.
> - The value search of an array will continue beyond comments and
>   newlines.
> 
> Thus, with this update, the above example is interpreted as::
> 
>   foo = "";
>   bar = "value";
> 
> And the below example will cause a syntax error because "bar" is expected
> as a key but it has ','.
> 
>   foo =
>     bar, buz
> 
> According to this change, one wrong example config is updated.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Fix to handle multi-line array case correctly.
>   - Make this as a spec update, not fix.
> ---
>  .../samples/good-array-space-comment.bconf         |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index 7a86042c9b6d..843b24b8de88 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -20,18 +20,26 @@ Config File Syntax
>  
>  The boot config syntax is a simple structured key-value. Each key consists
>  of dot-connected-words, and key and value are connected by ``=``. The value
> -has to be terminated by semi-colon (``;``) or newline (``\n``).
> -For array value, array entries are separated by comma (``,``). ::
> -
> -  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> -
> -Unlike the kernel command line syntax, spaces are OK around the comma and ``=``.
> +string has to be terminated by the following delimiters described below.
>  
>  Each key word must contain only alphabets, numbers, dash (``-``) or underscore
>  (``_``). And each value only contains printable characters or spaces except
>  for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
>  hash (``#``) and closing brace (``}``).
>  
> +If the ``=`` is followed by whitespace up to one of these delimiters, the
> +key is assigned an empty value.
> +
> +For arrays, the array values are comma (``,``) separated, and comments and
> +line breaks with newline (``\n``) are allowed between array values for
> +readability. Thus the first entry of the array must be the same line of the

                         must be on the same line as the key.

> +key.::
> +
> +  KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]
> +
> +Unlike the kernel command line syntax, white spaces (including tabs) are
> +ignored around the comma and ``=``.
> +
>  If you want to use those delimiters in a value, you can use either double-
>  quotes (``"VALUE"``) or single-quotes (``'VALUE'``) to quote it. Note that
>  you can not escape these quotes.
> @@ -138,8 +146,8 @@ This is parsed as below::
>   foo = value
>   bar = 1, 2, 3
>  
> -Note that you can not put a comment between value and delimiter(``,`` or
> -``;``). This means following config has a syntax error ::
> +Note that you can NOT put a comment or a newline between value and delimiter
> +(``,`` or ``;``). This means following config has a syntax error ::
>  
>   key = 1 # comment
>         ,2
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 81f29c29f47b..c210fb8b1e85 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -557,17 +557,13 @@ static int __init __xbc_close_brace(char *p)
>  /*
>   * Return delimiter or error, no node added. As same as lib/cmdline.c,
>   * you can use " around spaces, but can't escape " for value.
> + * *@__v must point real value string. (not including spaces before value.)
>   */
>  static int __init __xbc_parse_value(char **__v, char **__n)
>  {
>  	char *p, *v = *__v;
>  	int c, quotes = 0;
>  
> -	v = skip_spaces(v);
> -	while (*v == '#') {
> -		v = skip_comment(v);
> -		v = skip_spaces(v);
> -	}
>  	if (*v == '"' || *v == '\'') {
>  		quotes = *v;
>  		v++;
> @@ -617,6 +613,13 @@ static int __init xbc_parse_array(char **__v)
>  		last_parent = xbc_node_get_child(last_parent);
>  
>  	do {
> +		/* Search the next array value beyond comments and empty lines */
> +		next = skip_spaces(*__v);
> +		while (*next == '#') {
> +			next = skip_comment(next);
> +			next = skip_spaces(next);
> +		}
> +		*__v = next;
>  		c = __xbc_parse_value(__v, &next);
>  		if (c < 0)
>  			return c;
> @@ -701,9 +704,17 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
>  	if (ret)
>  		return ret;
>  
> -	c = __xbc_parse_value(&v, &next);
> -	if (c < 0)
> -		return c;
> +	v = skip_spaces_until_newline(v);
> +	/* If there is a comment, this has an mpty value. */

                                             empty value

-- Steve

> +	if (*v == '#') {
> +		next = skip_comment(v);
> +		*v = '\0';
> +		c = '\n';
> +	} else {
> +		c = __xbc_parse_value(&v, &next);
> +		if (c < 0)
> +			return c;
> +	}
>  
>  	child = xbc_node_get_child(last_parent);
>  	if (child && xbc_node_is_value(child)) {
> diff --git a/tools/bootconfig/samples/good-array-space-comment.bconf b/tools/bootconfig/samples/good-array-space-comment.bconf
> index 45b938dc0695..416fa2ed4109 100644
> --- a/tools/bootconfig/samples/good-array-space-comment.bconf
> +++ b/tools/bootconfig/samples/good-array-space-comment.bconf
> @@ -1,4 +1,3 @@
> -key =	# comment
> -	"value1",	  # comment1
> +key = "value1",	  # comment1
>  	"value2"	 , # comment2
>  	"value3"

